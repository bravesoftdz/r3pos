unit ufrmInitGuide;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ufrmBasic, ExtCtrls, ActnList, Menus, RzPanel, RzForms, RzBckgnd,
  StdCtrls, jpeg, RzBmpBtn, RzTabs, cxTextEdit, cxDropDownEdit, cxControls, EncDec,
  cxContainer, cxEdit, cxMaskEdit, cxSpinEdit, cxMemo, cxCheckBox,IniFiles, zBase,
  ComCtrls, RzTreeVw, uGodsFactory, uTreeUtil, zDataSet, cxCalendar, DB,
  ZAbstractRODataset, ZAbstractDataset, RzLabel;

type
  TfrmInitGuide = class(TfrmBasic)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    RzFormShape1: TRzFormShape;
    RzPanel3: TRzPanel;
    btn_Start: TRzBmpButton;
    btn_Prev: TRzBmpButton;
    btn_End: TRzBmpButton;
    btn_Next: TRzBmpButton;
    RzPanel4: TRzPanel;
    RzBackground1: TRzBackground;
    RzBackground3: TRzBackground;
    RzPanel5: TRzPanel;
    Rz_page: TRzPageControl;
    TabSheet1: TRzTabSheet;
    Label2: TLabel;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    TabSheet5: TRzTabSheet;
    Label6: TLabel;
    Bmp_1: TRzBmpButton;
    Bmp_2: TRzBmpButton;
    Bmp_3: TRzBmpButton;
    Bmp_4: TRzBmpButton;
    Bmp_5: TRzBmpButton;
    RzPanel6: TRzPanel;
    RzGroupBox1: TRzGroupBox;
    RzGroupBox2: TRzGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    cxDisplay: TcxComboBox;
    cxDisplayBaudRate: TcxComboBox;
    RzGroupBox3: TRzGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    cxCashBox: TcxComboBox;
    cxCashBoxRate: TcxComboBox;
    Label16: TLabel;
    RzPanel7: TRzPanel;
    RzPanel8: TRzPanel;
    RzGroupBox4: TRzGroupBox;
    Label3: TLabel;
    edtAutoRunPos: TcxCheckBox;
    chkCloseDayPrinted: TcxCheckBox;
    edtCloseDayPrintFlag: TcxComboBox;
    cxSavePrint: TcxCheckBox;
    cxPrintFormat: TcxComboBox;
    edtFOOTER: TcxMemo;
    Label9: TLabel;
    Label10: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    cxNullRow: TcxSpinEdit;
    edtPRINTERWIDTH: TcxComboBox;
    edtTicketPrintComm: TcxComboBox;
    edtTicketCopy: TcxSpinEdit;
    edtTICKET_PRINT_NAME: TcxComboBox;
    edtTitle: TcxTextEdit;
    edtIsData: TcxCheckBox;
    edtIsDevice: TcxCheckBox;
    RzPanel9: TRzPanel;
    rzCheckTree: TRzCheckTree;
    Label8: TLabel;
    edtUSING_DATE: TcxDateEdit;
    CdsUsing: TZQuery;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    procedure FormCreate(Sender: TObject);
    procedure btn_StartClick(Sender: TObject);
    procedure btn_PrevClick(Sender: TObject);
    procedure btn_NextClick(Sender: TObject);
    procedure btn_EndClick(Sender: TObject);
  private
    { Private declarations }
    procedure LoadTree;
    procedure WriteUnitSort;
    procedure LoadUsingDate;
    procedure WriteUsingDate;
  public
    { Public declarations }
    procedure LoadParameter;
    procedure WriteParameter;
    class function InitGuide(AOwner:TForm):boolean;
  end;


implementation
uses uShopGlobal,uGlobal,uDevFactory;
{$R *.dfm}

procedure TfrmInitGuide.FormCreate(Sender: TObject);
var i:Integer;
begin
  inherited;
  for i := 0 to Rz_page.PageCount - 1 do
    begin
      Rz_page.Pages[i].TabVisible := False;
    end;
  Rz_page.ActivePageIndex := 0;
  Bmp_1.Enabled := False;
  btn_Prev.Visible := False;
  btn_Next.Visible := False;
  btn_End.Visible := False;
end;

procedure TfrmInitGuide.btn_StartClick(Sender: TObject);
begin
  inherited;
  Rz_page.ActivePage := TabSheet2;
  LoadUsingDate;
  Bmp_1.Enabled := True;
  Bmp_2.Enabled := False;
  btn_Prev.Visible := True;
  btn_Next.Visible := True;
  btn_Start.Visible := False;
end;

