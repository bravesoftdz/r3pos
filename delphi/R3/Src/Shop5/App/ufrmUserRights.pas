unit ufrmUserRights;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, ComCtrls, RzTreeVw, StdCtrls, DB, ADODB, zBase, jpeg, DBClient,
  Grids, DBGridEh, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmUserRights = class(TframeDialogForm)
    TabSheet2: TRzTabSheet;
    Label1: TLabel;
    rzCheckTree: TRzCheckTree;
    Label2: TLabel;
    Image1: TImage;
    Panel1: TPanel;
    Label26: TLabel;
    Label3: TLabel;
    Image2: TImage;
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    RzPnl_Price: TRzPanel;
    DbGridEh1: TDBGridEh;
    adoRs: TZQuery;
    adoRs1: TZQuery;
    RoleList: TZQuery;
    rs1: TZQuery;
    OPcds: TZQuery;
    RoleDs: TDataSource;
    Label6: TLabel;
    Label7: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure rzCheckTreeStateChange(Sender: TObject; Node: TTreeNode; NewState: TRzCheckState);
    procedure rzCheckTreeCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure rzCheckTreeStateChanging(Sender: TObject; Node: TTreeNode;
      NewState: TRzCheckState; var AllowChange: Boolean);
    procedure DbGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DbGridEh1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    User_ID:string;
    User_NAME:string;
    FModiRight: boolean;
    FLastRole_IDS: string;  //最后一次打开: Role_IDS
    procedure Init(ROLE_IDS: String); //初始化显示数据(RoleGird和CheckeTree)
    procedure SaveRight;
    procedure SetModiRight(const Value: boolean);
    function  GetROLE_IDS: string;
    function  GetROLE_NAMES: string;  //当前的角色List: ROLE_NAMES
    procedure DoRzPageChange(Sender: Tobject); //Onchange
  public
    ccid:string;
    locked:Boolean;
    procedure Open(InUserID,InUser_NAME,User_ACCOUNT,ROLE_IDS: string);
    procedure OpenRight(ROLE_IDS: string);
    property  ModiRight:boolean read FModiRight write SetModiRight;
    property  ROLE_IDS: string read GetROLE_IDS;  //当前的角色List: ROLE_IDS
    property  ROLE_NAMES: string read GetROLE_NAMES;  //当前的角色List: ROLE_NAMES
  end;

var
  frmUserRights: TfrmUserRights;

implementation

uses
  uGlobal,uTreeUtil,uframeTreeFindDialog,ufrmUsers,uShopGlobal;

{$R *.dfm}

procedure TfrmUserRights.btnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmUserRights.Init(ROLE_IDS: String);
var
  i:integer;
  Str,Cnd: string;
  adoRs: TZQuery;
begin
  Cnd:='Select ROLE_ID as ROLE_ID1  From CA_ROLE_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') and ROLE_ID in ('''+StringReplace(ROLE_IDS,',',''',''',[rfReplaceAll])+''')';
  Str:='Select (case when B.ROLE_ID1 is null then 0 else 1 end) as selflag,A.* from  '+
       ' (select ROLE_ID,ROLE_NAME,REMARK from CA_ROLE_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'')) A '+
       ' Left Join ('+Cnd+')B On A.ROLE_ID=B.ROLE_ID1 order by ROLE_ID ';
  RoleList.Close;
  RoleList.SQL.Text:=str;
  RoleList.Params.ParamByName('TENANT_ID').AsInteger:=shopGlobal.TENANT_ID;
  Factor.Open(RoleList); 

  try
    adoRs:=TZQuery.Create(nil);
    adoRs.Close;
    adoRs.SQL.Text:='select MODU_ID,MODU_NAME,LEVEL_ID,SEQNo,0 Tag from CA_MODULE where PROD_ID=:PROD_ID and  COMM not in (''02'',''12'')  order by LEVEL_ID';
    if adoRs.Params.FindParam('PROD_ID')<>nil then
      adoRs.ParamByName('PROD_ID').AsString:=ProductID;
    Factor.Open(adoRs);
    CreateLevelTree(adoRs,rzCheckTree,'333333','MODU_ID','MODU_NAME','LEVEL_ID');
    if rzCheckTree.Items.Count>0 then rzCheckTree.TopItem.Selected:=True;
  finally
    adoRs.Free;
  end;
