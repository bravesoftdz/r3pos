unit ufrmRoleRights;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  jpeg, StdCtrls, RzButton, ComCtrls, RzTreeVw,ADODB,DB, zBase, DBClient,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGridEh,
  cxControls, cxContainer, cxEdit, cxCheckBox;

type
  TfrmRoleRights = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    Label26: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    rzCheckTree: TRzCheckTree;
    Panel1: TPanel;
    RoleRight: TZQuery;
    OPcds: TZQuery;
    Ca_Modle: TZQuery;
    Label3: TLabel;
    TabSheet2: TRzTabSheet;
    RzPanel1: TRzPanel;
    DBGridEh3: TDBGridEh;
    CdsDataRight: TZQuery;
    DsDataRight: TDataSource;
    Label4: TLabel;
    Image2: TImage;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel2: TPanel;
    ChkRights: TcxCheckBox;
    procedure btnCloseClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rzCheckTreeCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure rzCheckTreeStateChanging(Sender: TObject; Node: TTreeNode;
      NewState: TRzCheckState; var AllowChange: Boolean);
    procedure rzCheckTreeStateChange(Sender: TObject; Node: TTreeNode;
      NewState: TRzCheckState);
    procedure ChkRightsPropertiesChange(Sender: TObject);
  private
    Role_ID:string;
    RIGHTData:String;
    FModiRight: boolean;
    procedure SetModiRight(const Value: boolean);
    procedure GetOPRight;  //返回当前操作员的所拥有权限数据包 [ 限制他能授权的在其所拥有权限范围内 ]
  public
    ccid:string;
    locked:Boolean;
    procedure InitCheckTree; //初始化CheckTree树
    procedure InitParent(Node:TTreeNode); //初始化CheckTree可用授权最大范围
    procedure InitialParams(InRole_ID,Role_NAME,REMARK:string); //初始化参数
    procedure OpenRight;  //传入DutyID返回Role的权限List
    procedure SaveRight;
    procedure OpenDataRight;
    procedure SaveDataRight;
    property ModiRight:boolean read FModiRight write SetModiRight;
  end;

var
  frmRoleRights: TfrmRoleRights;

implementation

uses uDsUtil,uGlobal,uTreeUtil,uShopGlobal, ufrmBasic;

{$R *.dfm}

procedure TfrmRoleRights.btnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

//始
procedure TfrmRoleRights.InitCheckTree;
var
  i:integer;
begin
  try
    Ca_Modle.Close;
    Ca_Modle.SQL.Text:='select MODU_ID,MODU_TYPE,MODU_NAME,LEVEL_ID,SEQNO,0 as Tag,0 as CheckFlag from CA_MODULE where PROD_ID=:PROD_ID and MODU_TYPE in (1,2) and COMM not in (''02'',''12'') order by LEVEL_ID';
    if Ca_Modle.Params.FindParam('PROD_ID')<>nil then
      Ca_Modle.ParamByName('PROD_ID').AsString:=ProductID;
    Factor.Open(Ca_Modle);
    CreateLevelTree(Ca_Modle,rzCheckTree,'333333','MODU_ID','MODU_NAME','LEVEL_ID');
    if Global.UserID<>'admin' then InitParent(nil);
    if rzCheckTree.Items.Count>0 then
      rzCheckTree.TopItem.Selected:=True;
  finally
  end;
end;

procedure TfrmRoleRights.InitialParams(InRole_ID, Role_NAME, REMARK: string);
begin
  ROLE_ID:=InRole_ID;
  Label1.Caption:=Role_NAME;
  Label7.Caption := Role_NAME;

  Label2.Caption:=REMARK;
  {
  ccid:=ShopGlobal.GetCOMP_ID(Global.UserID);
  if (ShopGlobal.GetIsCompany(Global.UserID)) and  (ccid<>Global.CompanyID) then
    ccid:=ccid
  else
    ccid:=Global.CompanyID; }
end;

procedure TfrmRoleRights.btnOkClick(Sender: TObject);
begin
  inherited;
  SaveRight;
  SaveDataRight;
  ModalResult:=MROK;
end;

procedure TfrmRoleRights.OpenRight;
var
  ID:string;
  i,SEQUNo:integer;
  Params:TftParamList;