procedure TfrmInitGuide.btn_PrevClick(Sender: TObject);
begin
  inherited;
  case Rz_page.ActivePageIndex of
    1:begin
      Rz_page.ActivePage := TabSheet1;
      Bmp_2.Enabled := True;
      Bmp_1.Enabled := False;
      btn_Prev.Visible := False;
      btn_Next.Visible := False;
      btn_Start.Visible := True;
    end;
    2:begin
      Rz_page.ActivePage := TabSheet2;
      Bmp_4.Enabled := True;
      Bmp_3.Enabled := True;
      Bmp_2.Enabled := False;
    end;
    3:begin
      Rz_page.ActivePage := TabSheet3;
      if not edtIsData.Checked then
        begin
          btn_PrevClick(Sender);
          Exit;
        end;
      Bmp_4.Enabled := True;
      Bmp_3.Enabled := False;
    end;
  end;
end;

procedure TfrmInitGuide.btn_NextClick(Sender: TObject);
begin
  inherited;
  case Rz_page.ActivePageIndex of
    1:begin
      WriteUsingDate;

      Rz_page.ActivePage := TabSheet3;
      if not edtIsData.Checked then
        begin
          btn_NextClick(Sender);
          Exit;
        end;
      LoadTree;
      Bmp_2.Enabled := True;
      Bmp_3.Enabled := False;
    end;
    2:begin
      Rz_page.ActivePage := TabSheet4;
      if not edtIsDevice.Checked then
        begin
          btn_NextClick(Sender);
          Exit;
        end;
      if edtIsData.Checked then
        WriteUnitSort;
      cxDisplay.ItemIndex := 0;
      cxCashBox.ItemIndex := 0;
      edtTICKET_PRINT_NAME.ItemIndex := 0;
      LoadParameter;
      Bmp_2.Enabled := True;
      Bmp_3.Enabled := True;
      Bmp_4.Enabled := False;
    end;
    3:begin
      if edtIsDevice.Checked then
        WriteParameter;
      Rz_page.ActivePage := TabSheet5;
      Bmp_2.Enabled := True;
      Bmp_3.Enabled := True;
      Bmp_4.Enabled := True;
      Bmp_5.Enabled := False;
      btn_Prev.Visible := False;
      btn_Next.Visible := False;
      btn_End.Visible := True;
    end;
  end;
end;

procedure TfrmInitGuide.btn_EndClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmInitGuide.LoadParameter;
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'dev.fty');
  try
    cxSavePrint.Checked :=  F.ReadString('SYS_DEFINE','SAVEPRINT','0')='1';
    chkCloseDayPrinted.Checked :=  F.ReadString('SYS_DEFINE','CLOSEDAYPRINTED','0')='1';
    edtAutoRunPos.Checked :=  F.ReadString('SYS_DEFINE','AUTORUNPOS','0')='1';
    cxNullRow.Value := StrtoIntDef(F.ReadString('SYS_DEFINE','PRINTNULL','0'),0);
    edtTicketCopy.Value := StrtoIntDef(F.ReadString('SYS_DEFINE','TICKETCOPY','1'),1);
    cxPrintFormat.ItemIndex := StrtoIntDef(F.ReadString('SYS_DEFINE','PRINTFORMAT','0'),0);
    edtCloseDayPrintFlag.ItemIndex := StrtoIntDef(F.ReadString('SYS_DEFINE','CLOSEDAYPRINTFLAG','0'),0);
    edtTicketPrintComm.ItemIndex := StrtoIntDef(F.ReadString('SYS_DEFINE','PRINTERCOMM','1'),1);
    if F.ReadString('SYS_DEFINE','PRINTERWIDTH','33')='38' then
       edtPRINTERWIDTH.ItemIndex := 1
    else
       edtPRINTERWIDTH.ItemIndex := 0;
    cxDisplay.ItemIndex := StrtoIntDef(F.ReadString('SYS_DEFINE','BUYERDISPLAY','0'),0);
    cxCashBox.ItemIndex := StrtoIntDef(F.ReadString('SYS_DEFINE','CASHBOX','0'),0);
    cxDisplayBaudRate.ItemIndex := cxDisplayBaudRate.Properties.Items.IndexOf(F.ReadString('SYS_DEFINE','DISPLAYBAUDRATE','0'));
    cxCashBoxRate.ItemIndex := cxCashBoxRate.Properties.Items.IndexOf(F.ReadString('SYS_DEFINE','CASHBOXRATE','0'));

    edtTICKET_PRINT_NAME.ItemIndex := StrtoIntDef(F.ReadString('SYS_DEFINE','TICKET_PRINT_NAME','0'),0);

    edtFOOTER.Text := DecStr(F.ReadString('SYS_DEFINE','FOOTER',EncStr('敬请保留小票,以作售后依据',ENC_KEY)),ENC_KEY);
    edtTITLE.Text := DecStr(F.ReadString('SYS_DEFINE','TITLE',EncStr('[企业简称]',ENC_KEY)),ENC_KEY);
  finally
     F.Free;
  end;
