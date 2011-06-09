unit ufrmSupplier;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls, RzLabel,
  RzTabs, ExtCtrls, RzPanel, DB, Grids, DBGridEh, uGlobal, cxControls, cxContainer,
  cxEdit, cxTextEdit, RzButton, ZBase, cxMaskEdit, cxButtonEdit, zrComboBoxList,
  FR_Class, cxDropDownEdit, PrnDbgeh, jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmSupplier = class(TframeToolForm)
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
    N5: TMenuItem;
    Excel1: TMenuItem;
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
    procedure Excel1Click(Sender: TObject);
  private
    sqlstring:string;
    function CheckCanExport:boolean;
    procedure PrintView;
    { Private declarations }
  public
    { Public declarations }
    procedure AddRecord(AObj:TRecord_);
    procedure InitGrid;
  end;

implementation
uses ufrmSupplierInfo, uShopGlobal, uCtrlUtil, ufrmEhLibReport, ufrmBasic, uFnUtil, ufrmExcelFactory,
     uDsUtil;//,ufrmSendGsm
{$R *.dfm}

procedure TfrmSupplier.actNewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('33100001',2) then Raise Exception.Create('��û������'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  With TfrmSupplierInfo.Create(self) do
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

procedure TfrmSupplier.actDeleteExecute(Sender: TObject);
    procedure UpdateToGlobal(str:string);
    var Temp:TZQuery;
    begin
      Temp := Global.GetZQueryFromName('PUB_CLIENTINFO');
      Temp.Filtered :=false;
      if Temp.Locate('CLIENT_ID',str,[]) then
      begin
        Temp.Delete;
      end;
    end;
var
i:integer;
begin
  inherited;
  if (not Cds_Client.Active) or (Cds_Client.IsEmpty) then exit;
  if Cds_Client.State in [dsInsert,dsEdit] then Cds_Client.Post;
  if not ShopGlobal.GetChkRight('33100001',4) then Raise Exception.Create('��û��ɾ��'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  i:=MessageBox(Handle,Pchar('�Ƿ�Ҫɾ����?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
  if i=6 then
  begin
    Cds_Client.CommitUpdates;
    Cds_Client.DisableControls;
    try
      Cds_Client.Filtered := false;
      Cds_Client.Filter := 'selFlag=1';
      Cds_Client.Filtered := true;
      if Cds_Client.IsEmpty then Raise Exception.Create('��ѡ��Ҫɾ���Ĺ�Ӧ��...');
      Cds_Client.First;
      while not Cds_Client.Eof do
      begin
        if Cds_Client.FieldByName('selflag').AsString = '1' then
        begin
          UpdateToGlobal(Cds_Client.FieldByName('CLIENT_ID').AsString);
          Cds_Client.Delete;
        end
        else Cds_Client.Next;
      end;
      try
        Factor.UpdateBatch(Cds_Client,'TSupplier');
      except
        Cds_Client.CancelUpdates;
        Cds_Client.CancelUpdates;
        Raise;
      end;
    finally
      Cds_Client.Filtered := false;
      Cds_Client.EnableControls;
    end;
  end;

end;

procedure TfrmSupplier.actFindExecute(Sender: TObject);
var
   Str_Wh:String;
begin
  inherited;
  if not ShopGlobal.GetChkRight('33100001',1) then Raise Exception.Create('��û�в�ѯ'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  
  Str_Wh := 'select 0 as selflag,TENANT_ID,CLIENT_ID,CLIENT_TYPE,CLIENT_CODE,LICENSE_CODE,CLIENT_NAME,CLIENT_SPELL,SORT_ID,REGION_ID,SETTLE_CODE,ADDRESS,'+
  'POSTALCODE,LINKMAN,TELEPHONE3,TELEPHONE1,TELEPHONE2,FAXES,HOMEPAGE,EMAIL,QQ,MSN,BANK_ID,ACCOUNT,INVOICE_FLAG,REMARK,TAX_RATE,PRICE_ID,SHOP_ID'+
  ' from PUB_CLIENTINFO where COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and CLIENT_TYPE=''1'' ';

  sqlstring:='';
  if edtKey.Text<>'' then
    begin
      sqlstring:=' and (CLIENT_NAME LIKE ''%'+trim(edtKey.Text)+'%'' or CLIENT_SPELL LIKE ''%'+trim(edtKey.Text)+'%'' or CLIENT_CODE LIKE ''%'+trim(edtKey.Text)+'%'' )';
      Str_Wh:=Str_Wh+sqlstring;
    end;
  if fndSORT_ID.AsString<>'' then
    begin
      sqlstring:=sqlstring+' and SORT_ID='+QuotedStr(fndSORT_ID.AsString);
      Str_Wh:=Str_Wh+' and SORT_ID='+QuotedStr(fndSORT_ID.AsString);
    end;

  Cds_Client.Close;
  Cds_Client.SQL.Text := Str_Wh+' order by CLIENT_CODE';
  Factor.Open(Cds_Client);
end;

procedure TfrmSupplier.actEditExecute(Sender: TObject);
begin
  inherited;
  if (not Cds_Client.Active) or (Cds_Client.IsEmpty) then exit;
  if not ShopGlobal.GetChkRight('33100001',3) then Raise Exception.Create('��û���޸�'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  With TfrmSupplierInfo.Create(self) do
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

procedure TfrmSupplier.actExitExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmSupplier.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmSupplier.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQ_NO' then
     Background := clBtnFace;
  if uppercase(Column.FieldName) = 'SELFLAG' then
     Background := clBtnFace;     
end;

procedure TfrmSupplier.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (not Cds_Client.Active) or (Cds_Client.IsEmpty) then exit;
  With TfrmSupplierInfo.Create(self) do
  begin
    try
      Open(Cds_Client.FieldByName('CLIENT_ID').AsString);
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfrmSupplier.AddRecord(AObj: TRecord_);
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
     Cds_Client.FieldByName('selflag').AsString:='0';
     Cds_Client.Post;
  end;
  InitGrid;
  if Cds_Client.Locate('CLIENT_ID',AObj.FieldByName('CLIENT_ID').AsString,[]) then;
end;

procedure TfrmSupplier.edtKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=VK_DOWN then
     Cds_Client.Next;
  if Key=VK_UP then
     Cds_Client.Prior;
end;

procedure TfrmSupplier.FormShow(Sender: TObject);
begin
  inherited;
  actFindExecute(nil);
  if edtKey.CanFocus then
    edtKey.SetFocus;
end;

procedure TfrmSupplier.FormCreate(Sender: TObject);
begin
  inherited;
  InitGrid;
  fndSORT_ID.DataSet:=Global.GetZQueryFromName('PUB_SUPPERSORT');
  TDbGridEhSort.InitForm(self);
end;

procedure TfrmSupplier.InitGrid;
var tmp,rs:TZQuery;
begin
  DBGridEh1.FieldColumns['SORT_ID'].KeyList.Clear;
  DBGridEh1.FieldColumns['SORT_ID'].PickList.Clear;
  tmp:=Global.GetZQueryFromName('PUB_SUPPERSORT');
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
  
  try
    DBGridEh1.FieldColumns['SETTLE_CODE'].KeyList.Clear;
    DBGridEh1.FieldColumns['SETTLE_CODE'].PickList.Clear;
    rs := Global.GetZQueryFromName('PUB_SETTLE_CODE');
    rs.First;
    while not rs.Eof do
      begin
        DBGridEh1.FieldColumns['SETTLE_CODE'].KeyList.Add(rs.Fields[0].asstring);
        DBGridEh1.FieldColumns['SETTLE_CODE'].PickList.Add(rs.Fields[1].AsString);
        rs.Next;
      end;
  finally

  end;
end;

procedure TfrmSupplier.Cds_ClientAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if Cds_Client.RecNo<=0 then  str:='0'
  else str:=IntToStr(Cds_Client.RecNo);
  stbPanel.Caption:='��'+str+'��/��'+inttostr(Cds_Client.RecordCount)+'��';
end;

procedure TfrmSupplier.FormDestroy(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.FreeForm(self);  
end;

procedure TfrmSupplier.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('33100001',5) then
    Raise Exception.Create('��û�д�ӡ'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  try
    DBGridEh1.Columns[0].Visible := False;
    PrintView;
    PrintDBGridEh1.Print;
  finally
    DBGridEh1.Columns[0].Visible := True;
  end;
end;

procedure TfrmSupplier.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('33100001',5) then
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
procedure TfrmSupplier.DBGridEh1TitleClick(Column: TColumnEh);
begin
  inherited;
  if Column.FieldName='selflag' then
    N1Click(nil);
end;

procedure TfrmSupplier.N1Click(Sender: TObject);
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

procedure TfrmSupplier.N3Click(Sender: TObject);
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

procedure TfrmSupplier.N2Click(Sender: TObject);
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

procedure TfrmSupplier.N4Click(Sender: TObject);
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

procedure TfrmSupplier.Cds_ClientFilterRecord(DataSet: TDataSet;
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

function TfrmSupplier.CheckCanExport: boolean;
begin
  Result := ShopGlobal.GetChkRight('33100001',6);
end;

procedure TfrmSupplier.PrintView;
begin
  PrintDBGridEh1.PageHeader.CenterText.Text := '��Ӧ�̵�������';

  PrintDBGridEh1.AfterGridText.Text := #13+'��ӡ��:'+Global.UserName+'  ��ӡʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());

  DBGridEh1.DataSource.DataSet.Filtered := False;
  PrintDBGridEh1.DBGridEh := DBGridEh1;
end;

procedure TfrmSupplier.Excel1Click(Sender: TObject);
  function Check(Source,Dest:TDataSet;SFieldName:string;DFieldName:string):Boolean;
  var rs:TZQuery;
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
              end
            else
              Raise Exception.Create('û�ҵ�"'+Source.FieldByName(SFieldName).AsString+'"��Ӧ���ŵ����...');
          end
        else
          Raise Exception.Create('�ŵ겻��Ϊ��!');
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
                Result := True;
              end
            else
              Raise Exception.Create('û�ҵ�"'+Source.FieldByName(SFieldName).AsString+'"��Ӧ�ĵ�������...');
          end
        else
          Dest.FieldByName('REGION_ID').AsString := '#';
      end;

    //*******************��Ӧ�����*****************
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
              Raise Exception.Create('û�ҵ�"'+Source.FieldByName(SFieldName).AsString+'"��Ӧ�Ĺ�Ӧ��������...');
          end
        else
          begin
            Dest.FieldByName('SORT_ID').AsString := '#';
            //Raise Exception.Create('�ͻ������Ϊ��!');
          end;
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
                Result := True;
              end
            else
              Raise Exception.Create('û�ҵ�"'+Source.FieldByName(SFieldName).AsString+'"��Ӧ�Ľ��㷽ʽ����...');
          end
        else
          Raise Exception.Create('���㷽ʽ����Ϊ��!');
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
          end
        else
          Raise Exception.Create('û�ҵ�"'+Source.FieldByName(SFieldName).AsString+'"��Ӧ�ķ�Ʊ���ʹ���...');
      end;

    //��Ӧ�̱��
    if DFieldName = 'CLIENT_CODE' then
      begin
        if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
          begin
            if Length(Source.FieldByName(SFieldName).AsString) > 20 then
              Raise Exception.Create('��Ӧ�̱�ž���20���ַ�����!')
            else
              begin
                rs := Global.GetZQueryFromName('PUB_CLIENTINFO');
                if rs.Locate('CLIENT_CODE',Source.FieldByName(SFieldName).AsString,[]) then
                  Raise Exception.Create('��ǰ��Ӧ�̱���Ѿ�����!')
                else
                  begin
                    Dest.FieldbyName('CLIENT_CODE').AsString := Source.FieldByName(SFieldName).AsString;
                    Result := True;
                  end;
              end;
          end
        else
          begin
            Dest.FieldbyName('CLIENT_CODE').AsString := FnString.GetCodeFlag(inttostr(strtoint(fnString.TrimRight(Global.SHOP_ID,4))+1000)+TSequence.GetSequence('CID_'+Global.SHOP_ID,inttostr(Global.TENANT_ID),'',8));
          end;
      end;

    //��Ӧ������
    if DFieldName = 'CLIENT_NAME' then
      begin
        if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
          begin
            if Length(Source.FieldByName(SFieldName).AsString) > 50  then
              Raise Exception.Create('��Ӧ�����ƾ���50���ַ�����!')
            else
              begin
                Dest.FieldbyName('CLIENT_NAME').AsString := Source.FieldByName(SFieldName).AsString;
                Result := True;
              end;
          end
        else
          Raise Exception.Create('��Ӧ�����Ʋ���Ϊ��!');
      end;

    //��Ӧ��ƴ����
    if DFieldName = 'CLIENT_SPELL' then
      begin
        if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
          begin
            if Length(Source.FieldByName(SFieldName).AsString) > 50  then
              Raise Exception.Create('��Ӧ��ƴ�������50���ַ�����!')
            else
              begin
                Dest.FieldbyName('CLIENT_SPELL').AsString := Source.FieldByName(SFieldName).AsString;
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
        CdsExcel.FieldByName('CLIENT_TYPE').AsString := '1';
        CdsExcel.FieldByName('CREA_DATE').AsString := FormatDateTime('YYYY-MM-DD',Date());
        CdsExcel.FieldByName('CREA_USER').AsString := Global.UserID;
        //CdsExcel.FieldByName('IC_STATUS').AsString := '0';
        if CdsExcel.FieldByName('CLIENT_SPELL').AsString = '' then
          CdsExcel.FieldByName('CLIENT_SPELL').AsString := fnString.GetWordSpell(Trim(CdsExcel.FieldByName('CLIENT_NAME').AsString),3);

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
        Raise Exception.Create('ȱ���ŵ��ֶ�!');
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
    rs:TZQuery;
begin
  inherited;
  Params := TftParamList.Create(nil);
  rs := TZQuery.Create(nil);
  try
    Params.ParamByName('CLIENT_ID').asString := '';
    Params.ParamByName('UNION_ID').AsString := '#';
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(rs,'TSupplier',Params);

    FieldsString := 'CLIENT_CODE=��Ӧ�̱��,CLIENT_NAME=��Ӧ������,CLIENT_SPELL=ƴ����,SHOP_ID=�����ŵ�,SORT_ID=��Ӧ�̷���,REGION_ID=����,SETTLE_CODE=���㷽ʽ,'+
    'INVO_NAME=��˾ȫ��,LEGAL_REPR=���˴���,LICENSE_CODE=��Ӫ���֤,BANK_ID=��������,ACCOUNT=�˺�,TELEPHONE3=ע��绰,INVOICE_FLAG=��Ʊ����,'+
    'TAX_RATE=����˰��,TAX_NO=˰��Ǽ�֤��,ADDRESS=��ַ,LINKMAN=��ϵ��,FAXES=����,TELEPHONE1=�绰,TELEPHONE2=�ֻ�,QQ=QQ,MSN=MSN,EMAIL=�����ʼ�,'+
    'HOMEPAGE=��ַ,SEND_ADDR=�ʼĵ�ַ,POSTALCODE=��������,SEND_LINKMAN=�ͻ���,SEND_TELE=�ͻ����ֻ�,RECV_ADDR=�ջ���ַ,RECV_LINKMAN=�ջ���,RECV_TELE=�ջ����ֻ�,REMARK=��ע';

    FormatString := '0=CLIENT_CODE,1=CLIENT_NAME,2=CLIENT_SPELL,3=SHOP_ID,4=SORT_ID,5=REGION_ID,6=SETTLE_CODE,7=INVO_NAME,8=LEGAL_REPR,'+
    '9=LICENSE_CODE,10=BANK_ID,11=ACCOUNT,12=TELEPHONE3,13=INVOICE_FLAG,14=TAX_RATE,15=TAX_NO,16=ADDRESS,17=LINKMAN,18=FAXES,19=TELEPHONE1,'+
    '20=TELEPHONE2,21=QQ,22=MSN,23=EMAIL,24=HOMEPAGE,25=SEND_ADDR,26=POSTALCODE,27=SEND_LINKMAN,28=SEND_TELE,29=RECV_ADDR,30=RECV_LINKMAN,31=RECV_TELE,31=REMARK';

    TfrmExcelFactory.ExcelFactory(rs,FieldsString,@Check,@SaveExcel,@FindColumn,FormatString,1);

  finally
    Params.Free;
    rs.Free;
  end;
end;

end.
