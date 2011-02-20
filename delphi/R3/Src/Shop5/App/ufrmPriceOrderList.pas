unit ufrmPriceOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderToolForm, DB, ADODB, ActnList, Menus, ComCtrls,
  ToolWin, StdCtrls, RzLabel, Grids, DBGridEh, ExtCtrls, RzTabs, RzPanel,
  DBClient, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxButtonEdit, zrComboBoxList, RzButton,
  cxRadioGroup, ZBase, jpeg, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmPriceOrderList = class(TframeOrderToolForm)
    ToolButton11: TToolButton;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    Splitter1: TSplitter;
    RzLabel5: TRzLabel;
    fndPROM_ID: TcxTextEdit;
    Label1: TLabel;
    DataSource1: TDataSource;
    btnOk: TRzBitBtn;
    fndSTATUS: TcxRadioGroup;
    Timer1: TTimer;
    DBGridEh2: TDBGridEh;
    cdsDetail: TZQuery;
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure actFindExecute(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh2DrawFooterCell(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure actPriorExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
  private
    { Private declarations }
    oid:string;
  public
    { Public declarations }
    IsEnd: boolean;
    MaxId:string;
    function GetFormClass:TFormClass;override;
    function EncodeSQL(id:string):string;
    procedure Open(Id:string);
    procedure OpenDetail(id:string);
  end;

implementation
uses ufrmPriceOrder,uGlobal,uShopUtil,uXDictFactory, uShopGlobal;
{$R *.dfm}

{ TfrmPriceOrderList }

function TfrmPriceOrderList.GetFormClass: TFormClass;
begin
  result := TfrmPriceOrder;
end;

function TfrmPriceOrderList.EncodeSQL(id: string): string;
var w:string;
begin
  result:='';                                
  w:='where TENANT_ID=:TENANT_ID and BEGIN_DATE>=:BEGDATE and BEGIN_DATE<=:ENDDATE ';
  case Factor.iDbType of
   0,3:  if trim(fndPROM_ID.Text)<>'' then w:=w+' and GLIDE_NO like ''%'' + :GLIDE_NO + '' ';
   1,4,5:if trim(fndPROM_ID.Text)<>'' then w:=w+' and GLIDE_NO like ''%'' || :GLIDE_NO || '' ';
  end;
  if fndSTATUS.ItemIndex > 0 then
  begin
    if fndSTATUS.ItemIndex=1 then w := w +' and CHK_DATE is null ' else w := w +' and CHK_DATE is not null';
  end;
  if id<>'' then w := w +' and PROM_ID>'''+id+'''';
  case Factor.iDbType of
  0,3:result:='select top 600 PROM_ID,GLIDE_NO,BEGIN_DATE,END_DATE,REMARK,PRICE_ID,TENANT_ID from SAL_PRICEORDER '+w+' order by PROM_ID';
  1: result:='  ';
  4: result:='select tp.* from (select PROM_ID,GLIDE_NO,BEGIN_DATE,END_DATE,REMARK,PRICE_ID,TENANT_ID from SAL_PRICEORDER '+w+') order by PROM_ID) tp fetch first 600  rows only ';
  5: result:='select PROM_ID,GLIDE_NO,BEGIN_DATE,END_DATE,REMARK,PRICE_ID,TENANT_ID from SAL_PRICEORDER '+w+' order by PROM_ID LIMIT 600 ';
  end; 
end;

procedure TfrmPriceOrderList.Open(Id: string);
var
  rs: TZQuery;
  StrmData: TStream;
begin
  if not Visible then Exit;
  if Id='' then cdsList.close;
  cdsList.DisableControls;
  try
    StrmData:=TMemoryStream.Create;
    rs := TZQuery.Create(nil);
    rs.SQL.Text:= EncodeSQL(Id);
    if rs.Params.FindParam('TENANT_ID')<>nil then rs.ParamByName('TENANT_ID').AsInteger:=SHopGlobal.TENANT_ID;
    if rs.Params.FindParam('BEGDATE')<>nil then rs.ParamByName('BEGDATE').AsString:=FormatDatetime('YYYY-MM-DD',D1.Date);
    if rs.Params.FindParam('ENDDATE')<>nil then rs.ParamByName('ENDDATE').AsString:=formatDatetime('YYYY-MM-DD',D2.Date)+' 99:99:99';
    if rs.Params.FindParam('GLIDE_NO')<>nil then rs.ParamByName('GLIDE_NO').AsString:=trim(fndPROM_ID.Text);
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('PROM_ID').AsString;
    rs.SaveToStream(StrmData); 
    cdsList.LoadFromStream(StrmData);
    if rs.RecordCount <600 then IsEnd := True else IsEnd := false;
  finally
    cdsList.EnableControls;
    rs.Free;
  end;
end;

procedure TfrmPriceOrderList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);

end;

procedure TfrmPriceOrderList.FormCreate(Sender: TObject);
function FindColumn(FieldName: string): TColumnEh;
var i:integer;
begin
  Result := nil;
  for i:=0 to DBGridEh2.Columns.Count -1 do
    begin
      if UpperCase(DBGridEh2.Columns[i].FieldName)=UpperCase(FieldName) then
         begin
           Result := DBGridEh2.Columns[i];
           Exit;
         end;
    end;
end;
var
  rs: TZQuery;
  Column:TColumnEh;
begin
  inherited;
  InitGridPickList(DBGridEh1);
  InitGridPickList(DBGridEh2);
  D1.Date := date();
  D2.Date := date();
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  Column := FindColumn('CALC_UNITS');
  if Column<>nil then
  begin
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
  end;
  Column := FindColumn('SMALL_UNITS');
  if Column<>nil then
  begin
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
  end;
  Column := FindColumn('BIG_UNITS');
  if Column<>nil then
  begin
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
  end;
end;

procedure TfrmPriceOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open(''); 
end;

procedure TfrmPriceOrderList.OpenDetail(id: string);
var
  Params:TftParamList;
  i:integer;
begin
  Params := TftParamList.Create(nil);
  try
     oid := id;
     Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
     Params.ParamByName('PROM_ID').asString := id;
     cdsDetail.Close;
     Factor.Open(cdsDetail,'TPriceData',Params);
     //R3库中没有:  PRICE_TYPE  促销方式
     {
     for i:=0 to DBGridEh2.Columns.Count -1 do
      begin
        if copy(DBGridEh2.Columns[i].FieldName,1,4)='OUT_' then
           DBGridEh2.Columns[i].Visible := (cdsList.FieldbyName('PRICE_TYPE').asInteger=1);
        if copy(DBGridEh2.Columns[i].FieldName,1,5)='AGIO_' then
           DBGridEh2.Columns[i].Visible := (cdsList.FieldbyName('PRICE_TYPE').asInteger=2);
        if DBGridEh2.Columns[i].FieldName='CALC_UNITS' then
           DBGridEh2.Columns[i].Visible := (cdsList.FieldbyName('PRICE_TYPE').asInteger=1);
        if DBGridEh2.Columns[i].FieldName='SMALL_UNITS' then
           DBGridEh2.Columns[i].Visible := (cdsList.FieldbyName('PRICE_TYPE').asInteger=1);
        if DBGridEh2.Columns[i].FieldName='BIG_UNITS' then
           DBGridEh2.Columns[i].Visible := (cdsList.FieldbyName('PRICE_TYPE').asInteger=1);
      end;
     }
  finally
     Params.Free;
  end;
end;

procedure TfrmPriceOrderList.DBGridEh1CellClick(Column: TColumnEh);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  OpenDetail(cdsList.FieldbyName('PROM_ID').AsString);  
end;

procedure TfrmPriceOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');  
end;

procedure TfrmPriceOrderList.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh2.canvas.Brush.Color := $0000F2F2;
      DBGridEh2.canvas.FillRect(ARect);
      DrawText(DBGridEh2.Canvas.Handle,pchar(Inttostr(cdsDetail.RecNo)),length(Inttostr(cdsDetail.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmPriceOrderList.DBGridEh2DrawFooterCell(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; Rect: TRect;
  State: TGridDrawState);
function FindColumn(FieldName: string): TColumnEh;
var i:integer;
begin
  Result := nil;
  for i:=0 to DBGridEh2.Columns.Count -1 do
    begin
      if UpperCase(DBGridEh2.Columns[i].FieldName)=UpperCase(FieldName) then
         begin
           Result := DBGridEh2.Columns[i];
           Exit;
         end;
    end;
end;
var R:TRect;
  s:string;
begin
  inherited;
  if Column.FieldName = 'GODS_NAME' then
     begin
       R.Left := Rect.Left;
       R.Top := Rect.Top ;
       R.Bottom := Rect.Bottom;
       if FindColumn('GODS_CODE')<>nil then
       begin
         if FindColumn('UNIT_ID')=nil then
            R.Right := Rect.Right + FindColumn('GODS_CODE').Width
         else
            R.Right := Rect.Right + FindColumn('GODS_CODE').Width+ FindColumn('UNIT_ID').Width;
       end
       else
       begin
         if FindColumn('UNIT_ID')=nil then
            R.Right := Rect.Right + FindColumn('GODS_CODE').Width
         else
            R.Right := Rect.Right + FindColumn('GODS_CODE').Width+ FindColumn('UNIT_ID').Width;
       end;
       DBGridEh2.Canvas.FillRect(R);
       s := XDictFactory.GetMsgStringFmt('frame.OrderFooterLabel','合 计 共%s笔',[Inttostr(cdsDetail.RecordCount)]);
       DBGridEh2.Canvas.Font.Style := [fsBold];
       DBGridEh2.Canvas.TextRect(R,(Rect.Right-Rect.Left-DBGridEh2.Canvas.TextWidth(s)) div 2,Rect.Top+2,s);
     end;
end;

procedure TfrmPriceOrderList.actPriorExecute(Sender: TObject);
var
  Temp:TADODataSet;
  Params:TftParamList;
begin
  inherited;
  if CurOrder <> nil then
     begin
        Params := TftParamList.Create(nil);
        try
          Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
          Params.ParamByName('CREA_USER').asString := Global.UserID;
          if (CurOrder.gid = '') or (CurOrder.gid='..新增..') then
             Params.ParamByName('GLIDE_NO').asString := '9999999999999999'
          else
             Params.ParamByName('GLIDE_NO').asString := CurOrder.gid;
          Temp := TADODataSet.Create(nil);
          try
             Factor.Open(Temp,'TPriceOrderGetPrior',Params);
             if Temp.Fields[0].asString<>'' then
                CurOrder.Open(Temp.Fields[0].asString);
          finally
             Temp.Free;
          end;
        finally
          Params.Free;
        end;
     end
  else
     begin
        cdsList.Prior;
        OpenDetail(cdsList.FieldbyName('PROM_ID').AsString);
     end;
end;

procedure TfrmPriceOrderList.actNextExecute(Sender: TObject);
var
  Temp:TADODataSet;
  Params:TftParamList;
begin
  inherited;
  if CurOrder <> nil then
     begin
        Params := TftParamList.Create(nil);
        try
          Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
          Params.ParamByName('OPER_USER').asString := Global.UserID;
          if CurOrder.gid = '' then
             Params.ParamByName('GLIDE_NO').asString := '00000000000000'
          else
             Params.ParamByName('GLIDE_NO').asString := CurOrder.gid;
          Temp := TADODataSet.Create(nil);
          try
             Factor.Open(Temp,'TPriceOrderGetNext',Params);
             if Temp.Fields[0].asString<>'' then
                CurOrder.Open(Temp.Fields[0].asString);
          finally
             Temp.Free;
          end;
        finally
          Params.Free;
        end;
     end
  else
     begin
        cdsList.Next;
        OpenDetail(cdsList.FieldbyName('PROM_ID').AsString);
     end;
end;

procedure TfrmPriceOrderList.actEditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('500015') then Raise Exception.Create('你没有修改促销单的权限,请和管理员联系.');
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('PROM_ID').AsString);
     end;
  inherited;

end;

procedure TfrmPriceOrderList.actDeleteExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('500016') then Raise Exception.Create('你没有删除促销单的权限,请和管理员联系.');
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('PROM_ID').AsString);
     end;
  inherited;
  if (CurOrder<>nil) then
     begin
       if not CurOrder.saved then Exit;
       if ShopGlobal.GetChkRight('500014') and (MessageBox(Handle,'删除当前单据成功,是否继续新增促销单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurOrder.NewOrder
       else
          if rzPage.PageCount>2 then CurOrder.Close;
     end;
end;

procedure TfrmPriceOrderList.actSaveExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder<>nil) then
     begin
       if not CurOrder.saved then Exit;
       if ShopGlobal.GetChkRight('500014') and (MessageBox(Handle,'是否继续新增促销单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurOrder.NewOrder
       else
          if rzPage.PageCount>2 then CurOrder.Close;
     end;
end;

procedure TfrmPriceOrderList.actAuditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('500017') then Raise Exception.Create('你没有审核促销单的权限,请和管理员联系.');
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('PROM_ID').AsString);
     end;
  inherited;

end;

procedure TfrmPriceOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('PROM_ID').AsString);
     end;

end;

procedure TfrmPriceOrderList.Timer1Timer(Sender: TObject);
begin
  inherited;
  if not cdsList.Active then Exit;
  if cdsList.FieldByName('PROM_ID').AsString <> oid then
     OpenDetail(cdsList.FieldByName('PROM_ID').AsString);
end;

procedure TfrmPriceOrderList.actNewExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('500014') then Raise Exception.Create('你没有新增促销单的权限,请和管理员联系.');
  inherited;

end;

procedure TfrmPriceOrderList.actPrintExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('500018') then Raise Exception.Create('你没有打印促销单的权限,请和管理员联系.');
  inherited;

end;

procedure TfrmPriceOrderList.actPreviewExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('500018') then Raise Exception.Create('你没有打印促销单的权限,请和管理员联系.');
  inherited;

end;

procedure TfrmPriceOrderList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
//  if not ShopGlobal.GetChkRight('500015') then
     actInfo.OnExecute(nil)
//  else
//     actEdit.OnExecute(nil);

end;

end.
