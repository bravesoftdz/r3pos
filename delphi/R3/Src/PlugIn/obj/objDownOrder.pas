unit objDownOrder;

interface

uses
  SysUtils,Classes,Dialogs,ZBase,zIntf,ZDataSet;

type
  //下载订单列表
  TDownOrder=class(TZFactory)
  private
    TenID: string;     //R3终端企业ID
    ShopID: string;    //R3终端门店ID
    COM_ID: string;    //Rim烟草公司ID
    CUST_ID: string;   //Rim零售户ID
    pTenID: string;    //R3终端烟草公司名称
    pTenName: string;  //R3终端烟草公司名称
    //返回Rim零售户CUST_ID及零售户所属的COM_ID;
    function SetRimORGAN_CUST_ID(AGlobal:IdbHelp): Boolean;
    //返回R3烟草公司的TenID,TenName;
    function SetR3TenID_Name(AGlobal:IdbHelp): Boolean;
    //调用返回订单的表体数据；
    function DLLDoExecute(AGlobal:IdbHelp; var vData: OleVariant): integer;
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  //下载订单明细
  TDownIndeData=class(TZFactory)
  private
    function DLLDoExecute(AGlobal:IdbHelp; var vData: OleVariant): integer;
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;  


implementation

uses ZPlugIn, ZlogFile;

{ TDownOrder }       

function TDownOrder.SetRimORGAN_CUST_ID(AGlobal:IdbHelp): Boolean;
var
  Rs: TZQuery;
begin
  result:=False;
  COM_ID:='';
  CUST_ID:='';
  try
    Rs:=TZQuery.Create(nil);
    try
      Rs.SQL.Text:=
        'select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID from RM_CUST A,CA_SHOP_INFO B '+
        ' where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+TenID+' and B.SHOP_ID='''+ShopID+''' ';
      if AGlobal.Open(Rs) then
      begin
        COM_ID:=trim(Rs.fieldbyName('COM_ID').AsString);
        CUST_ID:=trim(Rs.fieldbyName('CUST_ID').AsString);
      end;
      result:=true;
    except
      on E:Exception do
      begin
        Raise Exception.Create(Pchar('传入<SHOP_ID='+ShopID+'> 返回Rim.COM_ID,CUST_ID出错：'+E.Message));
      end;
    end;
  finally
    rs.Free;
  end;
end;

function TDownOrder.SetR3TenID_Name(AGlobal: IdbHelp): Boolean;
var
  Rs: TZQuery;
begin
  result:=False;
  pTenID:='';
  pTenName:='';
  try
    Rs:=TZQuery.Create(nil);
    try
      //供应链关系表[返回传入企业所有下级企业]:
      Rs.SQL.Text:=
        'select T.TENANT_ID as TENANT_ID,T.TENANT_NAME as TENANT_NAME from CA_TENANT T,CA_RELATIONS R '+
        '  where T.TENANT_ID=R.TENANT_ID and T.COMM not in (''02'',''12'') and R.RELATI_ID='+TenID+' and R.RELATION_ID=1000006 ';
      if AGlobal.Open(Rs) then
      begin
        pTenID:=trim(Rs.fieldbyName('TENANT_ID').AsString);
        pTenName:=trim(Rs.fieldbyName('TENANT_NAME').AsString);
      end;
      result:=true;
    except
      on E:Exception do
      begin
        Raise Exception.Create(Pchar('传入<SHOP_ID='+ShopID+'> 返回R3烟草公司.TenID,TenName出错：'+E.Message));
      end;
    end;
  finally
    rs.Free;
  end;
end;

function TDownOrder.DLLDoExecute(AGlobal:IdbHelp; var vData: OleVariant): integer;
var
  NearDate: string;
  Rs: TZQuery;
