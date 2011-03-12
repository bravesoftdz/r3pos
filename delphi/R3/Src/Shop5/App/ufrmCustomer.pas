unit ufrmCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls, RzLabel,
  RzTabs, ExtCtrls, RzPanel, RzButton, DB, Grids, uGlobal, DBGridEh, cxControls,
  cxContainer, cxEdit, cxTextEdit, zBase, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxButtonEdit, zrComboBoxList, FR_Class, PrnDbgeh, jpeg, ZAbstractRODataset, 
  ZAbstractDataset, ZDataset;

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
    PrintDBGridEh1: TPrintDBGridEh;
    Cds_Customer: TZQuery;
    N13: TMenuItem;
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
    procedure actfrmIntegralExecute(Sender: TObject);
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
  private
    function CheckCanExport:boolean;
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
uses ufrmCustomerInfo, DateUtils, uShopGlobal,uCtrlUtil,ufrmEhLibReport,uFnUtil,
   ufrmBasic;
//  ufrmIntegralGlide,ufrmSendGsm,ufrmDeposit,ufrmReturn,ufrmCancelCard,ufrmReNew,ufrmNewCard,ufrmPassWord,

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
  edtDate1.Date := FnTime.fnStrtoDate(FormatDateTime('1900-01-01',Date));
  edtDate2.Date := Date;
  edtDate3.Date := FnTime.fnStrtoDate(FormatDateTime('1900-01-01',Date));
  edtDate4.Date := Date;
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
var Str_Where,Str_Sql:string;
begin
  if Trim(edtKey.Text)<>'' then
     begin
       Str_Where:=' and (MOVE_TELE LIKE '+QuotedStr('%'+Trim(edtKey.Text)+'%')+' or CUST_NAME LIKE '+QuotedStr('%'+Trim(edtKey.Text)+'%')+
       ' or CUST_CODE LIKE '+QuotedStr('%'+Trim(edtKey.Text)+'%')+' or CUST_SPELL LIKE '+QuotedStr('%'+Trim(edtKey.Text)+'%')+
       ' or ID_NUMBER LIKE '+QuotedStr('%'+Trim(edtKey.Text)+'%')+')';
     end;
  if id<>'' then
    Str_Where := Str_Where + ' and CUST_ID>'''+id+'''';

  //  对会员生日日期进行条件查询
  if (edtDate1.EditValue=NULL) and (edtDate2.EditValue<>NULL) then
     Str_Where:=Str_Where+' and BIRTHDAY='+QuotedStr(FormatDateTime('YYYY-MM-DD',edtDate2.Date));
  if (edtDate1.EditValue<>NULL) and (edtDate2.EditValue=NULL) then
     Str_Where:=Str_Where+' and BIRTHDAY='+QuotedStr(FormatDateTime('YYYY-MM-DD',edtDate1.Date));
  if (edtDate1.EditValue<>NULL) and (edtDate2.EditValue<>NULL) then
     Str_Where:=Str_Where+' and BIRTHDAY>='+QuotedStr(FormatDateTime('YYYY-MM-DD',edtDate1.Date))+' and BIRTHDAY<='+QuotedStr(FormatDateTime('YYYY-MM-DD',edtDate2.Date));

{  if (edtDate1.EditValue=NULL) and (edtDate2.EditValue<>NULL) then
     Str_Where:=Str_Where+' and substring(BIRTHDAY,6,5)='+QuotedStr(FormatDateTime('MM-DD',edtDate2.Date));
  if (edtDate1.EditValue<>NULL) and (edtDate2.EditValue=NULL) then
     Str_Where:=Str_Where+' and substring(BIRTHDAY,6,5)='+QuotedStr(FormatDateTime('MM-DD',edtDate1.Date));
  if (edtDate1.EditValue<>NULL) and (edtDate2.EditValue<>NULL) then
     Str_Where:=Str_Where+' and substring(BIRTHDAY,6,5)>='+QuotedStr(FormatDateTime('MM-DD',edtDate1.Date))+' and substring(BIRTHDAY,6,5)<='+QuotedStr(FormatDateTime('MM-DD',edtDate2.Date));}

  // 对会员入会日期进行条件查询
  if (edtDate3.EditValue=NULL) and (edtDate4.EditValue<>NULL) then
     Str_Where:=Str_Where+' and SND_DATE='+QuotedStr(FormatDateTime('YYYY-MM-DD',edtDate4.Date));
  if (edtDate3.EditValue<>NULL) and (edtDate4.EditValue=NULL) then
     Str_Where:=Str_Where+' and SND_DATE='+QuotedStr(FormatDateTime('YYYY-MM-DD',edtDate3.Date));
  if (edtDate3.EditValue<>NULL) and (edtDate4.EditValue<>NULL) then
     Str_Where:=Str_Where+' and SND_DATE>='+QuotedStr(FormatDateTime('YYYY-MM-DD',edtDate3.Date))+' and SND_DATE<='+QuotedStr(FormatDateTime('YYYY-MM-DD',edtDate4.Date));

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
  'SORT_ID,PRICE_ID,''#'' as UNION_ID from PUB_CUSTOMER where COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(Global.TENANT_ID)+' '+Str_Where+') '+
  'A left join PUB_IC_INFO B on A.CUST_ID=B.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.UNION_ID=B.UNION_ID ';

  Str1 := 'select count(A.CUST_ID) from PUB_CUSTOMER A where A.COMM not in (''02'',''12'') and A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' '+Str_Where;

  case Factor.iDbType of
  0:result := 'select top 600 * from ('+Str_Sql+') jp order by CUST_ID';
  4:result :=
       'select * from ('+
       'select * from ('+Str_Sql+') order by CUST_ID) tp fetch first 600  rows only';
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

procedure TfrmCustomer.actfrmIntegralExecute(Sender: TObject);
//var rs:TRecord_;
begin
  inherited;
  {if Cds_Customer.IsEmpty then Exit;
  rs := TRecord_.Create;
  try
    if TfrmIntegralGlide.IntegralGlide(self,Cds_Customer.FieldbyName('CUST_ID').AsString,rs) then
       begin
         Cds_Customer.Edit;
         Cds_Customer.FieldByName('INTEGRAL').AsFloat := Cds_Customer.FieldByName('INTEGRAL').AsFloat - rs.FieldbyName('INTEGRAL').AsFloat;
         Cds_Customer.FieldByName('RULE_INTEGRAL').AsFloat := Cds_Customer.FieldByName('RULE_INTEGRAL').AsFloat+rs.FieldbyName('INTEGRAL').AsFloat;
         Cds_Customer.Post;
         MessageBox(Handle,'积分兑换成功!',pchar(Application.Title),MB_OK); 
       end;
  finally
    rs.Free;
  end;}
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
var  card:string;
begin
  inherited;
  {if Cds_Customer.IsEmpty then Exit;
  if Cds_Customer.FieldByName('IC_CARDNO').AsString<>'' then Raise Exception.Create('此会员已经有储值卡！');

  if TfrmNewCard.Send_Card(Cds_Customer.FieldByName('CUST_ID').AsString,card) then
    begin
      Cds_Customer.Edit;
      Cds_Customer.FieldByName('IC_CARDNO').AsString:=card;
      Cds_Customer.FieldByName('BALANCE').AsString:='0';
      Cds_Customer.Post;
      UpdateToGlobal(card,Cds_Customer.FieldByName('CUST_ID').AsString);
      MessageBox(Handle,'发新卡成功！',pchar(Application.Title),MB_OK);
    end; }
end;

procedure TfrmCustomer.actPasswordExecute(Sender: TObject);
begin
  inherited;
  if (not Cds_Customer.Active) and (Cds_Customer.IsEmpty) then exit;
  if Cds_Customer.FieldByName('IC_CARDNO').AsString='' then  Raise Exception.Create('此会员没有储值卡！');

 { with TfrmPassWord.Create(self) do
    begin
      try
        IC_Card := Cds_Customer.FieldByName('CUST_ID').AsString;
        ShowModal;
      finally
        free;
      end;
    end;}
end;

procedure TfrmCustomer.actDepositExecute(Sender: TObject);
var BALANCE:string;
begin
  inherited;
  {if not Cds_Customer.Active then exit;
  if Cds_Customer.IsEmpty then exit;
  if Cds_Customer.FieldByName('IC_CARDNO').AsString='' then  Raise Exception.Create('此会员没有储值卡！');
  if TfrmDeposit.Open(Cds_Customer.FieldByName('CUST_ID').AsString,BALANCE) then
  begin
    Cds_Customer.Edit;
    Cds_Customer.FieldByName('BALANCE').AsString:=BALANCE;
    Cds_Customer.Post;
  end;}
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
 procedure UpdateToGlobal(IC:string;ID:string);
   var Temp:TZQuery;
   begin
      Temp := Global.GetZQueryFromName('BAS_CUSTOMER');
      Temp.Filtered := false;
      if not Temp.Locate('CUST_ID',ID,[]) then
         Temp.Append
      else
         Temp.Edit;
      Temp.FieldByName('IC_CARDNO').AsString:=IC;
      Temp.Post;
   end;
begin
  inherited;
  {if not Cds_Customer.Active then exit;
  if Cds_Customer.IsEmpty then exit;
  if Cds_Customer.FieldByName('IC_CARDNO').AsString='' then  Raise Exception.Create('此会员没有储值卡！');
  if TfrmCancelCard.Open(Cds_Customer.FieldByName('CUST_ID').AsString) then
  begin
    Cds_Customer.Edit;
    Cds_Customer.FieldByName('IC_CARDNO').AsString:='';
    Cds_Customer.FieldByName('BALANCE').AsString:='';
    Cds_Customer.Post;
    UpdateToGlobal(Cds_Customer.FieldByName('IC_CARDNO').AsString,Cds_Customer.FieldByName('CUST_ID').AsString);
    MessageBox(Handle,'注销卡成功！',pchar(Application.Title),MB_OK);
  end; }
end;

procedure TfrmCustomer.actReturnExecute(Sender: TObject);
var BALANCE:string;
begin
  inherited;
  {if not Cds_Customer.Active then exit;
  if Cds_Customer.IsEmpty then exit;
  if Cds_Customer.FieldByName('IC_CARDNO').AsString='' then  Raise Exception.Create('此会员没有储值卡！');
  if TfrmReturn.Open(Cds_Customer.FieldByName('CUST_ID').AsString,BALANCE) then
  begin
    Cds_Customer.Edit;
    Cds_Customer.FieldByName('BALANCE').AsString:=BALANCE;
    Cds_Customer.Post;
  end;}
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

  PrintDBGridEh1.DBGridEh := DBGridEh1;
  PrintDBGridEh1.Print;
end;

procedure TfrmCustomer.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('33400001',5) then
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

function TfrmCustomer.ShowExecute(AOwner: TForm; Params: String): Boolean;
begin
  SetChildDisplay(AOwner);
end;

function TfrmCustomer.CheckCanExport: boolean;
begin
  Result := ShopGlobal.GetChkRight('33400001',6);
end;

end.