end;

procedure TfrmUserRights.Open(InUserID,InUser_NAME,User_ACCOUNT,ROLE_IDS: string);
begin
  User_ID:=InUserID;
  Label1.Caption:=InUser_NAME;
  Label2.Caption:=InUser_NAME;
  Label3.Caption:=User_ACCOUNT;
  Label5.Caption:=User_ACCOUNT;
  Init(ROLE_IDS);  //初始化显示数据(RoleGird和CheckeTree)
  OpenRight(ROLE_IDS);  //读取当前角色IDS的Checked值
  RzPage.OnChange:=DoRzPageChange;
  locked:=false;
end;

procedure TfrmUserRights.OpenRight(ROLE_IDS: string);
var
  Str,ID:string;
  SEQUNo,i: integer;
  RsRight: TZQuery;
begin
  try
    RsRight:=TZQuery.Create(nil);
    case Factor.iDbType of
     0,5:
      begin //SQLITE环境下通过，Ms SQL Server语法一样
        Str:='select distinct MODU_ID,R.ROLE_ID as ROLE_ID,CHK from CA_RIGHTS R,CA_ROLE_INFO B where R.ROLE_TYPE=1 and R.TENANT_ID=B.TENANT_ID and '+
          ' R.ROLE_ID=B.ROLE_ID and R.TENANT_ID=:TENANT_ID and B.ROLE_ID in ('''+stringReplace(ROLE_IDS,',',''',''',[rfReplaceAll])+''') '+
          ' union all '+
          ' select distinct MODU_ID,ROLE_ID,CHK from CA_RIGHTS where ROLE_TYPE=0 and TENANT_ID=:TENANT_ID and ROLE_ID=:USER_ID ';
      end;
     1:
      begin
        Str:='';
      end;
     4:
      begin
        Str:='';
      end;
    end;
    RsRight.Close;
    RsRight.SQL.Text:=Str;
    if RsRight.Params.FindParam('TENANT_ID')<>nil then
      RsRight.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    if RsRight.Params.FindParam('USER_ID')<>nil then
      RsRight.ParamByName('USER_ID').AsString:=User_ID;
    Factor.Open(RsRight);

    for i:=0 to rzCheckTree.Items.Count -1 do
    begin
      SEQUNo:=TRecord_(rzCheckTree.Items[i].Data).FieldbyName('SEQNo').AsInteger;
      if (SEQUNo>0) and (rzCheckTree.Items[i].Parent<>nil) then
      begin
        ID := TRecord_(rzCheckTree.Items[i].Parent.Data).FieldbyName('MODU_ID').AsString;
        if ShopGlobal.GetOperRight(RsRight, SEQUNo,'MODU_ID='''+ID+'''') then
          rzCheckTree.ItemState[i] := csChecked
        else
          rzCheckTree.ItemState[i] := csUnChecked;
      end;
    end;
  finally
    FLastRole_IDS:=ROLE_IDS;
    RsRight.Free;
  end;
end;

procedure TfrmUserRights.btnOkClick(Sender: TObject);
begin
  inherited;
  SaveRight;
  ModalResult:=MROK;
end;

procedure TfrmUserRights.SetModiRight(const Value: boolean);
begin
  FModiRight := Value;
end;

procedure TfrmUserRights.rzCheckTreeStateChange(Sender: TObject;
  Node: TTreeNode; NewState: TRzCheckState);
begin
  inherited;
  if locked then exit;
  ModiRight := true;
end;

procedure TfrmUserRights.rzCheckTreeCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
var nNode:TTreeNode;
begin
  inherited;
//  if Global.UserID<>'admin' then
//  begin
//    if Node.HasChildren then exit;
    if TRecord_(Node.Data).FieldByName('Tag').AsString='1'  then
    begin
//      TRecord_(Node.Data).FieldByName('Tag').AsString:='1';
      rzCheckTree.Canvas.Font.Color := clBtnShadow;
//      nNode:=Node.Parent;
//      while (nNode<>nil) do
//      begin
//        TRecord_(nNode.Data).FieldByName('Tag').AsString:='1';
//        nNode:=nNode.Parent;
//      end;
    end;
//  end;
end;

procedure TfrmUserRights.rzCheckTreeStateChanging(Sender: TObject;
  Node: TTreeNode; NewState: TRzCheckState; var AllowChange: Boolean);
begin
  inherited;
  if locked then exit;
  rzCheckTree.CascadeChecks:=True; //全部设置为不可以Checked
  AllowChange:=False;


 {if  Global.UserID<>'admin' then
  begin
    if (TRecord_(Node.Data).FieldByName('Tag').AsString='1')  then
    begin
      rzCheckTree.CascadeChecks:=False;
      AllowChange:=False;
    end else
      rzCheckTree.CascadeChecks:=True;
  end;}
end;

procedure TfrmUserRights.DbGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
{  if Column.FieldName = 'SEQ_NO' then
  begin
    ARect := Rect;
    DbGridEh1.canvas.FillRect(ARect);
    DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(DbGridEh1.DataSource.DataSet.RecNo)),length(Inttostr(DbGridEh1.DataSource.DataSet.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end; }
end;

procedure TfrmUserRights.SaveRight;
var Params: TftParamList;
begin
  try
    Params:=TftParamList.Create(nil);
    Params.ParamByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
    Params.ParamByName('USER_ID').AsString:=User_ID;
    Params.ParamByName('ROLE_IDS').asString:=self.ROLE_IDS;
    Params.ParamByName('ROLE_NAMES').asString:=self.ROLE_NAMES;
    Factor.ExecProc('TUserRolesList',Params);
  finally
    Params.Free;
  end;
end;

procedure TfrmUserRights.DbGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if (RoleList.Active) and (DbGridEh1.Col>0) then
  begin
    OpenRight(self.ROLE_IDS);
    RzPage.ActivePage:=TabSheet2;
  end;
end;

function TfrmUserRights.GetROLE_IDS: string;
begin
  result:='';
  if (not RoleList.Active) or (RoleList.IsEmpty) then Exit;
  try
    RoleList.DisableControls;
    RoleList.First;
    while not RoleList.Eof do
    begin
      if trim(RoleList.fieldbyName('selflag').AsString)<>'0' then
      begin
        if result<>'' then result:=result+',';
        result:=result+RoleList.fieldbyName('ROLE_ID').AsString;
      end;
      RoleList.Next;
    end;
  finally
    RoleList.EnableControls;
  end;
end;

function TfrmUserRights.GetROLE_NAMES: string;
begin
  result:='';
  if (not RoleList.Active) or (RoleList.IsEmpty) then Exit;
  try
    RoleList.DisableControls;
    RoleList.First;
    while not RoleList.Eof do
    begin
      if trim(RoleList.fieldbyName('selflag').AsString)<>'0' then
      begin
        if result<>'' then result:=result+',';
        result:=result+RoleList.fieldbyName('ROLE_NAME').AsString;
      end;
      RoleList.Next;
    end;
  finally
    RoleList.EnableControls;
  end;
end;

procedure TfrmUserRights.FormCreate(Sender: TObject);
begin
  inherited;
  locked:=true;
  RzPage.ActivePage:=TabSheet1;
end;

procedure TfrmUserRights.DoRzPageChange(Sender: Tobject);
var CurIDS: string;
begin
  CurIDS:=ROLE_IDS;
  if (trim(FLastRole_IDS)<>trim(CurIDS)) and (RzPage.ActivePage=TabSheet2) then
    OpenRight(CurIDS);
end;

end.
