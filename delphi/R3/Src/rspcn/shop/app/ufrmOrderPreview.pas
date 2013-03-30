unit ufrmOrderPreview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ComCtrls, ToolWin, ExtCtrls,ZBase,
  FR_View, FR_Class, FR_DSet, FR_DBSet, DB, FR_E_RTF, FR_E_HTM, FR_E_TXT,
  FR_E_CSV,DbClient, FR_E_PDF, FR_Desgn, ZAbstractRODataset, ZDataSet,
  ZAbstractDataset, ufrmWebToolForm, RzBmpBtn, StdCtrls, RzLabel, PrViewEh,
  RzPanel;

type
  TfrmOrderPreview = class(TfrmWebToolForm)
    RzPanel12: TRzPanel;
    btnSet: TRzBmpButton;
    btnPrint: TRzBmpButton;
    btnExport: TRzBmpButton;
    btnReturn: TRzBmpButton;
    lblCaption: TRzLabel;
    SaveDialog: TSaveDialog;
    RzBmpButton4: TRzBmpButton;
    frTable: TfrDBDataSet;
    frPreview: TfrPreview;
    adoTable: TZQuery;
    frPDFExport: TfrPDFExport;
    frDesigner: TfrDesigner;
    frReport1: TfrReport;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnReturnClick(Sender: TObject);
    procedure btnSetClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnFormer(Sender: TObject);
    procedure frDesignerSaveReport(Report: TfrReport;
      var ReportName: String; SaveAs: Boolean; var Saved: Boolean);
    procedure btnPrintClick(Sender: TObject);
  private
    Desgn:boolean;
    FSelectSQL: string;
    FfrReport: TfrReport;
    procedure SetSelectSQL(const Value: string);
    procedure SetfrReport(const Value: TfrReport);
  protected
    procedure OpenFile(frReport:TfrReport;Index:integer=-1);
    procedure OpenReport(SQL:string);
    procedure DoFormer;
    property  frReport:TfrReport read FfrReport write SetfrReport;
    property  SelectSQL:string read FSelectSQL write SetSelectSQL;
  public
    constructor Create(AOwner: TComponent); override;
    function GetStockOrderPrintSQL(tid,oid:string):string;
    function GetSalesOrderPrintSQL(tid,oid:string):string;
    class procedure ShowReport(AOwner:TForm;ReportType:integer;AfrReport:TfrReport;tid,oid:string;Title:string);
    class procedure PrintReport(AOwner:TForm;ReportType:integer;AfrReport:TfrReport;tid,oid:string);
  end;

var GlobalIndex: integer = -1;

implementation

uses udataFactory,RzSplit,IniFiles,uFnUtil,FR_PrDlg,uTokenFactory,ufrmSelectFormer,
     ufrmSaveDesigner;

var SaveIndex: integer = -1;

{$R *.dfm}

{ TfrmOrderPreview }

procedure TfrmOrderPreview.OpenFile(frReport: TfrReport; Index: integer);
var
  s:string;
  logo:TfrPictureView;
