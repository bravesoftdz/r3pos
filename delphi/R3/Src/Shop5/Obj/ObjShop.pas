unit ObjShop;

interface
uses Windows,Dialogs,SysUtils,ZBase,Classes,ZIntf,AdoDb,ObjCommon,ZDataset;
type
  TShop=class(TZFactory)
  public
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True ������޸ĵ�ǰ��¼
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  TIntoShop=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
implementation

{ TShop }

function TShop.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
    Str:String;
begin
  try
    rs := TZQuery.Create(nil);
    rs.SQL.Text := 'select IN_MNY,OUT_MNY,BALANCE from ACC_ACCOUNT_INFO where COMM not in (''12'',''02'') and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PAYM_ID=''A''';
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsOldInteger;
    rs.ParamByName('SHOP_ID').AsString := FieldByName('SHOP_ID').AsString;
    AGlobal.Open(rs);
    if rs.FieldByName('BALANCE').AsInteger > 0 then
      Raise Exception.Create('���ŵ���ֽ��˻��������,����ɾ��!');
    else
      begin
        Str := 'delete from ACC_ACCOUNT_INFO where SHOP_ID=:OLD_SHOP_ID and TENANT_ID=:TENANT_ID';
        AGlobal.ExecSQL(Str,Self);
      end;
  finally
  end;

end;

function TShop.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
 //
end;

function TShop.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
//
end;

procedure TShop.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields:='SHOP_ID';
  SelectSQL.Text := 'Select SHOP_ID,SHOP_NAME,SHOP_SPELL,LICENSE_CODE,TENANT_ID,LINKMAN,TELEPHONE,FAXES,ADDRESS,POSTALCODE,REMARK,'+
  'REGION_ID,SHOP_TYPE,SEQ_NO From CA_SHOP_INFO where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID order by SEQ_NO';
  IsSQLUpdate := True;
  Str := 'insert into CA_SHOP_INFO(SHOP_ID,SHOP_NAME,SHOP_SPELL,LICENSE_CODE,TENANT_ID,LINKMAN,TELEPHONE,FAXES,ADDRESS,POSTALCODE,REMARK,REGION_ID,SHOP_TYPE,SEQ_NO,COMM,TIME_STAMP) '
       + 'VALUES(:SHOP_ID,:SHOP_NAME,:SHOP_SPELL,:LICENSE_CODE,:TENANT_ID,:LINKMAN,:TELEPHONE,:FAXES,:ADDRESS,:POSTALCODE,:REMARK,:REGION_ID,:SHOP_TYPE,:SEQ_NO,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update CA_SHOP_INFO set SHOP_TYPE=:SHOP_TYPE,SHOP_NAME=:SHOP_NAME,SHOP_SPELL=:SHOP_SPELL,LICENSE_CODE=:LICENSE_CODE,TELEPHONE=:TELEPHONE,FAXES=:FAXES,ADDRESS=:ADDRESS,POSTALCODE=:POSTALCODE,'
    +'REMARK=:REMARK,LINKMAN=:LINKMAN,SEQ_NO=:SEQ_NO,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where SHOP_ID=:OLD_SHOP_ID and TENANT_ID=:OLD_TENANT_ID';
  UpdateSQL.Text := Str;
  Str := 'update CA_SHOP_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where SHOP_ID=:OLD_SHOP_ID and TENANT_ID=:OLD_TENANT_ID';
  DeleteSQL.Text := Str;
end;

{ TIntoShop }

function TIntoShop.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
//var SHOP_ID1,SHOP_ID2,LEVEL_ID,Str:string;//SHOP_ID1 ԭ���ܵ�ID,SHOP_ID2 Ҫװ�����ܵ���ŵ�ID
begin
  {Result:=False;
  AGlobal.BeginTrans;
  try
    SHOP_ID1:=Params.ParamByName('SHOP_ID1').asString;
    SHOP_ID2:=Params.ParamByName('SHOP_ID2').asString;
    LEVEL_ID:=Params.ParamByName('LEVEL_ID').asString;
    Str:='update CA_SHOP_INFO set UPCOMP_ID=NULL,LEVEL_ID='''+SHOP_ID2+''',SHOP_TYPE=1 '
    + ',COMM=''01'','
    + 'TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where SHOP_ID='''+SHOP_ID2+'''';
    AGlobal.ExecSQL(Str,Self); //�޸�Ҫת�����ܵ���ŵ��UPCOMP_ID��LEVEL_ID
    Str:='update CA_COMPANY set LEVEL_ID='''+SHOP_ID2+'''+substring(LEVEL_ID,len('''+LEVEL_ID+''')+1,50)  '
    + ',COMM=''01'','
    + 'TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where LEVEL_ID like '''+LEVEL_ID+'%''';
    AGlobal.ExecSQL(Str,Self);//�޸ġ�Ҫת�����ܵ���ŵꡱ���¼��ŵ��LEVEL_ID
    Str:='update CA_COMPANY set UPCOMP_ID='''+SHOP_ID2+''',LEVEL_ID='''+SHOP_ID2+'''+LEVEL_ID,COMP_TYPE=2 '
    + ',COMM=''01'','
    + 'TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+ ' where COMP_ID='''+SHOP_ID1+'''';
    AGlobal.ExecSQL(Str,Self);//�޸�ԭ�ܵ��UPCOMP_ID��LEVEL_ID
    Str:='update CA_COMPANY set UPCOMP_ID='''+SHOP_ID2+''',LEVEL_ID='''+SHOP_ID2+'''+substring(LEVEL_ID,4,50) '
    + ',COMM=''01'','
    + 'TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where UPCOMP_ID='''+SHOP_ID1+'''';
    AGlobal.ExecSQL(Str,Self);//�޸�ԭ�ܵ�ĵ�һ���¼��ŵ��UPCOMP_ID��LEVEL_ID
    Str:='update CA_COMPANY set LEVEL_ID='''+SHOP_ID2+'''+substring(LEVEL_ID,4,50) '
    + ',COMM=''01'','
    + 'TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where LEVEL_ID like '''+SHOP_ID1+'%''';
    AGlobal.ExecSQL(Str,Self);//�޸�ԭ�ܵ���¼��ŵ��LEVEL_ID
    AGlobal.CommitTrans;
    Result:=True;
  except
    on E:Exception do
       begin
         Msg := E.Message;
         AGlobal.RollbackTrans;
       end;
  end;}
end;

initialization
  RegisterClass(TShop);
  RegisterClass(TIntoShop);
finalization
  UnRegisterClass(TShop);
  UnRegisterClass(TIntoShop);
end.
