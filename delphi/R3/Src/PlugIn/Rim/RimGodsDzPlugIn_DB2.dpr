{
  Create Date: 2011.04.08 Pm
  说明:
    1、插件ID: 是对于实现某个功能插件编号;

 }


library RimGodsDzPlugIn_DB2;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  DB,
  zDataSet,
  SysUtils,
  Variants,
  Classes,
  zBase,
  uPlugInUtil in '..\obj\uPlugInUtil.pas';

   
{$R *.res}


function GetORGAN_ID(PlugIntf: IPlugIn; TENANT_ID: string): string;
var
  str: string;
  Rs: TZQuery;
  vData: OleVariant;
begin
  result:='';
  try
    str:='select A.ORGAN_ID as ORGAN_ID from RIM_PUB_ORGAN A,CA_TENANT B where A.ORGAN_CODE=B.LOGIN_NAME and B.TENANT_ID='+TENANT_ID+' ';
    try
      Rs:=TZQuery.Create(nil);
      OpenData(PlugIntf, Rs, str);
      if Rs.Active then
        result:=trim(Rs.fieldbyName('ORGAN_ID').AsString);
    finally
      Rs.Free;
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('传入R3企业ID:('+TENANT_ID+') 返回Rim的企业ID出错：'+E.Message);
    end;
  end;
end;

//2011.04.08 Pm  Add [RIM_GOODSINFO] === [INF_GOODS_RELATION]
function DoUpdateINF_GOODSINFO(PlugIntf: IPlugIn; TENANT_ID: string): Integer;
var
  NotGods: string;     //日志调试使用
  Sort_ID2, Sort_ID6,CALC_UNIT: string; //价格分类 、是否是省内外　、计量单位
  Box_InPrice, Box_OutPrice: string;    //包的入库价、包的零售价
  ORGAN_ID, BarCode: string;   //1、RIM公司ID 2、条码
  StrSQL,RimSQL: Pchar;   
  iRet: integer;   //返回更改记录数
  AObj: TRecord_;
  RsRim,RsInf,RsBarPub: TZQuery;
