unit objCaFactory;

interface
uses Dialogs,SysUtils,ZBase,Classes, ZDataSet,ZIntf,ObjCommon,DB,math;
type
  TcoLogin=class(TZFactory)
  private
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TcheckUprade=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TdownloadCaModule=class(TZFactory)
  private
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TcoGetTenant=class(TZFactory)
  private
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TcoGetShop=class(TZFactory)
  private
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
implementation
uses IniFiles,EncDec;
{ TCaFactory }

function TcoLogin.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
  tid,i:integer;
  sid,srvrId,prodId,prodFlag,prodName,industry,auditStatus:string;
  f:TIniFile;
  ls:TStringList;
begin
  DataSet.Close;
  DataSet.FieldDefs.Clear;
  DataSet.FieldDefs.Add('code',ftString,1);
  DataSet.FieldDefs.Add('dbId',ftInteger,0);
  DataSet.FieldDefs.Add('tenantId',ftInteger,0);
  DataSet.FieldDefs.Add('srvrId',ftString,10);
  DataSet.FieldDefs.Add('shopId',ftString,13);
  DataSet.FieldDefs.Add('prodFlag',ftString,10);
  DataSet.FieldDefs.Add('industry',ftString,10);
  DataSet.FieldDefs.Add('prodId',ftString,10);
  DataSet.FieldDefs.Add('prodName',ftString,100);
  DataSet.FieldDefs.Add('srvrName',ftString,50);
  DataSet.FieldDefs.Add('hostName',ftString,50);
  DataSet.FieldDefs.Add('srvrPort',ftInteger,0);
  DataSet.FieldDefs.Add('srvrPath',ftString,255);
  DataSet.FieldDefs.Add('srvrStatus',ftInteger,0);
  TZQuery(DataSet).CreateDataSet;
  rs := TZQuery.Create(nil);
  f  := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  ls := TStringList.Create;
  try
    case Params.ParamByName('flag').AsInteger of
    1,2:rs.SQL.Text := 'select TENANT_ID,PASSWRD,PROD_ID,AUDIT_STATUS,SRVR_ID from CA_TENANT where LOGIN_NAME=:LOGIN_NAME';
    3:rs.SQL.Text := 'select A.TENANT_ID,A.SHOP_ID,B.PROD_ID,B.AUDIT_STATUS,B.SRVR_ID from CA_SHOP_INFO A,CA_TENANT B where A.TENANT_ID=B.TENANT_ID and A.XSM_CODE=:LOGIN_NAME';
    end;
    rs.ParamByName('LOGIN_NAME').AsString := Params.ParambyName('loginName').AsString;
    AGlobal.Open(rs);
    if rs.IsEmpty and (Params.ParamByName('flag').AsInteger=3) then
       begin
         rs.Close;
         rs.SQL.Text := 'select TENANT_ID,PASSWRD,PROD_ID,AUDIT_STATUS,SRVR_ID from CA_TENANT where LOGIN_NAME=:LOGIN_NAME';
         rs.ParamByName('LOGIN_NAME').AsString := Params.ParambyName('loginName').AsString;
         Params.ParambyName('flag').AsInteger := 2;
         AGlobal.Open(rs);
       end;
    srvrId := rs.FieldbyName('SRVR_ID').AsString;
    if rs.IsEmpty then Raise Exception.Create('注册的用户名无效');
    if (Params.ParamByName('flag').AsInteger=1) and (rs.Fields[1].asString=EncStr(Params.ParamByName('PassWrd').AsString,ENC_KEY)) then Raise Exception.Create('登录密码无效');
    tid := rs.FieldbyName('TENANT_ID').AsInteger;
    sid := rs.FieldbyName('TENANT_ID').AsString+'0001';
    prodId := rs.FieldbyName('PROD_ID').AsString;
    if rs.FieldbyName('AUDIT_STATUS').AsString='2' then
       auditStatus := '1'
    else
       auditStatus := '0';
    if (Params.ParamByName('flag').AsInteger=3) then sid := rs.Fields[1].AsString;
    rs.Close;
    rs.SQL.Text := 'select industry,prod_Flag,prod_Name from CA_PROD_INFO where PROD_ID=:PROD_ID';
    rs.Params.ParamByName('PROD_ID').AsString := prodId;
    AGlobal.Open(rs);
    if rs.IsEmpty then Raise Exception.Create(prodId+'软件产品在服务器上没找到');
    prodFlag := rs.FieldbyName('prod_Flag').AsString;
    industry := rs.FieldbyName('industry').AsString;
    prodName := rs.FieldbyName('prod_Name').AsString;
    f.ReadSections(ls);
    for i:=0 to ls.count-1 do
      begin
         if copy(ls[i],1,2)='H_' then
            begin
               DataSet.Append;
               DataSet.FieldByName('code').AsString := auditStatus;
               DataSet.FieldByName('dbId').AsInteger := f.ReadInteger('db','dbid',-1);
               DataSet.FieldByName('tenantId').AsInteger := tid;
               DataSet.FieldByName('shopId').AsString := sid;
               DataSet.FieldByName('prodFlag').AsString := prodFlag;
               DataSet.FieldByName('industry').AsString := industry;
               DataSet.FieldByName('prodId').AsString := prodId;
               DataSet.FieldByName('prodName').AsString := prodName;

               DataSet.FieldByName('srvrId').AsString := srvrId;
               DataSet.FieldByName('srvrPort').AsInteger := f.ReadInteger(ls[i],'srvrPort',1024);
               DataSet.FieldByName('srvrName').AsString := f.ReadString(ls[i],'srvrName','');
               DataSet.FieldByName('hostName').AsString := f.ReadString(ls[i],'hostName','');
               DataSet.FieldByName('srvrPath').AsString := f.ReadString(ls[i],'srvrPath','');
               DataSet.FieldByName('srvrStatus').AsInteger := 1;
               DataSet.Post;
            end;
      end;
    if DataSet.IsEmpty then Raise Exception.Create('服务器的环境没有配置完毕,请联系客服人员!'); 
  finally
    ls.Free;
    f.free;
    rs.Free;
  end;
  result := true;
