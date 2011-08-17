unit ufrmClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uFnUtil,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls, RzLabel, ObjCommon,
  RzTabs, ExtCtrls, RzPanel, DB, Grids, DBGridEh, uGlobal, cxControls, cxContainer,
  cxEdit, cxTextEdit, RzButton, ZBase, cxMaskEdit, cxButtonEdit, zrComboBoxList, uDsUtil,
  FR_Class, cxDropDownEdit, PrnDbgeh, jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmClient = class(TframeToolForm)
    RzPanel6: TRzPanel;
    RzPanel1: TRzPanel;
    DBGridEh1: TDBGridEh;
    Ds_Client: TDataSource;
    But_Add: TToolButton;
    But_Delete: TToolButton;
    ToolButton2: TToolButton;
    But_Edit: TToolButton;
    But_Exit: TToolButton;
    But_Info: TToolButton;
    But_Print: TToolButton;
    But_Preview: TToolButton;
    stbPanel: TPanel;
    Label2: TLabel;
    edtKey: TcxTextEdit;
    btnOk: TRzBitBtn;
    Label1: TLabel;
    Label3: TLabel;
    Label40: TLabel;
    fndSORT_ID: TzrComboBoxList;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Cds_Client: TZQuery;
    PrintDBGridEh1: TPrintDBGridEh;
    PopupMenu3: TPopupMenu;
    N14: TMenuItem;
    N15: TMenuItem;
    actfrmIntegral: TAction;
    actNewCard: TAction;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    PopupMenu2: TPopupMenu;
    N10: TMenuItem;
    actDeposit: TAction;
    N5: TMenuItem;
    Excel1: TMenuItem;
    actCancelCard: TAction;
    actPassword: TAction;
    actReturn: TAction;
    actLossCard: TAction;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N11: TMenuItem;
    procedure actNewExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure actInfoExecute(Sender: TObject);
    procedure edtKeyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Cds_ClientAfterScroll(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure Cds_ClientFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure actDepositExecute(Sender: TObject);
    procedure actNewCardExecute(Sender: TObject);
    procedure actfrmIntegralExecute(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
    procedure actReturnExecute(Sender: TObject);
    procedure actLossCardExecute(Sender: TObject);
    procedure actPasswordExecute(Sender: TObject);
    procedure actCancelCardExecute(Sender: TObject);
  private
    sqlstring:string;
    function CheckCanExport:boolean;
    procedure PrintView;
    procedure AddMenuItem;
    procedure ResetClientPswClick(Sender:TObject);
    { Private declarations }
  public
    { Public declarations }
    procedure AddRecord(AObj:TRecord_);
    procedure InitGrid;
  end;

implementation
uses ufrmClientInfo, uShopGlobal,uCtrlUtil,ufrmEhLibReport, ufrmIntegralGlide, ufrmExcelFactory,
     ufrmIntegralGlide_Add, ufrmDeposit, ufrmNewCard, ufrmCancelCard, ufrmReturn, ufrmPassWord,
     ufrmLossCard, ufrmBasic, EncDec;//,ufrmSendGsm
{$R *.dfm}

procedure TfrmClient.actNewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('33300001',2) then Raise Exception.Create('��û������'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  With TfrmClientInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Append;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfrmClient.actDeleteExecute(Sender: TObject);
    procedure UpdateToGlobal(str:string);
    var Temp:TZQuery;
    begin
      Temp := Global.GetZQueryFromName('PUB_CUSTOMER');
      if Temp.Locate('CLIENT_ID',str,[]) then
      begin
        Temp.Delete;
      end;
    end;
var i:integer;
  TemGlobal:TZQuery;
begin
  inherited;
  if (not Cds_Client.Active) and (Cds_Client.IsEmpty) then exit;
  if Cds_Client.State in [dsInsert,dsEdit] then Cds_Client.Post;
  if not ShopGlobal.GetChkRight('33300001',4) then Raise Exception.Create('��û��ɾ��'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  i:=MessageBox(Handle,Pchar('ȷ��Ҫɾ��ѡ�м�¼��?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1+MB_ICONQUESTION);
  if i=6 then
  begin
    TemGlobal := Global.GetZQueryFromName('PUB_CUSTOMER');
    Cds_Client.DisableControls;
    try
      TemGlobal.CommitUpdates;
      Cds_Client.CommitUpdates;
      Cds_Client.Filtered := false;
      Cds_Client.Filter := 'selFlag=''1''';
      Cds_Client.Filtered := true;
      if  Cds_Client.IsEmpty then Raise Exception.Create('��ѡ��Ҫɾ���Ļ�Ա...');
      Cds_Client.First;
      while not Cds_Client.Eof do
      begin
        if Cds_Client.FieldByName('selflag').AsString = '1' then
        begin
          if TemGlobal.Locate('CLIENT_ID',Cds_Client.FieldbyName('CLIENT_ID').AsString,[]) then
            begin
              TemGlobal.Delete;
            end;
          Cds_Client.Delete;
        end
        else
          Cds_Client.Next;
      end;

      try
        Factor.UpdateBatch(Cds_Client,'TClient');
      except
        TemGlobal.CancelUpdates;
        Cds_Client.CancelUpdates;
         Raise;
      end;
    finally
      Cds_Client.Filtered := false;
      Cds_Client.EnableControls;
    end;
  end;
end;

procedure TfrmClient.actFindExecute(Sender: TObject);
var Str_Where,StrText:String;
begin
  inherited;
  if not ShopGlobal.GetChkRight('33300001',1) then Raise Exception.Create('��û�в�ѯ'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  sqlstring:='';
  if edtKey.Text<>'' then
    begin
      sqlstring:=' and (CLIENT_NAME LIKE ''%'+trim(edtKey.Text)+'%'' or CLIENT_SPELL LIKE ''%'+trim(edtKey.Text)+'%'' or CLIENT_CODE LIKE ''%'+trim(edtKey.Text)+'%'' )';
      Str_Where:=Str_Where+sqlstring;
    end;
  if fndSORT_ID.AsString<>'' then
    begin
      sqlstring:=sqlstring+' and SORT_ID='+QuotedStr(fndSORT_ID.AsString);
      Str_Where:=Str_Where+' and SORT_ID='+QuotedStr(fndSORT_ID.AsString);
    end;

  StrText := 'select A.*,B.UNION_ID,B.IC_CARDNO,B.ACCU_INTEGRAL,B.RULE_INTEGRAL,B.INTEGRAL,B.BALANCE from ('+
  'select 0 as selflag,TENANT_ID,CLIENT_ID,CLIENT_TYPE,CLIENT_CODE,LICENSE_CODE,CLIENT_NAME,CLIENT_SPELL,SORT_ID,REGION_ID,SETTLE_CODE,'+
  'ADDRESS,POSTALCODE,LINKMAN,TELEPHONE3,TELEPHONE1,TELEPHONE2,FAXES,HOMEPAGE,EMAIL,QQ,MSN,BANK_ID,ACCOUNT,INVOICE_FLAG,REMARK,TAX_RATE,'+
  'PRICE_ID,SHOP_ID,''#'' as UNION_ID from PUB_CLIENTINFO where COMM not in (''02'',''12'') and CLIENT_TYPE=''2'' and TENANT_ID='+IntToStr(Global.TENANT_ID)
  +Str_Where+') A left join PUB_IC_INFO B on A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.UNION_ID=B.UNION_ID order by A.CLIENT_CODE ';

  Cds_Client.Close;
  Cds_Client.SQL.Text := StrText;
  Factor.Open(Cds_Client);
end;

procedure TfrmClient.actEditExecute(Sender: TObject);
begin
  inherited;
  if (not Cds_Client.Active) or (Cds_Client.IsEmpty) then exit;
  if not ShopGlobal.GetChkRight('33300001',3) then Raise Exception.Create('��û���޸�'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  With TfrmClientInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Edit(Cds_Client.FieldByName('CLIENT_ID').AsString);
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfrmClient.actExitExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmClient.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
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
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(Cds_Client.RecNo)),length(Inttostr(Cds_Client.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end
end;

procedure TfrmClient.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQ_NO' then
     Background := clBtnFace;
  if uppercase(Column.FieldName) = 'SELFLAG' then
     Background := clBtnFace;     
end;

procedure TfrmClient.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (not Cds_Client.Active) or (Cds_Client.IsEmpty) then exit;
  With TfrmClientInfo.Create(self) do
  begin
    try
      Open(Cds_Client.FieldByName('CLIENT_ID').AsString);
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfrmClient.AddRecord(AObj: TRecord_);
begin
  if not Cds_Client.Active  then exit;
  if Cds_Client.Locate('CLIENT_ID',AObj.FieldByName('CLIENT_ID').AsString,[]) then
  begin
     Cds_Client.Edit;
     AObj.WriteToDataSet(Cds_Client,false);
     Cds_Client.Post;
     //Cds_Client.CommitUpdates;
  end
  else
  begin
     Cds_Client.Append;
     AObj.WriteToDataSet(Cds_Client,false);
     Cds_Client.FieldByName('selflag').AsString:='0';
     Cds_Client.Post;
     //Cds_Client.CommitUpdates;
  end;
  InitGrid;
end;

procedure TfrmClient.edtKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=VK_DOWN then
     Cds_Client.Next;
  if Key=VK_UP then
     Cds_Client.Prior;
end;

procedure TfrmClient.FormShow(Sender: TObject);
begin
  inherited;
  if UpperCase(Global.UserID) = UpperCase('ADMIN') then
    AddMenuItem;  
  actFindExecute(nil);
  if edtKey.CanFocus then
    edtKey.SetFocus;
end;

procedure TfrmClient.FormCreate(Sender: TObject);
begin
  inherited;
  InitGrid;
  fndSORT_ID.DataSet:=Global.GetZQueryFromName('PUB_CLIENTSORT');
  TDbGridEhSort.InitForm(self);
end;

procedure TfrmClient.InitGrid;
var tmp:TZQuery;
begin
  DBGridEh1.FieldColumns['SORT_ID'].KeyList.Clear;
  DBGridEh1.FieldColumns['SORT_ID'].PickList.Clear;
  tmp:=Global.GetZQueryFromName('PUB_CLIENTSORT');
  tmp.First;
  while not tmp.Eof do
  begin
    DBGridEh1.FieldColumns['SORT_ID'].KeyList.Add(tmp.Fields[0].asstring);
    DBGridEh1.FieldColumns['SORT_ID'].PickList.Add(tmp.Fields[1].asstring);
    tmp.Next;
  end;

  DBGridEh1.FieldColumns['REGION_ID'].KeyList.Clear;
  DBGridEh1.FieldColumns['REGION_ID'].PickList.Clear;
  tmp:=Global.GetZQueryFromName('PUB_REGION_INFO');
  tmp.First;
  while not tmp.Eof do
  begin
    DBGridEh1.FieldColumns['REGION_ID'].KeyList.Add(tmp.Fields[0].asstring);
    DBGridEh1.FieldColumns['REGION_ID'].PickList.Add(tmp.Fields[1].asstring);
    tmp.Next;
  end;

  DBGridEh1.FieldColumns['PRICE_ID'].KeyList.Clear;
  DBGridEh1.FieldColumns['PRICE_ID'].PickList.Clear;
  tmp:=Global.GetZQueryFromName('PUB_PRICEGRADE');
  tmp.First;
  while not tmp.Eof do
  begin
    DBGridEh1.FieldColumns['PRICE_ID'].KeyList.Add(tmp.Fields[1].asstring);
    DBGridEh1.FieldColumns['PRICE_ID'].PickList.Add(tmp.Fields[2].asstring);
    tmp.Next;
  end;

  try
    DBGridEh1.FieldColumns['SETTLE_CODE'].KeyList.Clear;
    DBGridEh1.FieldColumns['SETTLE_CODE'].PickList.Clear;
                                  
    tmp:=Global.GetZQueryFromName('PUB_SETTLE_CODE');
    tmp.First;
    while not tmp.Eof do
      begin
        DBGridEh1.FieldColumns['SETTLE_CODE'].KeyList.Add(tmp.Fields[0].AsString);
        DBGridEh1.FieldColumns['SETTLE_CODE'].PickList.Add(tmp.Fields[1].AsString);
        tmp.Next;
      end;
  finally

  end;
end;

procedure TfrmClient.Cds_ClientAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if Cds_Client.RecNo<=0 then  str:='0'
  else str:=IntToStr(Cds_Client.RecNo);
  stbPanel.Caption:='��'+str+'��/��'+inttostr(Cds_Client.RecordCount)+'��';
end;

procedure TfrmClient.FormDestroy(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.FreeForm(self);  
end;

procedure TfrmClient.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('33300001',5) then
    Raise Exception.Create('��û�д�ӡ'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  try
    DBGridEh1.Columns[0].Visible := False;
    PrintView;
    PrintDBGridEh1.Print;
  finally
    DBGridEh1.Columns[0].Visible := True;
  end;
end;

procedure TfrmClient.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('33300001',5) then
    Raise Exception.Create('��û��Ԥ��'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  try
    DBGridEh1.Columns[0].Visible := False;
    PrintView;
    with TfrmEhLibReport.Create(self) do
      begin
        try
          Preview(PrintDBGridEh1);
        finally
          free;
        end;
      end;
  finally
    DBGridEh1.Columns[0].Visible := True;
  end;
end;
procedure TfrmClient.DBGridEh1TitleClick(Column: TColumnEh);
begin
  inherited;
  if Column.FieldName='selflag' then
    N1Click(nil);
end;

procedure TfrmClient.N1Click(Sender: TObject);
begin
  inherited;
  if not Cds_Client.Active then exit;
  if Cds_Client.IsEmpty then exit;
  Cds_Client.DisableControls;
  try
    Cds_Client.First;
    while not Cds_Client.Eof do
    begin
      Cds_Client.Edit;
      Cds_Client.FieldByName('selflag').AsString:='1';
      Cds_Client.Post;
      Cds_Client.Next;
    end;
  finally
    Cds_Client.First;
    Cds_Client.EnableControls;
  end;
end;

procedure TfrmClient.N3Click(Sender: TObject);
begin
  inherited;
  if not Cds_Client.Active then exit;
  if Cds_Client.IsEmpty then exit;
  Cds_Client.DisableControls;
  try
    Cds_Client.First;
    while not Cds_Client.Eof do
    begin
      Cds_Client.Edit;
      Cds_Client.FieldByName('selflag').AsString:='0';
      Cds_Client.Post;
      Cds_Client.Next;
    end;
  finally
    Cds_Client.First;
    Cds_Client.EnableControls;
  end;
end;

procedure TfrmClient.N2Click(Sender: TObject);
begin
  inherited;
  if not Cds_Client.Active then exit;
  if Cds_Client.IsEmpty then exit;
  Cds_Client.DisableControls;
  try
    Cds_Client.First;
    while not Cds_Client.Eof do
    begin
      Cds_Client.Edit;
      if Cds_Client.FieldByName('selflag').AsString='1' then
         Cds_Client.FieldByName('selflag').AsString:='0'
      else
         Cds_Client.FieldByName('selflag').AsString:='1';
      Cds_Client.Post;
      Cds_Client.Next;
    end;
  finally
    Cds_Client.First;
    Cds_Client.EnableControls;
  end;
end;

procedure TfrmClient.N4Click(Sender: TObject);
begin
  inherited;
{  if Cds_Client.IsEmpty then Exit;
  with TfrmSendGsm.Create(Self) do
    begin
      try
        Cds_Client.DisableControls;
        try
          Cds_Client.First;
          while not Cds_Client.Eof do
          begin
            if Cds_Client.FieldByName('selflag').AsBoolean and (Cds_Client.FieldbyName('TELEPHONE2').AsString<>'') then
            begin
              cdsTable.Append;
              cdsTable.FieldByName('STATE').AsString := '0';
              cdsTable.FieldByName('TEL').AsString := Cds_Client.FieldbyName('TELEPHONE2').AsString;
              cdsTable.FieldByName('CNAME').AsString := Cds_Client.FieldbyName('CLIENT_NAME').AsString;
              cdsTable.Post;
            end;
            Cds_Client.Next;
          end;
        finally
          Cds_Client.EnableControls;
        end;
        ShowModal;
      finally
        free;
      end;
    end; }
end;

procedure TfrmClient.Cds_ClientFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  if trim(edtKey.Text)='' then Exit;
  Accept:=False;
  if (pos(trim(edtKey.Text),DataSet['CLIENT_SPELL'])>0) or (pos(uppercase(trim(edtKey.Text)),DataSet['CLIENT_SPELL'])>0)
          or (pos(trim(edtKey.Text),DataSet['CLIENT_NAME'])>0) or (pos(uppercase(trim(edtKey.Text)),DataSet['CLIENT_NAME'])>0)
          or (pos(trim(edtKey.Text),DataSet['CLIENT_CODE'])>0) or (pos(uppercase(trim(edtKey.Text)),DataSet['CLIENT_CODE'])>0) then
     Accept:=True
  else
    Accept:=False;
end;

function TfrmClient.CheckCanExport: boolean;
begin
  Result := ShopGlobal.GetChkRight('33300001',6);
end;

procedure TfrmClient.PrintView;
begin
  PrintDBGridEh1.PageHeader.CenterText.Text := '�ͻ���������';

  PrintDBGridEh1.AfterGridText.Text := #13+'��ӡ��:'+Global.UserName+'  ��ӡʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]','']);
  DBGridEh1.DataSource.DataSet.Filtered := False;
  PrintDBGridEh1.DBGridEh := DBGridEh1;
end;

procedure TfrmClient.N14Click(Sender: TObject);
var Aobj_Integral:TRecord_;
begin
  inherited;
  if Cds_Client.IsEmpty then Exit;
  if not ShopGlobal.GetChkRight('33600001',2) then Raise Exception.Create('��û��"���ͻ���"��Ȩ��,��͹���Ա��ϵ.');
  Aobj_Integral := TRecord_.Create;
  try
    if TfrmIntegralGlide_Add.IntegralGlide(self,Cds_Client.FieldbyName('CLIENT_ID').AsString,Aobj_Integral) then
       begin
         {Cds_Customer.Edit;
         Cds_Customer.FieldByName('INTEGRAL').AsFloat := Cds_Customer.FieldByName('INTEGRAL').AsFloat + Aobj_Integral.FieldbyName('INTEGRAL').AsFloat;
         Cds_Customer.FieldByName('ACCU_INTEGRAL').AsFloat := Cds_Customer.FieldByName('ACCU_INTEGRAL').AsFloat+Aobj_Integral.FieldbyName('INTEGRAL').AsFloat;
         Cds_Customer.Post;}
         MessageBox(Handle,'�������ͳɹ�!',pchar(Application.Title),MB_OK);
       end;
  finally
    Aobj_Integral.Free;
  end;
end;

procedure TfrmClient.N15Click(Sender: TObject);
var Aobj_Integral:TRecord_;
begin
  inherited;
  if Cds_Client.IsEmpty then Exit;
  if not ShopGlobal.GetChkRight('33600001',5) then Raise Exception.Create('��û��"���ֶһ�"��Ȩ��,��͹���Ա��ϵ.');
  Aobj_Integral := TRecord_.Create;
  try
    if TfrmIntegralGlide.IntegralGlide(self,Cds_Client.FieldbyName('CLIENT_ID').AsString,Aobj_Integral) then
       begin
         {Cds_Customer.Edit;
         Cds_Customer.FieldByName('INTEGRAL').AsFloat := Cds_Customer.FieldByName('INTEGRAL').AsFloat - Aobj_Integral.FieldbyName('INTEGRAL').AsFloat;
         Cds_Customer.FieldByName('RULE_INTEGRAL').AsFloat := Cds_Customer.FieldByName('RULE_INTEGRAL').AsFloat+Aobj_Integral.FieldbyName('INTEGRAL').AsFloat;
         Cds_Customer.Post; }
         MessageBox(Handle,'���ֶһ��ɹ�!',pchar(Application.Title),MB_OK);
       end;
  finally
    Aobj_Integral.Free;
  end;
end;

procedure TfrmClient.actDepositExecute(Sender: TObject);
var BALANCE:string;
begin
  inherited;
  if not Cds_Client.Active then exit;
  if Cds_Client.IsEmpty then exit;
  if not ShopGlobal.GetChkRight('33500001',4) then Raise Exception.Create('��û��"��ֵ"��Ȩ��,��͹���Ա��ϵ.');
  //if Cds_Client.FieldByName('CLIENT_CODE').AsString='' then  Raise Exception.Create('�˿ͻ�û�л�Ա����');
  if TfrmDeposit.Open(Cds_Client.FieldByName('CLIENT_ID').AsString,BALANCE) then
  begin
    Cds_Client.Edit;
    Cds_Client.FieldByName('BALANCE').AsString:=BALANCE;
    Cds_Client.Post; 
  end;
end;

procedure TfrmClient.actNewCardExecute(Sender: TObject);
 procedure UpdateToGlobal(IC:string;ID:string);
   var Temp:TZQuery;
   begin
      Temp := Global.GetZQueryFromName('PUB_CLIENTINFO');
      Temp.Filtered := false;
      if not Temp.Locate('CLIENT_ID',ID,[]) then
         Temp.Append
      else
         Temp.Edit;
      Temp.FieldByName('CLIENT_CODE').AsString:=IC;
      Temp.Post;
   end;
var  card,union:string;
begin
  inherited;
  if Cds_Client.IsEmpty then Exit;
  if not ShopGlobal.GetChkRight('33500001',3) then Raise Exception.Create('��û��"����"��Ȩ��,��͹���Ա��ϵ.');
  if TfrmNewCard.SelectSendCard(Self,Cds_Client.FieldbyName('CLIENT_ID').AsString,'#',Cds_Client.FieldByName('CLIENT_NAME').AsString,1,card,union) then
    begin
      if union = '#' then
        begin
          Cds_Client.Edit;
          Cds_Client.FieldByName('CLIENT_CODE').AsString:=card;
          Cds_Client.Post;
          UpdateToGlobal(card,Cds_Client.FieldByName('CLIENT_ID').AsString);
        end;
        MessageBox(Handle,'���¿��ɹ���',pchar(Application.Title),MB_OK);
    end;
end;

procedure TfrmClient.actfrmIntegralExecute(Sender: TObject);
begin
  inherited;
  N15Click(Sender);
end;

procedure TfrmClient.Excel1Click(Sender: TObject);
  function Check(Source,Dest:TDataSet;SFieldName:string;DFieldName:string):Boolean;
  var rs:TZQuery;
  begin
    if (SFieldName <> '') and (DFieldName <> '') then
      begin
        Result := False;
        // *******************�ŵ�********************
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
                  Raise Exception.Create('û�ҵ�"'+Source.FieldByName(SFieldName).AsString+'"��Ӧ���ŵ����...');
              end
            else
              Raise Exception.Create('�ŵ겻��Ϊ��!');
          end;

        //*******************�ͻ��ȼ�*****************
        if DFieldName = 'PRICE_ID' then
          begin
            if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
              begin
                rs := Global.GetZQueryFromName('PUB_PRICEGRADE');
                if rs.Locate('PRICE_NAME',Trim(Source.FieldByName(SFieldName).AsString),[]) then
                  begin
                    Dest.FieldByName('PRICE_ID').AsString := rs.FieldbyName('PRICE_ID').AsString;
                    Result := True;
                    Exit;
                  end
                else
                  Raise Exception.Create('û�ҵ�"'+Source.FieldByName(SFieldName).AsString+'"��Ӧ�Ŀͻ��ȼ�����...');
              end
            else
              Raise Exception.Create('�ͻ��ȼ�����Ϊ��!');
          end;

        //*******************����*****************
        if DFieldName = 'REGION_ID' then
          begin
            if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
              begin
                rs := Global.GetZQueryFromName('PUB_REGION_INFO');
                if rs.Locate('CODE_NAME',Trim(Source.FieldByName(SFieldName).AsString),[]) then
                  begin
                    Dest.FieldByName('REGION_ID').AsString := rs.FieldbyName('CODE_ID').AsString;
                  end
                else
                  Raise Exception.Create('û�ҵ�"'+Source.FieldByName(SFieldName).AsString+'"��Ӧ�ĵ�������...');
              end
            else
              Dest.FieldByName('REGION_ID').AsString := '#';
            Result := True;
            Exit;
          end;

        //*******************�ͻ����*****************
        if DFieldName = 'SORT_ID' then
          begin
            if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
              begin
                rs := Global.GetZQueryFromName('PUB_CLIENTSORT');
                if rs.Locate('CODE_NAME',Trim(Source.FieldByName(SFieldName).AsString),[]) then
                  begin
                    Dest.FieldByName('SORT_ID').AsString := rs.FieldbyName('CODE_ID').AsString;
                  end
                else
                  Raise Exception.Create('û�ҵ�"'+Source.FieldByName(SFieldName).AsString+'"��Ӧ�Ŀͻ�������...');
              end
            else
              begin
                Dest.FieldByName('SORT_ID').AsString := '#';
                //Raise Exception.Create('�ͻ������Ϊ��!');
              end;
            Result := True;
            Exit;
          end;

        //*******************���㷽ʽ*****************
        if DFieldName = 'SETTLE_CODE' then
          begin
            if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
              begin
                rs := Global.GetZQueryFromName('PUB_SETTLE_CODE');
                if rs.Locate('CODE_NAME',Trim(Source.FieldByName(SFieldName).AsString),[]) then
                  begin
                    Dest.FieldByName('SETTLE_CODE').AsString := rs.FieldbyName('CODE_ID').AsString;
                  end
                else
                  Raise Exception.Create('û�ҵ�"'+Source.FieldByName(SFieldName).AsString+'"��Ӧ�Ľ��㷽ʽ����...');
              end
            else
              Dest.FieldByName('SETTLE_CODE').AsString := '#';
            Result := True;
            Exit;
          end;

        //*******************��������*****************
        if DFieldName = 'BANK_ID' then
          begin
            rs := Global.GetZQueryFromName('PUB_BANK_INFO');
            if rs.Locate('CODE_NAME',Trim(Source.FieldByName(SFieldName).AsString),[]) then
              begin
                Dest.FieldByName('BANK_ID').AsString := rs.FieldbyName('CODE_ID').AsString;
                Result := True;
              end
            else
              Raise Exception.Create('û�ҵ�"'+Source.FieldByName(SFieldName).AsString+'"��Ӧ�Ŀ������д���...');
          end;

        //*******************��Ʊ����*****************
        if DFieldName = 'INVOICE_FLAG' then
          begin
            rs := Global.GetZQueryFromName('PUB_PARAMS');
            if rs.Locate('TYPE_CODE;CODE_NAME',VarArrayOf(['INVOICE_FLAG',Trim(Source.FieldByName(SFieldName).AsString)]),[]) then
              begin
                Dest.FieldByName('INVOICE_FLAG').AsString := rs.FieldbyName('CODE_ID').AsString;
                Result := True;
                Exit;
              end
            else
              Raise Exception.Create('û�ҵ�"'+Source.FieldByName(SFieldName).AsString+'"��Ӧ�ķ�Ʊ���ʹ���...');
          end;

        //�ͻ����
        if DFieldName = 'CLIENT_CODE' then
          begin
            if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
              begin
                if Length(Source.FieldByName(SFieldName).AsString) > 20 then
                  Raise Exception.Create('�ͻ���ž���20���ַ�����!')
                else
                  begin
                    rs := Global.GetZQueryFromName('PUB_CLIENTINFO');
                    if rs.Locate('CLIENT_CODE',Source.FieldByName(SFieldName).AsString,[]) then
                      Raise Exception.Create('��ǰ�ͻ�����Ѿ�����!')
                    else
                      begin
                        Dest.FieldbyName('CLIENT_CODE').AsString := Source.FieldByName(SFieldName).AsString;
                        Result := True;
                        Exit;
                      end;
                  end;
              end;
          end;

        //�ͻ�����
        if DFieldName = 'CLIENT_NAME' then
          begin
            if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
              begin
                if Length(Source.FieldByName(SFieldName).AsString) > 50  then
                  Raise Exception.Create('�ͻ����ƾ���50���ַ�����!')
                else
                  begin
                    Dest.FieldbyName('CLIENT_NAME').AsString := Source.FieldByName(SFieldName).AsString;
                    Result := True;
                    Exit;
                  end;
              end
            else
              Raise Exception.Create('�ͻ����Ʋ���Ϊ��!');
          end;

        //�ͻ�ƴ����
        if DFieldName = 'CLIENT_SPELL' then
          begin
            if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
              begin
                if Length(Source.FieldByName(SFieldName).AsString) > 50  then
                  Raise Exception.Create('�ͻ�ƴ�������50���ַ�����!')
                else
                  begin
                    Dest.FieldbyName('CLIENT_SPELL').AsString := Source.FieldByName(SFieldName).AsString;
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
        CdsExcel.FieldByName('CLIENT_ID').AsString  := TSequence.NewId;
        CdsExcel.FieldByName('UNION_ID').AsString := '#';
        CdsExcel.FieldByName('CLIENT_TYPE').AsString := '2';
        CdsExcel.FieldByName('CREA_DATE').AsString := FormatDateTime('YYYY-MM-DD',Date());
        CdsExcel.FieldByName('CREA_USER').AsString := Global.UserID;
        CdsExcel.FieldByName('IC_INFO').AsString := '��ҵ��';
        CdsExcel.FieldByName('IC_STATUS').AsString := '0';
        CdsExcel.FieldByName('IC_TYPE').AsString := '0';
        CdsExcel.FieldByName('PASSWRD').AsString := EncStr('1234',ENC_KEY);
        if CdsExcel.FieldByName('CLIENT_SPELL').AsString = '' then
          CdsExcel.FieldByName('CLIENT_SPELL').AsString := fnString.GetWordSpell(Trim(CdsExcel.FieldByName('CLIENT_NAME').AsString),3);
        if CdsExcel.FieldByName('CLIENT_CODE').AsString = '' then
          CdsExcel.FieldByName('CLIENT_CODE').AsString := FnString.GetCodeFlag(inttostr(strtoint(fnString.TrimRight(Global.SHOP_ID,4))+1000)+TSequence.GetSequence('CID_'+Global.SHOP_ID,inttostr(Global.TENANT_ID),'',8));

        CdsExcel.Post;
        CdsExcel.Next;
      end;
    Result := Factor.UpdateBatch(CdsExcel,'TClient',nil);
  end;
  function FindColumn(CdsCol:TDataSet):Boolean;
  begin
    Result := True;
    if not CdsCol.Locate('FieldName','SHOP_ID',[]) then
      begin
        Result := False;
        Raise Exception.Create('ȱ���ŵ��ֶ�!');
      end;
    if not CdsCol.Locate('FieldName','PRICE_ID',[]) then
      begin
        Result := False;
        Raise Exception.Create('ȱ�ٵȼ��ֶ�!');
      end;
    if not CdsCol.Locate('FieldName','SETTLE_CODE',[]) then
      begin
        Result := False;
        Raise Exception.Create('ȱ�ٽ��㷽ʽ�ֶ�!');
      end;
    if not CdsCol.Locate('FieldName','CLIENT_NAME',[]) then
      begin
        Result := False;
        Raise Exception.Create('ȱ�ٿͻ������ֶ�!');
      end;
  end;
var FieldsString,FormatString:String;
    Params:TftParamList;
    cdsTable,rs:TZQuery;
begin
  inherited;
  Params := TftParamList.Create(nil);
  cdsTable := TZQuery.Create(nil);
  try
    Params.ParamByName('CLIENT_ID').asString := '';
    Params.ParamByName('UNION_ID').AsString := '#';
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsTable.Close;
    Factor.Open(cdsTable,'TClient',Params);

    FieldsString := 'CLIENT_CODE=�ͻ����,CLIENT_NAME=�ͻ�����,CLIENT_SPELL=ƴ����,SORT_ID=�ͻ����,PRICE_ID=�ͻ��ȼ�,REGION_ID=����,SHOP_ID=�����ŵ�,'+
    'SETTLE_CODE=���㷽ʽ,LICENSE_CODE=��Ӫ���֤,ADDRESS=ע���ַ,POSTALCODE=��������,LINKMAN=��ϵ��,TELEPHONE3=ע��绰,TELEPHONE1=�绰,TELEPHONE2=�ֻ�,SEND_ADDR=�ͻ���ַ,'+
    'SEND_TELE=�ͻ����ֻ�,SEND_LINKMAN=�ͻ���,RECV_ADDR=�ջ���ַ,RECV_LINKMAN=�ջ���,RECV_TELE=�ջ����ֻ�,LEGAL_REPR=���˴���,INVO_NAME=��˾ȫ��,'+
    'TAX_NO=˰��Ǽ�֤��,FAXES=����,HOMEPAGE=��ַ,EMAIL=�����ʼ�,QQ=QQ,MSN=MSN,BANK_ID=��������,ACCOUNT=�˺�,INVOICE_FLAG=��Ʊ����,REMARK=��ע';

    FormatString := '0=CLIENT_CODE,1=CLIENT_NAME,2=CLIENT_SPELL,3=SORT_ID,4=PRICE_ID,5=REGION_ID,6=SHOP_ID,'+
    '7=SETTLE_CODE,8=LICENSE_CODE,9=ADDRESS,10=POSTALCODE,11=LINKMAN,12=TELEPHONE3,13=TELEPHONE1,14=TELEPHONE2,15=SEND_ADDR,16=SEND_TELE,'+
    '17=SEND_LINKMAN,18=RECV_ADDR,19=RECV_LINKMAN,20=RECV_TELE,21=LEGAL_REPR,22=INVO_NAME,23=TAX_NO,24=FAXES,25=HOMEPAGE,26=EMAIL,27=QQ,28=MSN,'+
    '29=BANK_ID,30=ACCOUNT,31=INVOICE_FLAG,32=REMARK';

    TfrmExcelFactory.ExcelFactory(cdsTable,FieldsString,@Check,@SaveExcel,@FindColumn,FormatString,1);

  finally
    Params.Free;
    cdsTable.Free;
  end;
end;

procedure TfrmClient.actReturnExecute(Sender: TObject);
var BALANCE:string;
begin
  inherited;
  if not Cds_Client.Active then exit;
  if Cds_Client.IsEmpty then exit;
  if not ShopGlobal.GetChkRight('33500001',5) then Raise Exception.Create('��û��"�˿�"��Ȩ��,��͹���Ա��ϵ.');
  if TfrmReturn.Open(Cds_Client.FieldByName('CLIENT_ID').AsString,BALANCE) then
  begin
    Cds_Client.Edit;
    Cds_Client.FieldByName('BALANCE').AsString:=BALANCE;
    Cds_Client.Post;
  end;
end;

procedure TfrmClient.actLossCardExecute(Sender: TObject);
var CardNo,CardName:String;
begin
  inherited;
  if not Cds_Client.Active then exit;
  if Cds_Client.IsEmpty then exit;
  if not ShopGlobal.GetChkRight('33500001',6) then Raise Exception.Create('��û��"��ʧ��"��Ȩ��,��͹���Ա��ϵ.');
  if TfrmLossCard.SelectCard(Self,Cds_Client.FieldbyName('CLIENT_ID').AsString,'#',CardNo,CardName) then
    begin
      MessageBox(Handle,pchar(CardName+'��"'+CardNo+'"��ʧ�ɹ���'),pchar(Application.Title),MB_OK);
    end;
end;

procedure TfrmClient.actPasswordExecute(Sender: TObject);
begin
  inherited;
  if (not Cds_Client.Active) and (Cds_Client.IsEmpty) then exit;
  TfrmPassWord.SelectCard(Self,Cds_Client.FieldByName('CLIENT_ID').AsString,IntToStr(Global.TENANT_ID));
end;

procedure TfrmClient.actCancelCardExecute(Sender: TObject);
var CardNo,CardName:String;
begin
  inherited;
  if not Cds_Client.Active then exit;
  if Cds_Client.IsEmpty then exit;
  if not ShopGlobal.GetChkRight('33500001',7) then Raise Exception.Create('��û��"ע����"��Ȩ��,��͹���Ա��ϵ.');
  if TfrmCancelCard.SelectCard(Self,Cds_Client.FieldbyName('CLIENT_ID').AsString,'#',CardNo,CardName) then
    begin
      MessageBox(Handle,pchar(CardName+'��"'+CardNo+'"ע���ɹ���'),pchar(Application.Title),MB_OK);
    end;
end;

procedure TfrmClient.AddMenuItem;
var Item:TMenuItem;
begin
  PopupMenu2.Items.Add(NewItem('��������',0,False,True,ResetClientPswClick,0,'ResetClientPsw'));
end;

procedure TfrmClient.ResetClientPswClick(Sender: TObject);
var Str_Sql:String;
    i:Integer;
begin
  if MessageBox(Handle,Pchar('ȷ������"'+Cds_Client.FieldByName('CLIENT_NAME').AsString+'"�Ļ�Ա�����룡'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  Str_Sql :=
  'update PUB_IC_INFO set PASSWRD='''+EncStr('1234',ENC_KEY)+''',COMM='+GetCommStr(Factor.iDbType)+',TIME_STAMP='+GetTimeStamp(Factor.iDbType)+
  ' where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and UNION_ID=''#'' and IC_CARDNO='+QuotedStr(Cds_Client.FieldByName('CLIENT_CODE').AsString);
  i := Factor.ExecSQL(Str_Sql);
  if i = 0 then
    MessageBox(handle,Pchar('��ʾ:"'+Cds_Client.FieldByName('CLIENT_NAME').AsString+'"�Ļ�Ա����������ʧ��!'),Pchar(Caption),MB_OK)
  else if i > 0 then
    MessageBox(handle,Pchar('��ʾ:"'+Cds_Client.FieldByName('CLIENT_NAME').AsString+'"�Ļ�Ա���������óɹ�!'),Pchar(Caption),MB_OK);
end;

end.