begin
  locked:=True;
  try
    Params:=TftParamList.Create(nil);
    Params.ParamByName('ROLE_ID').asString:=ROLE_ID;
    Params.ParamByName('TENANT_ID').AsInteger :=Global.TENANT_ID;
    Factor.Open(RoleRight,'TRoleRigths',Params);
    for i:=0 to rzCheckTree.Items.Count -1 do
    begin
      SEQUNo:=TRecord_(rzCheckTree.Items[i].Data).FieldbyName('SEQNo').AsInteger;
      if (SEQUNo>0) and (rzCheckTree.Items[i].Parent<>nil) then
      begin          
        ID := TRecord_(rzCheckTree.Items[i].Parent.Data).FieldbyName('MODU_ID').AsString;
        if ShopGlobal.GetOperRight(RoleRight, SEQUNo,'MODU_ID='''+ID+'''') then
          rzCheckTree.ItemState[i] := csChecked
        else
          rzCheckTree.ItemState[i] := csUnChecked;
      end;
    end;
    ModiRight := false;
  finally
    Params.Free;
    locked:=False;
  end;
end;

procedure TfrmRoleRights.FormShow(Sender: TObject);
begin
  inherited;
  RIGHTData := '';
  GetOPRight;     //返回当前操作员的所拥有权限数据包 [ 限制他能授权的在其所拥有权限范围内 ]
  InitCheckTree;
  OpenRight;
  DBGridEh3.Enabled := False;
  OpenDataRight;
  rzCheckTree.SetFocus;
  if rzCheckTree.Items.Count>0 then rzCheckTree.TopItem.Selected:=True;
  RzPage.ActivePageIndex := 0;
end;

procedure TfrmRoleRights.rzCheckTreeCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
var nNode:TTreeNode;
begin
  inherited;
//  if Global.UserID<>'admin' then
  begin
//    if Node.HasChildren then exit;
    if TRecord_(Node.Data).FieldByName('Tag').AsString='1'  then
    begin
      //TRecord_(Node.Data).FieldByName('Tag').AsString:='1';
      rzCheckTree.Canvas.Font.Color := clBtnShadow;
      //nNode:=Node.Parent;
      //while (nNode<>nil) do
      //begin
      //  TRecord_(nNode.Data).FieldByName('Tag').AsString:='1';
      //  nNode:=nNode.Parent;
      //end;
    end;
  end;
end;

procedure TfrmRoleRights.rzCheckTreeStateChanging(Sender: TObject;
  Node: TTreeNode; NewState: TRzCheckState; var AllowChange: Boolean);
begin
  inherited;
  rzCheckTree.CascadeChecks:=True;
  if locked then exit;
  if  Global.UserID<>'admin' then
  begin
    if (TRecord_(Node.Data).FieldByName('Tag').AsString='1')  then
    begin
      rzCheckTree.CascadeChecks:=False;
      AllowChange:=False;
    end
    else rzCheckTree.CascadeChecks:=True;
  end;
end;

procedure TfrmRoleRights.rzCheckTreeStateChange(Sender: TObject;  Node: TTreeNode; NewState: TRzCheckState);
begin
  inherited;
  if locked then exit;
  ModiRight := true;
end;

procedure TfrmRoleRights.SetModiRight(const Value: boolean);
begin
  FModiRight := Value;
end;

procedure TfrmRoleRights.GetOPRight;
var str: string; Params:TftParamList;
begin
  if Global.UserID<>'admin' then
  begin
    Str:='select distinct MODU_ID,R.ROLE_ID as ROLE_ID,CHK from CA_RIGHTS R,CA_ROLE_INFO B where R.ROLE_TYPE=1 and R.TENANT_ID=B.TENANT_ID and '+
         ' R.ROLE_ID=B.ROLE_ID and R.TENANT_ID=:TENANT_ID and B.ROLE_ID=:ROLE_ID '+
         ' union all '+
         ' select distinct MODU_ID,ROLE_ID,CHK from CA_RIGHTS where ROLE_TYPE=0 and TENANT_ID=:TENANT_ID and ROLE_ID=:USER_ID ';
    OPcds.Close;
    OPcds.SQL.Text:=Str;
    if OPcds.Params.FindParam('TENANT_ID')<>nil then
      OPcds.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    if OPcds.Params.FindParam('ROLE_ID')<>nil then
      OPcds.ParamByName('ROLE_ID').AsString:=Role_ID;
    if OPcds.Params.FindParam('USER_ID')<>nil then
      OPcds.ParamByName('USER_ID').AsString:=Global.UserID;    
    Factor.Open(OPcds);
  end;
end;

//Tag设置:当前登陆的操作员只能授权 他自己所拥有权限
procedure TfrmRoleRights.InitParent(Node: TTreeNode);
var
  SEQUNo: integer;
  CurMID: string;
  Child:TTreeNode;
begin
  if (Node<>nil) and not Node.HasChildren then  
  begin
    CurMID:=trim(TRecord_(Node.Data).FieldByName('MODU_ID').AsString);
    SEQUNo:=TRecord_(Node.Data).FieldByName('SEQNo').AsInteger;
    if ShopGlobal.GetOperRight(OPcds,SEQUNo,'MODU_ID='''+CurMID+'''') then
      TRecord_(Node.Data).FieldByName('Tag').AsString:='1';
    Exit;
  end;

  if Node<>nil then
    Child := Node.getFirstChild
  else
    Child := rzCheckTree.TopItem;

  while Child<>nil do
  begin
    InitParent(Child);
    if Assigned(Node) and (TRecord_(Child.Data).FieldByName('TAG').AsInteger = 1) then
      TRecord_(Node.Data).FieldByName('TAG').AsInteger := 1;
    if Node<>nil then
      Child := Node.GetNextChild(Child)
    else
      Child := Child.getNextSibling;
  end;
end;    

{-------------------------------------------------------------------------------
 1、先将CheckTree的checked和SEQUNo移位后的结果 写入对应Ca_Modle的CheckFlag；
 2、根据权限rs中MOLE_ID累计出个模块：CHK值；                                 
 -------------------------------------------------------------------------------}
procedure TfrmRoleRights.SaveRight;
  function GetRightValue(rs: TDataSet; MODU_ID: string): integer;
  var LevelID,CurID: string; vLen: integer;
  begin
    result:=0;
    if not rs.Active then Exit;
    if rs.Locate('MODU_ID',MODU_ID,[]) then
    begin
      //定位模块ID，根据模块的LEVEL_ID搜索其具体功能权限CHK值
      LevelID:=trim(rs.fieldbyName('LEVEL_ID').AsString);
      vLen:=length(LevelID);
      rs.First;
      while not rs.Eof do
      begin
        CurID:=trim(rs.fieldbyName('LEVEL_ID').AsString);
        if (vLen<length(CurID)) and (LevelID=Copy(CurID,1,vLen)) then
          result:=result+rs.fieldbyName('CheckFlag').AsInteger;
        rs.Next;
      end;
    end;
  end;
var
  c,ID:string;
  pTreeNode: TTreeNode;
  i,j, vCheck,SEQUNo,MODU_TYPE:integer;
begin
  if ModiRight then
  begin       
    for i:=0 to rzCheckTree.Items.Count -1 do
    begin
      SEQUNo:=TRecord_(rzCheckTree.Items[i].Data).FieldByName('SEQNo').AsInteger;
      MODU_TYPE:=TRecord_(rzCheckTree.Items[i].Data).FieldByName('MODU_TYPE').AsInteger;
      if (SEQUNo>0) and (MODU_TYPE=2) then
      begin
        SEQUNo:=SEQUNo-1;
        ID:= TRecord_(rzCheckTree.Items[i].Data).FieldbyName('MODU_ID').AsString;
        if rzCheckTree.ItemState[i] in [csChecked,csPartiallyChecked] then vCheck:= 1 else vCheck := 0;
        if Ca_Modle.Locate('MODU_ID',ID,[]) then
        begin
          Ca_Modle.Edit;
          Ca_Modle.FieldByName('CheckFlag').AsInteger:=vCheck shl SEQUNo;  //移位转成10制
          Ca_Modle.Post;
        end;

        //有父级才具备权限
        if rzCheckTree.Items[i].Parent<>nil then
        begin
          ID:= TRecord_(rzCheckTree.Items[i].Parent.Data).FieldbyName('MODU_ID').AsString;
          if not RoleRight.Locate('ROLE_ID;MODU_ID',VarArrayOf([Role_ID,ID]),[]) then
          begin
            RoleRight.Append;
            RoleRight.FieldByName('ROWS_ID').AsString:=TSequence.NewId;
            RoleRight.FieldByName('MODU_ID').AsString:=ID;
            RoleRight.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
            RoleRight.FieldByName('ROLE_ID').AsString:=Role_ID;
            RoleRight.FieldByName('ROLE_TYPE').AsInteger:=1;
            RoleRight.FieldByName('CHK').AsInteger:=0;
            RoleRight.Post;
          end;
        end;
      end;
    end;

    RoleRight.First;
    while not RoleRight.Eof do
    begin
      RoleRight.Edit;
      //因为权限表里没有产品ID号。原ID可能跟原产品代码的id相同，每次变动都改成最新的。
      RoleRight.FieldByName('ROWS_ID').AsString:=TSequence.NewId;
      RoleRight.FieldByName('CHK').AsInteger:=GetRightValue(Ca_Modle,trim(RoleRight.fieldbyName('MODU_ID').AsString));
      RoleRight.Post;
      RoleRight.Next;
    end;
    //判断是否存在没有在RoleRight内的模块功能
    Factor.UpdateBatch(RoleRight,'TRoleRigths',nil);
  end;
end;

procedure TfrmRoleRights.OpenDataRight;
var i:Integer;
    rs:TZQuery;
    IsRight:Boolean;
begin
  rs := TZQuery.Create(nil);
  CdsDataRight.DisableControls;
  IsRight := False;
  try
    CdsDataRight.SQL.Text := ' select 0 as selflag,CODE_NAME from PUB_PARAMS where TYPE_CODE=''DATA_TYPE'' order by CODE_ID ';
    Factor.Open(CdsDataRight);

    rs.Close;
    rs.SQL.Text := 'select RIGHT_FORDATA from CA_ROLE_INFO where ROLE_ID='+QuotedStr(Role_ID);
    Factor.Open(rs);

    if Trim(rs.FieldByName('RIGHT_FORDATA').AsString) <> '' then
      begin
        i := 1;
        RIGHTData := rs.FieldByName('RIGHT_FORDATA').AsString;
        CdsDataRight.First;
        while not CdsDataRight.Eof do
          begin
            CdsDataRight.Edit;
            CdsDataRight.FieldByName('selflag').AsInteger := StrToInt(Copy(RIGHTData,i,1));
            CdsDataRight.Post;
            if CdsDataRight.FieldByName('selflag').AsInteger = 1 then IsRight := True;
            CdsDataRight.Next;
            inc(i);
          end;
      end;

    if not IsRight then
      DBGridEh3.Font.Color := clGray
    else
      DBGridEh3.Font.Color := clBlack;

    ChkRights.Checked := IsRight;
  finally
    rs.Free;
    CdsDataRight.EnableControls;
  end;
end;

procedure TfrmRoleRights.SaveDataRight;
var rs:TZQuery;
    Params:TftParamList;
    DataRight:String;
begin
  rs := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger :=ShopGlobal.TENANT_ID;
    Params.ParamByName('ROLE_ID').AsString := Role_ID;
    rs.Close;
    Factor.Open(rs,'TRoleInfo',Params);

    CdsDataRight.First;
    while not CdsDataRight.Eof do
      begin
        DataRight := DataRight + CdsDataRight.FieldByName('selflag').AsString;
        CdsDataRight.Next;
      end;
    if not ChkRights.Checked then DataRight := '00';
    if RIGHTData <> '' then
      RIGHTData := DataRight + Copy(RIGHTData,3,8)
    else
      RIGHTData := DataRight + '00000000';
    rs.Edit;
    rs.FieldByName('RIGHT_FORDATA').AsString := RIGHTData;
    rs.Post;

    Factor.UpdateBatch(rs,'TRoleInfo',nil)
  finally
    rs.Free;
    Params.Free;
  end;
end;

procedure TfrmRoleRights.ChkRightsPropertiesChange(Sender: TObject);
begin
  inherited;
  DBGridEh3.Enabled := ChkRights.Checked;
  if not ChkRights.Checked then
    DBGridEh3.Font.Color := clGray
  else
    DBGridEh3.Font.Color := clBlack;
end;

end.
