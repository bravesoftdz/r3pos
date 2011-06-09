unit ufrmCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls, RzLabel,
  RzTabs, ExtCtrls, RzPanel, RzButton, DB, Grids, uGlobal, DBGridEh, cxControls,
  cxContainer, cxEdit, cxTextEdit, zBase, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxButtonEdit, zrComboBoxList, FR_Class, PrnDbgeh, jpeg, ZAbstractRODataset, 
  ZAbstractDataset, ZDataset, ObjCommon;

type
  TfrmCustomer = class(TframeToolForm)
    RzPanel6: TRzPanel;
    RzPanel1: TRzPanel;
    DBGridEh1: TDBGridEh;
    Ds_Customer: TDataSource;
    But_Add: TToolButton;
    But_Delete: TToolButton;
    But_Edit: TToolButton;
    ToolButton2: TToolButton;
    But_Exit: TToolButton;
    But_Info: TToolButton;
    But_Print: TToolButton;
    But_Preview: TToolButton;
    stbPanel: TPanel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    actfrmIntegral: TAction;
    N1: TMenuItem;
    ToolButton1: TToolButton;
    edtKey: TcxTextEdit;
    btnOk: TRzBitBtn;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtDate1: TcxDateEdit;
    Label5: TLabel;
    edtDate2: TcxDateEdit;
    RzLabel22: TRzLabel;
    cmbSHOP_ID: TzrComboBoxList;
    RzLabel2: TRzLabel;
    edtDate3: TcxDateEdit;
    RzLabel14: TRzLabel;
    cmbPRICE_ID: TzrComboBoxList;
    N2: TMenuItem;
    Label6: TLabel;
    edtDate4: TcxDateEdit;
    Bevel1: TBevel;
    RzLabel4: TRzLabel;
    fndINTEGRAL: TcxTextEdit;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    ToolButton3: TToolButton;
    PopupMenu2: TPopupMenu;
    N10: TMenuItem;
    N9: TMenuItem;
    actNewCard: TAction;
    actCancelCard: TAction;
    actDeposit: TAction;
    N11: TMenuItem;
    actPassword: TAction;
    N12: TMenuItem;
    actReturn: TAction;
    ToolButton5: TToolButton;
    actRenew: TAction;
    fndSORT_ID: TzrComboBoxList;
    Label40: TLabel;
    Cds_Customer: TZQuery;
    N13: TMenuItem;
    PrintDBGridEh1: TPrintDBGridEh;
    PopupMenu3: TPopupMenu;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    actLossCard: TAction;
    Excel1: TMenuItem;
    procedure actNewExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure edtKeyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Cds_CustomerAfterScroll(DataSet: TDataSet);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure actNewCardExecute(Sender: TObject);
    procedure actPasswordExecute(Sender: TObject);
    procedure actDepositExecute(Sender: TObject);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure edtKeyKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ToolButton3Click(Sender: TObject);
    procedure actCancelCardExecute(Sender: TObject);
    procedure actReturnExecute(Sender: TObject);
    procedure actRenewExecute(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure actfrmIntegralExecute(Sender: TObject);
    procedure actLossCardExecute(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
  private
    function CheckCanExport:boolean;
    procedure PrintView;
    function FormatReportHead(TitleList: TStringList; Cols: integer): string;
    { Private declarations }
  public
    { Public declarations }
    IsEnd: boolean;
    MaxId,sqlstring:string;
    rcAmt:integer;
    procedure InitGrid;
    procedure AddRecord(AObj:TRecord_);
    procedure Open(id:string);
    function EncodeSQL(id:string;var Str1:string):string;
    procedure GetNo;
    function ShowExecute(AOwner:TForm;Params:String):Boolean;override;
  end;

implementation
uses ufrmCustomerInfo, DateUtils,  uShopGlobal, uCtrlUtil, ufrmEhLibReport, uFnUtil, uDsUtil, ufrmIntegralGlide,
     ufrmIntegralGlide_Add, ufrmDeposit, ufrmNewCard, ufrmBasic, ufrmCancelCard, ufrmReturn, ufrmPassWord,
     ufrmLossCard, ufrmExcelFactory;
//  ufrmSendGsm, ufrmReNew,

{$R *.dfm}

procedure TfrmCustomer.actNewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('33400001',2) then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
  With TfrmCustomerInfo.Create(self) do
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

procedure TfrmCustomer.actDeleteExecute(Sender: TObject);
var i,n:integer;
    tmpGlobal:TZQuery;
begin
  inherited;
  if (Not Cds_Customer.Active) or (Cds_Customer.RecordCount = 0) then Exit;
  if Cds_Customer.State in [dsEdit,dsInsert] then Cds_Customer.Post;
  if not ShopGlobal.GetChkRight('33400001',4) then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');
  i:=MessageBox(Handle,Pchar('确定要删除选中记录吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1+MB_ICONQUESTION);
  if i=6 then
  begin
    tmpGlobal := Global.GetZQueryFromName('PUB_CUSTOMER');
    Cds_Customer.DisableControls;
    try
      Cds_Customer.CommitUpdates;
      tmpGlobal.CommitUpdates;
      Cds_Customer.Filtered := false;
      Cds_Customer.Filter := 'selFlag=1';
      Cds_Customer.Filtered := true;
      if Cds_Customer.IsEmpty then Raise Exception.Create('请选择要删除的会员...');
      n:=0;
      Cds_Customer.First;
      while not Cds_Customer.Eof do
      begin
        if Cds_Customer.FieldByName('selflag').AsString = '1' then
        begin
          if tmpGlobal.Locate('CLIENT_ID',Cds_Customer.FieldByName('CUST_ID').AsString,[]) then
             begin
              tmpGlobal.Delete;
             end;
          Cds_Customer.Delete;
          inc(n);
        end
        else
          Cds_Customer.Next;
      end;
      try
        Factor.UpdateBatch(Cds_Customer,'TCustomer');
        rcAmt := rcAmt - n;
      except
        Cds_Customer.CancelUpdates;
        tmpGlobal.CancelUpdates;
        Raise;
      end;
    finally
      Cds_Customer.Filtered := false;    
      Cds_Customer.EnableControls;
    end;
  end;
  GetNo;
end;

procedure TfrmCustomer.actFindExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('33400001',1) then Raise Exception.Create('你没有查询'+Caption+'的权限,请和管理员联系.');
  Open('');
end;

procedure TfrmCustomer.actEditExecute(Sender: TObject);
var Tmp:TZQuery;
begin
  inherited;
  if (not Cds_Customer.Active) or (Cds_Customer.IsEmpty) then exit;
  if not ShopGlobal.GetChkRight('33400001',3) then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
    with TfrmCustomerInfo.Create(self) do
      begin
        try
          OnSave := AddRecord;
          Edit(Cds_Customer.FieldByName('CUST_ID').AsString);
          ShowModal;
        finally
          free;
        end;
      end;

end;

procedure TfrmCustomer.AddRecord(AObj: TRecord_);
begin
  if not Cds_Customer.Active  then exit;
  if Cds_Customer.Locate('CUST_ID',AObj.FieldByName('CUST_ID').AsString,[]) then
  begin
     Cds_Customer.Edit;
     AObj.WriteToDataSet(Cds_Customer,false);
     Cds_Customer.Post;
  end
  else
  begin
     Cds_Customer.Append;
     AObj.WriteToDataSet(Cds_Customer,false);
     Cds_Customer.FieldByName('selflag').AsString:='0';
     Cds_Customer.Post;
     inc(rcAmt);
  end;
  InitGrid;
  //if Cds_Customer.Locate('CUST_ID',AObj.FieldByName('CUST_ID').AsString,[]) then;
end;

procedure TfrmCustomer.actExitExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCustomer.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (not Cds_Customer.Active) and (Cds_Customer.IsEmpty) then exit;
  with TfrmCustomerInfo.Create(self) do
    begin
      try
        Open(Cds_Customer.FieldByName('CUST_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmCustomer.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect: TRect;
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
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(Cds_Customer.RecNo)),length(Inttostr(Cds_Customer.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmCustomer.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQ_NO' then
     Background := clBtnFace;
  if uppercase(Column.FieldName) = 'SELFLAG' then
     Background := clBtnFace;
end;

procedure TfrmCustomer.FormShow(Sender: TObject);
begin
  inherited;
  actFind.OnExecute(nil);
  if not Cds_Customer.IsEmpty then Cds_Customer.First;
  if edtKey.CanFocus then
    edtKey.SetFocus;
end;

procedure TfrmCustomer.edtKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_DOWN then
     Cds_Customer.Next;
  if Key = VK_UP then
     Cds_Customer.Prior;
end;

procedure TfrmCustomer.InitGrid;
var tmp:TZQuery;
begin
  DBGridEh1.FieldColumns['PRICE_ID'].PickList.Clear;
  DBGridEh1.FieldColumns['PRICE_ID'].KeyList.Clear;
  tmp := Global.GetZQueryFromName('PUB_PRICEGRADE');
  tmp.First;
  while not tmp.Eof do
  begin
    DBGridEh1.FieldColumns['PRICE_ID'].KeyList.Add(tmp.Fields[1].asstring);
    DBGridEh1.FieldColumns['PRICE_ID'].PickList.Add(tmp.Fields[2].asstring);
    tmp.Next;
  end;

  DBGridEh1.FieldColumns['SHOP_ID'].PickList.Clear;
  DBGridEh1.FieldColumns['SHOP_ID'].KeyList.Clear;
  tmp := Global.GetZQueryFromName('CA_SHOP_INFO');
  tmp.First;
  while not tmp.Eof do
    begin
      DBGridEh1.FieldColumns['SHOP_ID'].KeyList.Add(tmp.Fields[0].AsString);
      DBGridEh1.FieldColumns['SHOP_ID'].PickList.Add(tmp.Fields[1].AsString);
      tmp.Next;
    end;

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

end;


procedure TfrmCustomer.FormCreate(Sender: TObject);
begin
  inherited;
  InitGrid;
  fndSORT_ID.DataSet:=Global.GetZQueryFromName('PUB_CLIENTSORT');
  cmbPRICE_ID.DataSet := Global.GetZQueryFromName('PUB_PRICEGRADE');
  cmbSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  TDbGridEhSort.InitForm(self);
end;

procedure TfrmCustomer.Open(id: string);
var rs,tmp:TZQuery;
    Str:string;
    sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then Cds_Customer.close;
  sm := TMemoryStream.Create;
  tmp := TZQuery.Create(nil);
  Cds_Customer.DisableControls;
  try
    tmp.SQL.Text := EncodeSQL(id,Str);
    Factor.Open(tmp);
    tmp.Last;
    MaxId := tmp.FieldByName('CUST_ID').AsString;
    if id = '' then
      begin
        rs := TZQuery.Create(nil);
        try
          rs.SQL.Text := Str;
          Factor.Open(rs);
          rcAmt := rs.Fields[0].AsInteger;
        finally
          rs.Free;
        end;
        tmp.SaveToStream(sm);
        Cds_Customer.LoadFromStream(sm);
      end
    else
      begin
        tmp.SaveToStream(sm);
        Cds_Customer.AddFromStream(sm);
      end;
    if tmp.RecordCount < 600 then IsEnd := True else IsEnd := False;
  finally
    tmp.Free;
    Cds_Customer.EnableControls;
    sm.Free;
  end;
  
end;

function TfrmCustomer.EncodeSQL(id: string;var Str1:string): string;
var Str_Where,Str_Sql,Str_Join:string;
    Date1,Date2:TDate;
begin
  if Trim(edtKey.Text)<>'' then
     begin
       Str_Where:=' and (MOVE_TELE LIKE '+QuotedStr('%'+Trim(edtKey.Text)+'%')+' or CUST_NAME LIKE '+QuotedStr('%'+Trim(edtKey.Text)+'%')+
       ' or CUST_CODE LIKE '+QuotedStr('%'+Trim(edtKey.Text)+'%')+' or CUST_SPELL LIKE '+QuotedStr('%'+Trim(edtKey.Text)+'%')+
       ' or ID_NUMBER LIKE '+QuotedStr('%'+Trim(edtKey.Text)+'%')+')';
     end;
  if id<>'' then
    Str_Where := Str_Where + ' and CUST_ID>'''+id+'''';

  case Factor.iDbType of
   0,2,3: Str_Join:='+';
   1,4,5: Str_Join:='||';
   else Str_Join:='+';
  end;
  
  //  对会员生日日期进行条件查询
  if (edtDate1.EditValue=NULL) and (edtDate2.EditValue<>NULL) then
     Str_Where:=Str_Where+' and '+FormatDateTime('YYYY',Date())+Str_Join+'substring(isnull(BIRTHDAY,''          ''),5,6)='+QuotedStr(FormatDateTime(FormatDateTime('YYYY',Date())+'-MM-DD',edtDate2.Date));
  if (edtDate1.EditValue<>NULL) and (edtDate2.EditValue=NULL) then
     Str_Where:=Str_Where+' and '+FormatDateTime('YYYY',Date())+Str_Join+'substring(isnull(BIRTHDAY,''          ''),5,6)='+QuotedStr(FormatDateTime(FormatDateTime('YYYY',Date())+'-MM-DD',edtDate1.Date));
  if (edtDate1.EditValue<>NULL) and (edtDate2.EditValue<>NULL) then
    begin
      Date1 := FnTime.fnStrtoDate(FormatDateTime(FormatDateTime('YYYY',Date())+'-MM-DD',edtDate1.Date));
      Date2 := FnTime.fnStrtoDate(FormatDateTime(FormatDateTime('YYYY',Date())+'-MM-DD',edtDate2.Date));
      if Date1 < Date2 then
        Str_Where:=Str_Where+' and '+FormatDateTime('YYYY',Date())+Str_Join+'substring(isnull(BIRTHDAY,''          ''),5,6)>='+QuotedStr(FormatDateTime('YYYY-MM-DD',Date1))+
        ' and '+FormatDateTime('YYYY',Date())+Str_Join+'substring(isnull(BIRTHDAY,''          ''),5,6)<='+QuotedStr(FormatDateTime('YYYY-MM-DD',edtDate2.Date))
      else if Date1 > Date2 then
        Str_Where:=Str_Where+' and '+FormatDateTime('YYYY',Date())+Str_Join+'substring(isnull(BIRTHDAY,''          ''),5,6)>='+QuotedStr(FormatDateTime('YYYY-MM-DD',Date2))+
        ' and '+FormatDateTime('YYYY',Date())+Str_Join+'substring(isnull(BIRTHDAY,''          ''),5,6)<='+QuotedStr(FormatDateTime('YYYY-MM-DD',edtDate1.Date))
      else
        Str_Where:=Str_Where+' and '+FormatDateTime('YYYY',Date())+Str_Join+'substring(isnull(BIRTHDAY,''          ''),5,6)='+QuotedStr(FormatDateTime('YYYY-MM-DD',Date2));
    end;

  // 对会员入会日期进行条件查询
  if (edtDate3.EditValue=NULL) and (edtDate4.EditValue<>NULL) then
     Str_Where:=Str_Where+' and '+FormatDateTime('YYYY',Date())+Str_Join+'substring(isnull(CON_DATE,''          ''),5,6)='+QuotedStr(FormatDateTime(FormatDateTime('YYYY',Date())+'-MM-DD',edtDate4.Date));
  if (edtDate3.EditValue<>NULL) and (edtDate4.EditValue=NULL) then
     Str_Where:=Str_Where+' and '+FormatDateTime('YYYY',Date())+Str_Join+'substring(isnull(CON_DATE,''          ''),5,6)='+QuotedStr(FormatDateTime(FormatDateTime('YYYY',Date())+'-MM-DD',edtDate3.Date));
  if (edtDate3.EditValue<>NULL) and (edtDate4.EditValue<>NULL) then
    begin
      Date1 := FnTime.fnStrtoDate(FormatDateTime(FormatDateTime('YYYY',Date())+'-MM-DD',edtDate3.Date));
      Date2 := FnTime.fnStrtoDate(FormatDateTime(FormatDateTime('YYYY',Date())+'-MM-DD',edtDate4.Date));
      if Date1 < Date2 then
        Str_Where:=Str_Where+' and '+FormatDateTime('YYYY',Date())+Str_Join+'substring(isnull(CON_DATE,''          ''),5,6)>='+QuotedStr(FormatDateTime('YYYY-MM-DD',Date1))+
        ' and '+FormatDateTime('YYYY',Date())+Str_Join+'substring(isnull(CON_DATE,''          ''),5,6)<='+QuotedStr(FormatDateTime('YYYY-MM-DD',edtDate2.Date))
      else if Date1 > Date2 then
        Str_Where:=Str_Where+' and '+FormatDateTime('YYYY',Date())+Str_Join+'substring(isnull(CON_DATE,''          ''),5,6)>='+QuotedStr(FormatDateTime('YYYY-MM-DD',Date2))+
        ' and '+FormatDateTime('YYYY',Date())+Str_Join+'substring(isnull(CON_DATE,''          ''),5,6)<='+QuotedStr(FormatDateTime('YYYY-MM-DD',edtDate1.Date))
      else
        Str_Where:=Str_Where+' and '+FormatDateTime('YYYY',Date())+Str_Join+'substring(isnull(CON_DATE,''          ''),5,6)='+QuotedStr(FormatDateTime('YYYY-MM-DD',Date2));
    end;

  if cmbSHOP_ID.AsString<>'' then
     Str_Where:=Str_Where+' and SHOP_ID='+QuotedStr(cmbSHOP_ID.AsString);
  if cmbPRICE_ID.AsString<>'' then
     Str_Where:=Str_Where+' and PRICE_ID='+QuotedStr(cmbPRICE_ID.AsString);
  if fndSORT_ID.AsString<>'' then
     Str_Where:=Str_Where+' and SORT_ID='+QuotedStr(fndSORT_ID.AsString);
  if trim(fndINTEGRAL.Text)<>'' then
     Str_Where:=Str_Where+' and INTEGRAL>='+inttostr(StrtoIntDef(trim(fndINTEGRAL.Text),0));

  Str_Sql :=
  'select A.*,B.ACCU_INTEGRAL,B.RULE_INTEGRAL,B.INTEGRAL,B.BALANCE from ('+
  'select 0 selflag,CUST_ID,TENANT_ID,SHOP_ID,CUST_CODE,CUST_NAME,SEX,MOVE_TELE,BIRTHDAY,FAMI_ADDR,'+
  'SORT_ID,PRICE_ID,''#'' as UNION_ID from PUB_CUSTOMER where COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(Global.TENANT_ID)+' '+ParseSQL(Factor.iDbType,Str_Where)+') '+
  'A left join PUB_IC_INFO B on A.CUST_ID=B.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.UNION_ID=B.UNION_ID ';

  Str1 := 'select count(A.CUST_ID) from PUB_CUSTOMER A where A.COMM not in (''02'',''12'') and A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' '+ParseSQL(Factor.iDbType,Str_Where);

  case Factor.iDbType of
  0:result := 'select top 600 * from ('+Str_Sql+') jp order by CUST_ID';
  4:result :=
       'select * from ('+
       'select * from ('+Str_Sql+') B order by CUST_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+Str_Sql+') order by CUST_ID limit 600';
  else
    result := 'select * from ('+Str_Sql+') order by CUST_ID';
  end;
end;

procedure TfrmCustomer.Cds_CustomerAfterScroll(DataSet: TDataSet);
begin
  GetNo;
  if IsEnd or not DataSet.Eof then Exit;
  if Cds_Customer.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TfrmCustomer.GetNo;
var str:string;
begin
  if Cds_Customer.IsEmpty then  str:='0'
  else str:=IntToStr(Cds_Customer.RecNo);
  stbPanel.Caption:='第'+str+'条/共'+inttostr(rcAmt)+'条';
end;

procedure TfrmCustomer.N2Click(Sender: TObject);
begin
  inherited;
  {if Cds_Customer.IsEmpty then Exit;
  with TfrmSendGsm.Create(Self) do
    begin
      try
        cds_Customer.DisableControls;
        try
          cds_Customer.First;
          while not cds_Customer.Eof do
          begin
            if cds_Customer.FieldByName('selflag').AsBoolean and (Cds_Customer.FieldbyName('MOVE_TELE').AsString<>'') then
            begin
              cdsTable.Append;
              cdsTable.FieldByName('STATE').AsString := '0';
              cdsTable.FieldByName('TEL').AsString := Cds_Customer.FieldbyName('MOVE_TELE').AsString;
              cdsTable.FieldByName('CNAME').AsString := Cds_Customer.FieldbyName('CUST_NAME').AsString;
              cdsTable.Post;
            end;
            cds_Customer.Next;
          end;
        finally
          cds_Customer.EnableControls;
        end;
        ShowModal;
      finally
        free;
      end;
    end; }
end;

procedure TfrmCustomer.N3Click(Sender: TObject);
begin
  inherited;
  if (not Cds_Customer.Active) and (Cds_Customer.IsEmpty) then exit;
  while not IsEnd do Open(MaxID);
  Cds_Customer.DisableControls;
  try
    Cds_Customer.First;
    while not Cds_Customer.Eof do
    begin
      Cds_Customer.Edit;
      Cds_Customer.FieldByName('selflag').AsString:='1';
      Cds_Customer.Post;
      Cds_Customer.Next;
    end;
  finally
    Cds_Customer.First;
    Cds_Customer.EnableControls;
  end;
end;

procedure TfrmCustomer.N4Click(Sender: TObject);
begin
  inherited;
  if not Cds_Customer.Active then exit;
  if Cds_Customer.IsEmpty then exit;
  while not IsEnd do Open(MaxID);   
  Cds_Customer.DisableControls;
  try
    Cds_Customer.First;
    while not Cds_Customer.Eof do
    begin
      Cds_Customer.Edit;
      if Cds_Customer.FieldByName('selflag').AsString='0' then
         Cds_Customer.FieldByName('selflag').AsString:='1'
      else
         Cds_Customer.FieldByName('selflag').AsString:='0';
      Cds_Customer.Post;
      Cds_Customer.Next;
    end;
  finally
    Cds_Customer.First;
    Cds_Customer.EnableControls;
  end;
end;

procedure TfrmCustomer.N5Click(Sender: TObject);
begin
  inherited;
  if not Cds_Customer.Active then exit;
  if Cds_Customer.IsEmpty then exit;
  while not IsEnd do Open(MaxID);
  Cds_Customer.DisableControls;
  try
    Cds_Customer.First;
    while not Cds_Customer.Eof do
    begin
      Cds_Customer.Edit;
      Cds_Customer.FieldByName('selflag').AsString:='0';
      Cds_Customer.Post;
      Cds_Customer.Next;
    end;
  finally
    Cds_Customer.First;
    Cds_Customer.EnableControls;
  end;
end;

procedure TfrmCustomer.FormDestroy(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.FreeForm(self);
end;

procedure TfrmCustomer.N6Click(Sender: TObject);
begin
  inherited;
  if not Cds_Customer.Active  then Exit;
  while not IsEnd do Open(MaxId);
end;

procedure TfrmCustomer.actNewCardExecute(Sender: TObject);
 procedure UpdateToGlobal(IC:string;ID:string);
   var Temp:TZQuery;
   begin
      Temp := Global.GetZQueryFromName('PUB_CUSTOMER');
      Temp.Filtered := false;
      if not Temp.Locate('CLIENT_ID',ID,[]) then
         Temp.Append
      else
         Temp.Edit;
      Temp.FieldByName('IC_CARDNO').AsString:=IC;
      Temp.Post;
   end;
var  card,union:string;
begin
  inherited;
  if Cds_Customer.IsEmpty then Exit;

  if TfrmNewCard.SelectSendCard(Self,Cds_Customer.FieldbyName('CUST_ID').AsString,'#',Cds_Customer.FieldByName('CUST_NAME').AsString,1,card,union) then
    begin
      if union = '#' then
        begin
          Cds_Customer.Edit;
          Cds_Customer.FieldByName('CUST_CODE').AsString:=card;
          Cds_Customer.Post;
          UpdateToGlobal(card,Cds_Customer.FieldByName('CUST_ID').AsString);
        end;
        MessageBox(Handle,'发新卡成功！',pchar(Application.Title),MB_OK);
    end;
end;

procedure TfrmCustomer.actPasswordExecute(Sender: TObject);
begin
  inherited;
  if (not Cds_Customer.Active) and (Cds_Customer.IsEmpty) then exit;
  TfrmPassWord.SelectCard(Self,Cds_Customer.FieldByName('CUST_ID').AsString,IntToStr(Global.TENANT_ID));
end;

procedure TfrmCustomer.actDepositExecute(Sender: TObject);
var BALANCE:string;
begin
  inherited;
  if not Cds_Customer.Active then exit;
  if Cds_Customer.IsEmpty then exit;
  //if Cds_Customer.FieldByName('CUST_CODE').AsString='' then  Raise Exception.Create('此会员没有会员卡！');
  if TfrmDeposit.Open(Cds_Customer.FieldByName('CUST_ID').AsString,BALANCE) then
  begin
    Cds_Customer.Edit;
    Cds_Customer.FieldByName('BALANCE').AsString:=BALANCE;
    Cds_Customer.Post;
  end;
end;

procedure TfrmCustomer.DBGridEh1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then actEditExecute(nil);
end;

procedure TfrmCustomer.edtKeyKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then   Open('');
end;

procedure TfrmCustomer.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if not edtKey.Focused then inherited;
end;

procedure TfrmCustomer.ToolButton3Click(Sender: TObject);
begin
  inherited;
  actNewCardExecute(nil);
end;

procedure TfrmCustomer.actCancelCardExecute(Sender: TObject);
var CardNo,CardName:String;
begin
  inherited;
  if not Cds_Customer.Active then exit;
  if Cds_Customer.IsEmpty then exit;

  if TfrmCancelCard.SelectCard(Self,Cds_Customer.FieldbyName('CUST_ID').AsString,'#',CardNo,CardName) then
    begin
      MessageBox(Handle,pchar(CardName+'卡"'+CardNo+'"注销成功！'),pchar(Application.Title),MB_OK);
    end;
end;

procedure TfrmCustomer.actReturnExecute(Sender: TObject);
var BALANCE:string;
begin
  inherited;
  if not Cds_Customer.Active then exit;
  if Cds_Customer.IsEmpty then exit;
  //if Cds_Customer.FieldByName('CUST_CODE').AsString='' then  Raise Exception.Create('此会员没有会员卡！');
  if TfrmReturn.Open(Cds_Customer.FieldByName('CUST_ID').AsString,BALANCE) then
  begin
    Cds_Customer.Edit;
    Cds_Customer.FieldByName('BALANCE').AsString:=BALANCE;
    Cds_Customer.Post;
  end;
end;

procedure TfrmCustomer.actRenewExecute(Sender: TObject);
var rs:TRecord_;
begin
  inherited;
  {if Cds_Customer.IsEmpty then Exit;
  rs := TRecord_.Create;
  try
    if TfrmReNew.ReNew(self,Cds_Customer.FieldbyName('CUST_ID').AsString,rs) then
       begin
         Cds_Customer.Edit;
         Cds_Customer.FieldByName('INTEGRAL').AsFloat :=rs.FieldbyName('INTEGRAL2').AsFloat;
         Cds_Customer.Post;
         MessageBox(Handle,'会员续会成功!',pchar(Application.Title),MB_OK);
       end;
  finally
    rs.Free;
  end;}
end;

procedure TfrmCustomer.DBGridEh1TitleClick(Column: TColumnEh);
begin
  if Column.FieldName='selflag' then
    N3Click(nil)
  else
  begin
    {Cds_Customer.IndexName := '';
    Cds_Customer.IndexFieldNames := 'CUST_CODE'; }
  end;
end;

procedure TfrmCustomer.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('33400001',5) then
    Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
  try
    DBGridEh1.Columns[0].Visible := False;
    PrintView;
    PrintDBGridEh1.Print;
  finally
    DBGridEh1.Columns[0].Visible := True;
  end;
end;

procedure TfrmCustomer.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('33400001',5) then
    Raise Exception.Create('你没有预览'+Caption+'的权限,请和管理员联系.');
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

function TfrmCustomer.ShowExecute(AOwner: TForm; Params: String): Boolean;
begin
  SetChildDisplay(AOwner);
end;

function TfrmCustomer.CheckCanExport: boolean;
begin
  Result := ShopGlobal.GetChkRight('33400001',6);
end;

procedure TfrmCustomer.PrintView;
var HeaderText:String;
    HeaderList:TStringList;
begin
  HeaderList := TStringList.Create;
  try
    PrintDBGridEh1.PageHeader.CenterText.Text := '会员档案管理';
    if cmbPRICE_ID.Text <> '' then
      HeaderList.Add('会员等级:'+cmbPRICE_ID.Text);
    if cmbSHOP_ID.Text <> '' then
      HeaderList.Add('会员等级:'+cmbPRICE_ID.Text);
    if fndSORT_ID.Text <> '' then
      HeaderList.Add('会员类别:'+fndSORT_ID.Text);

    // 对会员入会日期进行条件查询
    if (edtDate3.EditValue=NULL) and (edtDate4.EditValue<>NULL) then
      HeaderList.Add('入会日期:'+FormatDateTime('YYYY-MM-DD',edtDate4.Date));
    if (edtDate3.EditValue<>NULL) and (edtDate4.EditValue=NULL) then
      HeaderList.Add('入会日期:'+FormatDateTime('YYYY-MM-DD',edtDate3.Date));
    if (edtDate3.EditValue<>NULL) and (edtDate4.EditValue<>NULL) then
      HeaderList.Add('入会日期:'+FormatDateTime('YYYY-MM-DD',edtDate3.Date)+' 至 '+FormatDateTime('YYYY-MM-DD',edtDate4.Date));


    //  对会员生日日期进行条件查询
    if (edtDate1.EditValue=NULL) and (edtDate2.EditValue<>NULL) then
      HeaderList.Add('会员生日:'+FormatDateTime('YYYY-MM-DD',edtDate2.Date));
    if (edtDate1.EditValue<>NULL) and (edtDate2.EditValue=NULL) then
      HeaderList.Add('会员生日:'+FormatDateTime('YYYY-MM-DD',edtDate1.Date));
    if (edtDate1.EditValue<>NULL) and (edtDate2.EditValue<>NULL) then
      HeaderList.Add('会员生日:'+FormatDateTime('YYYY-MM-DD',edtDate1.Date)+' 至 '+FormatDateTime('YYYY-MM-DD',edtDate2.Date));

    HeaderText := FormatReportHead(HeaderList,4);
    PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[whr]',HeaderText]);
    DBGridEh1.DataSource.DataSet.Filtered := False;
    PrintDBGridEh1.DBGridEh := DBGridEh1;
  finally
    HeaderList.Free;
  end;
end;

function TfrmCustomer.FormatReportHead(TitleList: TStringList;
  Cols: integer): string;
var
  spaceStr,str1: string;
  i,j: integer;
begin
  //中间间隔4个空格:
  result:='';
  for i:=0 to TitleList.Count-1 do
  begin
    if i mod Cols=0 then
    begin
      j:=i;
      if j<=TitleList.Count-1 then str1:=trim(TitleList.Strings[j]);    //1
      inc(j);
      if j<=TitleList.Count-1 then str1:=str1+trim(TitleList.Strings[j]); //2
      inc(j);
      if j<=TitleList.Count-1 then str1:=str1+trim(TitleList.Strings[j]); //3
      inc(j);
      if j<=TitleList.Count-1 then str1:=str1+trim(TitleList.Strings[j]); //4
      case length(str1) of
        1.. 50:  spaceStr:='                                ';
        51..60:  spaceStr:='                          ';
        61..75:  spaceStr:='                    ';
        76..90:  spaceStr:='              ';
        else     spaceStr:='        ';
      end;
    end;
    if result='' then result:=trim(TitleList.Strings[i])
    else
    begin
      if (i mod Cols=0) and (i>=Cols) then
        result:=result+#13+trim(TitleList.Strings[i])
      else
        result:=result+spaceStr+trim(TitleList.Strings[i]);
    end;
  end;
end;

procedure TfrmCustomer.N14Click(Sender: TObject);
var Aobj_Integral:TRecord_;
begin
  inherited;
  if Cds_Customer.IsEmpty then Exit;
  Aobj_Integral := TRecord_.Create;
  try
    if TfrmIntegralGlide_Add.IntegralGlide(self,Cds_Customer.FieldbyName('CUST_ID').AsString,Aobj_Integral) then
       begin
         Cds_Customer.Edit;
         Cds_Customer.FieldByName('INTEGRAL').AsFloat := Cds_Customer.FieldByName('INTEGRAL').AsFloat + Aobj_Integral.FieldbyName('INTEGRAL').AsFloat;
         Cds_Customer.FieldByName('ACCU_INTEGRAL').AsFloat := Cds_Customer.FieldByName('ACCU_INTEGRAL').AsFloat+Aobj_Integral.FieldbyName('INTEGRAL').AsFloat;
         Cds_Customer.Post;
         MessageBox(Handle,'积分增送成功!',pchar(Application.Title),MB_OK);
       end;
  finally
    Aobj_Integral.Free;
  end;
end;

procedure TfrmCustomer.N15Click(Sender: TObject);
var Aobj_Integral:TRecord_;
begin
  inherited;
  if Cds_Customer.IsEmpty then Exit;
  Aobj_Integral := TRecord_.Create;
  try
    if TfrmIntegralGlide.IntegralGlide(self,Cds_Customer.FieldbyName('CUST_ID').AsString,Aobj_Integral) then
       begin
         Cds_Customer.Edit;
         Cds_Customer.FieldByName('INTEGRAL').AsFloat := Cds_Customer.FieldByName('INTEGRAL').AsFloat - Aobj_Integral.FieldbyName('INTEGRAL').AsFloat;
         Cds_Customer.FieldByName('RULE_INTEGRAL').AsFloat := Cds_Customer.FieldByName('RULE_INTEGRAL').AsFloat+Aobj_Integral.FieldbyName('INTEGRAL').AsFloat;
         Cds_Customer.Post;
         MessageBox(Handle,'积分兑换成功!',pchar(Application.Title),MB_OK);
       end;
  finally
    Aobj_Integral.Free;
  end;
end;

procedure TfrmCustomer.actfrmIntegralExecute(Sender: TObject);
begin
  inherited;
  N15Click(Sender);  
end;

procedure TfrmCustomer.actLossCardExecute(Sender: TObject);
var CardNo,CardName:String;
begin
  inherited;
  if not Cds_Customer.Active then exit;
  if Cds_Customer.IsEmpty then exit;

  if TfrmLossCard.SelectCard(Self,Cds_Customer.FieldbyName('CUST_ID').AsString,'#',CardNo,CardName) then
    begin
      MessageBox(Handle,pchar(CardName+'卡"'+CardNo+'"挂失成功！'),pchar(Application.Title),MB_OK);
    end;
end;

procedure TfrmCustomer.Excel1Click(Sender: TObject);
  function Check(Source,Dest:TDataSet;SFieldName:string;DFieldName:string):Boolean;
  var rs:TZQuery;
  begin
    Result := False;
    // *******************入会门店********************
    if DFieldName = 'SHOP_ID' then
      begin
        if Source.FieldByName(SFieldName).AsString <> '' then
          begin
            rs := Global.GetZQueryFromName('CA_SHOP_INFO');
            if rs.Locate('SHOP_NAME',Trim(Source.FieldByName(SFieldName).AsString),[]) then
              begin
                Dest.FieldByName('SHOP_ID').AsString := rs.FieldByName('SHOP_ID').AsString;
                Result := True;
              end
            else
              Raise Exception.Create('没找到'+Source.FieldByName(SFieldName).AsString+'对应的门店代码...');
          end
        else
          Raise Exception.Create('门店不能为空!');
      end;

    // *******************会员等级*****************
    if DFieldName = 'PRICE_ID' then 
      begin
        if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
          begin
            rs := Global.GetZQueryFromName('PUB_PRICEGRADE');
            if rs.Locate('PRICE_NAME',Trim(Source.FieldByName(SFieldName).AsString),[]) then
              begin
                Dest.FieldByName('PRICE_ID').AsString := rs.FieldbyName('PRICE_ID').AsString;
                Result := True;
              end
            else
              Raise Exception.Create('没找到'+Source.FieldByName(SFieldName).AsString+'对应的会员等级代码...');
          end
        else
          begin
            Raise Exception.Create('会员等级不能为空!');
          end;
      end;

    //*******************地区*****************
    if DFieldName = 'REGION_ID' then   
      begin
        if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
          begin
            rs := Global.GetZQueryFromName('PUB_REGION_INFO');
            if rs.Locate('CODE_NAME',Trim(Source.FieldByName(SFieldName).AsString),[]) then
              begin
                Dest.FieldByName('REGION_ID').AsString := rs.FieldbyName('CODE_ID').AsString;
                Result := True;
              end
            else
              Raise Exception.Create('没找到'+Source.FieldByName(SFieldName).AsString+'对应的地区代码...');
          end
        else
          //Raise Exception.Create('地区不能为空!');
          Dest.FieldByName('REGION_ID').AsString := '#';
      end;

    //*******************会员类别*****************
    if DFieldName = 'SORT_ID' then
      begin
        if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
          begin
            rs := Global.GetZQueryFromName('PUB_CLIENTSORT');
            if rs.Locate('CODE_NAME',Trim(Source.FieldByName(SFieldName).AsString),[]) then
              begin
                Dest.FieldByName('SORT_ID').AsString := rs.FieldbyName('CODE_ID').AsString;
                Result := True;
              end
            else
              Raise Exception.Create('没找到'+Source.FieldByName(SFieldName).AsString+'对应的会员类别代码...');
          end
        else
          begin
            Dest.FieldByName('SORT_ID').AsString := '#';
            //Raise Exception.Create('会员类别不能为空!');
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
                Dest.FieldbyName('SEX').AsString := Source.FieldByName(SFieldName).AsString;
                Result := True;
              end;
          end
        else
          Raise Exception.Create('会员性别不能为空!');
      end;

    //会员编号
    if DFieldName = 'CUST_CODE' then    
      begin
        if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
          begin
            if Length(Source.FieldByName(SFieldName).AsString) > 20 then
              Raise Exception.Create('会员编号就在20个字符以内!')
            else
              begin
                rs := Global.GetZQueryFromName('PUB_CUSTOMER');
                if rs.Locate('CLIENT_CODE',Source.FieldByName(SFieldName).AsString,[]) then
                  Raise Exception.Create('当前会员编号已经存在!')
                else
                  begin
                    Dest.FieldbyName('CUST_CODE').AsString := Source.FieldByName(SFieldName).AsString;
                    Result := True;
                  end;
              end;
          end
        else
          begin
            Dest.FieldbyName('CUST_CODE').AsString := FnString.GetCodeFlag(inttostr(strtoint(fnString.TrimRight(Global.SHOP_ID,4))+1000)+TSequence.GetSequence('CID_'+Global.SHOP_ID,inttostr(Global.TENANT_ID),'',8));
          end;
      end;

    //会员名称
    if DFieldName = 'CUST_NAME' then    
      begin
        if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
          begin
            if Length(Source.FieldByName(SFieldName).AsString) > 50  then
              Raise Exception.Create('客户名称就在50个字符以内!')
            else
              begin
                Dest.FieldbyName('CUST_NAME').AsString := Source.FieldByName(SFieldName).AsString;
                Result := True;
              end;
          end
        else
          Raise Exception.Create('客户名称不能为空!');
      end;

    //会员拼音码
    if DFieldName = 'CUST_SPELL' then
      begin
        if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
          begin
            if Length(Source.FieldByName(SFieldName).AsString) > 50  then
              Raise Exception.Create('会员拼音码就在50个字符以内!')
            else
              begin
                Dest.FieldbyName('CUST_SPELL').AsString := Source.FieldByName(SFieldName).AsString;
                Result := True;
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
        CdsExcel.FieldByName('CUST_ID').AsString  := TSequence.NewId;
        CdsExcel.FieldByName('UNION_ID').AsString := '#';
        CdsExcel.FieldByName('CLIENT_TYPE').AsString := '2';
        CdsExcel.FieldByName('CREA_DATE').AsString := FormatDateTime('YYYY-MM-DD',Date());
        CdsExcel.FieldByName('CREA_USER').AsString := Global.UserID;
        CdsExcel.FieldByName('IC_INFO').AsString := '企业卡';
        CdsExcel.FieldByName('IC_STATUS').AsString := '0';
        CdsExcel.FieldByName('IC_TYPE').AsString := '0';
        if CdsExcel.FieldByName('CUST_SPELL').AsString = '' then
          CdsExcel.FieldByName('CUST_SPELL').AsString := fnString.GetWordSpell(Trim(CdsExcel.FieldByName('CUST_NAME').AsString),3);
        CdsExcel.Post;
        CdsExcel.Next;
      end;
    Result := Factor.UpdateBatch(CdsExcel,'TCustomer',nil);
  end;
  function FindColumn(CdsCol:TDataSet):Boolean;
  begin
    if not CdsCol.Locate('FieldName','SHOP_ID',[]) then
      begin
        Result := False;
        Raise Exception.Create('缺少门店字段!');
      end;
    if not CdsCol.Locate('FieldName','PRICE_ID',[]) then
      begin
        Result := False;
        Raise Exception.Create('缺少等级字段!');
      end;
    if not CdsCol.Locate('FieldName','SEX',[]) then
      begin
        Result := False;
        Raise Exception.Create('缺少性别字段!');
      end;
    if not CdsCol.Locate('FieldName','CUST_NAME',[]) then
      begin
        Result := False;
        Raise Exception.Create('缺少会员名称字段!');
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
    Params.ParamByName('CUST_ID').asString := '';
    Params.ParamByName('UNION_ID').AsString := '#';
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(rs,'TCustomer',Params);

    FieldsString := 'CUST_CODE=会员卡号,CUST_NAME=会员名称,CUST_SPELL=拼音码,SEX=性别,SORT_ID=会员类别,PRICE_ID=会员等级,REGION_ID=地区,'+
    'SHOP_ID=入会门店,MOVE_TELE=移动电话,BIRTHDAY=会员生日,FAMI_ADDR=地址,POSTALCODE=邮编,ID_NUMBER=证件号码,IDN_TYPE=证件类型,SND_DATE=入会日期,'+
    'CON_DATE=续会日期,QQ=QQ,MSN=MSN,END_DATE=有效截止日期,MONTH_PAY=月收入,DEGREES=学历,EMAIL=电子邮件,OFFI_TELE=办公电话,FAMI_TELE=家庭电话,'+
    'OCCUPATION=职业,JOBUNIT=工作单位,REMARK=备注';

    FormatString := '0=CUST_CODE,1=CUST_NAME,2=CUST_SPELL,3=SEX,4=SORT_ID,5=PRICE_ID,6=REGION_ID,7=SHOP_ID,8=MOVE_TELE,9=BIRTHDAY,10=FAMI_ADDR,'+
    '11=POSTALCODE,12=ID_NUMBER,13=IDN_TYPE,14=SND_DATE,15=CON_DATE,16=QQ,17=MSN,18=END_DATE,19=MONTH_PAY,20=DEGREES,21=EMAIL,22=OFFI_TELE,'+
    '23=FAMI_TELE,24=OCCUPATION,25=JOBUNIT,26=REMARK';

    TfrmExcelFactory.ExcelFactory(rs,FieldsString,@Check,@SaveExcel,@FindColumn,FormatString,1);

  finally
    Params.Free;
    rs.Free;
  end;
end;

end.


