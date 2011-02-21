unit ufrmClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls, RzLabel,
  RzTabs, ExtCtrls, RzPanel, DB, Grids, DBGridEh, uGlobal, cxControls, cxContainer,
  cxEdit, cxTextEdit, RzButton, ZBase, cxMaskEdit, cxButtonEdit, zrComboBoxList,
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
    PrintDBGridEh1: TPrintDBGridEh;
    Cds_Client: TZQuery;
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
    procedure edtKeyPropertiesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure But_PrintClick(Sender: TObject);
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
  private
    ccid,sqlstring:string;
    { Private declarations }
  public
    { Public declarations }
    procedure AddRecord(AObj:TRecord_);
    procedure InitGrid;
  end;

implementation
uses ufrmClientInfo, uShopGlobal,uCtrlUtil,ufrmEhLibReport, ufrmBasic;//,ufrmSendGsm
{$R *.dfm}

procedure TfrmClient.actNewExecute(Sender: TObject);
begin
  inherited;
  //if not ShopGlobal.GetChkRight('400007') then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
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
      Temp := Global.GetZQueryFromName('PUB_CLIENTINFO');
      Temp.Filtered :=false;
      if Temp.Locate('CLIENT_ID',str,[]) then
      begin
        Temp.Delete;
        //temp.UpdateBatch(arAll);
      end;
    end;
