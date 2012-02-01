unit ufrmMktKpiResult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, jpeg, ExtCtrls, RzTabs, RzPanel, Grids, DBGridEh, DB, DBGridEhImpExp,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, zrComboBoxList, cxSpinEdit,
  RzButton, PrnDbgeh, cxDropDownEdit, ZBase;

type
  TfrmMktKpiResult = class(TframeToolForm)
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
    Label23: TLabel;
    fndCUST_TYPE: TcxComboBox;
    fndCUST_VALUE: TzrComboBoxList;
    RzLabel4: TRzLabel;
    fndCLIENT_ID: TzrComboBoxList;
    Label40: TLabel;
    fndSHOP_ID: TzrComboBoxList;
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
    procedure fndCUST_TYPEPropertiesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure CdsKpiResultAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure GridDrawFooterCell(Sender: TObject; DataCol, Row: Integer;
      Column: TColumnEh; Rect: TRect; State: TGridDrawState);
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
  ufrmBasic,ObjCommon,uFnUtil,uShopUtil,uXDictFactory;
{$R *.dfm}

procedure TfrmMktKpiResult.actExitExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMktKpiResult.FormCreate(Sender: TObject);
begin
  inherited;
  cdsKPI_ID.Close;
  cdsKPI_ID.SQL.Text := ' select KPI_ID,KPI_NAME from MKT_KPI_INDEX where COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and IDX_TYPE = ''1'' ';
  Factor.Open(cdsKPI_ID);
  fndKPI_YEAR.Value := StrToInt(FormatDateTime('YYYY',Date()));
  fndCLIENT_ID.DataSet := ShopGlobal.GetZQueryFromName('PUB_CUSTOMER');
  fndDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '仓库名称';
    end;
  CdsClient := TZQuery.Create(nil);
end;

procedure TfrmMktKpiResult.actFindExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002158',1) then Raise Exception.Create('你没有查询'+Caption+'的权限,请和管理员联系.');
  Open('');                            
end;

procedure TfrmMktKpiResult.actAuditExecute(Sender: TObject);
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002158',3) then Raise Exception.Create('你没有审核'+Caption+'的权限,请和管理员联系.');
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

procedure TfrmMktKpiResult.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002158',4) then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
  PrintView;
  PrintDBGridEh1.Print;
end;

procedure TfrmMktKpiResult.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002158',4) then Raise Exception.Create('你没有预览'+Caption+'的权限,请和管理员联系.');
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

procedure TfrmMktKpiResult.actSaveExecute(Sender: TObject);
var Stream: TMemoryStream;
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002158',5) then Raise Exception.Create('你没有导出'+Caption+'的权限,请和管理员联系.');
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