end;

procedure TfrmInitGuide.WriteParameter;
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'dev.fty');
  try
    if edtAutoRunPos.Checked then
       F.WriteString('SYS_DEFINE','AUTORUNPOS','1')
    else
       F.WriteString('SYS_DEFINE','AUTORUNPOS','0');
    if cxSavePrint.Checked then
       F.WriteString('SYS_DEFINE','SAVEPRINT','1')
    else
       F.WriteString('SYS_DEFINE','SAVEPRINT','0');
    if chkCloseDayPrinted.Checked then
       F.WriteString('SYS_DEFINE','CLOSEDAYPRINTED','1')
    else
       F.WriteString('SYS_DEFINE','CLOSEDAYPRINTED','0');
    if cxSavePrint.Checked then
       F.WriteString('SYS_DEFINE','SAVEPRINT','1')
    else
       F.WriteString('SYS_DEFINE','SAVEPRINT','0');
    F.WriteString('SYS_DEFINE','PRINTNULL',cxNullRow.Value);
    F.WriteString('SYS_DEFINE','TICKETCOPY',edtTicketCopy.Value);
    F.WriteString('SYS_DEFINE','PRINTFORMAT',Inttostr(cxPrintFormat.ItemIndex));
    F.WriteString('SYS_DEFINE','PRINTERCOMM',Inttostr(edtTicketPrintComm.ItemIndex));
    if edtPRINTERWIDTH.ItemIndex = 1 then
       F.WriteString('SYS_DEFINE','PRINTERWIDTH','38')
    else
       F.WriteString('SYS_DEFINE','PRINTERWIDTH','33');
    F.WriteString('SYS_DEFINE','CLOSEDAYPRINTFLAG',Inttostr(edtCloseDayPrintFlag.ItemIndex));
    F.WriteString('SYS_DEFINE','BUYERDISPLAY',Inttostr(cxDisplay.ItemIndex));
    F.WriteString('SYS_DEFINE','CASHBOX',Inttostr(cxCashBox.ItemIndex));
    F.WriteString('SYS_DEFINE','TICKET_PRINT_NAME',Inttostr(edtTICKET_PRINT_NAME.ItemIndex));
    F.WriteString('SYS_DEFINE','DISPLAYBAUDRATE',cxDisplayBaudRate.Text);
    F.WriteString('SYS_DEFINE','CASHBOXRATE',cxCashBoxRate.Text);
    F.WriteString('SYS_DEFINE','FOOTER',EncStr(edtFOOTER.Text,ENC_KEY));
    F.WriteString('SYS_DEFINE','TITLE',EncStr(edtTitle.Text,ENC_KEY));
  finally
     F.Free;
  end;
  DevFactory.InitComm;
end;

procedure TfrmInitGuide.LoadTree;
var Sql_Str:String;
    rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select SORT_ID,LEVEL_ID,SORT_NAME,SORT_TYPE,SORT_SPELL,SEQ_NO,TENANT_ID from PUB_GOODSSORT '+
    'where COMM not in (''02'',''12'') and TENANT_ID=0 and SORT_TYPE=1 order by LEVEL_ID';
    GodsFactory.Db.Open(rs);
    CreateLevelTree(rs,rzCheckTree,'4444444444','SORT_ID','SORT_NAME','LEVEL_ID');
  finally
    rs.Free;
  end;
end;

