unit ufrmBatchNoInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  StdCtrls, RzLabel, RzButton, cxMemo, cxControls, cxContainer, cxEdit,
  cxTextEdit, ZBase, cxRadioGroup, DB, cxDropDownEdit,
  cxCalendar, cxMaskEdit, cxButtonEdit, zrComboBoxList, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmBatchNoInfo = class(TframeDialogForm)
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    lab_REMARK: TRzLabel;
    RzLabel1: TRzLabel;
    lab_ACCOUNT: TRzLabel;
    edtBATCH_NO: TcxTextEdit;
    lab_USER_NAME: TRzLabel;
    edtREMARK: TcxMemo;
    RzLabel2: TRzLabel;
    cdsTable: TZQuery;
    RzLabel5: TRzLabel;
    RzLabel7: TRzLabel;
    edtGODS_ID: TzrComboBoxList;
    labBIRTHDAY: TRzLabel;
    edtFACT_DATE: TcxDateEdit;
    lab_WORK_DATE: TRzLabel;
    edtVILD_DATE: TcxDateEdit;
    procedure Btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    //ccid:string;
    Aobj:TRecord_;
    Saved:Boolean;
    procedure SetdbState(const Value: TDataSetState); override;
    procedure Open(code:string;godsid:string);
    procedure Append;
    procedure Edit(code:string;godsid:string);
    procedure Save;
    procedure Writeto(Aobj:TRecord_);
    function  IsEdit(Aobj:TRecord_;cdsTable:TZQuery):Boolean;//判断会员档案是否有修改
    class function AddDialog(Owner:TForm;var _AObj:TRecord_;gid:string):boolean;
    class function EditDialog(Owner:TForm;id,gid:string;var _AObj:TRecord_):boolean;
    class function ShowDialog(Owner:TForm;id,gid:string):boolean;
  end;

implementation
uses uShopUtil,uDsUtil,ufrmBasic,Math,uGlobal,uFnUtil,uShopGlobal;//
{$R *.dfm}

procedure TfrmBatchNoInfo.Append;
begin
  Open('','');
  dbState := dsInsert;
  edtGODS_ID.KeyValue := '#';
  edtGODS_ID.Text := '无';
end;

procedure TfrmBatchNoInfo.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBatchNoInfo.Edit(code: string;godsid:string);
begin
  Open(code,godsid);
  dbState := dsEdit;
end;

procedure TfrmBatchNoInfo.FormCreate(Sender: TObject);
begin
  inherited;
  edtGODS_ID.DataSet:=Global.GetZQueryFromName('PUB_GOODSINFO');
  Aobj := TRecord_.Create;
end;

procedure TfrmBatchNoInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  Aobj.Free;
  Freeform(Self);
end;

procedure TfrmBatchNoInfo.Open(code: string;godsid:string);
var
  Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('BATCH_NO').asString := code;
    Params.ParamByName('GODS_ID').asString := godsid;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsTable.Close;
    Factor.Open(cdsTable,'TBatchNo',Params);
    Aobj.ReadFromDataSet(cdsTable);
    ReadFromObject(Aobj,Self);
    dbState := dsBrowse;
  finally
    Params.Free;
  end;
end;

procedure TfrmBatchNoInfo.Save;
var temp,tmp,tmp1:TZQuery;
    j:integer;
begin
  if dbState=dsBrowse then exit;
  if trim(edtBATCH_NO.Text)='' then
  begin
    if edtBATCH_NO.CanFocus then edtBATCH_NO.SetFocus;
    raise Exception.Create('批号不能为空！');
  end;
  if edtGODS_ID.AsString='' then
     begin
       edtGODS_ID.KeyValue := '#';
       edtGODS_ID.Text := '无';
     end;
  //检测结束
  Writeto(Aobj);
  cdsTable.Edit;
  Aobj.WriteToDataSet(cdsTable);
  cdsTable.Post;
  Factor.UpdateBatch(cdsTable,'TBatchNo',nil);
  dbState:=dsBrowse;
  Saved:=True;