begin
  if Index <= 0 then s := '' else s := inttostr(Index);
  if FileExists(ExtractFilePath(Application.ExeName)+'frf\'+frReport.Name+s+'.frf') then
     frReport.LoadFromFile(ExtractFilePath(Application.ExeName)+'frf\'+frReport.Name+s+'.frf');
  logo := TfrPictureView(frReport.FindObject('logo'));
  if not Desgn then SaveIndex := -1;
  if (logo<>nil) and FileExists(ExtractFilePath(Application.ExeName)+'logo.jpg') then
     logo.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'logo.jpg');
end;

procedure TfrmOrderPreview.OpenReport(SQL: string);
begin
  adoTable.Close;
  adoTable.SQL.Text := SQL;
  dataFactory.Open(adoTable);
  frReport.ShowReport;
end;

class procedure TfrmOrderPreview.ShowReport(AOwner:TForm;ReportType:integer;AfrReport:TfrReport;tid,oid:string;Title:string);
var CommandText:string;
begin
  if AfrReport = nil then Raise Exception.Create('AfrReport参数没有Create');
  with TfrmOrderPreview.Create(AOwner) do
  begin
    lblCaption.Caption := Title;
    hWnd := AOwner.Handle;
    ShowForm;
    BringtoFront;
    try
      FfrReport := AfrReport;
      OpenFile(AfrReport,GlobalIndex);
      frReport.Dataset := frTable;
      frReport.Preview := frPreview;
      case ReportType of
        0:
          begin
            CommandText := GetStockOrderPrintSQL(tid,oid);
          end;
        1:
          begin
            CommandText := GetSalesOrderPrintSQL(tid,oid);
          end;
      end;
      SelectSQL := CommandText;
      OpenReport(SelectSQL);
    except
      on E:Exception do Raise Exception.Create('生成报表出错:'+E.Message);
    end;
  end;
end;

procedure TfrmOrderPreview.btnSetClick(Sender: TObject);
var
  s:string;
  rs:TZQuery;
  sm:TMemoryStream;
begin
  if frReport = nil then Exit;

  if (token.userId<>'admin') and (token.userId<>'system') and (token.account <> token.xsmCode) then
     Raise Exception.Create('只有管理员才能操作此功能.');

  Desgn := true;
  try
    if SaveIndex <  0 then SaveIndex := GlobalIndex;
    if SaveIndex <= 0 then s := '' else s := inttostr(SaveIndex);
    if FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+s+'.frf') then
       frReport.LoadFromFile(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+s+'.frf')
    else
       begin
         rs := TZQuery.Create(nil);
         sm := TMemoryStream.Create;
         try
           rs.SQL.Text := 'select * from SYS_FASTFILE where frfFileName=:frfFileName and TENANT_ID=:TENANT_ID';
           rs.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
           rs.ParamByName('frfFileName').AsString := frReport.Name;
           dataFactory.Open(rs);
           if not rs.IsEmpty then
              begin
                if SaveIndex <= 0 then
                   TBlobField(rs.FieldByName('frfBlob')).SaveToStream(sm)
                else
                   TBlobField(rs.FieldByName('frfBlob'+inttostr(SaveIndex))).SaveToStream(sm);
                sm.Position := 0;
                frReport.LoadFromStream(sm);
              end;
           frReport.FileName := '';
         finally
           rs.Free;
           sm.Free;
         end;
       end;
    frReport.DesignReport;
    frReport.PrepareReport;
    frReport.ShowPreparedReport;
  finally
    Desgn := false;
  end;
end;

