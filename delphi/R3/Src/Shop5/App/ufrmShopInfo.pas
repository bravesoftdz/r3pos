unit ufrmShopInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, ZBase, DB,
  DBClient, RzButton, RzCmboBx, Mask, RzEdit, cxMaskEdit, cxDropDownEdit,
  cxMemo, cxCalendar, cxButtonEdit,ADODB, zrComboBoxList,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmShopInfo = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    Label18: TLabel;
    edtLINKMAN: TcxTextEdit;
    Label16: TLabel;
    edtFAXES: TcxTextEdit;
    Label17: TLabel;
    edtTELEPHONE: TcxTextEdit;
    Label22: TLabel;
    edtADDRESS: TcxTextEdit;
    Label26: TLabel;
    edtREMARK: TcxMemo;
    Label20: TLabel;
    edtPOSTALCODE: TcxTextEdit;
    drpCompany: TADODataSet;
    RzPanel1: TRzPanel;
    Label1: TLabel;
    edtSHOP_ID: TcxTextEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtSHOP_NAME: TcxTextEdit;
    Label5: TLabel;
    Label8: TLabel;
    edtSHOP_TYPE: TcxComboBox;
    Label7: TLabel;
    Label6: TLabel;
    edtSHOP_SPELL: TcxTextEdit;
    Label25: TLabel;
    edtREGION_ID: TzrComboBoxList;
    cdsTable: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtSHOP_NAMEPropertiesChange(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    function GetLevelId: string;
    { Private declarations }
  public
    { Public declarations }
    AObj:TRecord_;
    Saved:boolean;
    ccid:string;
    procedure SetdbState(const Value: TDataSetState); override;
    procedure Open(code:string);
    procedure Append;
    procedure Edit(code:string);
    procedure Save;
    procedure WriteTo(AObj:TRecord_);
    class function AddDialog(Owner:TForm;var _AObj:TRecord_):boolean;
    class function EditDialog(Owner:TForm;id:string;var _AObj:TRecord_):boolean;
    class function ShowDialog(Owner:TForm;id:string):boolean;
    function  IsClose(str: string;str1:string): Boolean;//是否存在闭合路径问题
    function  IsEdit(Aobj:TRecord_;cdsTable:TZQuery):Boolean;//判断门店资料是否有修改
  end;
implementation
uses uShopUtil,uDsUtil,uFnUtil, uGlobal,uXDictFactory, uShopGlobal,ufrmShopMain,
  ufrmBasic;
{$R *.dfm}

{ TfrmCompanyInfo }

procedure TfrmShopInfo.Append;
//var rs:TADODataSet;
begin
  Open('');
  dbState := dsInsert;
  edtSHOP_ID.Text := TSequence.GetMaxID('',Factor,'SHOP_ID','CA_SHOP_INFO','000');
  edtSHOP_TYPE.ItemIndex := -1;
  if IntToStr(Global.SHOP_ID) = '' then
     begin
       edtSHOP_TYPE.ItemIndex := 0;
       {edtUPCOMP_ID.KeyValue := null;
       edtUPCOMP_ID.Text := '';
       Label9.Visible:=False;
       edtUPCOMP_ID.Visible:=False;
       Label10.Visible:=False;}
     end
  else
     begin
       {rs := TADODataSet.Create(nil);
       try
         rs.Close;
         rs.CommandText:='select SHOP_NAME,SHOP_TYPE from CA_SHOP_INFO where SHOP_ID='+QuotedStr(ccid);
         Factor.Open(rs);
         if (rs.FieldbyName('SHOP_TYPE').AsString<>'1') then Raise Exception.Create('只有经销商用户才能添加门店..');
         edtCOMP_TYPE.ItemIndex := 1;
         edtUPCOMP_ID.KeyValue := ccid;
         edtUPCOMP_ID.Text := rs.FieldByName('COMP_NAME').AsString;
         Label9.Visible:=True;
         edtUPCOMP_ID.Visible:=True;
         Label10.Visible:=True;
       finally
         rs.Free;
       end; }
     end;
  edtREGION_ID.KeyValue:='#';
  edtREGION_ID.Text:='无区域';
  if Visible and edtSHOP_NAME.CanFocus then edtSHOP_NAME.SetFocus;
end;

procedure TfrmShopInfo.Edit(code: string);
begin
  Open(code);
  dbState := dsEdit;
  {if edtUPCOMP_ID.AsString='' then
  begin
    Label9.Visible:=False;
    edtUPCOMP_ID.Visible:=False;
    Label10.Visible:=False;
    edtCOMP_TYPE.Enabled:=False;
  end;
  if not ShopGlobal.GetIsCompany(Global.UserID) then
  begin
    edtCOMP_TYPE.Enabled:=False;
    edtUPCOMP_ID.Enabled:=False;
  end;}
  if Visible and edtSHOP_NAME.CanFocus then edtSHOP_NAME.SetFocus;
end;

procedure TfrmShopInfo.FormCreate(Sender: TObject);
begin
  inherited;
  {ccid:=ShopGlobal.GetCOMP_ID(Global.UserID);
  if (ShopGlobal.GetIsCompany(Global.UserID)) and  (ccid<>Global.SHOP_ID) then
    ccid:=ccid
  else
    ccid:=Global.sh;}
  edtREGION_ID.DataSet:=Global.GetZQueryFromName('PUB_REGION_INFO');
  AObj := TRecord_.Create;
end;

procedure TfrmShopInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  AObj.Free;
end;

procedure TfrmShopInfo.Open(code: string);
var
  Params:TftParamList;
  //tmp:TADODataSet;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('SHOP_ID').asString := code;
    cdsTable.Close;
    Factor.Open(cdsTable,'TShop',Params);
    AObj.ReadFromDataSet(cdsTable);
    ReadFromObject(AObj,self);
    {tmp:=TADODataSet.Create(nil);
    try
      tmp.Close;
      tmp.CommandText:='select COMP_NAME from CA_COMPANY where COMP_TYPE=1 and COMP_ID='+QuotedStr(Aobj.FieldByName('UPCOMP_ID').AsString);
      Factor.Open(tmp);
      edtUPCOMP_ID.Text:=tmp.FieldByName('COMP_NAME').AsString;
    finally
      tmp.Free;
    end;
    edtUPCOMP_ID.Visible := cdsTable.IsEmpty or (cdsTable.FieldbyName('UPCOMP_ID').AsString<>'');
    Label9.Visible:=cdsTable.IsEmpty or (cdsTable.FieldbyName('UPCOMP_ID').AsString<>'');
    Label10.Visible:=cdsTable.IsEmpty or (cdsTable.FieldbyName('UPCOMP_ID').AsString<>'');}
    dbState := dsBrowse;
  finally
    Params.Free;
  end;
end;

function TfrmShopInfo.GetLevelId:string;
var
 rs:TADODataSet;
 pid:string;
begin
// rs := Global.GetADODataSetFromName('CA_COMPANY');
 {rs:=TADODataSet.Create(nil);
 rs.Close;
 rs.CommandText:='select COMP_ID,UPCOMP_ID from CA_COMPANY where COMP_TYPE=1';
 Factor.Open(rs);
 pid := edtUPCOMP_ID.AsString;
 result := '';
 while rs.Locate('COMP_ID',pid,[]) do
   begin
     result := rs.FieldbyName('COMP_ID').AsString + result;
     pid := rs.FieldbyName('UPCOMP_ID').AsString;
   end;
 result := result + edtCOMP_ID.Text;}
end;

procedure TfrmShopInfo.Save;
 procedure UpdateToGlobal(AObj:TRecord_);
   begin
      {Global.RefreshTable('CA_COMPANY');
      if Global.CompanyID = AObj.FieldbyName('COMP_ID').AsString then
      begin
        Global.CompanyName := AObj.FieldbyName('COMP_NAME').AsString;
        frmShopMain.lblUserInfo.Caption := '欢使你:'+Global.UserName+' 登录门店：'+Global.CompanyName;
      end;
      Global.RefreshTable('CA_COMPANY_SELF'); }
   end;
 procedure UpdateToGlobalCustomer(AObj:TRecord_);
   var Temp:TADODataSet;
   begin
      {Temp := Global.GetADODataSetFromName('BAS_CUSTOMER');
      Temp.Filtered :=false;
      if not Temp.Locate('CUST_ID',edtCOMP_ID.Text,[]) then
        Temp.Append
      else
        Temp.Edit;
      Temp.FieldByName('CUST_ID').AsString:=edtCOMP_ID.Text;
      Temp.FieldByName('CUST_CODE').AsString:=edtCOMP_ID.Text;
      Temp.FieldByName('CUST_NAME').AsString:=edtCOMP_NAME.Text;
      Temp.FieldByName('CUST_SPELL').AsString:=edtCOMP_SPELL.Text;
      Temp.FieldByName('IC_CARDNO').AsString:=edtCOMP_ID.Text;
      Temp.FieldByName('LINKMAN').AsString:=edtLINKMAN.Text;
      Temp.FieldByName('ADDRESS').AsString:=edtADDRESS.Text;
      Temp.Post; }
   end;
 procedure UpdateToGlobalClient(AObj:TRecord_);
   var Temp:TADODataSet;
   begin
      {Temp := Global.GetADODataSetFromName('BAS_CLIENTINFO');
      Temp.Filtered :=false;
      if not Temp.Locate('CLIENT_ID',edtCOMP_ID.Text,[]) then
        Temp.Append
      else
        Temp.Edit;
      Temp.FieldByName('CLIENT_ID').AsString:=edtCOMP_ID.Text;
      Temp.FieldByName('CLIENT_CODE').AsString:=edtCOMP_ID.Text;
      Temp.FieldByName('CLIENT_NAME').AsString:=edtCOMP_NAME.Text;
      Temp.FieldByName('CLIENT_SPELL').AsString:=edtCOMP_SPELL.Text;
      Temp.FieldByName('LINKMAN').AsString:=edtLINKMAN.Text;
      Temp.FieldByName('ADDRESS').AsString:=edtADDRESS.Text;      
      Temp.Post; }
   end;
var tmp:TZQuery;
    i,j:integer;
    UPCOMP_ID:string;
begin
  if trim(edtSHOP_NAME.Text)='' then
  begin
    if edtSHOP_NAME.CanFocus then edtSHOP_NAME.SetFocus;
    raise Exception.Create('门店名称不能为空！');
  end;
  {if trim(edtCOMP_SPELL.Text)='' then
  begin
    if edtCOMP_SPELL.CanFocus then edtCOMP_SPELL.SetFocus;
    raise Exception.Create('拼音码不能为空！');
  end; }
  if trim(edtSHOP_TYPE.Text)='' then
  begin
    if edtSHOP_TYPE.CanFocus then edtSHOP_TYPE.SetFocus;
    raise Exception.Create('门店类型不能为空！');
  end;
  if edtSHOP_TYPE.ItemIndex=-1 then
  begin
    if edtSHOP_TYPE.CanFocus then edtSHOP_TYPE.SetFocus;
    raise Exception.Create('请重新选择正确的门店类型！');
  end;
  {if edtUPCOMP_ID.Visible and (trim(edtUPCOMP_ID.AsString)='') then
  begin
    if edtUPCOMP_ID.CanFocus then edtUPCOMP_ID.SetFocus;
    raise Exception.Create('隶属经销商不能为空！');
  end;}
  tmp:=TZQuery.Create(nil);
  tmp.Close;
  tmp.SQL.Text:='select SHOP_ID,SHOP_NAME from CA_SHOP_INFO where COMM<>''02'' and COMM<>''12''';
  //tmp.CommandText:='select COMP_ID,UPCOMP_ID,COMP_NAME from CA_COMPANY where COMM<>''02'' and COMM<>''12''';
  Factor.Open(tmp);
  if dbState=dsInsert then
  begin
      if tmp.Locate('SHOP_NAME',trim(edtSHOP_NAME.Text),[]) then
      begin
        if edtSHOP_NAME.CanFocus then edtSHOP_NAME.SetFocus;
        raise  Exception.Create('门店名称已经存在，不能重复！');
      end;
  end;
  if dbState=dsEdit then
  begin
      tmp.First;
      while not tmp.Eof do
      begin
        if (tmp.FieldByname('SHOP_NAME').AsString=trim(edtSHOP_NAME.Text)) and (tmp.FieldByname('SHOP_ID').AsString<>trim(edtSHOP_ID.Text)) then
        begin
          if edtSHOP_NAME.CanFocus then edtSHOP_NAME.SetFocus;
          raise  Exception.Create('门店名称已经存在，不能重复！');
        end;
        tmp.Next;
      end;
      {if tmp.Locate('UPCOMP_ID',edtCOMP_ID.Text,[]) and (edtCOMP_TYPE.ItemIndex<>0) then
      begin
        if edtCOMP_TYPE.CanFocus then edtCOMP_TYPE.SetFocus;
        raise Exception.Create('有下级门店，经营方式必须是经销商！');
      end;}
  end;
  WriteTo(AObj);
  if AObj.FieldByName('SEQ_NO').AsString = '' then
     AObj.FieldByName('SEQ_NO').AsString := AObj.FieldByName('SHOP_ID').AsString;
  //判断档案是否有修改
  if not IsEdit(Aobj,cdsTable) then Exit;
  cdsTable.Edit;
  AObj.WriteToDataSet(cdsTable);
  cdsTable.Post;
  //闭合算法判断隶属经销商不能是自己
  if dbState=dsInsert then
  begin
    //UpdateToGlobal(AObj);
    {if IsClose(edtCOMP_ID.Text,edtCOMP_ID.Text) then
    begin
      if tmp.Locate('COMP_ID',edtCOMP_ID.Text,[]) then tmp.Delete;
      tmp.UpdateBatch(arAll);
      if edtUPCOMP_ID.CanFocus then edtUPCOMP_ID.SetFocus;
      raise Exception.Create('隶属经销商关系维护不正确,请核对是否输入有误！');
    end;}
  end;
  if dbState=dsEdit then
  begin
    {if tmp.Locate('SHOP_ID',edtSHOP_ID.Text,[]) then
    begin
      UPCOMP_ID:=tmp.FieldbyName('UPCOMP_ID').asString;
      tmp.Edit;
      tmp.FieldbyName('UPCOMP_ID').asString:=edtUPCOMP_ID.AsString;
      tmp.Post;
    end;
    if IsClose(edtCOMP_ID.Text,edtCOMP_ID.Text) then
    begin
      if tmp.Locate('COMP_ID',edtCOMP_ID.Text,[]) then
      begin
        tmp.Edit;
        tmp.FieldbyName('UPCOMP_ID').asString:=UPCOMP_ID;
        tmp.Post;
      end;
      if edtUPCOMP_ID.CanFocus then edtUPCOMP_ID.SetFocus;
      raise Exception.Create('隶属经销商关系维护不正确,请核对是否输入有误！');
    end;}
  end;
  if Factor.UpdateBatch(cdsTable,'TSHOP',nil) then
  begin
     UpdateToGlobal(Aobj);
     UpdateToGlobalCustomer(Aobj);
     UpdateToGlobalClient(Aobj);
  end;
  dbState := dsBrowse;
  Saved := true;
end;

procedure TfrmShopInfo.btnOkClick(Sender: TObject);
var bl:Boolean;
begin
  inherited;
  if trim(edtSHOP_NAME.Text)='初始登录' then
     begin
       if edtSHOP_NAME.CanFocus then edtSHOP_NAME.SetFocus;
       Raise Exception.Create('请正确输入门店名称');
     end;
  bl:=(dbState<>dsEdit);
  Save;
  if Saved and Assigned(OnSave) then OnSave(AObj);
  if Saved and Assigned(OnSave) and bl then //继续新增
  begin
    if MessageBox(Handle,'是否继续新增门店?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
       Append
    else
      ModalResult := MROK;
  end
  else
    ModalResult := MROK;
end;

procedure TfrmShopInfo.edtSHOP_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  if dbState<>dsBrowse then
     edtSHOP_SPELL.Text := fnString.GetWordSpell(edtSHOP_NAME.Text,3);
end;

procedure TfrmShopInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  Label4.Visible:=true;
  Label6.Visible:=true;
  Label8.Visible:=true;

  btnOk.Visible := (Value<>dsBrowse);
  case Value of
  dsInsert:Caption := '门店档案--(新增)';
  dsEdit:Caption := '门店档案--(修改)';
  else
      begin
        Caption := '门店档案';
        Label4.Visible:=False;
        Label6.Visible:=False;
        Label8.Visible:=False;

      end;
  end;
end;

class function TfrmShopInfo.AddDialog(Owner: TForm;var _AObj: TRecord_): boolean;
begin
   {if not ShopGlobal.GetChkRight('100004') then Raise Exception.Create('你没有新增门店的权限,请和管理员联系.');}
   with TfrmShopInfo.Create(Owner) do
    begin
      try
        Append;
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

procedure TfrmShopInfo.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmShopInfo.IsEdit(Aobj: TRecord_;
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

function TfrmShopInfo.IsClose(str, str1: string): Boolean;
var tmp:TZQuery;
    ls:TStringList;
    i:integer;
begin
  result:=False;
  tmp:=Global.GetZQueryFromName('CA_SHOP_INFO');
  tmp.Filtered:=False;
  tmp.Filter:=' UPCOMP_ID='+QuotedStr(str);
  tmp.Filtered:=True;
  ls:=TStringList.Create;
  try
    tmp.First;
    while not tmp.Eof do
    begin
      ls.Add(tmp.FieldByName('SHOP_ID').AsString);
      tmp.Next;
    end;
    for i:=0 to ls.Count-1 do
    begin
      if ls.Strings[i]='' then continue;
      if ls.Strings[i]=str1 then result:=True
      else result := IsClose(ls.Strings[i],str1);
      if result then Exit;
    end;
  finally
    ls.Free;
  end;

end;

class function TfrmShopInfo.EditDialog(Owner:TForm;id:string;var _AObj:TRecord_): boolean;
begin
   {if not ShopGlobal.GetChkRight('100005') then Raise Exception.Create('你没有修改门店的权限,请和管理员联系.');}
   with TfrmShopInfo.Create(Owner) do
    begin
      try
        Edit(id);
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

procedure TfrmShopInfo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  try
   if not((dbState = dsInsert) and (trim(edtSHOP_NAME.Text)='')) then
   begin
      WriteTo(AObj);
      if not IsEdit(Aobj,cdsTable) then Exit;
      i:=MessageBox(Handle,'门店档案有修改，是否保存修改信息？',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
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

procedure TfrmShopInfo.WriteTo(AObj: TRecord_);
begin
  WriteToObject(AObj,self);
  Aobj.FieldByName('SHOP_ID').AsString:=edtSHOP_ID.Text;
  //Aobj.FieldByName('LEVEL_ID').AsString:=GetLevelId;
end;

procedure TfrmShopInfo.FormShow(Sender: TObject);
begin
  inherited;
  if edtSHOP_NAME.CanFocus then edtSHOP_NAME.SetFocus;
end;

class function TfrmShopInfo.ShowDialog(Owner: TForm;
  id: string): boolean;
begin
   with TfrmShopInfo.Create(Owner) do
    begin
      try
        Open(id);
        if ShowModal=MROK then
        begin
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;

end.