end;

procedure TfrmBatchNoInfo.Btn_SaveClick(Sender: TObject);
var bl:boolean;
begin
  inherited;
  bl:=(dbState<>dsEdit);
  Save;
  If Saved and Assigned(OnSave) then OnSave(Aobj);
  If Saved and Assigned(OnSave) and bl then
  begin
    if MessageBox(Handle,'是否继续新增批号?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
      Append
    else
      ModalResult := MROK;
  end
  else
    ModalResult := MROK;
end;

procedure TfrmBatchNoInfo.FormShow(Sender: TObject);
begin
  inherited;
  if edtBATCH_NO.CanFocus then edtBATCH_NO.SetFocus;
  RzPage.ActivePageIndex := 0;
end;

procedure TfrmBatchNoInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  Btn_Save.Visible := (value<>dsBrowse);
  case dbState of
  dsInsert:Caption:='批号档案--(新增)';
  dsEdit:Caption:='批号档案--(修改)';
  else
    begin
      Caption:='批号档案';
    end;
  end;
end;

function TfrmBatchNoInfo.IsEdit(Aobj: TRecord_;
  cdsTable: TZQuery): Boolean;
var i:integer;
begin
  Result:=False;
  for i:=0 to cdsTable.FieldCount-1 do
  begin
    if AObj.Fields[i].AsString<>cdsTable.Fields[i].AsString then
    begin
      Result:=True;
      break;
    end;
  end;
end;

procedure TfrmBatchNoInfo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  try
   if not((dbState = dsInsert) and (trim(edtBATCH_NO.Text)='')) then
   begin
    WriteTo(AObj);
    if not IsEdit(Aobj,cdsTable) then Exit;
    i:=MessageBox(Handle,'批号档案有修改，是否保存修改信息？',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
    if i=6 then
       begin
         Save;
         if Saved and Assigned(OnSave) then OnSave(AObj);
       end;
    if i=2 then abort;
   end;
  except
    CanClose := false;
    Raise;
  end;
end;

procedure TfrmBatchNoInfo.Writeto(Aobj: TRecord_);
begin
  WriteToObject(Aobj,self);
  AObj.FieldbyName('TENANT_ID').asInteger := Global.TENANT_ID;
end;

class function TfrmBatchNoInfo.AddDialog(Owner: TForm;
  var _AObj: TRecord_;gid:string): boolean;
begin
   if not ShopGlobal.GetChkRight('100002513',2) then Raise Exception.Create('你没有新增批号的权限,请和管理员联系.');
   with TfrmBatchNoInfo.Create(Owner) do
    begin
      try
        Append;
        edtGODS_ID.KeyValue := gid;
        if edtGODS_ID.DataSet.Locate('GODS_ID',gid,[]) then
           edtGODS_ID.Text := edtGODS_ID.DataSet.FieldbyName('GODS_NAME').AsString;
        if ShowModal=MROK then
        begin
          AObj.CopyTo(_AObj);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;

class function TfrmBatchNoInfo.EditDialog(Owner: TForm; id,gid: string;
  var _AObj: TRecord_): boolean;
begin
   if not ShopGlobal.GetChkRight('100002513',3) then Raise Exception.Create('你没有修改批号的权限,请和管理员联系.');
   with TfrmBatchNoInfo.Create(Owner) do
    begin
      try
        Edit(id,gid);
        if ShowModal=MROK then
        begin
          AObj.CopyTo(_AObj);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;

class function TfrmBatchNoInfo.ShowDialog(Owner: TForm; id,gid: string): boolean;
begin
   with TfrmBatchNoInfo.Create(Owner) do
    begin
      try
        Open(id,gid);
        ShowModal;
      finally
        free;
      end;
    end;
end;

end.
