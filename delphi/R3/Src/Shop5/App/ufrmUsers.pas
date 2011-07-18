unit ufrmUsers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, Grids, DBGridEh, cxControls, cxContainer, cxEdit, cxTextEdit,
  StdCtrls, RzLabel, ComCtrls, ToolWin, DB, ZBase, EncDec,
  FR_Class, jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset, PrnDbgeh,
  cxMaskEdit, cxButtonEdit, zrComboBoxList, cxDropDownEdit;

type
  TfrmUsers = class(TframeToolForm)
    RzPanel1: TRzPanel;
    DBGridEh1: TDBGridEh;
    RzPanel6: TRzPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtKey: TcxTextEdit;
    Ds_Users: TDataSource;
    But_Add: TToolButton;
    But_Delete: TToolButton;
    But_Edit: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    But_Info: TToolButton;
    But_Print: TToolButton;
    But_Preview: TToolButton;
    ToolButton4: TToolButton;
    actRights: TAction;
    btnOk: TRzBitBtn;
    stbPanel: TPanel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Cds_Users: TZQuery;
    PrintDBGridEh1: TPrintDBGridEh;
    N2: TMenuItem;
    actPasswordReset: TAction;
    Bevel1: TBevel;
    Label3: TLabel;
    RzLabel22: TRzLabel;
    RzLabel13: TRzLabel;
    RzLabel6: TRzLabel;
    fndSEX: TRadioGroup;
    fndDEPT_ID: TzrComboBoxList;
    labDEGREES: TRzLabel;
    fndDEGREES: TcxComboBox;
    lab_DUTY_IDS: TRzLabel;
    fndDUTY_IDS: TzrComboBoxList;
    RzLabel1: TRzLabel;
    fndState: TRadioGroup;
    fndSHOP_ID: TzrComboBoxList;
    N3: TMenuItem;
    Excel1: TMenuItem;
    procedure actFindExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure edtKeyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actRightsExecute(Sender: TObject);
    procedure Cds_UsersAfterScroll(DataSet: TDataSet);
    procedure N1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPasswordResetExecute(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure Excel1Click(Sender: TObject);
  private
    //IsCompany:Boolean;
    //ccid:string;
    { Private declarations }
    function CheckCanExport:Boolean;
    procedure PrintView;
    procedure IniDegrees;
  public
    { Public declarations }
    procedure InitGrid;
    procedure AddRecord(AObj:TRecord_);
    function  PrintSQL:string;    
  end;


implementation
uses ufrmUsersInfo, ufrmBasic, uframeDialogForm, uGlobal, objCommon, uShopUtil, uFnUtil,
     uDsUtil, ufrmUserRights, uShopGlobal, ufrmEhLibReport, uCtrlUtil, ufrmExcelFactory;//ufrmFastReport,
{$R *.dfm}

procedure TfrmUsers.actFindExecute(Sender: TObject);
var str:string;
begin
  inherited;
  //查自已门店用户，及下属直营门店的用户
  if not ShopGlobal.GetChkRight('31500001',1) then Raise Exception.Create('你没有查询'+Caption+'的权限,请和管理员联系.');
  if fndSHOP_ID.AsString <> '' then
    str := ' and a.SHOP_ID = '+QuotedStr(fndSHOP_ID.AsString);
  if fndDUTY_IDS.AsString <> '' then
    str := str + ' and a.DUTY_IDS = '+QuotedStr(fndDUTY_IDS.AsString);
  if fndDEPT_ID.AsString <> '' then
    str := str + ' and a.DEPT_ID = '+QuotedStr(fndDEPT_ID.AsString);
  if fndDEGREES.Text <> '' then
    str := str + ' and a.DEGREES = '+QuotedStr(TRecord_(fndDEGREES.Properties.Items.Objects[fndDEGREES.ItemIndex]).FieldbyName('CODE_ID').AsString);
  if (fndSEX.ItemIndex <> -1) and (fndSEX.ItemIndex <> 0) then
    str := str + ' and a.SEX = '+QuotedStr(IntToStr(fndSEX.ItemIndex-1));
  if (fndState.ItemIndex <> -1) and (fndState.ItemIndex <> 0) then
    begin
      case fndState.ItemIndex of
        1:str := str + ' and a.WORK_DATE>'+QuotedStr(FormatDateTime('YYYY-MM-DD',Date));
        2:str := str + ' and a.WORK_DATE<'+QuotedStr(FormatDateTime('YYYY-MM-DD',Date))+' and ifnull(a.DIMI_DATE,'+QuotedStr(FormatDateTime('YYYY-MM-DD',Date+1))+')>'+QuotedStr(FormatDateTime('YYYY-MM-DD',Date));
        3:str := str + ' and ifnull(a.DIMI_DATE,'+QuotedStr(FormatDateTime('YYYY-MM-DD',Date+1))+')<'+QuotedStr(FormatDateTime('YYYY-MM-DD',Date));
      end;
   //这里组条件
//  ' case when (WORK_DATE>'+QuotedStr(FormatDateTime('YYYY-MM-DD',Date))+') then 0 '+
//  '     when (WORK_DATE<'+QuotedStr(FormatDateTime('YYYY-MM-DD',Date))+' and ifnull(DIMI_DATE,'+QuotedStr(FormatDateTime('YYYY-MM-DD',Date+1))+')>'+QuotedStr(FormatDateTime('YYYY-MM-DD',Date))+') then 1'+
//  '     when (ifnull(DIMI_DATE,'''')<'+QuotedStr(FormatDateTime('YYYY-MM-DD',Date))+') then 2'+
//  '     else -1 end) as STATUS from CA_USERS a '+

    end;

  if edtKey.Text<>'' then
     str:= str + ' and ( a.USER_NAME LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%')+
                  ' or a.USER_SPELL LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%')+' or a.ACCOUNT LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%')+')';
  Cds_Users.Close;
  Cds_Users.SQL.Text :=
  ParseSQL(Factor.iDbType,
  'select jb.*,b.SHOP_NAME as SHOP_ID_TEXT from( '+
  'select ja.*,a.DEPT_NAME as DEPT_ID_TEXT from('+
  'select TENANT_ID,SHOP_ID,USER_ID,ACCOUNT,ENCODE,USER_NAME,USER_SPELL,PASS_WRD,DEPT_ID,DUTY_IDS,DUTY_NAMES as DUTY_IDS_TEXT,'+
  'ROLE_IDS,ROLE_NAMES as ROLE_IDS_TEXT,SEX,BIRTHDAY,DEGREES,MOBILE,OFFI_TELE,FAMI_TELE,EMAIL,QQ,'+
  'MSN,MM,ID_NUMBER,IDN_TYPE,FAMI_ADDR,POSTALCODE,WORK_DATE,DIMI_DATE,REMARK,COMM from CA_USERS a '+
  'where a.COMM not in (''12'',''02'') and a.TENANT_ID='+IntToStr(Global.TENANT_ID)+str+') ja '+
  'left outer join CA_DEPT_INFO a on ja.TENANT_ID=a.TENANT_ID and ja.DEPT_ID=a.DEPT_ID) jb '+
  'left outer join CA_SHOP_INFO b on jb.TENANT_ID=b.TENANT_ID and jb.SHOP_ID=b.SHOP_ID ORDER BY jb.USER_ID'
  );
  Factor.Open(Cds_Users);