end;

{ TcheckUprade }

function TcheckUprade.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
function CompareVersion(v1,v2:string):Boolean;
var L1,L2:TStringList;
  v11,v12,v13,v14:Integer;
  v21,v22,v23,v24:Integer;
begin
  L1 := TStringList.Create;
  L2 := TStringList.Create;
  try
    L1.Delimiter := '.';
    L1.DelimitedText := v1;
    L2.Delimiter := '.';
    L2.DelimitedText := v2;

    if L1.Count >= 1 then v11 := StrtoIntDef(L1[0],0) else v11 := 0;
    if L1.Count >= 2 then v12 := StrtoIntDef(L1[1],0) else v12 := 0;
    if L1.Count >= 3 then v13 := StrtoIntDef(L1[2],0) else v13 := 0;
    if L1.Count >= 4 then v14 := StrtoIntDef(L1[3],0) else v14 := 0;

    if L2.Count >= 1 then v21 := StrtoIntDef(L2[0],0) else v21 := 0;
    if L2.Count >= 2 then v22 := StrtoIntDef(L2[1],0) else v22 := 0;
    if L2.Count >= 3 then v23 := StrtoIntDef(L2[2],0) else v23 := 0;
    if L2.Count >= 4 then v24 := StrtoIntDef(L2[3],0) else v24 := 0;

    if v11>v21 then
       result := true
    else
    if v11<v21 then
       result := false
    else
    if v12>v22 then
       result := true
    else
    if v12<v22 then
       result := false
    else
    if v13>v23 then
       result := true
    else
    if v13<v23 then
       result := false
    else
    if v14>v24 then
       result := true
    else
       result := false;
  finally
    L1.Free;
    L2.Free;
  end;
end;
var
  F:TIniFile;
  newVersion,curVersion:string;
  prms:TftParamList;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'upd.cfg');
  prms := TftParamList.Create(nil);
  try
    newVersion := F.ReadString(Params.ParambyName('prodId').AsString,'version','3.0.0.0');
    curVersion := Params.ParambyName('curVeraion').AsString;
    if CompareVersion(newVersion,curVersion) then
       begin
         prms.parambyname('upgradeType').AsString := F.ReadString(Params.ParambyName('prodId').AsString,'upgradeType','1');
       end
    else
       prms.parambyname('upgradeType').AsString := '3';
    prms.parambyname('newVersion').AsString := newVersion;
    prms.parambyname('pkgDownloadUrl').AsString := F.ReadString(Params.ParambyName('prodId').AsString,'url','');
    msg := TftParamList.Encode(Prms);
    result := true;
  finally
    prms.Free;
    F.Free;
  end;
end;

{ TdownloadCaModule }

function TdownloadCaModule.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  temp:TZQuery;
begin
  temp:=TZQuery.Create(nil);
  try
    temp.SQL.Text := 'select count(*) from CA_MODULE where PROD_ID=:PROD_ID and TIME_STAMP>:TIME_STAMP';
    temp.ParamByName('PROD_ID').AsString := Params.ParambyName('prodId').AsString;
    temp.ParamByName('TIME_STAMP').Value := Params.ParambyName('timeStamp').Value;
    AGlobal.Open(temp);
    if temp.IsEmpty then
       selectSQL.Text := 'select * from CA_MODULE where PROD_ID is null'
    else
       selectSQL.Text := 'select * from CA_MODULE where PROD_ID=:prodId';
    result := true;
  finally
    temp.Free;
  end;
end;

{ TcoGetTenant }

function TcoGetTenant.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  selectSQL.Text := 'select * from CA_TENANT where TENANT_ID=:tenantId';
  result := true;
end;

{ TcoGetShop }

function TcoGetShop.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  selectSQL.Text := 'select * from CA_SHOP_INFO where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';
  result := true;
end;

initialization
  RegisterClass(TcoLogin);
  RegisterClass(TcheckUprade);
  RegisterClass(TdownloadCaModule);
  RegisterClass(TcoGetTenant);
  RegisterClass(TcoGetShop);
finalization
  UnRegisterClass(TcoLogin);
  UnRegisterClass(TcheckUprade);
  UnRegisterClass(TdownloadCaModule);
  UnRegisterClass(TcoGetTenant);
  UnRegisterClass(TcoGetShop);
end.
