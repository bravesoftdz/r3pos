{ 14200001	0	领用单	1	查询	2	新增 	3	修改 	4	删除 	5	审核	6	打印	7	导出 }


unit ufrmChangeOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderToolForm, DB, ActnList, Menus, ComCtrls,
  ToolWin, StdCtrls, RzLabel, Grids, DBGridEh, ExtCtrls, RzTabs, RzPanel,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxButtonEdit, zrComboBoxList, RzButton,
  cxRadioGroup, zBase, FR_Class, jpeg, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmChangeOrderList = class(TframeOrderToolForm)
    ToolButton11: TToolButton;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel5: TRzLabel;
    fndCHANGE_ID: TcxTextEdit;
    Label1: TLabel;
    btnOk: TRzBitBtn;
    fndSTATUS: TcxRadioGroup;
    fndDUTY_USER: TzrComboBoxList;
    RzLabel6: TRzLabel;
    frfChangeOrder: TfrReport;
    Label40: TLabel;
    fndSHOP_ID: TzrComboBoxList;
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure actFindExecute(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure frfChangeOrderGetValue(const ParName: String; var ParValue: Variant);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure frfChangeOrderUserFunction(const Name: String; p1, p2, p3: Variant; var Val: Variant);
  private
    { Private declarations }
    oid:string;
    FCodeId: string;
    procedure SetCodeId(const Value: string);
    function  CheckCanExport: boolean; override;
    function GetfrfReport:TfrReport;
    function FindColumn(FieldName:string):TColumnEh;
  public
    { Public declarations }
    IsEnd: boolean;
    MaxId:string;
    function PrintSQL(tenantid,id:string):string;
    function GetFormClass:TFormClass;override;
    function EncodeSQL(id:string):string;
    procedure Open(Id:string);
    property CodeId:string read FCodeId write SetCodeId;
  end;

implementation
uses ufrmChangeOrder,ufrmFastReport,uFnUtil,uGlobal,uShopUtil,uXDictFactory,
  uShopGlobal;
{$R *.dfm}

{ TfrmStockOrderList }

function TfrmChangeOrderList.EncodeSQL(id: string): string;
var w:string;
begin
  w := 'where A.TENANT_ID=:TENANT_ID and A.SHOP_ID=:SHOP_ID and A.CHANGE_CODE='''+CodeId+''' and A.CHANGE_DATE>=:D1 and A.CHANGE_DATE<=:D2';
  if fndDUTY_USER.AsString <> '' then
     w := w +' and A.DUTY_USER=:DUTY_USER';
  if trim(fndCHANGE_ID.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndCHANGE_ID.Text)+'''';
  if fndSTATUS.ItemIndex > 0 then
     begin
       if fndSTATUS.ItemIndex=1 then
          w := w +' and A.CHK_DATE is null'
       else
          w := w +' and A.CHK_DATE is not null';
     end;
  if id<>'' then
     w := w +' and A.CHANGE_ID>'''+id+'''';
  result := 'select A.CHANGE_ID,A.CHANGE_DATE,A.GLIDE_NO,A.CHANGE_TYPE,A.REMARK,A.DUTY_USER,A.CHANGE_CODE,A.TENANT_ID,A.DEPT_ID,A.SHOP_ID,A.CREA_DATE,A.CREA_USER,CHANGE_AMT as AMOUNT,CHANGE_MNY as AMONEY '+
            'from STO_CHANGEORDER A '+w ;
  result := 'select ja.*,a.DEPT_NAME from ('+result+') ja left outer join CA_DEPT_INFO a on ja.TENANT_ID=a.TENANT_ID and ja.DEPT_ID=a.DEPT_ID';
  result := 'select jb.*,b.USER_NAME as DUTY_USER_TEXT from ('+result+') jb left outer join VIW_USERS b on jb.TENANT_ID=b.TENANT_ID and jb.DUTY_USER=b.USER_ID';
  result := 'select jc.*,c.USER_NAME as CREA_USER_TEXT from ('+result+') jc left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.CREA_USER=c.USER_ID';
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') jp order by CHANGE_ID';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by CHANGE_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') j order by CHANGE_ID limit 600';
  else
    result := 'select * from ('+result+') j order by CHANGE_ID';
  end;
end;

function TfrmChangeOrderList.GetFormClass: TFormClass;
begin
  result := TfrmChangeOrder;
end;

procedure TfrmChangeOrderList.Open(Id: string);
var
  rs:TZQuery;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then cdsList.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  cdsList.DisableControls;
  try
    rs.SQL.Text := EncodeSQL(Id);
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('SHOP_ID').AsString := fndSHOP_ID.AsString;
    rs.Params.ParamByName('D1').AsInteger := strtoint(formatdatetime('YYYYMMDD',D1.Date));
    rs.Params.ParamByName('D2').AsInteger := strtoint(formatdatetime('YYYYMMDD',D2.Date));
    if rs.Params.FindParam('DUTY_USER')<>nil then rs.Params.FindParam('DUTY_USER').AsString := fndDUTY_USER.AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('CHANGE_ID').AsString;
    if Id='' then
    begin
       rs.SaveToStream(sm);
       cdsList.LoadFromStream(sm);  
       cdsList.IndexFieldNames := 'GLIDE_NO';
    end
    else
    begin
       rs.SaveToStream(sm);
       cdsList.AddFromStream(sm);
    end;
    if rs.RecordCount <600 then IsEnd := True else IsEnd := false;
  finally
    cdsList.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmChangeOrderList.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);

end;

procedure TfrmChangeOrderList.FormCreate(Sender: TObject);
var
  rs:TZQuery;
  AObj:TRecord_;
begin
  inherited;
  fndSHOP_ID.KeyValue := Global.SHOP_ID;
  fndSHOP_ID.Text := Global.SHOP_NAME;
  fndSHOP_ID.DataSet := Global.GeTZQueryFromName('CA_SHOP_INFO');
  InitGridPickList(DBGridEh1);
  fndDUTY_USER.DataSet := Global.GeTZQueryFromName('CA_USERS');
  D1.Date := date();
  D2.Date := date();
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
    begin
      SetEditStyle(dsBrowse,fndSHOP_ID.Style);
      fndSHOP_ID.Properties.ReadOnly := True;
    end;
  if not ShopGlobal.GetChkRight('14500001',2) then
     DBGridEh1.Columns[6].Free;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '仓库名称';
    end;
end;

procedure TfrmChangeOrderList.DBGridEh1CellClick(Column: TColumnEh);
begin
  inherited;
  if cdsList.IsEmpty then Exit;

end;

procedure TfrmChangeOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');

end;

procedure TfrmChangeOrderList.actPriorExecute(Sender: TObject);
var
  Temp:TZQuery;
  Params:TftParamList;
begin
  inherited;
  if CurOrder <> nil then
     begin
        Params := TftParamList.Create(nil);
        try
          Params.ParamByName('SHOP_ID').asString := CurOrder.cid;
          Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
          Params.ParamByName('CREA_USER').asString := Global.UserID;
          if (CurOrder.gid = '') or (CurOrder.gid='..新增..') then
             Params.ParamByName('GLIDE_NO').asString := '9999999999999999'
          else
             Params.ParamByName('GLIDE_NO').asString := CurOrder.gid;
          Params.ParamByName('CHANGE_CODE').asString := CodeId;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TChangeOrderGetPrior',Params);
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
     end;
end;

procedure TfrmChangeOrderList.actNextExecute(Sender: TObject);
var
  Temp:TZQuery;
  Params:TftParamList;
begin
  inherited;
  if CurOrder <> nil then
     begin
        Params := TftParamList.Create(nil);
        try
          Params.ParamByName('SHOP_ID').asString := CurOrder.cid;
          Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
          Params.ParamByName('CREA_USER').asString := Global.UserID;
          if CurOrder.gid = '' then
             Params.ParamByName('GLIDE_NO').asString := '00000000000000'
          else
             Params.ParamByName('GLIDE_NO').asString := CurOrder.gid;
          Params.ParamByName('CHANGE_CODE').asString := CodeId;
          Temp := TZQuery.Create(nil);
          try
             Factor.Open(Temp,'TChangeOrderGetNext',Params);
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
     end;
end;

procedure TfrmChangeOrderList.actEditExecute(Sender: TObject);
begin
  if CodeId='1' then
     begin
       if not ShopGlobal.GetChkRight('14300001',3) then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
     end;
  if CodeId='2' then
     begin                        
       if not ShopGlobal.GetChkRight('14200001',3) then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
     end;
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('CHANGE_ID').AsString);
     end;
  if CurOrder<>nil then
     TfrmChangeOrder(CurOrder).CodeId := CodeId;
  inherited;

end;

procedure TfrmChangeOrderList.actDeleteExecute(Sender: TObject);
begin
  if CodeId='1' then  //损益单:
     begin
       if not ShopGlobal.GetChkRight('14300001',4) then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');
     end;
  if CodeId='2' then  //领用单:
     begin
       if not ShopGlobal.GetChkRight('14200001',4) then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');
     end;
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('CHANGE_ID').AsString,cdsList.FieldbyName('SHOP_ID').AsString);
     end;
  if CurOrder<>nil then
     TfrmChangeOrder(CurOrder).CodeId := CodeId;
  inherited;
  if (CurOrder<>nil) then
     begin
       if not CurOrder.saved then Exit;
       if (
          ((CodeId='1') and ShopGlobal.GetChkRight('14300001',2))
           or
          ((CodeId='2') and ShopGlobal.GetChkRight('14200001',2))
          )
          and (MessageBox(Handle,pchar('删除当前单据成功,是否继续新增'+Caption+'？'),pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurOrder.NewOrder
       else
          if rzPage.PageCount>2 then CurOrder.Close;
     end;
end;

procedure TfrmChangeOrderList.actSaveExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder<>nil) then
     begin
       if not CurOrder.saved then Exit;
       if (
          ((CodeId='1') and ShopGlobal.GetChkRight('14300001',2))
           or
          ((CodeId='2') and ShopGlobal.GetChkRight('14200001',2))
          )
          and (MessageBox(Handle,pchar('保存当前单据成功,是否继续新增'+Caption+'？'),pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurOrder.NewOrder
       else
          if rzPage.PageCount>2 then CurOrder.Close;
     end;

end;

procedure TfrmChangeOrderList.actAuditExecute(Sender: TObject);
begin
  if CodeId='1' then
     begin
       if not ShopGlobal.GetChkRight('14300001',5) then Raise Exception.Create('你没有审核'+Caption+'的权限,请和管理员联系.');
     end;
  if CodeId='2' then
     begin
       if not ShopGlobal.GetChkRight('14200001',5) then Raise Exception.Create('你没有审核'+Caption+'的权限,请和管理员联系.');
     end;
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('CHANGE_ID').AsString,cdsList.FieldbyName('COMP_ID').AsString);
     end;
  if CurOrder<>nil then
     TfrmChangeOrder(CurOrder).CodeId := CodeId;
  inherited;

end;

procedure TfrmChangeOrderList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('CHANGE_ID').AsString,cdsList.FieldbyName('TENANT_ID').AsString);
     end;

end;

function TfrmChangeOrderList.PrintSQL(tenantid, id: string): string;
begin
  result :=
   'select j.*,case when j.IS_PRESENT=2 then ''(兑换)'' when j.IS_PRESENT=1 then ''(赠送)'' else '''' end as IS_PRESENT_TEXT,'+
   '(select sum(CALC_MONEY) from STO_CHANGEDATA where TENANT_ID='+tenantid+' and CHANGE_ID=j.CHANGE_ID) as TOTAL_RTL_MNY '+
   'from ('+
   'select jl.*,l.DEPT_NAME from ('+
   'select jk.*,k.UNIT_NAME from ('+
   'select jj.*,j.COLOR_NAME as PROPERTY_02_TEXT from ('+
   'select ji.*,i.SIZE_NAME as PROPERTY_01_TEXT from ('+
   'select jh.*,h.GODS_NAME,h.GODS_CODE,h.BARCODE from ('+
   'select jg.*,g.SHOP_NAME,g.ADDRESS as SHOP_ADDR,g.TELEPHONE as SHOP_TELE,g.FAXES from ('+
   'select jf.*,f.USER_NAME as CREA_USER_TEXT from ('+
   'select je.*,e.USER_NAME as CHK_USER_TEXT from ('+
   'select jc.*,c.USER_NAME as DUTY_USER_TEXT from ('+
   'select jb.*,b.CHANGE_NAME from ('+
   'select A.*,B.AMOUNT,B.CALC_AMOUNT,B.COST_PRICE,B.APRICE,B.CALC_MONEY,B.SEQNO,B.PROPERTY_01,B.PROPERTY_02,B.UNIT_ID,B.BATCH_NO,B.GODS_ID,B.IS_PRESENT,B.REMARK as REMARK_DETAIL from STO_CHANGEORDER A,STO_CHANGEDATA B '+
   'where A.TENANT_ID=B.TENANT_ID and A.CHANGE_ID=B.CHANGE_ID and A.TENANT_ID='+tenantid+' and A.CHANGE_ID='''+id+''' ) jb '+
   'left outer join STO_CHANGECODE b on jb.CHANGE_CODE=b.CHANGE_CODE ) jc '+
   'left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.DUTY_USER=c.USER_ID ) je '+
   'left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CHK_USER=e.USER_ID ) jf '+
   'left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.CREA_USER=f.USER_ID ) jg '+
   'left outer join CA_SHOP_INFO g on jg.TENANT_ID=g.TENANT_ID and jg.SHOP_ID=g.SHOP_ID ) jh '+
   'left outer join VIW_GOODSINFO h on jh.TENANT_ID=h.TENANT_ID and jh.GODS_ID=h.GODS_ID ) ji '+
   'left outer join VIW_SIZE_INFO i on ji.TENANT_ID=i.TENANT_ID and ji.PROPERTY_01=i.SIZE_ID ) jj '+
   'left outer join VIW_COLOR_INFO j on jj.TENANT_ID=j.TENANT_ID and jj.PROPERTY_02=j.COLOR_ID ) jk '+
   'left outer join VIW_MEAUNITS k on jk.TENANT_ID=k.TENANT_ID and jk.UNIT_ID=k.UNIT_ID ) jl '+
   'left outer join CA_DEPT_INFO l on jl.TENANT_ID=l.TENANT_ID and jl.DEPT_ID=l.DEPT_ID ) j order by SEQNO';

end;

procedure TfrmChangeOrderList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if CodeId='1' then
     begin
       if not ShopGlobal.GetChkRight('14300001',6) then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
     end;
  if CodeId='2' then
     begin
       if not ShopGlobal.GetChkRight('14200001',6) then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
     end;
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurOrder<>nil then
           begin
             if CurOrder.oid = '' then Exit;
             if CurOrder.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             PrintReport(PrintSQL(inttostr(Global.TENANT_ID),CurOrder.oid),GetfrfReport);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             PrintReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('CHANGE_ID').AsString),GetfrfReport);
           end;
      finally
         free;
      end;
    end;

end;

procedure TfrmChangeOrderList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if CodeId='1' then
     begin
       if not ShopGlobal.GetChkRight('14300001',6) then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
     end;
  if CodeId='2' then
     begin
       if not ShopGlobal.GetChkRight('14200001',6) then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
     end;
  with TfrmFastReport.Create(Self) do
    begin
      try
        if CurOrder<>nil then
           begin
             if CurOrder.oid = '' then Exit;
             if CurOrder.dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
             ShowReport(PrintSQL(inttostr(Global.TENANT_ID),CurOrder.oid),GetfrfReport,nil,true);
           end
        else
           begin
             if cdsList.IsEmpty then Exit;
             ShowReport(PrintSQL(cdsList.FieldbyName('TENANT_ID').AsString,cdsList.FieldbyName('CHANGE_ID').AsString),GetfrfReport,nil,true);
           end;
      finally
         free;
      end;
    end;

end;

procedure TfrmChangeOrderList.actNewExecute(Sender: TObject);
begin
  if CodeId='1' then
     begin
       if not ShopGlobal.GetChkRight('14300001',2) then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
     end;
  if CodeId='2' then
     begin
       if not ShopGlobal.GetChkRight('14200001',2) then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
     end;
  inherited;
  if CurOrder<>nil then
     TfrmChangeOrder(CurOrder).CodeId := CodeId;
end;

procedure TfrmChangeOrderList.SetCodeId(const Value: string);
var rs:TZQuery;
begin
  FCodeId := Value;
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select CHANGE_CODE,CHANGE_NAME from STO_CHANGECODE where CHANGE_CODE='''+Value+''' and TENANT_ID in (0,'+inttostr(Global.TENANT_ID)+')';
    Factor.Open(rs);
    Caption := rs.Fields[1].AsString+'单';
    lblToolCaption.Caption := '当前位置->'+Caption;
    RzPage.Pages[0].Caption := Caption + '查询';
  finally
    rs.Free;
  end;
  Open('');
  GetfrfReport.Name := 'frfChangeOrder'+Value;
  if Value='2' then
     begin
       RzLabel6.Caption := '领 用 人';
       FindColumn('DUTY_USER_TEXT').Title.Caption := '领用人';
       FindColumn('DEPT_NAME').Title.Caption := '领用部门';
     end
  else
     begin
       RzLabel6.Caption := '经 手 人';
       FindColumn('DUTY_USER_TEXT').Title.Caption := '经手人';
       FindColumn('DEPT_NAME').Title.Caption := '损益部门';
     end;
end;

procedure TfrmChangeOrderList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if CodeId='1' then
     begin
//        if not ShopGlobal.GetChkRight('600030') then
           actInfo.OnExecute(nil)
//        else
//           actEdit.OnExecute(nil);
     end;
  if CodeId='2' then
     begin
//        if not ShopGlobal.GetChkRight('600023') then
           actInfo.OnExecute(nil)
//        else
//           actEdit.OnExecute(nil);
     end;

end;

procedure TfrmChangeOrderList.frfChangeOrderGetValue(const ParName: String;
  var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;

end;

procedure TfrmChangeOrderList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh1.canvas.Brush.Color := $0000F2F2;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmChangeOrderList.frfChangeOrderUserFunction(
  const Name: String; p1, p2, p3: Variant; var Val: Variant);
var small:real;
begin
  inherited;
  if UPPERCASE(Name)='SMALLTOBIG' then
     begin
       small := frParser.Calc(p1);
       Val := FnNumber.SmallTOBig(small);
     end;
end;

function TfrmChangeOrderList.CheckCanExport: boolean;
begin
  if trim(CodeId)='1' then
    result:=ShopGlobal.GetChkRight('14300001',7)
  else if trim(CodeId)='2' then
    result:=ShopGlobal.GetChkRight('14200001',7);
end;

function TfrmChangeOrderList.GetfrfReport: TfrReport;
var
  i:integer;
begin
  result := nil;
  for i:=0 to self.ComponentCount -1 do
    begin
      if self.Components[i] is TfrReport then
         begin
           result := TfrReport(Components[i]);
           break;
         end;
    end;
  if result = nil then Raise Exception.Create('没找到报表'); 
end;

function TfrmChangeOrderList.FindColumn(FieldName: string): TColumnEh;
var
  i:integer;
begin
  result := nil;
  for i:=0 to DBGridEh1.Columns.Count -1 do
    begin
      if lowercase(DBGridEh1.Columns[i].FieldName) = lowercase(FieldName) then
        begin
          result := DBGridEh1.Columns[i];
          Break;
        end;
    end;
end;

end.