begin
  result:=-1;
  iRet:=-1;
  NotGods:='';
  ORGAN_ID:=GetORGAN_ID(PlugIntf,TENANT_ID); //根据R3企业ID返回Rim企业内码(comp_id)
  TLogRunInfo.LogWrite('开始执行对照取参数:（R3企业ID：'+TENANT_ID+'，RIM烟草公司ID:'+ORGAN_ID+'）','RimGodsDzPlugIn.dll');
  if ORGAN_ID='' then Raise Exception.Create('没有找到Rim系统烟草公司ID！'); 

  Sort_ID2:=
    '(case when SORT_ID2=''1'' then ''85994503-9CBC-4346-BC86-24C7F5A92BC6'''+  //价类
         ' when SORT_ID2=''2'' then ''59FD3FCD-2E8F-440A-B9B6-727B45524535'''+
         ' when SORT_ID2=''3'' then ''C7591724-53FF-4DA0-BE32-FACCDB3A3BFC'''+
         ' when SORT_ID2=''4'' then ''48F953FF-D86D-4A77-AA9A-0D56491B43EF'''+
         ' when SORT_ID2=''5'' then ''B82B26CF-E0D3-499C-808C-C074B0240881'''+
         ' when SORT_ID2=''6'' then ''70EC2D50-6CA7-4730-8362-D76909D3BFF2'''+
         ' else ''#'' end) as SORT_ID2';
  Sort_ID6:=
    '(case when SORT_ID6=''0'' then ''635E6FB4-8B94-4996-95E1-A77401323560'''+  //是否省内外、国外烟
         ' when SORT_ID6=''1'' then ''E76D1A2A-1423-42E1-B827-8B268AF92CCD'''+
         ' when SORT_ID6=''3'' then ''800F74E2-B697-4D95-9131-8FAD458EC992'''+
         ' else ''#'' end) as SORT_ID6';
  CALC_UNIT:='''95331F4A-7AD6-45C2-B853-C278012C5525'' as CALC_UNIT '; //盒包装单位: GUID

  Box_InPrice:='(case when CAlC_AMT>0 then PACK_INPRICE/CAlC_AMT else PACK_INPRICE end) as NEW_INPRICE ';   //盒单位的 入库价
  Box_OutPrice:='(case when CAlC_AMT>0 then PACK_OUTPRICE/CAlC_AMT else PACK_OUTPRICE end) as NEW_OUTPRICE ';  //盒单位的 零售价

  //1、先删除供应关系中间表:
  StrSQL:=PChar('delete from INF_GOODS_RELATION where TENANT_ID='+TENANT_ID+' ');
  if PlugIntf.ExecSQL(StrSQL,iRet)<>0 then Raise Exception.Create('1、先删除供应关系中间表:'); 

  //2、插入传入企业商品供应链:
  try
    AObj:=TRecord_.Create;
    RsRim:=TZQuery.Create(nil);  //Rim视图
    RsInf:=TZQuery.Create(nil);  //R3中间表
    RsBarPub:=TZQuery.Create(nil);  //R3条码_供应链
    StrSQL:=Pchar(
      'select A.GODS_ID,A.BARCODE,B.ROWS_ID,B.SECOND_ID,B.RELATION_ID,(case when A.GODS_ID=B.Gods_ID and B.SECOND_ID is not null then 1 else 2 end) as IsFlag from PUB_BARCODE A '+
      'left outer join (select * from PUB_GOODS_RELATION where TENANT_ID='+TENANT_ID+') B on A.GODS_ID=B.GODS_ID '+
      ' where A.TENANT_ID=110000001 and A.BARCODE_TYPE=''1'' ');
    OpenData(PlugIntf, RsBarPub, StrSQL);
    RimSQL:=Pchar('select GODS_ID as SECOND_ID,GODS_CODE,GODS_NAME,'+Sort_ID2+','+Sort_ID6+','+Box_InPrice+','+Box_OutPrice+',PACK_BARCODE from RIM_GOODS_RELATION where TENANT_ID='''+ORGAN_ID+''' ');
    OpenData(PlugIntf, RsRim, RimSQL);
    OpenData(PlugIntf, RsInf, Pchar('select * from INF_GOODS_RELATION where TENANT_ID='+TENANT_ID));

    //写调试日志:
    TLogRunInfo.LogWrite('对照Open数据：1、RsBarPub.SQL='+StrSQL+'  返回记录数:'+InttoStr(RsBarPub.RecordCount)+' 2、RsRim.SQL='+RimSQL+'  返回记录数:'+InttoStr(RsRim.RecordCount),'RimGodsDzPlugIn.dll');

    //开始循环对照
    try
      if (RsRim.Active) and (RsInf.Active) and (RsBarPub.Active) then
      begin
        RsRim.First;
        while not RsRim.Eof do
        begin
          AObj.ReadFromDataSet(RsRim);
          BarCode:=trim(RsRim.fieldbyName('PACK_BARCODE').AsString);
          if RsBarPub.Locate('BARCODE',BarCode,[]) then  //条码能关联上
          begin
            if RsInf.IsEmpty then RsInf.Edit else RsInf.Append;
            AObj.WriteToDataSet(RsInf,False);  //Aobj写入DataSet;
            if trim(RsBarPub.fieldbyName('ROWS_ID').AsString)<>'' then
              RsInf.FieldByName('ROWS_ID').AsString:=RsBarPub.fieldbyName('ROWS_ID').AsString
            else
              RsInf.FieldByName('ROWS_ID').AsString:=NewId();
            RsInf.FieldByName('TENANT_ID').AsInteger:=StrtoInt(TENANT_ID);
            RsInf.FieldByName('RELATION_ID').AsInteger:=NT_RELATION_ID;  //国家卷烟供应链1000006
            RsInf.FieldByName('GODS_ID').AsString:=RsBarPub.fieldbyName('GODS_ID').AsString; //国家卷烟供应链
            RsInf.FieldByName('PACK_BARCODE').AsString:=BarCode; //条条码
            RsInf.FieldByName('UPDATE_FLAG').AsInteger:=RsBarPub.fieldbyName('IsFlag').AsInteger; //状态[1表示新对上，2表示原已对上]
            RsInf.Post;
          end else  {==对不上，作为返回显示结果查看==}
          begin
            if NotGods='' then NotGods:=BarCode else NotGods:=NotGods+';'+BarCode; //本行调试记录对不上条码
            if RsInf.IsEmpty then RsInf.Edit else RsInf.Append;
            AObj.WriteToDataSet(RsInf, False); //Aobj写入DataSet;
            RsInf.FieldByName('ROWS_ID').AsString:=NewId();
            RsInf.FieldByName('TENANT_ID').AsInteger:=StrtoInt(TENANT_ID);
            RsInf.FieldByName('RELATION_ID').AsInteger:=NT_RELATION_ID;  //国家卷烟供应链:1000006
            RsInf.FieldByName('GODS_ID').AsString:='#';  //对应不上默认为：#
            RsInf.FieldByName('PACK_BARCODE').AsString:=BarCode; //条条码
            RsInf.FieldByName('UPDATE_FLAG').AsInteger:=0; //状态[1对不上]
            RsInf.Post;
          end;
          RsRim.Next;
        end; //end (循环: while not RsRim.Eof do)
        TLogRunInfo.LogWrite('循环对照结果：对不上Rim条单位条码：'+NotGods,'RimGodsDzPlugIn.dll');
        result:=PlugIntf.UpdateBatch(RsInf.Data, 'TInf_Goods_Relation'); //提交RsInf保存中间表:INF_GOODS_RELATION;
        if result<>0 then
          Raise Exception.Create('提交中间表INF_GOODS_RELATION出现异常！');
      end //end (if (RsRim.Active) and (RsInf.Active) and (RsBarPub.Active) then)
      else
        Raise Exception.Create(' 存在数据集没有Open！');
    except
      on E:Exception do
      begin
        Raise Exception.Create('从RIM_GOODS_RELATION视图插入到中间表:INF_GOODS_RELATION出错：'+E.Message);
      end;
    end;
    TLogRunInfo.LogWrite('对照执行完毕！','RimGodsDzPlugIn.dll');
  finally
    AObj.Free;
    RsRim.Free;
    RsInf.Free;
    RsBarPub.Free;
  end;
end;

//RSP装载插件时调用，传插件可访问的服务接口
function SetParams(PlugIn: IPlugIn):integer; stdcall;
begin
  GPlugIn := PlugIn;
end;

//插件中执行的所有操作都必须带 try except end 如果出错时，由此方法返回错信息
function GetLastError:Pchar; stdcall;
begin
  result := Pchar(GLastError);
end;

//返回当前插件说明
function GetPlugInDisplayName:Pchar; stdcall;
begin
  result := 'RSP平台与RIM系统卷烟档案对照';
end;

//为每个插件定义一个唯一标识号，范围1000-9999
function GetPlugInId:Integer; stdcall;
begin
  result := 1001;  //RIM接口的插件
end;

//RSP调用插件时执行此方法
function DoExecute(Params:Pchar; var Data: oleVariant):Integer; stdcall;
begin
  try
    //2011.04.08 Pm  Add 执行从[RIM_GOODSINFO] ==> [INF_GOODS_RELATION]导入
    //调试使用: DoUpdateINF_GOODSINFO(GPlugIn, '100011'); //StrPas(Params)
    //GPlugIn.WriteLogFile(PChar('传入Tenant_ID:'+Params));
    
    result:=DoUpdateINF_GOODSINFO(GPlugIn, StrPas(Params));  //StrPas(Params)
  except
    on E:Exception do
    begin
      GLastError := E.Message;
      GPlugIn.WriteLogFile(PChar(GLastError));
      result := 2001;
    end;
  end;
end;

//RSP调用插件自定义的管理界面,没有时直接返回0
function ShowPlugin:Integer; stdcall;
begin
  try
    //开始显示主界面窗体
    result := 0;
  except
    on E:Exception do
      begin
        GLastError := E.Message;
        result := 2002;
      end;
  end;
end;

exports
  SetParams,GetLastError,GetPlugInDisplayName,GetPlugInId,DoExecute,ShowPlugin;
begin

end.




 { ////用SQL语句插入中间表:
  StrSQL:=PChar(
    'insert into INF_GOODS_RELATION '+
    ' (TENANT_ID,RELATION_ID,GODS_ID,GODS_CODE,GODS_NAME,SORT_ID2,SORT_ID6,NEW_INPRICE,NEW_OUTPRICE,UPDATE_FLAG) '+
    ' select '+TENANT_ID+' as TENANT_ID,'+InttoStr(NT_RELATION_ID)+' as RELATION_ID,A.GODS_ID,A.GODS_CODE,A.GODS_NAME,'+Sort_ID2+','+Sort_ID6+','+Box_InPrice+','+Box_OutPrice+',(case when coalesce(B.GODS_ID,'''')<>'''' then 1 else 0 end) as UPDATE_FLAG '+
    ' from RIM_GOODS_RELATION A '+
    ' left join VIW_BARCODE B on A.BOX_BARCODE=B.BARCODE '+
    ' where A.TENANT_ID='''+ORGAN_ID+''' ');
  PlugIntf.ExecSQL(StrSQL,iRet);  }
