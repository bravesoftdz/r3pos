unit ufrmMktKpiResult3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, jpeg, ExtCtrls, RzTabs, RzPanel, Grids, DBGridEh, DB, DBGridEhImpExp,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, zrComboBoxList, cxSpinEdit,
  RzButton, PrnDbgeh, cxDropDownEdit, ZBase;

type
  TfrmMktKpiResult3 = class(TframeToolForm)
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Grid: TDBGridEh;
    DsKpiResult: TDataSource;
    CdsKpiResult: TZQuery;
    fndKPI_ID: TzrComboBoxList;
    Label1: TLabel;
    ToolButton9: TToolButton;
    RzLabel7: TRzLabel;
    fndKPI_YEAR: TcxSpinEdit;
    btnOk: TRzBitBtn;
    cdsKPI_ID: TZQuery;
    SaveDialog1: TSaveDialog;
    PrintDBGridEh1: TPrintDBGridEh;
    Label32: TLabel;
    fndDEPT_ID: TzrComboBoxList;
    RzLabel4: TRzLabel;
    fndCLIENT_ID: TzrComboBoxList;
    Label40: TLabel;
    fndSHOP_ID: TzrComboBoxList;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    procedure actExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure fndKPI_YEARPropertiesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure CdsKpiResultAfterScroll(DataSet: TDataSet);
    procedure GridDrawFooterCell(Sender: TObject; DataCol, Row: Integer;
      Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    MaxId:String;
    IsEnd:Boolean;
    CdsClient:TZQuery;
    FIsAudit: Boolean;
    procedure PrintView;
    procedure SetIsAudit(const Value: Boolean);
  public
    { Public declarations }
    function  DoBeforeExport: boolean; override;
    function EncodeSql(id:String):String;
    procedure Open(Id:String);
    property IsAudit:Boolean read FIsAudit write SetIsAudit;
  end;


implementation
uses uGlobal, uShopGlobal, ufrmEhLibReport, uframeMDForm, ufrmMktKpiResultList, ufrmMktKpiCalculate,
  ufrmBasic,uFnUtil,ObjCommon,uXDictFactory,ufrmKpiIndexInfo;
{$R *.dfm}

procedure TfrmMktKpiResult3.actExitExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMktKpiResult3.FormCreate(Sender: TObject);
begin
  inherited;
  cdsKPI_ID.Close;
  cdsKPI_ID.SQL.Text := ' select KPI_ID,KPI_NAME,KPI_SPELL from MKT_KPI_INDEX where COMM not in (''02'',''12'') and TENANT_ID='+
                        IntToStr(Global.TENANT_ID)+' and IDX_TYPE = ''3'' ';
  Factor.Open(cdsKPI_ID);
  fndKPI_YEAR.Value := StrToInt(FormatDateTime('YYYY',Date()));
  fndCLIENT_ID.DataSet := ShopGlobal.GetZQueryFromName('CA_USERS');
  fndDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '仓库名称';
    end;  
  CdsClient := TZQuery.Create(nil);
end;

procedure TfrmMktKpiResult3.actFindExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002170',1) then Raise Exception.Create('你没有查询'+Caption+'的权限,请和管理员联系.');
  Open('');
end;

procedure TfrmMktKpiResult3.actAuditExecute(Sender: TObject);
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002170',3) then Raise Exception.Create('你没有审核'+Caption+'的权限,请和管理员联系.');
  if IsAudit then
     begin
       if CdsKpiResult.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前经销商考核结果执行弃审');
       if MessageBox(Handle,'确认弃审当前经销商考核结果？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
       if MessageBox(Handle,'确认审核当前经销商考核结果？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('PLAN_ID').asString := CdsKpiResult.FieldbyName('PLAN_ID').AsString;
      Params.ParamByName('KPI_ID').asString := CdsKpiResult.FieldbyName('KPI_ID').AsString;
      Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('CHK_USER').asString := Global.UserID;
      if not IsAudit then
         Msg := Factor.ExecProc('TMktKpiResultAudit',Params)
      else
         Msg := Factor.ExecProc('TMktKpiResultUnAudit',Params) ;
    finally
       Params.free;
    end;
    MessageBox(Handle,Pchar(Msg),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);

  except
    on E:Exception do
       begin
         Raise Exception.Create(E.Message);
       end;
  end;
  btnOk.OnClick(nil);
end;

procedure TfrmMktKpiResult3.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002170',4) then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
  PrintView;
  PrintDBGridEh1.Print;
end;

procedure TfrmMktKpiResult3.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002170',4) then Raise Exception.Create('你没有预览'+Caption+'的权限,请和管理员联系.');
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

procedure TfrmMktKpiResult3.actSaveExecute(Sender: TObject);
var Stream: TMemoryStream;
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002170',5) then Raise Exception.Create('你没有导出'+Caption+'的权限,请和管理员联系.');
  if Grid=nil then Exit;
  if Grid.DataSource=nil then Exit;
  if Grid.DataSource.DataSet=nil then Exit;
  if not Grid.DataSource.DataSet.Active then Exit;
  SaveDialog1.DefaultExt := '*.xls';
  SaveDialog1.Filter := 'Excel文档(*.xls)|*.xls|HTML文档(*.html)|*.html';
  if SaveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
    begin
      if MessageBox(Handle, Pchar(SaveDialog1.FileName + '已经存在，是否覆盖它？'), Pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) <> 6 then
        exit;
      DeleteFile(SaveDialog1.FileName);
    end;
    //导出Excel数据
    DoBeforeExport;
    Stream := TMemoryStream.Create;
    try
      Stream.Position := 0;
      if ExtractFileExt(SaveDialog1.FileName)='.xls' then
      begin
        with TDBGridEhExportAsXLS.Create do
        begin
          try
            DBGridEh := self.Grid;
            ExportToStream(Stream, True);
          finally
            Free;
          end;
        end;
      end
      else
      begin
        with TDBGridEhExportAsHTML.Create do
        begin
          try
            DBGridEh := self.Grid;
            ExportToStream(Stream, True);
          finally
            Free;
          end;
        end;
      end;
      Stream.SaveToFile(SaveDialog1.FileName);
    finally
      Stream.Free;
    end;
  end;
end;

procedure TfrmMktKpiResult3.actEditExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002170',2) then Raise Exception.Create('你没有计算'+Caption+'的权限,请和管理员联系.');
  with TfrmMktKpiCalculate.Create(nil) do
  begin
    try
      IdxType := '3';
      PlanType := '3';
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfrmMktKpiResult3.GridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = Grid.CellRect(Grid.Col, Grid.Row).Top) and (not
    (gdFocused in State) or not Grid.Focused) then
  begin
    Grid.Canvas.Brush.Color := clAqua;
  end;
  Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      Grid.canvas.Brush.Color := $0000F2F2;
      Grid.canvas.FillRect(ARect);
      DrawText(Grid.Canvas.Handle,pchar(Inttostr(CdsKpiResult.RecNo)),length(Inttostr(CdsKpiResult.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

function TfrmMktKpiResult3.EncodeSql(id: String): String;
var w,w1:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.IDX_TYPE=''3'' and A.KPI_YEAR=:KPI_YEAR and A.COMM not in (''02'',''12'') ';

  if fndDEPT_ID.AsString <> '' then
     w := w + ' and B.DEPT_ID=:DEPT_ID ';
  if fndCLIENT_ID.AsString <> '' then
     w := w + ' and A.PLAN_USER=:CLIENT_ID ';
  if fndSHOP_ID.AsString <> '' then
     w := w + ' and A.SHOP_ID=:SHOP_ID ';         
  if fndKPI_ID.AsString <> '' then
     w := w +' and A.KPI_ID=:KPI_ID ';

  if id<>'' then
     w := w +' and A.PLAN_ID>'''+id+'''';
          
  Result := ' select A.TENANT_ID,A.PLAN_ID,C.USER_NAME as PLAN_USER_TEXT,A.IDX_TYPE,A.KPI_TYPE,A.KPI_DATA,A.KPI_CALC,A.KPI_YEAR,A.BEGIN_DATE,'+
            'A.END_DATE,A.CLIENT_ID,A.CHK_DATE,F.KPI_NAME as KPI_ID_TEXT,A.CHK_USER,E.USER_NAME as CHK_USER_TEXT,F.UNIT_NAME,'+
            'case when A.KPI_DATA in (''1'',''4'') then G.AMOUNT else G.AMONEY end as PLAN_AMT,'+
            'case when A.KPI_DATA in (''1'',''4'') then A.FISH_AMT else A.FISH_MNY end as FISH_AMT,'+
            'A.KPI_MNY,A.REMARK,A.CREA_DATE,A.CREA_USER,D.USER_NAME as CREA_USER_TEXT '+
            ' from MKT_KPI_RESULT A inner join MKT_PLANORDER B on A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID '+
            ' inner join VIW_USERS C on B.TENANT_ID=C.TENANT_ID and B.PLAN_USER=C.USER_ID '+
            ' left outer join MKT_PLANDATA G on A.TENANT_ID=G.TENANT_ID and A.PLAN_ID=G.PLAN_ID and A.KPI_ID=G.KPI_ID'+
            ' left outer join VIW_USERS D on A.TENANT_ID=D.TENANT_ID and A.CREA_USER=D.USER_ID '+
            ' left outer join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.CHK_USER=E.USER_ID '+
            ' left outer join MKT_KPI_INDEX F on A.TENANT_ID=F.TENANT_ID and A.KPI_ID=F.KPI_ID ' + w;
  Result := ParseSQL(Factor.iDbType,
            'select H.*,case when H.PLAN_AMT <> 0 then cast(H.FISH_AMT*1.0/H.PLAN_AMT*1.0 as decimal(18,6))*100 else 0.00 end as FISH_RATE from ('+Result+') H ');

  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') jp order by PLAN_ID';
  1:result :=
       'select * from ('+
       'select * from ('+result+') j order by PLAN_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by PLAN_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') j order by PLAN_ID limit 600';
  else
    result := 'select * from ('+result+') j order by PLAN_ID';
  end;
              
end;

procedure TfrmMktKpiResult3.Open(Id: String);
var
  rs:TZQuery;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then CdsKpiResult.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  CdsKpiResult.DisableControls;
  try
    rs.SQL.Text := EncodeSQL(Id);
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('KPI_YEAR').AsInteger := fndKPI_YEAR.Value;
    if rs.Params.FindParam('DEPT_ID')<>nil then rs.Params.FindParam('DEPT_ID').AsString := fndDEPT_ID.AsString;
    if rs.Params.FindParam('CLIENT_ID')<>nil then rs.Params.FindParam('CLIENT_ID').AsString := fndCLIENT_ID.AsString;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.Params.FindParam('SHOP_ID').AsString := fndSHOP_ID.AsString;
    if rs.Params.FindParam('KPI_ID')<>nil then rs.Params.FindParam('KPI_ID').AsString := fndKPI_ID.AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('PLAN_ID').AsString;
    if Id='' then
    begin
       rs.SaveToStream(sm);
       CdsKpiResult.LoadFromStream(sm);
       //cdsList.IndexFieldNames := 'GLIDE_NO';
    end
    else
    begin
       rs.SaveToStream(sm);
       CdsKpiResult.AddFromStream(sm);
    end;
    if rs.RecordCount <600 then IsEnd := True else IsEnd := false;
  finally
    CdsKpiResult.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmMktKpiResult3.fndKPI_YEARPropertiesChange(Sender: TObject);
begin
  inherited;
  if (fndKPI_YEAR.Value < 2011) or (fndKPI_YEAR.Value > 2111) then
     Raise Exception.Create('输入年度范围"2011-2111"');

end;

function TfrmMktKpiResult3.DoBeforeExport: boolean;
var
  i: integer;                      
  PageNo,CurStr: string;  //控件页码
  Str: WideString;
  TitleList: TStringList;
begin
  Str:='';
  try
    Grid.DBGridHeader.Clear;
    Grid.DBGridFooter.Clear;
    PageNo:=InttoStr(RzPage.ActivePageIndex+1);
    Grid.DBGridTitle:=RzPage.ActivePage.Caption;
    //调用DBGridEh的Print来获取导出条件
    TitleList:=TStringList.Create;
    //AddReportReport(TitleList, PageNo);
    for i:=0 to TitleList.Count-1 do
    begin
      CurStr:=trim(TitleList.Strings[i]);
      if (i>0) and (i mod 4=0) then  //4个条件换一行
        Str:=Str+#13+CurStr
      else
      begin
        if i=0 then
          Str:=CurStr
        else
          Str:=Str+'      '+CurStr;
      end;
    end;
  finally
    TitleList.Free;
  end;
  Grid.DBGridHeader.Text:=Str;
  Grid.DBGridFooter.Add(' '+#13+' 操作员：'+Global.UserName+'  导出时间：'+formatDatetime('YYYY-MM-DD HH:NN:SS',now()));
end;

procedure TfrmMktKpiResult3.PrintView;
begin
  PrintDBGridEh1.PageHeader.CenterText.Text := '经销商考核';

  PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]','']);
  Grid.DataSource.DataSet.Filtered := False;
  PrintDBGridEh1.DBGridEh := Grid;
end;

procedure TfrmMktKpiResult3.FormDestroy(Sender: TObject);
begin
  inherited;
  CdsClient.Free;
end;

procedure TfrmMktKpiResult3.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (not CdsKpiResult.Active) or (CdsKpiResult.IsEmpty) then exit;

  with TfrmMktKpiResultList.Create(self) do
  begin
    try
      KpiType := CdsKpiResult.FieldByName('KPI_TYPE').AsString;
      KpiData := CdsKpiResult.FieldByName('KPI_DATA').AsString;
      KpiCalc := CdsKpiResult.FieldByName('KPI_CALC').AsString;
      KpiName := CdsKpiResult.FieldByName('KPI_ID_TEXT').AsString;
      IdxType := CdsKpiResult.FieldByName('IDX_TYPE').AsString;
      KpiYear := CdsKpiResult.FieldByName('KPI_YEAR').AsString;
      Open(CdsKpiResult.FieldByName('PLAN_ID').AsString);
      ShowModal;
    finally
      Free;
    end;
  end;

end;

procedure TfrmMktKpiResult3.GridDblClick(Sender: TObject);
begin
  inherited;
  actInfo.OnExecute(nil);
end;

procedure TfrmMktKpiResult3.CdsKpiResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if CdsKpiResult.IsEmpty then Exit;
  IsAudit := (CdsKpiResult.FieldByName('CHK_DATE').AsString <> '');
end;

procedure TfrmMktKpiResult3.SetIsAudit(const Value: Boolean);
begin
  FIsAudit := Value;
  if Value then
     actAudit.Caption := '弃审'
  else
     actAudit.Caption := '审核';
end;

procedure TfrmMktKpiResult3.GridDrawFooterCell(Sender: TObject; DataCol,
  Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
var R:TRect;
  s:string;
begin
  inherited;
  if Column.FieldName = 'PLAN_USER_TEXT' then
     begin
       R.Left := Rect.Left;
       R.Top := Rect.Top ;
       R.Bottom := Rect.Bottom;

       Grid.Canvas.FillRect(R);
       s := XDictFactory.GetMsgStringFmt('frame.OrderFooterLabel','合 计 共%s人',[Inttostr(CdsKpiResult.RecordCount)]);
       Grid.Canvas.Font.Style := [fsBold];
       Grid.Canvas.TextRect(R,(Rect.Right) div 2,Rect.Top+2,s);
     end;
end;

procedure TfrmMktKpiResult3.N1Click(Sender: TObject);
begin
  inherited;
  if not CdsKpiResult.Active then Exit;
  if CdsKpiResult.IsEmpty then Exit;
  //if not ShopGlobal.GetChkRight('100002143',1) then Raise Exception.Create('你没有查看指标的权限,请和管理员联系.');
  with TfrmKpiIndexInfo.Create(self) do
    begin
      try
        Open(CdsKpiResult.FieldByName('KPI_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

end.