procedure TfrmInitGuide.WriteUnitSort;
var Sort_Str,Sql_Str:String;
    i,j:Integer;
    rs,rs1,cs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  rs1 := TZQuery.Create(nil);
  cs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select SORT_ID,LEVEL_ID,SORT_NAME,SORT_TYPE,SORT_SPELL,SEQ_NO,TENANT_ID from PUB_GOODSSORT where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SORT_TYPE=1';
    Factor.Open(rs);
    if not rs.IsEmpty then
       begin
         if MessageBox(Handle,'此账套已经初化了，是否重初始化？','友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       end;
    j := 1;
    for i := 0 to rzCheckTree.Items.Count - 1 do
      begin
        if rzCheckTree.ItemState[i] in [csChecked,csPartiallyChecked] then
          begin
            if Trim(Sort_Str) = '' then
              Sort_Str := QuotedStr(TRecord_(rzCheckTree.Items[i].Data).FieldByName('SORT_ID').AsString)
            else
              Sort_Str := Sort_Str + ',' + QuotedStr(TRecord_(rzCheckTree.Items[i].Data).FieldByName('SORT_ID').AsString);
            rs.Append;
            rs.FieldByName('SORT_ID').AsString := TRecord_(rzCheckTree.Items[i].Data).FieldByName('SORT_ID').AsString;
            rs.FieldByName('LEVEL_ID').AsString := TRecord_(rzCheckTree.Items[i].Data).FieldByName('LEVEL_ID').AsString;
            rs.FieldByName('SORT_NAME').AsString := TRecord_(rzCheckTree.Items[i].Data).FieldByName('SORT_NAME').AsString;
            rs.FieldByName('SORT_SPELL').AsString := TRecord_(rzCheckTree.Items[i].Data).FieldByName('SORT_SPELL').AsString;
            rs.FieldByName('SORT_TYPE').AsInteger := TRecord_(rzCheckTree.Items[i].Data).FieldByName('SORT_TYPE').AsInteger;
            rs.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
            rs.FieldByName('SEQ_NO').AsInteger := j;
            rs.Post;
            inc(j);
          end;
      end;

    if Trim(Sort_Str) = '' then Exit;
    Factor.BeginTrans();
    try
      Sql_Str := 'delete from PUB_MEAUNITS where TENANT_ID='+IntToStr(Global.TENANT_ID);
      Factor.ExecSQL(Sql_Str);
      Sql_Str := 'delete from PUB_GOODSSORT where SORT_TYPE=1 and TENANT_ID='+IntToStr(Global.TENANT_ID);
      Factor.ExecSQL(Sql_Str);
      
      cs.SQL.Text :=
      'select UNIT_ID,'+IntToStr(Global.TENANT_ID)+' as TENANT_ID,UNIT_NAME,UNIT_SPELL,SEQ_NO from PUB_MEAUNITS where UNIT_ID in '+
      '('+
      'select A.CALC_UNITS from PUB_GOODSINFO A where A.COMM not in (''02'',''12'') and A.TENANT_ID=0 and A.SORT_ID1 in ('+Sort_Str+') union all '+
      'select A.SMALL_UNITS from PUB_GOODSINFO A where A.COMM not in (''02'',''12'') and A.TENANT_ID=0 and A.SORT_ID1 in ('+Sort_Str+') union all '+
      'select A.BIG_UNITS from PUB_GOODSINFO A where A.COMM not in (''02'',''12'') and A.TENANT_ID=0 and A.SORT_ID1 in ('+Sort_Str+') '+
      ') ';
      GodsFactory.Db.Open(cs);
      rs1.SyncDelta := cs.SyncDelta;
      
      Factor.UpdateBatch(rs1,'TMeaUnits');
      Factor.UpdateBatch(rs,'TGoodsSort');
      Factor.CommitTrans;
    except
      Factor.RollbackTrans;
      Raise;
    end;

  finally
    rs.Free;
    rs1.Free;
    cs.Free;
  end;
end;


procedure TfrmInitGuide.LoadUsingDate;
begin
  edtUSING_DATE.Date := Date;
  edtIsData.Checked := False;
  edtIsDevice.Checked := False;
end;

procedure TfrmInitGuide.WriteUsingDate;
var rs:TZQuery;
    Str:String;
begin
  rs := TZQuery.Create(nil);
  try
    case Factor.iDbType of
      0,3: Str := 'select TENANT_ID,DEFINE,[VALUE],VALUE_TYPE from SYS_DEFINE where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and DEFINE=''USING_DATE''';
      1,2,4,5: Str := 'select TENANT_ID,DEFINE,"VALUE",VALUE_TYPE from SYS_DEFINE where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and DEFINE=''USING_DATE''';
    end;
    rs.Close;
    rs.SQL.Text := Str;
    Factor.Open(rs);

    if rs.Locate('DEFINE','USING_DATE', []) then
      rs.Edit
    else
      rs.Append;
    rs.FieldByName('DEFINE').AsString := 'USING_DATE';
    rs.FieldByName('TENANT_ID').AsString := IntToStr(Global.TENANT_ID);
    rs.FieldByName('VALUE').AsString := FormatDateTime('YYYY-MM-DD', edtUSING_DATE.Date);
    rs.FieldByName('VALUE_TYPE').AsString := '0';
    rs.Post;

    Factor.UpdateBatch(rs,'TSysDefine');
  finally
    rs.Free;
  end;
end;

class function TfrmInitGuide.InitGuide(AOwner: TForm): boolean;
begin
  with TfrmInitGuide.Create(AOwner) do
    begin
      try
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

end.