begin
  result:=-1;
  NearDate:=FormatDatetime('YYYYMMDD',Date()-30); //获取最近30天的订单日期
  try
    Rs:=TZQuery.Create(nil);
    try
      Rs.SQL.Text:=
        'select '+TenID+' as TENANT_ID,'+
          ''''+ShopID+''' as SHOP_ID,'+
          ''''+pTenID+''' as CLIENT_ID,'+
          ''''+pTenName+''' as CLIENT_NAME,'+          
          'A.CO_NUM as INDE_ID,'+
          'A.CRT_DATE as INDE_DATE,'+
          'A.QTY_SUM as INDE_AMT,'+
          'A.AMT_SUM as INDE_MNY,'+
          'sum(QTY_NEED) as NEED_AMT,'+
          'A.STATUS as STATUS,'+
          'A.ARR_DATE as ARR_DATE '+
        ' from RIM_SD_CO A,RIM_SD_CO_LINE B '+
        ' where A.CO_NUM=B.CO_NUM and A.COM_ID='''+COM_ID+''' and A.CUST_ID='''+CUST_ID+''' and A.STATUS in (''04'',''05'',''06'') and A.CRT_DATE>='''+NearDate+''' and '+
        ' not exists(select COMM_ID from STK_STOCKORDER C where C.COMM_ID=A.CO_NUM and C.TENANT_ID='+TenID+' and C.SHOP_ID='''+ShopID+''' and C.STOCK_DATE>='+NearDate+') '+
        ' group by A.CO_NUM,A.CRT_DATE,A.QTY_SUM,A.AMT_SUM,A.ARR_DATE,A.STATUS ';
      if AGlobal.Open(Rs) then
      begin
        vData:=Rs.Data;
        result:=0;
      end;
    except
      on E:Exception do
      begin
        Raise Exception.Create('下载订单（RIM_SD_CO）出错：'+E.Message); //写异常日志;
      end;
    end;
  finally
    Rs.Free;
  end;
end;

function TDownOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  vData: OleVariant;
  Str, IndeTab: string;
begin
  result:=False;
  //读取R3企业ID、门店ID
  TenID:=IntToStr(Params.ParamByName('TENANT_ID').AsInteger);
  ShopID:=trim(Params.ParamByName('SHOP_ID').AsString);
  //Rim的烟草公司、零售户ID
  SetRimORGAN_CUST_ID(AGlobal);
  //R3的烟草公司、名称
  SetR3TenID_Name(AGlobal);

  //判断卷烟供应链供应关系：
  if pTenID='' then Raise Exception.Create('R3门店ID［'+ShopID+'］没有找到R3的烟草公司ID［卷烟供应链关系有错］！');
  //判断是否对照关系是否正常
  if (COM_ID='') or (CUST_ID='') then Raise Exception.Create('R3门店ID［'+ShopID+'］没有找到RIM系统零售户［许可证号没对应上］！');

  try
    if DLLDoExecute(AGlobal, vData)=0 then
    begin
      TZQuery(DataSet).Data:=vData;
      result:=true;
    end;
  except
    Raise;
  end;
end;

procedure TDownOrder.InitClass;
begin
  inherited;

end;

{ TDownIndeData }

function TDownIndeData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  vData: OleVariant; 
  Str,TENANT_ID,IndeID: string;
begin
  result:=False;
  IndeID:=Params.ParamByName('INDE_ID').AsString;
  TENANT_ID:=Params.ParamByName('TENANT_ID').AsString;

  try
    //执行插件将RIM_SD_CO对接到:中间表[INF_INDEORDER]:
    if DLLDoExecute(AGlobal,vData)=0 then
    begin
      TZQuery(DataSet).Data:=vData;
      result:=true;
    end;

    //返回订单明细表Data
    Str:='select INDE_ID,GODS_ID,SECOND_ID,UNIT_ID,NEED_AMT,CHK_AMT,AMOUNT,APRICE,PRI3,AGIO_MONEY,AMONEY,CALC_AMOUNT from INF_INDEDATA '+
         ' where TENANT_ID='+TENANT_ID+' and INDE_ID='''+IndeID+''' ';

    //返回查询结果集:
    
    SelectSQL.Text:=Str;
    result:=true;
  except
    Raise;
  end;
end;

{== 缩放比例计算: R3.数量 ÷ZOOM_RATE =Rim.数量 若都为计量单位则不变缩放系数 ==}
{== 如:大为杜夫:  R3:1条=10盒; Rim:1条=20盒; 换算系数ZOOM_RATE:2 ==}
function TDownIndeData.DLLDoExecute(AGlobal: IdbHelp; var vData: OleVariant): integer;
var
  TenID: string;     //R3终端企业ID
  ShopID: string;    //R3终端门店ID
  INDE_ID: string;   //订单ID
  Rs: TZQuery;
begin
  result:=-1;
  TenID:=IntToStr(Params.ParamByName('TENANT_ID').AsInteger);
  ShopID:=trim(Params.ParamByName('SHOP_ID').AsString);
  INDE_ID:=trim(Params.ParamByName('INDE_ID').AsString);

  Rs:=TZQuery.Create(nil);
  try
    try
      case AGlobal.iDbType of
       1: //Oracle
        begin
          //'insert into INF_INDEDATA(TENANT_ID,INDE_ID,GODS_ID,UNIT_ID,NEED_AMT,CHK_AMT,AMOUNT,APRICE,AMONEY,AGIO_MONEY) '+
          Rs.SQL.Text:=
             ' select CO_NUM as INDE_ID,'+
             ' B.GODS_ID as GODS_ID,'+
             ' ''95331F4A-7AD6-45C2-B853-C278012C5525'' as UNIT_ID,'+
             ' sum(QTY_NEED*nvl(B.ZOOM_RATE,1.0)) as NEED_AMT,'+   //ITEM_ID,
             ' sum(QTY_VFY*nvl(B.ZOOM_RATE,1.0)) as CHK_AMT,'+
             ' sum(QTY_ORD*nvl(B.ZOOM_RATE,1.0)) as AMOUNT,'+
             ' (case when sum(QTY_ORD*nvl(B.ZOOM_RATE,1.0))<>0 then cast(sum(AMT)as decimal(18,3))/cast(sum(QTY_ORD*nvl(B.ZOOM_RATE,1.0)) as decimal(18,3)) else 0 end) as APRICE,'+
             ' sum(AMT) as AMONEY,'+
             ' sum(RET_AMT) as AGIO_MONEY '+
             ' from RIM_SD_CO_LINE A '+
             ' left outer join (select GODS_ID,SECOND_ID,COMM_ID,ZOOM_RATE from VIW_GOODSINFO where TENANT_ID='+TenID+' and COMM not in (''02'',''12''))B '+
             ' on (A.ITEM_ID=B.SECOND_ID) or (INSTR(B.COMM_ID,'','' || A.ITEM_ID || '','', 1, 1)>0) '+  //加条件：
             ' where A.CO_NUM='''+INDE_ID+''' '+
             ' group by CO_NUM,B.GODS_ID ';  //,ITEM_ID
        end;
       4: //DB2
        begin                                                     //SECOND_ID,
          //'insert into INF_INDEDATA(TENANT_ID,INDE_ID,GODS_ID,UNIT_ID,NEED_AMT,CHK_AMT,AMOUNT,APRICE,AMONEY,AGIO_MONEY) '+
          Rs.SQL.Text:=
             ' select CO_NUM as INDE_ID,'+
             ' B.GODS_ID as GODS_ID,'+
             ' ''95331F4A-7AD6-45C2-B853-C278012C5525'' as UNIT_ID,'+
             ' sum(QTY_NEED*coalesce(B.ZOOM_RATE,1.0)) as NEED_AMT,'+
             ' sum(QTY_VFY*coalesce(B.ZOOM_RATE,1.0)) as CHK_AMT,'+
             ' sum(QTY_ORD*coalesce(B.ZOOM_RATE,1.0)) as AMOUNT,'+
             ' (case when sum(QTY_ORD*coalesce(B.ZOOM_RATE,1.0))<>0 then cast(sum(AMT)as decimal(18,3))/cast(sum(QTY_ORD*coalesce(B.ZOOM_RATE,1.0)) as decimal(18,3)) else 0 end) as APRICE,'+
             ' sum(AMT) as AMONEY,'+
             ' sum(RET_AMT) as AGIO_MONEY '+
             ' from RIM_SD_CO_LINE A '+
             ' left outer join (select GODS_ID,SECOND_ID,COMM_ID,ZOOM_RATE from VIW_GOODSINFO where TENANT_ID='+TenID+' and COMM not in (''02'',''12''))B '+
             ' on (A.ITEM_ID=B.SECOND_ID) or (locate('','' || A.ITEM_ID || '','',B.COMM_ID)>0) '+  //加条件：
             ' where A.CO_NUM='''+INDE_ID+''' '+
             ' group by CO_NUM,B.GODS_ID ';
        end;
      end;
      if AGlobal.Open(Rs) then
      begin
        vData:=Rs.Data;
        result:=0;
      end;
    except
      on E:Exception do
      begin
        Raise Exception.Create('下载订单明细（RIM_SD_CO_LINE）出错：'+E.Message);
      end;
    end;
  finally
    Rs.Free;
  end;
end;

procedure TDownIndeData.InitClass;
begin
  inherited;

end;

initialization
  RegisterClass(TDownOrder);
  RegisterClass(TDownIndeData); 

finalization
  UnRegisterClass(TDownOrder);
  UnRegisterClass(TDownIndeData);

end.
