{  12200001	0	商品促销 	1	查询	2	新增	3	修改	4	删除	5	审核	6	打印	7	导出    }

unit ufrmPriceOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderToolForm, DB, ActnList, Menus, ComCtrls, ToolWin,
  StdCtrls, RzLabel, Grids, DBGridEh, ExtCtrls, RzTabs, RzPanel, cxCalendar, 
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxButtonEdit, zrComboBoxList, RzButton, cxRadioGroup, ZBase, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmPriceOrderList = class(TframeOrderToolForm)
    ToolButton11: TToolButton;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel5: TRzLabel;
    fndPROM_ID: TcxTextEdit;
    Label1: TLabel;
    btnOk: TRzBitBtn;
    fndSTATUS: TcxRadioGroup;
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
  private
    oid:string;
    procedure AddGridPRICE_IDItems;  //添加PRICE_ID的Items
    function  CheckCanExport: boolean; override; //判断导出权限
  public
    IsEnd: boolean;
    MaxId:string;
    function GetFormClass:TFormClass;override;
    function EncodeSQL(id:string):string;
    procedure Open(Id:string);
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
var w,viwName:string;
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
  viwName:='(select PROM_ID,GLIDE_NO,BEGIN_DATE,END_DATE,REMARK,PRICE_ID,TENANT_ID from SAL_PRICEORDER '+w+') A '+
       ' left join (select PROM_ID,Count(*) as GOODSum From SAL_PRICEDATA where TENANT_ID=:TENANT_ID Group by PROM_ID)B on A.PROM_ID=B.PROM_ID '+
       ' left join (select PROM_ID,count(*) as ShopSum From SAL_PROM_SHOP where TENANT_ID=:TENANT_ID Group by PROM_ID)C on A.PROM_ID=C.PROM_ID ';
  case Factor.iDbType of
   0,3:result:='select top 600 A.*,B.GoodSum as GoodSum,C.ShopSum as ShopSum from '+viwName+' order by A.PROM_ID';
   1: result:='  ';
   4: result:='select tp.* from (select A.*,B.GoodSum as GoodSum,C.ShopSum as ShopSum from '+viwName+' order by A.PROM_ID) tp fetch first 600  rows only ';
   5: result:='select A.*,B.GoodSum as GoodSum,C.ShopSum as ShopSum From ('+viwName+') order by A.PROM_ID LIMIT 600 ';
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
begin
  inherited;
  InitGridPickList(DBGridEh1);
  AddGridPRICE_IDItems;  //添加PRICE_ID的Items
  D1.Date := date();
  D2.Date := date();
end;

procedure TfrmPriceOrderList.FormShow(Sender: TObject);
begin
  inherited;
  Open(''); 
end;

procedure TfrmPriceOrderList.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');  
end;

procedure TfrmPriceOrderList.actPriorExecute(Sender: TObject);
var
  Temp:TZQuery;
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
          Temp := TZQuery.Create(nil);
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
     end;
end;

procedure TfrmPriceOrderList.actNextExecute(Sender: TObject);
var
  Temp:TZQuery;
  Params:TftParamList;
begin
  inherited;
  if CurOrder <> nil then
     begin
        Params := TftParamList.Create(nil);
        try
          Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
          Params.ParamByName('CREA_USER').asString := Global.UserID;
          if CurOrder.gid = '' then
             Params.ParamByName('GLIDE_NO').asString := '00000000000000'
          else
             Params.ParamByName('GLIDE_NO').asString := CurOrder.gid;
          Temp := TZQuery.Create(nil);
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
     end;
end;

procedure TfrmPriceOrderList.actEditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('12200001',3) then Raise Exception.Create('你没有修改促销单的权限,请和管理员联系.');
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('PROM_ID').AsString);
     end;
  inherited;

end;

procedure TfrmPriceOrderList.actDeleteExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('12200001',4) then Raise Exception.Create('你没有删除促销单的权限,请和管理员联系.');
  if (CurOrder=nil) then
     begin
       if cdsList.IsEmpty then Exit;
       OpenForm(cdsList.FieldbyName('PROM_ID').AsString);
     end;
  inherited;
  if (CurOrder<>nil) then
     begin
       if not CurOrder.saved then Exit;
       if ShopGlobal.GetChkRight('12200001',2) and (MessageBox(Handle,'删除当前单据成功,是否继续新增促销单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
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
       if ShopGlobal.GetChkRight('12200001',2) and (MessageBox(Handle,'是否继续新增促销单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
          CurOrder.NewOrder
       else
          if rzPage.PageCount>2 then CurOrder.Close;
     end;
end;

procedure TfrmPriceOrderList.actAuditExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('12200001',5) then Raise Exception.Create('你没有审核促销单的权限,请和管理员联系.');
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

procedure TfrmPriceOrderList.actNewExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('12200001',2) then Raise Exception.Create('你没有新增促销单的权限,请和管理员联系.');
  inherited;

end;

procedure TfrmPriceOrderList.actPrintExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('12200001',6) then Raise Exception.Create('你没有打印促销单的权限,请和管理员联系.');
  inherited;

end;

procedure TfrmPriceOrderList.actPreviewExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('12200001',6) then Raise Exception.Create('你没有打印促销单的权限,请和管理员联系.');
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

procedure TfrmPriceOrderList.AddGridPRICE_IDItems;
var
  rs: TZQuery;
  CurCol: TColumnEh;
begin
  CurCol:=FindColumn(DBGridEh1,'PRICE_ID');
  if CurCol=nil then Exit;
  CurCol.KeyList.Clear;
  CurCol.PickList.Clear;
  rs:=ShopGlobal.GetZQueryFromName('PUB_PRICEGRADE');
  if (rs<>nil) and (rs.Active) then
  begin
    CurCol.KeyList.Add('#');
    CurCol.PickList.Add('所有客户');
    rs.First;
    while not rs.Eof do
    begin
      CurCol.KeyList.Add(rs.fieldbyName('PRICE_ID').AsString);
      CurCol.PickList.Add(rs.fieldbyName('PRICE_NAME').AsString);
      rs.Next;
    end;
  end;
end;

function TfrmPriceOrderList.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('12200001',7);
end;

end.