end;

procedure TfrmUsers.actDeleteExecute(Sender: TObject);
  procedure UpdateToGlobal(Str:string);
  var Tmp:TZQuery;
  begin
    Tmp := Global.GetZQueryFromName('CA_USERS');
    if Tmp.Locate('USER_ID',Str,[]) then
    begin
      Tmp.Delete;
      //Tmp.CommitUpdates;
    end;
  end;
var i:integer;
begin
  inherited;
  if (Not Cds_Users.Active) then Exit;
  if (Cds_Users.RecordCount = 0) then Exit;
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('连锁版不允许离线操作!');
  if not ShopGlobal.GetChkRight('31500001',4) then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');
  i:=MessageBox(Handle,Pchar('是否要删除吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
  if i=6 then
  begin
    try
      Cds_Users.CommitUpdates;
      UpdateToGlobal(Cds_Users.FieldByName('USER_ID').AsString);
      Cds_Users.Delete;
      Factor.UpdateBatch(Cds_Users,'TUsers');
    Except
      Cds_Users.CancelUpdates;
      Raise;
    end;
  end;
end;

procedure TfrmUsers.actNewExecute(Sender: TObject);
begin
  inherited;
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('连锁版不允许离线操作!');
  if not ShopGlobal.GetChkRight('31500001',2) then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
  with TfrmUsersInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        Append;
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmUsers.actEditExecute(Sender: TObject);
begin
  inherited;
  if (not Cds_Users.Active) or (Cds_Users.IsEmpty) then exit;
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('连锁版不允许离线操作!');
  if not ShopGlobal.GetChkRight('31500001',3) then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
  with TfrmUsersInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Edit(Cds_Users.FieldByName('USER_ID').AsString);
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmUsers.AddRecord(AObj: TRecord_);
begin
  if not Cds_Users.Active  then exit;
  if Cds_Users.Locate('USER_ID',AObj.FieldByName('USER_ID').AsString,[]) then
  begin
     Cds_Users.Edit;
     AObj.WriteToDataSet(Cds_Users,false);
     Cds_Users.Post;
  end
  else
  begin
     Cds_Users.Append;
     AObj.WriteToDataSet(Cds_Users,false);
     Cds_Users.Post;
  end;
  InitGrid;
  if Cds_Users.Locate('USER_ID',AObj.FieldByName('USER_ID').AsString,[]) then exit;
end;

procedure TfrmUsers.actExitExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmUsers.FormCreate(Sender: TObject);
begin
  inherited;
  InitGrid;
  IniDegrees;
  fndSHOP_ID.DataSet:=Global.GetZQueryFromName('CA_SHOP_INFO');
  fndDUTY_IDS.DataSet := Global.GetZQueryFromName('CA_DUTY_INFO');
  fndDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  TDbGridEhSort.InitForm(self);  
end;

procedure TfrmUsers.actInfoExecute(Sender: TObject);
begin
  inherited;
  if not Cds_Users.Active then Exception.Create('没有数据！');
  if Cds_Users.IsEmpty then Exception.Create('没有数据！');
  with TfrmUsersInfo.Create(self) do
    begin
      try
        Open(Cds_Users.FieldByName('USER_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmUsers.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var  ARect: TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(Cds_Users.RecNo)),length(Inttostr(Cds_Users.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmUsers.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQNO' then
     Background := clBtnFace;
end;

procedure TfrmUsers.InitGrid;
var tmp:TZQuery;
begin
  {try
    DBGridEh1.FieldColumns['SHOP_ID'].PickList.Clear;
    DBGridEh1.FieldColumns['SHOP_ID'].KeyList.Clear;

    tmp := TZQuery.Create(nil);
    tmp.SQL.Text := 'select SHOP_ID,SHOP_NAME from CA_SHOP_INFO where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID ';
    tmp.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(tmp);
    tmp.First;
    while not tmp.Eof do
    begin
      DBGridEh1.FieldColumns['SHOP_ID'].KeyList.Add(tmp.Fields[0].asstring);
      DBGridEh1.FieldColumns['SHOP_ID'].PickList.Add(tmp.Fields[1].asstring);
      tmp.Next;
    end;
  finally
    tmp.Free;
  end;}
end;

procedure TfrmUsers.FormShow(Sender: TObject);
begin
  inherited;
  actFindExecute(nil);
  if edtKey.CanFocus then
  edtKey.SetFocus;
end;

procedure TfrmUsers.edtKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=VK_DOWN then
     Cds_Users.Next;
  if Key=VK_UP then
     Cds_Users.Prior;
end;

procedure TfrmUsers.actRightsExecute(Sender: TObject);
var ROLE_IDS:string;
begin
  inherited;
  if not Cds_Users.Active then exit;
  if Cds_Users.IsEmpty then exit;
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('连锁版不允许离线操作!');
  if not ShopGlobal.GetChkRight('31500001',5) then Raise Exception.Create('你没有授权'+Caption+'的权限,请和管理员联系.');
  ROLE_IDS:=Cds_Users.FieldByName('ROLE_IDS').AsString;
  if TfrmUserRights.ShowUserRight(Cds_Users.FieldByName('USER_ID').AsString,
                                  Cds_Users.FieldByName('USER_NAME').AsString,
                                  Cds_Users.FieldByName('ACCOUNT').AsString,
                                  ROLE_IDS) then
  begin
    if not (Cds_Users.State in [dsInsert,dsEdit]) then
      Cds_Users.Edit;
    Cds_Users.FieldByName('ROLE_IDS').AsString:=ROLE_IDS;
    Cds_Users.Post;
  end;
end;
procedure TfrmUsers.Cds_UsersAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if Cds_Users.RecNo<=0 then  str:='0'
  else str:=IntToStr(Cds_Users.RecNo);
  stbPanel.Caption:='第'+str+'条/共'+inttostr(Cds_Users.RecordCount)+'条';
end;

procedure TfrmUsers.N1Click(Sender: TObject);
begin
  inherited;
  actRightsExecute(nil);
end;

procedure TfrmUsers.FormDestroy(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.FreeForm(self);  
end;

function TfrmUsers.PrintSQL: string;
var str:string;
begin
  inherited;
  {if edtKey.Text<>'' then
     str:=' and ( [USER_NAME] LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%')+
                  ' or A.USER_SPELL LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%')+' or A.ACCOUNT LIKE '+QuotedStr('%'+trim(edtkey.Text)+'%')+')';
  Result:='Select E.DUTY_NAME as 职务,A.ACCOUNT as 用户账号,[USER_NAME] as 用户姓名,C.COMP_NAME as 所在门店,D.CODE_NAME as 性别,A.MOBILE as 移动电话,A.OFFI_TELE as 办公电话,A.FAMI_TELE as 家庭电话,A.EMAIL as 电子邮箱'+
  '  From CA_USERS A  left outer join CA_COMPANY C on A.COMP_ID=C.COMP_ID   left outer join (select CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=''SEX'')D on A.SEX=D.CODE_ID '+
  '  left outer join CA_DEPTDUTY E on A.DUTY_IDS=E.DUTY_ID ' +
  ' Where  A.COMM NOT IN (''02'',''12'')'+str;}
  // and (A.COMP_ID in (select COMP_ID from CA_COMPANY where UPCOMP_ID='''+ccid+''' and COMP_TYPE=2 and COMM<>''02'' and COMM<>''12'') or A.COMP_ID='''+ccid+''')'
end;

procedure TfrmUsers.actPrintExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('31500001',6) then
    Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');

  PrintView;
  PrintDBGridEh1.Print;
end;

procedure TfrmUsers.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('31500001',6) then
    Raise Exception.Create('你没有预览'+Caption+'的权限,请和管理员联系.');
  PrintView;
  with TfrmEhLibReport.Create(self) do
  begin
    try
      Preview(PrintDBGridEh1);
    finally
      free;
    end;
  end;
end;

function TfrmUsers.CheckCanExport: Boolean;
begin
  Result := ShopGlobal.GetChkRight('31500001',7);
end;

procedure TfrmUsers.PrintView;
begin
  PrintDBGridEh1.PageHeader.CenterText.Text := '员工档案管理';

  PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]','']);
  DBGridEh1.DataSource.DataSet.Filtered := False;
  PrintDBGridEh1.DBGridEh := DBGridEh1;
end;

procedure TfrmUsers.actPasswordResetExecute(Sender: TObject);
var Str_Sql:String;
    i:Integer;
begin
  inherited;
  if not Cds_Users.Active then exit;
  if Cds_Users.IsEmpty then exit;  
  if not ShopGlobal.GetChkRight('31500001',8) then
    Raise Exception.Create('你没有密码重置的权限,请和管理员联系.');

  Str_Sql :=
  'update CA_USERS set PASS_WRD='''+EncStr('1234',ENC_KEY)+''',COMM='+GetCommStr(Factor.iDbType)+',TIME_STAMP='+GetTimeStamp(Factor.iDbType)+' where USER_ID='''+Cds_Users.FieldbyName('USER_ID').AsString+''' and TENANT_ID='+IntToStr(Global.TENANT_ID);
  i := Factor.ExecSQL(Str_Sql);
  if i = 0 then
    MessageBox(handle,Pchar('提示:密码重置失败!'),Pchar(Caption),MB_OK)
  else if i > 0 then
    MessageBox(handle,Pchar('提示:密码重置成功!'),Pchar(Caption),MB_OK);
end;

procedure TfrmUsers.DBGridEh1CellClick(Column: TColumnEh);
begin
  inherited;
  if Column.FieldName = 'ROLE_IDS_TEXT' then
    begin
      actRightsExecute(nil);
    end;
end;

procedure TfrmUsers.IniDegrees;
var Tem:TZQuery;
    Aobj_3:TRecord_;
begin
  try
    Tem := TZQuery.Create(nil);
    Tem.Close;
    Tem.SQL.Text := 'select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''14'' and TENANT_ID=0 order by SEQ_NO';
    Factor.Open(Tem);
    if not Tem.IsEmpty then ClearCbxPickList(fndDEGREES);
    Tem.First;
    while not Tem.Eof do
      begin
        Aobj_3 := TRecord_.Create;
        Aobj_3.ReadFromDataSet(Tem);
        fndDEGREES.Properties.Items.AddObject(Tem.FieldbyName('CODE_NAME').AsString,Aobj_3);
        Tem.Next;
      end;
  finally
    Tem.Free;
  end;
end;

procedure TfrmUsers.Excel1Click(Sender: TObject);
  function Check(Source,Dest:TDataSet;SFieldName:string;DFieldName:string):Boolean;
  var rs:TZQuery;
      StrList:TStringList;
      ID,NAME:String;
      i:Integer;
  begin
    if (SFieldName <> '') and (DFieldName <> '') then
      begin
        Result := False;
        // *******************门店********************
        if DFieldName = 'SHOP_ID' then
          begin
            if Source.FieldByName(SFieldName).AsString <> '' then
              begin
                rs := Global.GetZQueryFromName('CA_SHOP_INFO');
                if rs.Locate('SHOP_NAME',Trim(Source.FieldByName(SFieldName).AsString),[]) then
                  begin
                    Dest.FieldByName('SHOP_ID').AsString := rs.FieldByName('SHOP_ID').AsString;
                    Result := True;
                    Exit;
                  end
                else
                  Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的门店代码...');
              end
            else
              Raise Exception.Create('门店不能为空!');
          end;

        //*******************部门*****************
        if DFieldName = 'DEPT_ID' then
          begin
            if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
              begin
                rs := Global.GetZQueryFromName('CA_DEPT_INFO');
                if rs.Locate('DEPT_NAME',Source.FieldByName(SFieldName).AsString,[]) then
                  begin
                    Dest.FieldByName('DEPT_ID').AsString := rs.FieldbyName('DEPT_ID').AsString;
                  end
                else
                  Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的部门代码...');
              end
            else
              Dest.FieldByName('DEPT_ID').AsString := '#';
            Result := True;
            Exit;
          end;

        //*******************职务*****************
        if DFieldName = 'DUTY_IDS' then
          begin
            if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
              begin
                rs := Global.GetZQueryFromName('CA_DUTY_INFO');
                StrList := TStringList.Create;
                try
                  StrList.CommaText := Trim(Source.FieldByName(SFieldName).AsString);
                  for i := 0 to StrList.Count - 1 do
                    begin
                      if rs.Locate('DUTY_NAME',StrList[i],[]) then
                        begin
                          if ID = '' then
                            ID := rs.FieldbyName('DUTY_ID').AsString
                          else
                            ID := ID + ',' + rs.FieldbyName('DUTY_ID').AsString;
                          if NAME = '' then
                            NAME := rs.FieldbyName('DUTY_NAME').AsString
                          else
                            NAME := NAME + ',' + rs.FieldbyName('DUTY_NAME').AsString;
                        end
                      else
                        Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的职务代码...');
                    end;
                  Dest.FieldByName('DUTY_IDS').AsString := ID;
                  Dest.FieldByName('DUTY_IDS_TEXT').AsString := NAME;
                finally
                  StrList.Free;
                end;
              end
            else
              begin
                Dest.FieldByName('DUTY_IDS').AsString := '#';
                Dest.FieldByName('DUTY_IDS_TEXT').AsString := '#';
                //Raise Exception.Create('客户类别不能为空!');
              end;
            Result := True;
            Exit;
          end;

        //*******************学历*****************
        if DFieldName = 'DEGREES' then
          begin
            if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
              begin
                rs := Global.GetZQueryFromName('PUB_DEGREES_INFO');
                if rs.Locate('CODE_NAME',Trim(Source.FieldByName(SFieldName).AsString),[]) then
                  begin
                    Dest.FieldByName('DEGREES').AsString := rs.FieldbyName('CODE_ID').AsString;
                    Result := True;
                    Exit;
                  end
                else
                  Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的学历代码...');
              end;
          end;

        //*******************性别*****************
        if DFieldName = 'SEX' then
          begin
            if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
              begin
                if Length(Source.FieldByName(SFieldName).AsString) > 4  then
                  Raise Exception.Create('会员性别在4个字符以内!')
                else
                  begin
                    if Source.FieldByName(SFieldName).AsString = '女' then
                      Dest.FieldbyName('SEX').AsString := '0'
                    else if Source.FieldByName(SFieldName).AsString = '男' then
                      Dest.FieldbyName('SEX').AsString := '1'
                    else
                      Dest.FieldbyName('SEX').AsString := '2';
                  end;
              end
            else
              Dest.FieldbyName('SEX').AsString := '2';
            Result := True;
            Exit;
          end;

        //用户账号
        if DFieldName = 'ACCOUNT' then
          begin
            if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
              begin
                if Length(Source.FieldByName(SFieldName).AsString) > 20 then
                  Raise Exception.Create('用户账号就在20个字符以内!')
                else
                  begin
                    rs := Global.GetZQueryFromName('CA_USERS');
                    if rs.Locate('ACCOUNT',Source.FieldByName(SFieldName).AsString,[]) then
                      Raise Exception.Create('当前用户账号已经存在!')
                    else
                      begin
                        Dest.FieldbyName('ACCOUNT').AsString := Source.FieldByName(SFieldName).AsString;
                        Result := True;
                        Exit;
                      end;
                  end;
              end;

          end;

        //用户名称
        if DFieldName = 'USER_NAME' then
          begin
            if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
              begin
                if Length(Source.FieldByName(SFieldName).AsString) > 50  then
                  Raise Exception.Create('用户名称就在50个字符以内!')
                else
                  begin
                    Dest.FieldbyName('USER_NAME').AsString := Source.FieldByName(SFieldName).AsString;
                    Result := True;
                    Exit;
                  end;
              end
            else
              Raise Exception.Create('用户名称不能为空!');
          end;

        //用户拼音码
        if DFieldName = 'USER_SPELL' then
          begin
            if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
              begin
                if Length(Source.FieldByName(SFieldName).AsString) > 50  then
                  Raise Exception.Create('用户拼音码就在50个字符以内!')
                else
                  begin
                    Dest.FieldbyName('USER_SPELL').AsString := Source.FieldByName(SFieldName).AsString;
                    Result := True;
                    Exit;
                  end;
              end;
          end;
      end;
  end;
  function SaveExcel(CdsExcel:TDataSet):Boolean;
  begin
    CdsExcel.First;
    while not CdsExcel.Eof do
      begin
        CdsExcel.Edit;
        CdsExcel.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
        CdsExcel.FieldByName('USER_ID').AsString  := TSequence.NewId;
        CdsExcel.FieldByName('ROLE_IDS').AsString := '#';
        CdsExcel.FieldByName('ROLE_IDS_TEXT').AsString := '#';
        CdsExcel.FieldByName('PASS_WRD').AsString := EncStr('1234',ENC_KEY);
        if CdsExcel.FieldByName('USER_SPELL').AsString = '' then
          CdsExcel.FieldByName('USER_SPELL').AsString := fnString.GetWordSpell(Trim(CdsExcel.FieldByName('USER_NAME').AsString),3);

        CdsExcel.Post;
        CdsExcel.Next;
      end;
    Result := Factor.UpdateBatch(CdsExcel,'TUsers',nil);
  end;
  function FindColumn(CdsCol:TDataSet):Boolean;
  begin
    Result := True;
    if not CdsCol.Locate('FieldName','SHOP_ID',[]) then
      begin
        Result := False;
        Raise Exception.Create('缺少门店字段!');
      end;
    if not CdsCol.Locate('FieldName','ACCOUNT',[]) then
      begin
        Result := False;
        Raise Exception.Create('缺少用户账号字段!');
      end;
    if not CdsCol.Locate('FieldName','USER_NAME',[]) then
      begin
        Result := False;
        Raise Exception.Create('缺少用户姓名字段!');
      end;
    if not CdsCol.Locate('FieldName','SEX',[]) then
      begin
        Result := False;
        Raise Exception.Create('缺少性别字段!');
      end;
    if not CdsCol.Locate('FieldName','DEPT_ID',[]) then
      begin
        Result := False;
        Raise Exception.Create('缺少部门字段!');
      end;
    if not CdsCol.Locate('FieldName','DUTY_IDS',[]) then
      begin
        Result := False;
        Raise Exception.Create('缺少职务字段!');
      end;
  end;
var FieldsString,FormatString:String;
    Params:TftParamList;
    rs:TZQuery;
begin
  inherited;
  Params := TftParamList.Create(nil);
  rs := TZQuery.Create(nil);
  try
    Params.ParamByName('USER_ID').asString := '';
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(rs,'TUsers',Params);

    FieldsString := 'ACCOUNT=用户账号,USER_NAME=用户姓名,USER_SPELL=拼音码,SEX=性别,DEPT_ID=部门,DUTY_IDS=职务,SHOP_ID=所属门店,DEGREES=学历,'+
    'IDN_TYPE=证件类型,ID_NUMBER=证件号码,BIRTHDAY=出生日期,WORK_DATE=入职日期,DIMI_DATE=离职日期,REMARK=备注,FAMI_TELE=家庭电话,MOBILE=手机,'+
    'OFFI_TELE=办公电话,QQ=QQ,MSN=MSN,MM=MM,EMAIL=电子邮箱,POSTALCODE=邮政编码,FAMI_ADDR=联系地址';

    FormatString := '0=ACCOUNT,1=USER_NAME,2=USER_SPELL,3=SEX,4=DEPT_ID,5=DUTY_IDS,6=SHOP_ID,7=DEGREES,8=IDN_TYPE,9=ID_NUMBER,10=BIRTHDAY,'+
    '11=WORK_DATE,12=DIMI_DATE,13=REMARK,14=FAMI_TELE,15=MOBILE,16=OFFI_TELE,17=QQ,18=MSN,19=MM,20=EMAIL,21=POSTALCODE,22=FAMI_ADDR';

    TfrmExcelFactory.ExcelFactory(rs,FieldsString,@Check,@SaveExcel,@FindColumn,FormatString,1);

  finally
    Params.Free;
    rs.Free;
  end;
end;

end.
