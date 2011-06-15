unit ufrmDevFactory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ComCtrls, cxControls, cxContainer, cxEdit, cxCheckBox,
  StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, ExtCtrls, cxButtonEdit,ZBase,
  cxSpinEdit, zrComboBoxList, DB, cxMemo;

type
  TfrmDevFactory = class(TForm)
    btnOK: TRzBitBtn;
    btnCancel: TRzBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Bevel2: TBevel;
    Label9: TLabel;
    cxNullRow: TcxSpinEdit;
    edtPRINTERWIDTH: TcxComboBox;
    Label10: TLabel;
    edtTicketPrintComm: TcxComboBox;
    Label4: TLabel;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label5: TLabel;
    Label7: TLabel;
    cxDisplay: TcxComboBox;
    cxDisplayBaudRate: TcxComboBox;
    Label8: TLabel;
    Label2: TLabel;
    cxCashBox: TcxComboBox;
    cxCashBoxRate: TcxComboBox;
    Bevel1: TBevel;
    Bevel3: TBevel;
    TabSheet4: TTabSheet;
    edtAutoRunPos: TcxCheckBox;
    Bevel4: TBevel;
    Label3: TLabel;
    edtTicketCopy: TcxSpinEdit;
    Label6: TLabel;
    edtTICKET_PRINT_NAME: TcxComboBox;
    Label11: TLabel;
    edtTitle: TcxTextEdit;
    chkCloseDayPrinted: TcxCheckBox;
    edtCloseDayPrintFlag: TcxComboBox;
    cxSavePrint: TcxCheckBox;
    cxPrintFormat: TcxComboBox;
    edtFOOTER: TcxMemo;
    Label1: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadParameter;
    procedure WriteParameter;
  end;

implementation

uses uGlobal,EncDec,IniFiles,uDevFactory;

{$R *.dfm}

procedure TfrmDevFactory.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDevFactory.LoadParameter;
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

procedure TfrmDevFactory.WriteParameter;
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
end;

procedure TfrmDevFactory.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  cxDisplay.ItemIndex := 0;
  cxCashBox.ItemIndex := 0;
  edtTICKET_PRINT_NAME.ItemIndex := 0;
  LoadParameter;
end;

procedure TfrmDevFactory.btnOKClick(Sender: TObject);
begin
  WriteParameter;
  DevFactory.InitComm;
  Self.ModalResult := MROK;
end;

end.