procedure TfrmMktKpiResult.actEditExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002158',2) then Raise Exception.Create('你没有计算'+Caption+'的权限,请和管理员联系.');
  with TfrmMktKpiCalculate.Create(nil) do
  begin
    try
      IdxType := '1';
      PlanType := '1';
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfrmMktKpiResult.GridDrawColumnCell(Sender: TObject;
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

function TfrmMktKpiResult.EncodeSql(id: String): String;
var w,w1:string;
begin
  w := ' where A.TENANT_ID=:TENANT_ID and A.IDX_TYPE=''1'' and A.KPI_YEAR=:KPI_YEAR and A.COMM not in (''02'',''12'') ';
  if fndCUST_VALUE.AsString <> '' then
  begin
     case fndCUST_TYPE.ItemIndex of
       0:
       begin
         if FnString.TrimRight(trim(fndCUST_VALUE.AsString),2)='00' then  //非末级区域
           w := w +' and C.REGION_ID like '':REGION_ID%'' '
         else
           w := w +' and C.REGION_ID=:REGION_ID ';
       end;
       1:w := w +' and C.PRICE_ID=:PRICE_ID ';
       2:w := w +' and C.SORT_ID=:SORT_ID ';
       3:w := w +' and C.FLAG=:FLAG ';
     end;
  end;
  if fndDEPT_ID.AsString <> '' then
     w := w + ' and B.DEPT_ID=:DEPT_ID ';
  if fndCLIENT_ID.AsString <> '' then
     w := w + ' and A.CLIENT_ID=:CLIENT_ID ';
  if fndSHOP_ID.AsString <> '' then
     w := w + ' and A.SHOP_ID=:SHOP_ID ';
  if fndKPI_ID.AsString <> '' then
     w := w +' and A.KPI_ID=:KPI_ID ';

  if id<>'' then
     w := w +' and A.PLAN_ID>'''+id+'''';

  Result := ' select A.TENANT_ID,A.PLAN_ID,C.CLIENT_NAME as CLIENT_ID_TEXT,A.IDX_TYPE,A.KPI_TYPE,A.KPI_DATA,A.KPI_CALC,A.KPI_YEAR,A.BEGIN_DATE,'+
            'A.END_DATE,A.CLIENT_ID,A.CHK_DATE,F.KPI_NAME as KPI_ID_TEXT,A.CHK_USER,E.USER_NAME as CHK_USER_TEXT,F.UNIT_NAME,'+
            'case when A.KPI_DATA in (''1'',''4'') then A.PLAN_AMT else A.PLAN_MNY end as PLAN_AMT,'+
            'case when A.KPI_DATA in (''1'',''4'') then A.FISH_AMT else A.FISH_MNY end as FISH_AMT,'+
            'A.KPI_MNY,A.WDW_MNY,A.KPI_MNY-A.WDW_MNY as BALANCE_MNY,A.REMARK,A.CREA_DATE,A.CREA_USER,D.USER_NAME as CREA_USER_TEXT '+
            ' from MKT_KPI_RESULT A inner join MKT_PLANORDER B on A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID '+
            ' inner join VIW_CUSTOMER C on A.TENANT_ID=C.TENANT_ID and A.CLIENT_ID=C.CLIENT_ID '+
            ' left outer join VIW_USERS D on A.TENANT_ID=D.TENANT_ID and A.CREA_USER=D.USER_ID '+
            ' left outer join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.CHK_USER=E.USER_ID '+
            ' left outer join MKT_KPI_INDEX F on A.TENANT_ID=F.TENANT_ID and A.KPI_ID=F.KPI_ID ' + w;
  Result := ParseSQL(Factor.iDbType,
            'select H.*,case when H.PLAN_AMT <> 0 then cast(H.FISH_AMT*1.0/H.PLAN_AMT*1.0 as decimal(18,6))*100 else 0.00 end as FISH_RATE from ('+Result+') H  ');

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

procedure TfrmMktKpiResult.Open(Id: String);
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
    if rs.Params.FindParam('REGION_ID')<>nil then rs.Params.FindParam('REGION_ID').AsString := GetRegionId(fndCUST_VALUE.AsString);
    if rs.Params.FindParam('PRICE_ID')<>nil then rs.Params.FindParam('PRICE_ID').AsString := fndCUST_VALUE.AsString;
    if rs.Params.FindParam('SORT_ID')<>nil then rs.Params.FindParam('SORT_ID').AsString := fndCUST_VALUE.AsString;
    if rs.Params.FindParam('FLAG')<>nil then rs.Params.FindParam('FLAG').AsString := fndCUST_VALUE.AsString;
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

procedure TfrmMktKpiResult.fndKPI_YEARPropertiesChange(Sender: TObject);
begin
  inherited;
  if (fndKPI_YEAR.Value < 2011) or (fndKPI_YEAR.Value > 2111) then
     Raise Exception.Create('输入年度范围"2011-2111"');

end;

function TfrmMktKpiResult.DoBeforeExport: boolean;
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

procedure TfrmMktKpiResult.PrintView;
begin
  PrintDBGridEh1.PageHeader.CenterText.Text := '经销商考核';

  PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]','']);
  Grid.DataSource.DataSet.Filtered := False;
  PrintDBGridEh1.DBGridEh := Grid;
end;

procedure TfrmMktKpiResult.fndCUST_TYPEPropertiesChange(Sender: TObject);
begin
  CdsClient:=TZQuery.Create(self);
  CdsClient.Close;
  CdsClient.SQL.Text:='select 0 as SEQ_NO,DEFINE as CODE_ID,VALUE as CODE_NAME from SYS_DEFINE where 1=2 ';
  Factor.Open(CdsClient);
  CdsClient.IndexFieldNames:='SEQ_NO';
  //添加：全部
  CdsClient.Edit;
  CdsClient.FieldByName('SEQ_NO').AsString:='1';
  CdsClient.FieldByName('CODE_ID').AsString:='1';
  CdsClient.FieldByName('CODE_NAME').AsString:='全部';
  CdsClient.Post;
  //添加：企业客户
  CdsClient.Append;
  CdsClient.FieldByName('SEQ_NO').AsString:='2';
  CdsClient.FieldByName('CODE_ID').AsString:='0';
  CdsClient.FieldByName('CODE_NAME').AsString:='企业客户';
  CdsClient.Post;
  //添加：会员
  CdsClient.Append;
  CdsClient.FieldByName('SEQ_NO').AsString:='3';
  CdsClient.FieldByName('CODE_ID').AsString:='2';
  CdsClient.FieldByName('CODE_NAME').AsString:='会员';
  CdsClient.Post;


  case fndCUST_TYPE.ItemIndex of
   0:
    begin
      fndCUST_VALUE.DataSet:=Global.GetZQueryFromName('PUB_REGION_INFO'); //行政区域 和客户分类
      fndCUST_VALUE.KeyField:='CODE_ID';
      fndCUST_VALUE.ListField:='CODE_NAME';
      fndCUST_VALUE.FilterFields:='CODE_ID;CODE_NAME;CODE_SPELL';
      fndCUST_VALUE.DropWidth:=170;
      fndCUST_VALUE.DropHeight:=180;
    end;
   1:
    begin
      fndCUST_VALUE.DataSet:=Global.GetZQueryFromName('PUB_PRICEGRADE');  //客户等级
      fndCUST_VALUE.KeyField:='PRICE_ID';
      fndCUST_VALUE.ListField:='PRICE_NAME';
      fndCUST_VALUE.FilterFields:='PRICE_ID;PRICE_NAME;PRICE_SPELL';
      fndCUST_VALUE.DropWidth:=fndCUST_VALUE.Width+15;
      fndCUST_VALUE.DropHeight:=120;
    end;
    2:
    begin
      fndCUST_VALUE.DataSet:=Global.GetZQueryFromName('PUB_CLIENTSORT'); //行政区域 和客户分类
      fndCUST_VALUE.KeyField:='CODE_ID';
      fndCUST_VALUE.ListField:='CODE_NAME';
      fndCUST_VALUE.FilterFields:='CODE_ID;CODE_NAME;CODE_SPELL';
      fndCUST_VALUE.DropWidth:=150;
      fndCUST_VALUE.DropHeight:=154;
    end;
    3:
    begin
      fndCUST_VALUE.DataSet:=CdsClient; //行政区域 和客户分类
      fndCUST_VALUE.KeyField:='CODE_ID';
      fndCUST_VALUE.ListField:='CODE_NAME';
      fndCUST_VALUE.FilterFields:='CODE_ID;CODE_NAME';
      fndCUST_VALUE.DropWidth:=fndCUST_VALUE.Width+15;
      fndCUST_VALUE.DropHeight:=120;
    end;
  end;
  fndCUST_VALUE.Columns[0].FieldName:=fndCUST_VALUE.ListField;
  if fndCUST_VALUE.Columns.Count>1 then
  begin
    fndCUST_VALUE.Columns[1].FieldName:=fndCUST_VALUE.KeyField;
    fndCUST_VALUE.Columns[1].Visible:=not((fndCUST_TYPE.ItemIndex=1) or (fndCUST_TYPE.ItemIndex=3));
  end;
  fndCUST_VALUE.KeyValue:=null;
  fndCUST_VALUE.Text:='';

end;

procedure TfrmMktKpiResult.FormDestroy(Sender: TObject);
begin
  inherited;
  CdsClient.Free;
end;

procedure TfrmMktKpiResult.actInfoExecute(Sender: TObject);
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

procedure TfrmMktKpiResult.GridDblClick(Sender: TObject);
begin
  inherited;
  actInfo.OnExecute(nil);
end;

procedure TfrmMktKpiResult.CdsKpiResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if CdsKpiResult.IsEmpty then Exit;
  IsAudit := (CdsKpiResult.FieldByName('CHK_DATE').AsString <> '');
end;

procedure TfrmMktKpiResult.SetIsAudit(const Value: Boolean);
begin
  FIsAudit := Value;
  if Value then
     actAudit.Caption := '弃审'
  else
     actAudit.Caption := '审核';
end;

procedure TfrmMktKpiResult.FormShow(Sender: TObject);
begin
  inherited;
  fndCUST_TYPE.ItemIndex := 0;
end;

procedure TfrmMktKpiResult.GridDrawFooterCell(Sender: TObject; DataCol,
  Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
var R:TRect;
  s:string;
begin
  inherited;
  if Column.FieldName = 'CLIENT_ID_TEXT' then
     begin
       R.Left := Rect.Left;
       R.Top := Rect.Top ;
       R.Bottom := Rect.Bottom;

       Grid.Canvas.FillRect(R);
       s := XDictFactory.GetMsgStringFmt('frame.OrderFooterLabel','合 计 共%s个',[Inttostr(CdsKpiResult.RecordCount)]);
       Grid.Canvas.Font.Style := [fsBold];
       Grid.Canvas.TextRect(R,(Rect.Right) div 2,Rect.Top+2,s);
     end;
end;

end.
