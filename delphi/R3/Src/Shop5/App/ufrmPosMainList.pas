unit ufrmPosMainList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, StdCtrls, RzLabel, Grids, DBGridEh, RzButton, DB, DBClient;

type
  TfrmPosMainList = class(TframeDialogForm)
    RzPanel1: TRzPanel;
    RzLabel2: TRzLabel;
    D1: TcxDateEdit;
    RzLabel3: TRzLabel;
    D2: TcxDateEdit;
    RzLabel5: TRzLabel;
    fndSALES_ID: TcxTextEdit;
    Label1: TLabel;
    btnOk: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    edtDelete: TRzBitBtn;
    edtExit: TRzBitBtn;
    cdsList: TClientDataSet;
    dsList: TDataSource;
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtExitClick(Sender: TObject);
    procedure edtDeleteClick(Sender: TObject);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    IsEnd: boolean;
    MaxId:string;
    function EncodeSQL(id:string):string;
    procedure Open(Id:string);
    class function FindDialog(AOwner:TForm):string;
  end;

implementation

uses uGlobal;

{$R *.dfm}

{ TfrmPosMainList }

function TfrmPosMainList.EncodeSQL(id: string): string;
var w:string;
begin
  w := 'and A.COMP_ID='''+Global.CompanyID+''' and A.SALES_TYPE=1 and A.SALES_DATE>='''+formatDatetime('YYYY-MM-DD',D1.Date)+''' and A.SALES_DATE<='''+formatDatetime('YYYY-MM-DD',D2.Date)+'''';
  if trim(fndSALES_ID.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndSALES_ID.Text)+'''';
  if id<>'' then
     w := w +' and A.SALES_ID>'''+id+'''';
  result := 'select A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.REMARK,A.INVOICE_FLAG,A.CUST_ID,A.SHROFF,A.COMP_ID,A.CREA_DATE,sum(AMOUNT) as AMOUNT,sum(CALC_MONEY) as AMONEY '+
            'from SAL_SALESORDER A,SAL_SALESDATA B where A.COMP_ID=B.COMP_ID and A.SALES_ID=B.SALES_ID '+w+' '+
            'group by A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.REMARK,A.INVOICE_FLAG,A.CUST_ID,A.SHROFF,A.COMP_ID,A.CREA_DATE';
  result := 'select ja.*,a.CUST_NAME from ('+result+') ja left outer join VIW_CUSTOMER a on ja.CUST_ID=a.CUST_ID';
  result := 'select top 100 jb.*,b.USER_NAME as SHROFF_TEXT from ('+result+') jb left outer join VIW_USERS b on jb.SHROFF=b.USER_ID order by SALES_ID';
end;

procedure TfrmPosMainList.Open(Id: string);
var
  rs:TClientDataSet;
begin
  if Id='' then cdsList.close;
  rs := TClientDataSet.Create(nil);
  cdsList.DisableControls;
  try
    rs.CommandText := EncodeSQL(Id);
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('SALES_ID').AsString;
    if Id='' then
       cdsList.Data := rs.Data
    else
       cdsList.AppendData(rs.Data,true);
    if rs.RecordCount <100 then IsEnd := True else IsEnd := false;
  finally
    cdsList.EnableControls;
    rs.Free;
  end;
end;

procedure TfrmPosMainList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TfrmPosMainList.FormCreate(Sender: TObject);
begin
  inherited;
  D1.Date := date();
  D2.Date := date();

end;

procedure TfrmPosMainList.btnOkClick(Sender: TObject);
begin
  inherited;
  Open('');
  DBGridEh1.SetFocus;
end;

procedure TfrmPosMainList.edtExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmPosMainList.edtDeleteClick(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then
     begin
       Raise Exception.Create('没有选中你要查询的单据...');
     end;
  self.ModalResult := MROK;
end;

class function TfrmPosMainList.FindDialog(AOwner: TForm): string;
begin
  with TfrmPosMainList.Create(AOwner) do
    begin
      try
        open('');
        if ShowModal=MROK then
           result := cdsList.FieldbyName('SALES_ID').AsString
        else
           result := '';
      finally
        free;
      end;
    end;
end;

procedure TfrmPosMainList.DBGridEh1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then edtDeleteClick(nil);
end;

end.