procedure TfrmOrderPreview.btnExportClick(Sender: TObject);
begin
  inherited;
  SaveDialog.DefaultExt := '*.pdf';
  SaveDialog.Filter := 'pdf文件|*.pdf';
  if SaveDialog.Execute then
     begin
       if FileExists(SaveDialog.FileName) then
          begin
            if MessageBox(Handle,Pchar(SaveDialog.FileName+'文件已经存在，是否覆盖它？'),PChar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
            if not DeleteFile(SaveDialog.FileName) then
               Raise Exception.CreateFmt('%s文件可能被其他用使用，无法覆盖。',[SaveDialog.FileName]);
          end;
       frReport.ExportTo(frPDFExport,SaveDialog.FileName);
     end;
end;

procedure TfrmOrderPreview.btnFormer(Sender: TObject);
begin
  inherited;
  if (token.userId <> 'admin') and (token.userId <> 'system') and (token.account <> token.xsmCode) then
     Raise Exception.Create('只有管理员才能操作此功能.');

  Desgn := true;
  try
    DoFormer;
    frReport.PrepareReport;
    frReport.ShowPreparedReport;
  finally
    Desgn := false;
  end;
end;

procedure TfrmOrderPreview.DoFormer;
var
  s:string;
  sm:TFileStream;
  r:integer;
  rs:TZQuery;
begin
  s := TfrmSelectFormer.SelectFormer(self,frReport.Name);
  if s = '' then Exit;
  r := TfrmSaveDesigner.SaveDialog(self,frReport.Name,nil);
  if pos('(自定义)',s)=0 then
     begin
       sm := TFileStream.Create(ExtractFilePath(ParamStr(0))+'frf\'+s+'.frf',fmOpenRead);
       try
         sm.Position := 0;
         frReport.LoadFromStream(sm);
         if r <= 0 then
            frReport.SaveToFile(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+'.frf')
         else
            frReport.SaveToFile(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+inttostr(r)+'.frf');
         SaveIndex := r;
         GlobalIndex := r;
         delete(s,1,length(frReport.Name)+1);
       finally
         sm.Free;
       end;
     end
  else
     begin
       rs := TZQuery.Create(nil);
       try
         delete(s,1,length(frReport.Name)+1);
         rs.SQL.Text := 'select frfBlob from SYS_FASTFILE where TENANT_ID='+token.tenantId+' and frfFileName like '''+frReport.Name+'%'' and frfFileTitle='''+copy(s,1,length(s)-8)+'''';
         dataFactory.MoveToRemote;
         try
           dataFactory.Open(rs);
         finally
           dataFactory.MoveToDefault;
         end;
         if rs.IsEmpty then Raise Exception.Create('没找到模版文件'); 
         if r <= 0 then
            TBlobField(rs.Fields[0]).SaveToFile(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+'.frf')
         else
            TBlobField(rs.Fields[0]).SaveToFile(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+inttostr(r)+'.frf');
         SaveIndex := r;
         GlobalIndex := r;
       finally
         rs.Free;
       end;
     end;
end;

procedure TfrmOrderPreview.frDesignerSaveReport(Report: TfrReport; var ReportName: String; SaveAs: Boolean; var Saved: Boolean);
var
  s:string;
  r:integer;
begin
  if frReport=nil then Exit;
  if not Desgn then Exit;
  if SaveAs then
     begin
       SaveDialog.DefaultExt := '*.frf';
       SaveDialog.Filter := '报表格式|*.frf';
       if SaveDialog.Execute then
          begin
            if FileExists(SaveDialog.FileName) then
               begin
                 if MessageBox(Handle,Pchar(SaveDialog.FileName+'文件已经存在，是否覆盖它？'),PChar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
                 if not DeleteFile(SaveDialog.FileName) then
                    Raise Exception.CreateFmt('%s文件可能被其他用使用，无法覆盖。',[SaveDialog.FileName]);
               end;
            frReport.SaveToFile(SaveDialog.FileName);
          end;
       Exit;
     end;
  r := TfrmSaveDesigner.SaveDialog(self,frReport.Name,frReport);
  if r < 0 then Exit;
  if r = 0 then s := '' else s := inttostr(r);
  ForceDirectories(ExtractFilePath(ParamStr(0))+'frf\');
  frReport.SaveToFile(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+s+'.frf');
  SaveIndex := r;
  Saved := True;
end;

constructor TfrmOrderPreview.Create(AOwner: TComponent);
begin
  inherited;
  frReport := frReport1;
  Desgn := false;
end;

procedure TfrmOrderPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmOrderPreview.btnReturnClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmOrderPreview.SetfrReport(const Value: TfrReport);
begin
  FfrReport := Value;
end;

procedure TfrmOrderPreview.btnPrintClick(Sender: TObject);
begin
  inherited;
  frPreview.Print;
end;
    
procedure TfrmOrderPreview.SetSelectSQL(const Value: string);
begin
  FSelectSQL := Value;
end;

function TfrmOrderPreview.GetStockOrderPrintSQL(tid, oid: string): string;
var TopCnd: string;
begin
  case dataFactory.iDbType of
    0: TopCnd:=' top 20000 ';
    else TopCnd:='';
  end;
  result :=
   'select j.*,case when j.IS_PRESENT=2 then ''(兑换)'' when j.IS_PRESENT=1 then ''(赠送)'' else '''' end as IS_PRESENT_TEXT,'+
   '(select sum(RECK_MNY) from ACC_PAYABLE_INFO where TENANT_ID='+tid+' and CLIENT_ID=j.CLIENT_ID and STOCK_ID='''+oid+''') as ORDER_OWE_MNY,'+
   '(select sum(RECK_MNY) from ACC_PAYABLE_INFO where TENANT_ID='+tid+' and CLIENT_ID=j.CLIENT_ID) as TOTAL_OWE_MNY '+
   'from ('+
   'select jn.*,n.GLIDE_NO as GLIDE_NO_FROM from('+
   'select jm.*,m.DEPT_NAME as DEPT_ID_TEXT from ('+
   'select jl.*,l.CODE_NAME as SETTLE_CODE_TEXT from ('+
   'select jk.*,k.UNIT_NAME from ('+
   'select jj.*,j.COLOR_NAME as PROPERTY_02_TEXT from ('+
   'select ji.*,i.SIZE_NAME as PROPERTY_01_TEXT from ('+
   'select jh.*,h.GODS_NAME,h.GODS_CODE,h.BARCODE from ('+
   'select jg.*,g.SHOP_NAME,g.ADDRESS as SHOP_ADDR,g.TELEPHONE as SHOP_TELE,g.FAXES from ('+
   'select jf.*,f.USER_NAME as CREA_USER_TEXT from ('+
   'select je.*,e.CODE_NAME as INVOICE_FLAG_TEXT from ('+
   'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
   'select jc.*,c.USER_NAME as GUIDE_USER_TEXT,m.USER_NAME as LOCUS_USER_TEXT from ('+
   'select jb.*,b.CLIENT_NAME,b.LINKMAN,b.TELEPHONE2 as MOVE_TELE,b.SETTLE_CODE,b.POSTALCODE,b.ADDRESS,b.FAXES CLIENT_FAXES from ('+
   'select A.TENANT_ID,A.SHOP_ID,A.DEPT_ID,A.STOCK_ID,A.GLIDE_NO,A.STOCK_DATE,A.CLIENT_ID,A.CREA_USER,A.GUIDE_USER,'+
   'A.CHK_DATE,A.CHK_USER,A.FROM_ID,A.FIG_ID,A.STOCK_AMT,A.STOCK_MNY,A.REMARK,A.INVOICE_FLAG,A.TAX_RATE,A.CREA_DATE,A.PRINT_TIMES,'+
   'B.AMOUNT,B.APRICE,B.SEQNO,B.ORG_PRICE,B.PROPERTY_01,B.PROPERTY_02,B.UNIT_ID,B.BATCH_NO,B.GODS_ID,B.LOCUS_NO,B.CALC_MONEY,B.AGIO_RATE,B.AGIO_MONEY,B.IS_PRESENT,B.REMARK as REMARK_DETAIL from STK_STOCKORDER A,STK_STOCKDATA B '+
   'where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and A.TENANT_ID='+tid+' and A.STOCK_ID='''+oid+''' ) jb '+
   'left outer join VIW_CLIENTINFO b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.CLIENT_ID ) jc '+
   'left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.GUIDE_USER=c.USER_ID left outer join VIW_USERS m on jc.TENANT_ID=m.TENANT_ID and jc.GUIDE_USER=m.USER_ID ) jd '+
   'left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
   'left outer join (select CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=''INVOICE_FLAG'') e on je.INVOICE_FLAG=e.CODE_ID ) jf '+
   'left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.CREA_USER=f.USER_ID ) jg '+
   'left outer join CA_SHOP_INFO g on jg.TENANT_ID=g.TENANT_ID and jg.SHOP_ID=g.SHOP_ID) jh '+
   'left outer join VIW_GOODSINFO h on jh.TENANT_ID=h.TENANT_ID and jh.GODS_ID=h.GODS_ID ) ji '+
   'left outer join VIW_SIZE_INFO i on ji.TENANT_ID=i.TENANT_ID and ji.PROPERTY_01=i.SIZE_ID ) jj '+
   'left outer join VIW_COLOR_INFO j on jj.TENANT_ID=j.TENANT_ID and jj.PROPERTY_02=j.COLOR_ID ) jk '+
   'left outer join VIW_MEAUNITS k on jk.TENANT_ID=k.TENANT_ID and jk.UNIT_ID=k.UNIT_ID ) jl '+
   'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''6'' and TENANT_ID='+tid+') l on jl.SETTLE_CODE=l.CODE_ID) jm '+
   'left outer join CA_DEPT_INFO m on jm.TENANT_ID=m.TENANT_ID and jm.DEPT_ID=m.DEPT_ID ) jn '+
   'left outer join STK_INDENTORDER n on jn.TENANT_ID=n.TENANT_ID and jn.FROM_ID=n.INDE_ID ) j order by SEQNO';
end;

function TfrmOrderPreview.GetSalesOrderPrintSQL(tid, oid: string): string;
var TopCnd: string;
begin
  case dataFactory.iDbType of
   0: TopCnd:=' top 20000 ';
   else TopCnd:='';
  end;

  result :=
     'select j.*,case when j.IS_PRESENT=2 then ''(兑换)'' when j.IS_PRESENT=1 then ''(赠送)'' else '''' end as IS_PRESENT_TEXT ,'+
     '(select sum(RECK_MNY) from ACC_RECVABLE_INFO where CLIENT_ID=j.CLIENT_ID and TENANT_ID='+tid+') as TOTAL_OWE_MNY,'+
     '(select sum(RECK_MNY) from ACC_RECVABLE_INFO where CLIENT_ID=j.CLIENT_ID and TENANT_ID='+tid+' and SALES_ID='''+oid+''') as ORDER_OWE_MNY,'+
     'case when j.INVOICE_FLAG=''1'' then ''收款收据'' when j.INVOICE_FLAG=''2'' then ''普通发票'' else ''增值税票'' end as INVOICE_FLAG_TEXT '+  //INVOICE_FLAG: 字符型号
     'from ('+
     'select jn.*,n.DEPT_NAME as DEPT_ID_TEXT from ('+
     'select jm.*,m.CODE_NAME as SETTLE_CODE_TEXT from ( '+
     'select jl.*,l.CODE_NAME as SALES_STYLE_TEXT from ( '+
     'select jk.*,k.UNIT_NAME from ('+
     'select jj.*,j.COLOR_NAME as PROPERTY_02_TEXT from ('+
     'select ji.*,i.SIZE_NAME as PROPERTY_01_TEXT from ('+
     'select jh.*,h.GODS_NAME,h.GODS_CODE,h.BARCODE from ('+
     'select jg.*,g.SHOP_NAME,g.ADDRESS as SHOP_ADDR,g.TELEPHONE as SHOP_TELE,g.FAXES from ('+
     'select jf.*,f.USER_NAME as CREA_USER_TEXT from ('+
     'select je.*,e.GLIDE_NO as GLIDE_NO_FROM from ('+
     'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
     'select jc.*,c.USER_NAME as GUIDE_USER_TEXT from ('+
     'select jb.*,b.CLIENT_NAME,b.CLIENT_CODE,b.SETTLE_CODE,b.ADDRESS,b.POSTALCODE,b.TELEPHONE2 as MOVE_TELE,b.INTEGRAL as ACCU_INTEGRAL,b.FAXES as CLIENT_FAXES from ('+
     'select '+TopCnd+' A.TENANT_ID,A.SHOP_ID,A.DEPT_ID,A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.PLAN_DATE,A.LINKMAN,A.TELEPHONE,A.SEND_ADDR,A.CLIENT_ID,A.CREA_USER,A.GUIDE_USER,A.PRINT_TIMES,'+
     'A.CHK_DATE,A.CHK_USER,A.FROM_ID,A.FIG_ID,A.SALE_AMT,A.SALE_MNY,A.CASH_MNY,A.PAY_ZERO,A.PAY_DIBS,A.PAY_A,A.PAY_B,A.PAY_C,A.PAY_D,'+
     'A.PAY_E,A.PAY_F,A.PAY_G,A.PAY_H,A.PAY_I,A.PAY_J,A.INTEGRAL,A.REMARK,A.INVOICE_FLAG,A.TAX_RATE,A.CREA_DATE,A.SALES_STYLE,'+
     'B.AMOUNT,B.APRICE,B.SEQNO,B.ORG_PRICE,B.PROPERTY_01,B.PROPERTY_02,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,B.GODS_ID,B.CALC_MONEY,A.BARTER_INTEGRAL,B.AGIO_RATE,B.AGIO_MONEY,B.IS_PRESENT,B.REMARK as REMARK_DETAIL from SAL_SALESORDER A,SAL_SALESDATA B '+
     'where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.TENANT_ID='+tid+' and A.SALES_ID='''+oid+''' order by SEQNO) jb '+
     'left outer join VIW_CUSTOMER b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.CLIENT_ID ) jc '+
     'left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.GUIDE_USER=c.USER_ID ) jd '+
     'left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
     'left outer join SAL_INDENTORDER e on je.TENANT_ID=e.TENANT_ID and je.FROM_ID=e.INDE_ID ) jf '+
     'left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.CREA_USER=f.USER_ID ) jg '+
     'left outer join CA_SHOP_INFO g on jg.TENANT_ID=g.TENANT_ID and jg.SHOP_ID=g.SHOP_ID ) jh '+
     'left outer join VIW_GOODSINFO h on jh.TENANT_ID=h.TENANT_ID and jh.GODS_ID=h.GODS_ID ) ji '+
     'left outer join VIW_SIZE_INFO i on ji.TENANT_ID=i.TENANT_ID and ji.PROPERTY_01=i.SIZE_ID ) jj '+
     'left outer join VIW_COLOR_INFO j on jj.TENANT_ID=j.TENANT_ID and  jj.PROPERTY_02=j.COLOR_ID ) jk '+
     'left outer join VIW_MEAUNITS k on jk.TENANT_ID=k.TENANT_ID and jk.UNIT_ID=k.UNIT_ID ) jl  '+
     'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''2'' and TENANT_ID='+tid+') l on jl.SALES_STYLE=l.CODE_ID) jm '+
     'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''6'' and TENANT_ID='+tid+') m on jm.SETTLE_CODE=m.CODE_ID) jn '+
     'left outer join CA_DEPT_INFO n on jn.TENANT_ID=n.TENANT_ID and jn.DEPT_ID=n.DEPT_ID ) j order by SEQNO';
end;

class procedure TfrmOrderPreview.PrintReport(AOwner:TForm; ReportType: integer; AfrReport: TfrReport; tid, oid: string);
var Pages,CommandText:string;
begin
  with TfrmOrderPreview.Create(AOwner) do
    begin
      try
        if AfrReport=nil then Raise Exception.Create('AfrReport参数没有Create');
        try
          FfrReport := AfrReport;
          OpenFile(AfrReport,GlobalIndex);
          frReport.Dataset := frTable;
          frReport.Preview := frPreview;
          case ReportType of
            0:CommandText := GetStockOrderPrintSQL(tid,oid);
            1:CommandText := GetSalesOrderPrintSQL(tid,oid);
          end;
          SelectSQL := CommandText;
          adoTable.Close;
          adoTable.SQL.Text := CommandText;
          dataFactory.Open(adoTable);
          if frReport.PrepareReport then
             begin
               if (frReport.EMFPages = nil) then Exit;
               with TfrPrintForm.Create(Application) do
               begin
                 try
                   E1.Text := IntToStr(frReport.DefaultCopies);
                   CollateCB.Checked := frReport.DefaultCollate;
                   if not frReport.ShowPrintDialog or (ShowModal = mrOk) then
                      begin
                        if RB1.Checked then
                           Pages := ''
                        else if RB2.Checked then
                           Pages := IntToStr(1)
                        else
                           Pages := E2.Text;
                        frReport.PrintPreparedReport(Pages, StrToInt(E1.Text),CollateCB.Checked,TfrPrintPages(CB2.ItemIndex));
                      end;
                 finally
                   Free;
                 end;
               end;
             end;
        except
          on E:Exception do
            begin
               Raise Exception.Create('生成报表出错:'+E.Message);
            end;
        end;
      finally
        Free;
      end;
    end;
end;

end.
