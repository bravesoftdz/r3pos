unit uGodsDzFactory;

interface

uses
  SysUtils, Variants, Classes, Dialogs, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory, uRimSyncFactory;


//第三方系统数据对接的基类
type
  TGodsDzSyncFactory=class(TRimSyncFactory)
  private
    //将RIM提供视图[RIM_GOODS_RELATION]插入中间表
    function InsertData_INF_GOODS_RELATION(COM_ID: string; UpdateMode: integer): Integer;
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //调用上报
  end;

implementation

{ TRimSyncFactory }

function TGodsDzSyncFactory.InsertData_INF_GOODS_RELATION(COM_ID: string; UpdateMode: integer): Integer;
var
  iRet: integer;    //返回更改记录数
  Sort_ID2,Sort_ID5,Sort_ID6,CALC_UNIT,TENANT_ID: string; //价格分类 、是否是省内外　、计量单位
  Box_InPrice, Box_OutPrice, BarCode: string;    //包的入库价、包的零售价、条码
  StrSQL,RimSQL: Pchar;
  AObj: TRecord_;
  RsRim,RsInf,RsBarPub: TZQuery;
begin
  result:=-1;
  HasError:=False;
  iRet:=-1;
  TENANT_ID:= Params.ParamByName('TENANT_ID').AsString;
  Sort_ID2:=
    '(case when SORT_ID2=''1'' then ''85994503-9CBC-4346-BC86-24C7F5A92BC6'''+  //价类
         ' when SORT_ID2=''2'' then ''59FD3FCD-2E8F-440A-B9B6-727B45524535'''+
         ' when SORT_ID2=''3'' then ''C7591724-53FF-4DA0-BE32-FACCDB3A3BFC'''+
         ' when SORT_ID2=''4'' then ''48F953FF-D86D-4A77-AA9A-0D56491B43EF'''+
         ' when SORT_ID2=''5'' then ''B82B26CF-E0D3-499C-808C-C074B0240881'''+
         ' when SORT_ID2=''6'' then ''70EC2D50-6CA7-4730-8362-D76909D3BFF2'''+
         ' else ''#'' end) as SORT_ID2';
  //增加是否重点品牌:
  Sort_ID5:=
    '(case when SORT_ID4=''1'' then ''01072169-2F03-42C1-9EAB-541D031647AF'''+  //是否重点品牌
         ' else ''15CD1495-B3C7-42C7-8709-5376FC061305'' end) as SORT_ID5 ';
  Sort_ID6:=
    '(case when SORT_ID6=''0'' then ''635E6FB4-8B94-4996-95E1-A77401323560'''+  //是否省内外、国外烟
         ' when SORT_ID6=''1'' then ''E76D1A2A-1423-42E1-B827-8B268AF92CCD'''+
         ' when SORT_ID6=''3'' then ''800F74E2-B697-4D95-9131-8FAD458EC992'''+
         ' else ''#'' end) as SORT_ID6';
  CALC_UNIT:='''95331F4A-7AD6-45C2-B853-C278012C5525'' as CALC_UNIT '; //盒包装单位: GUID

  //2011.06.29修改换算系数用R3的单位换算系数:
   Box_InPrice:=' PACK_INPRICE as NEW_INPRICE ';   //盒单位的 入库价
   Box_OutPrice:=' PACK_OUTPRICE as NEW_OUTPRICE ';  //盒单位的 零售价
  {Box_InPrice:='(case when CAlC_AMT>0 then PACK_INPRICE*1.00/CAlC_AMT else PACK_INPRICE end) as NEW_INPRICE ';   //盒单位的 入库价
   Box_OutPrice:='(case when CAlC_AMT>0 then PACK_OUTPRICE*1.00/CAlC_AMT else PACK_OUTPRICE end) as NEW_OUTPRICE ';  //盒单位的 零售价
  }
  
  //1、先删除供应关系中间表:
  StrSQL:=PChar('delete from INF_GOODS_RELATION where TENANT_ID='+TENANT_ID+' ');
  if ExecSQL(StrSQL,iRet)<>0 then Raise Exception.Create('1、先删除供应关系中间表:');

  //2、插入传入企业商品供应链:
  try
    AObj:=TRecord_.Create;
    RsRim:=TZQuery.Create(nil);  //Rim视图
    RsInf:=TZQuery.Create(nil);  //R3中间表
    RsBarPub:=TZQuery.Create(nil);  //R3条码_供应链
    RsBarPub.SQL.Text:=
      'select A.GODS_ID,A.BARCODE,B.ROWS_ID,B.SECOND_ID,B.RELATION_ID,'+
      '(case when A.GODS_ID=B.Gods_ID and B.SECOND_ID is not null then 1 else 2 end) as IsFlag from PUB_BARCODE A '+
      'left outer join (select * from PUB_GOODS_RELATION where TENANT_ID='+TENANT_ID+') B '+
      ' on A.GODS_ID=B.GODS_ID '+
      ' where A.TENANT_ID=110000001 and A.BARCODE_TYPE=''1'' ';
    Open(RsBarPub);
    RsRim.Close;
    RsRim.SQL.Text:='select GODS_ID as SECOND_ID,GODS_CODE,GODS_NAME,'+Sort_ID2+','+Sort_ID5+','+Sort_ID6+','+Box_InPrice+','+Box_OutPrice+',PACK_BARCODE from RIM_GOODS_RELATION where TENANT_ID='''+COM_ID+''' ';
    Open(RsRim);
    RsInf.SQL.Text:='select A.*,0 as UpdateMode,0 as FLAG from INF_GOODS_RELATION A where A.TENANT_ID='+TENANT_ID;
    Open(RsInf);

    //开始循环对照
    try
      if (RsRim.Active) and (RsInf.Active) and (RsBarPub.Active) then
      begin
        RsRim.First;
        while not RsRim.Eof do
        begin
          AObj.ReadFromDataSet(RsRim);
          BarCode:=trim(RsRim.fieldbyName('PACK_BARCODE').AsString);
          if RsBarPub.Locate('BARCODE',BarCode,[]) then  //条条码能关联上
          begin
            //判断当前插入中是否存在条码重复情况:
            if RsInf.Locate('PACK_BARCODE',BarCode,[]) then  //已存在[重复]
            begin
              //重置原记录状态
              RsInf.Edit;
              RsInf.FieldByName('PACK_BARCODE').AsString:=BarCode; //条条码
              RsInf.FieldByName('UPDATE_FLAG').AsInteger:=4;       //状态[4: 重复条码]
              RsInf.Post;
              //新插入当前
              RsInf.Append;
              AObj.WriteToDataSet(RsInf,False);  //Aobj写入DataSet;
              RsInf.FieldByName('ROWS_ID').AsString:=NewId();
              RsInf.FieldByName('TENANT_ID').AsInteger:=StrtoInt(TENANT_ID);
              RsInf.FieldByName('RELATION_ID').AsInteger:=NT_RELATION_ID;  //国家卷烟供应链1000006
              RsInf.FieldByName('GODS_ID').AsString:=RsBarPub.fieldbyName('GODS_ID').AsString; //国家卷烟供应链
              RsInf.FieldByName('PACK_BARCODE').AsString:=BarCode; //条条码
              RsInf.FieldByName('UPDATE_FLAG').AsInteger:=4;       //状态[4: 重复条码]
              RsInf.FieldByName('UpdateMode').AsInteger:=UpdateMode; //更新模式
              RsInf.FieldByName('FLAG').AsInteger:=SyncType; //运行类型[R3、Rsp]
              RsInf.Post;
            end else
            begin
              RsInf.Append;
              AObj.WriteToDataSet(RsInf,False);  //Aobj写入DataSet;
              RsInf.FieldByName('ROWS_ID').AsString:=NewId();
              RsInf.FieldByName('TENANT_ID').AsInteger:=StrtoInt(TENANT_ID);
              RsInf.FieldByName('RELATION_ID').AsInteger:=NT_RELATION_ID;  //国家卷烟供应链1000006
              RsInf.FieldByName('GODS_ID').AsString:=RsBarPub.fieldbyName('GODS_ID').AsString; //国家卷烟供应链
              RsInf.FieldByName('PACK_BARCODE').AsString:=BarCode; //条条码
              RsInf.FieldByName('UPDATE_FLAG').AsInteger:=RsBarPub.fieldbyName('IsFlag').AsInteger; //状态[1表示新对上，2表示原已对上]
              RsInf.FieldByName('UpdateMode').AsInteger:=UpdateMode; //更新模式
              RsInf.FieldByName('FLAG').AsInteger:=SyncType; //运行类型[R3、Rsp]
              RsInf.Post;
            end;
          end else  {==对不上，作为返回显示结果查看==}
          begin
            RsInf.Append;
            AObj.WriteToDataSet(RsInf, False); //Aobj写入DataSet;
            RsInf.FieldByName('ROWS_ID').AsString:=NewId();
            RsInf.FieldByName('TENANT_ID').AsInteger:=StrtoInt(TENANT_ID);
            RsInf.FieldByName('RELATION_ID').AsInteger:=NT_RELATION_ID;  //国家卷烟供应链:1000006
            RsInf.FieldByName('GODS_ID').AsString:='#';  //对应不上默认为：#
            RsInf.FieldByName('PACK_BARCODE').AsString:=BarCode; //条条码
            RsInf.FieldByName('UPDATE_FLAG').AsInteger:=0; //状态[1对不上]
            RsInf.FieldByName('UpdateMode').AsInteger:=UpdateMode; //更新模式
            RsInf.FieldByName('FLAG').AsInteger:=SyncType; //运行类型[R3、Rsp]
            RsInf.Post;
          end;
          RsRim.Next;
        end; //end (循环: while not RsRim.Eof do)
        //提交数据库
        if RsInf.Changed then
        begin
          result:=PlugIntf.UpdateBatch(RsInf.Data, 'TInf_Goods_Relation',dbResoler);
          if result<>0 then
            Raise Exception.Create('提交中间表[Inf_Goods_Relation]数据错误！'); 
        end else
          Raise Exception.Create('在Rim没有找到对应条码的卷烟档案！');
      end else
        Raise Exception.Create('存在数据集没有Open状态！');
    except
      on E:Exception do
      begin
        Raise Exception.Create('从RIM_GOODS_RELATION视图插入到中间表:INF_GOODS_RELATION出错：'+E.Message); 
      end;
    end;
  finally
    AObj.Free;
    RsRim.Free;
    RsInf.Free;
    RsBarPub.Free;
  end;
end;

function TGodsDzSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  COM_ID: String;
  UpdateMode: integer; //更新模式
begin
  result:=-1;
  {------初始化参数------}
  PlugIntf:=GPlugIn;

  //1、返回数据库类型
  GetDBType;

  //2、还原ParamsList的参数对象
  Params.Decode(Params, InParamStr);
  GetSyncType;  //返回同步类型标记
    
  UpdateMode:=1;  //默认为全部；
  if Params.FindParam('UPDATE_MODE')<>nil then
  begin
    UpdateMode:=Params.ParamByName('UPDATE_MODE').AsInteger;  //刷新模式
    if (UpdateMode<1) or (UpdateMode>3) then
      UpdateMode:=1;  //默认为全部；  
  end;

  //3、返回Rim烟草公司Com_ID
  COM_ID:=GetRimCOM_ID(Params.ParamByName('TENANT_ID').AsString);
  if COM_ID='' then Raise Exception.Create('没有找到对应Rim系统烟草公司！');

  {------开始处理对照------}
  try
    result:=InsertData_INF_GOODS_RELATION(COM_ID, UpdateMode);
  except
    on E:Exception do
    begin
      HasError:=true;
      ErrorMsg:=E.Message;
    end;
  end;
end;

 
end.