var
i:integer;
begin
  inherited;
  if (not Cds_Client.Active) and (Cds_Client.IsEmpty) then exit;
  //if not ShopGlobal.GetChkRight('400009') then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');
  i:=MessageBox(Handle,Pchar('是否要删除吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
  if i=6 then
  begin
    Cds_Client.Delete;
    Factor.UpdateBatch(Cds_Client,'TClient');
    UpdateToGlobal(Cds_Client.FieldByName('CLIENT_ID').AsString);
  end;
end;

procedure TfrmClient.actFindExecute(Sender: TObject);
var
   Str_Wh:String;
begin
  inherited;

  {Str_Wh := 'select 0 as selflag,TENANT_ID,CLIENT_ID,CLIENT_TYPE,CLIENT_CODE,LICENSE_CODE,CLIENT_NAME,CLIENT_SPELL,'+
  'SORT_ID,REGION_ID,SETTLE_CODE,ADDRESS,POSTALCODE,LINKMAN,TELEPHONE3,TELEPHONE1,TELEPHONE2,FAXES,HOMEPAGE,'+
  'EMAIL,QQ,MSN,BANK_ID,ACCOUNT,IC_CARDNO,INVOICE_FLAG,REMARK,TAX_RATE,PRICE_ID,ACCU_INTEGRAL,RULE_INTEGRAL,'+
  'INTEGRAL,BALANCE,SHOP_ID from PUB_CLIENTINFO where COMM not in (''02'',''12'') and TENANT_ID='''+IntToStr(Global.TENANT_ID)+''' and CLIENT_TYPE = ''2'' ';}

  Str_Wh := 'select 0 as selflag,A.TENANT_ID,A.CLIENT_ID,A.CLIENT_TYPE,A.CLIENT_CODE,A.LICENSE_CODE,A.CLIENT_NAME,A.CLIENT_SPELL,A.SORT_ID,'+
  'A.REGION_ID,A.SETTLE_CODE,A.ADDRESS,A.POSTALCODE,A.LINKMAN,A.TELEPHONE3,A.TELEPHONE1,A.TELEPHONE2,A.FAXES,A.HOMEPAGE,A.EMAIL,A.QQ,'+
  'A.MSN,A.BANK_ID,A.ACCOUNT,B.IC_CARDNO,A.INVOICE_FLAG,A.REMARK,A.TAX_RATE,A.PRICE_ID,B.ACCU_INTEGRAL,B.RULE_INTEGRAL,B.INTEGRAL,B.BALANCE,'+
  'A.SHOP_ID from PUB_CLIENTINFO A left join PUB_IC_INFO B on A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID=B.TENANT_ID'+
  ' where A.COMM not in (''02'',''12'') and A.CLIENT_TYPE=''2'' and UNION_ID=''#'' and A.TENANT_ID='+IntToStr(Global.TENANT_ID);

  sqlstring:='';
  if edtKey.Text<>'' then
    begin
      sqlstring:=' and (A.CLIENT_NAME LIKE ''%'+trim(edtKey.Text)+'%'' or A.CLIENT_SPELL LIKE ''%'+trim(edtKey.Text)+'%'' or A.CLIENT_CODE LIKE ''%'+trim(edtKey.Text)+'%'' )';
      Str_Wh:=Str_Wh+sqlstring;
    end;
  if fndSORT_ID.AsString<>'' then
    begin
      sqlstring:=sqlstring+' and A.SORT_ID='+QuotedStr(fndSORT_ID.AsString);
      Str_Wh:=Str_Wh+' and A.SORT_ID='+QuotedStr(fndSORT_ID.AsString);
    end;

  Cds_Client.Close;
  Cds_Client.SQL.Text := Str_Wh+' order by A.CLIENT_CODE';
  Factor.Open(Cds_Client);
end;

procedure TfrmClient.actEditExecute(Sender: TObject);
begin
  inherited;
  if (not Cds_Client.Active) or (Cds_Client.IsEmpty) then exit;
  if not ShopGlobal.GetChkRight('400008') then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
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
  end
  else
  begin
     Cds_Client.Append;
     AObj.WriteToDataSet(Cds_Client,false);
     Cds_Client.FieldByName('selflag').AsBoolean:=False;
     Cds_Client.Post;
  end;
  InitGrid;
  if Cds_Client.Locate('CLIENT_ID',AObj.FieldByName('CLIENT_ID').AsString,[]) then;
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
  actFindExecute(nil);
  if edtKey.CanFocus then
    edtKey.SetFocus;
end;

procedure TfrmClient.edtKeyPropertiesChange(Sender: TObject);
begin
  inherited;
//  Cds_Client.Filtered:=False;
//  Cds_Client.Filter:='CLIENT_NAME LIKE ''%'+trim(edtKey.Text)+'%'' or CLIENT_SPELL LIKE ''%'+trim(edtKey.Text)+'%'' or CLIENT_CODE LIKE ''%'+trim(edtKey.Text)+'%'' ';
//  Cds_Client.Filtered:=(trim(edtKey.Text)<>'');
  Cds_Client.Filtered:=False;
  Cds_Client.Filtered:=True;
end;

procedure TfrmClient.FormCreate(Sender: TObject);
begin
  inherited;
  {ccid:=ShopGlobal.GetCOMP_ID(Global.UserID);
  if (ShopGlobal.GetIsCompany(Global.UserID)) and  (ccid<>Global.CompanyID) then
    ccid:=ccid
  else
    ccid:=Global.CompanyID; }
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
end;

procedure TfrmClient.But_PrintClick(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('400010') then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
end;

procedure TfrmClient.Cds_ClientAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if Cds_Client.RecNo<=0 then  str:='0'
  else str:=IntToStr(Cds_Client.RecNo);
  stbPanel.Caption:='第'+str+'条/共'+inttostr(Cds_Client.RecordCount)+'条';
end;

procedure TfrmClient.FormDestroy(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.FreeForm(self);  
end;

procedure TfrmClient.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('400010') then
    Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  PrintDBGridEh1.Print;
end;

procedure TfrmClient.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('400010') then
    Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');  
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  with TfrmEhLibReport.Create(self) do
    begin
      try
        Preview(PrintDBGridEh1);
      finally
        free;
      end;
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
      Cds_Client.FieldByName('selflag').AsBoolean:=True;
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
      Cds_Client.FieldByName('selflag').AsBoolean:=False;
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
      if Cds_Client.FieldByName('selflag').AsBoolean=True then
         Cds_Client.FieldByName('selflag').AsBoolean:=False
      else
         Cds_Client.FieldByName('selflag').AsBoolean:=True;
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

end.
