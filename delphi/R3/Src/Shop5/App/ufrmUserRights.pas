unit ufrmUserRights;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel, uFnUtil,
  RzButton, ComCtrls, RzTreeVw, StdCtrls, DB, ADODB, zBase, jpeg, DBClient,ObjCommon,
  Grids, DBGridEh, ZAbstractRODataset, ZAbstractDataset, ZDataset, RzCmboBx,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit;

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
    RoleList: TZQuery;
    OPcds: TZQuery;
    RoleDs: TDataSource;
    Label6: TLabel;
    Label7: TLabel;
    tabDataRight: TRzTabSheet;
    RzPanel1: TRzPanel;
    RzPanel3: TRzPanel;
    Panel3: TPanel;
    Image3: TImage;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    RzPanel4: TRzPanel;
    DataRightTree: TRzCheckTree;
    RzPanel5: TRzPanel;
    Label12: TLabel;
    edtDataRight: TcxComboBox;
    CdsShop_DeptRight: TZQuery;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtDataRightPropertiesChange(Sender: TObject);
    procedure DataRightTreeStateChange(Sender: TObject; Node: TTreeNode;
      NewState: TRzCheckState);
  private
    User_ID:string;
    User_NAME:string;
    FModiRight: boolean;
    FLastRole_IDS: string;
    FDataRightState: Boolean;
    FDataFlag: string;  //最后一次打开: Role_IDS
    procedure Init(InUserID,InUser_NAME,User_ACCOUNT: string; ROLE_IDS: String); //初始化显示数据(RoleGird和CheckeTree)
    procedure SaveRight;
    procedure InitDataRight;
    procedure ReadDataRight;
    procedure WriteDataRight;
    procedure SetModiRight(const Value: boolean);
    function  GetROLE_IDS: string;
    function  GetROLE_NAMES: string;  //当前的角色List: ROLE_NAMES
    procedure DoRzPageChange(Sender: Tobject);  //Onchange
    procedure InitShopTree;
    procedure InitDeptTree;
    procedure GetShop_DeptRight;
    function  IntToVarchar(FieldName: string): string;
    function  GetShopNo(AliasTabName: string=''): string; //返回门店的排序号
    procedure SetDataFlag(const Value: string);
    procedure SetDataRightState(const Value: Boolean);
  public
    FReROLE_IDS: string;
    ccid:string;
    locked,UnLock:Boolean;
    procedure OpenRight(ROLE_IDS: string);
    class function ShowUserRight(InUserID,InUser_NAME,User_ACCOUNT: string; var ROLE_IDS: string): Boolean;
    property  ModiRight:boolean read FModiRight write SetModiRight;
    property  ROLE_IDS: string read GetROLE_IDS;  //当前的角色List: ROLE_IDS
    property  ROLE_NAMES: string read GetROLE_NAMES;  //当前的角色List: ROLE_NAMES
    //当前用户所拥有的数据权限类型;
    property DataFlag:string read FDataFlag write SetDataFlag;
  end;

var
  frmUserRights: TfrmUserRights;

implementation

uses
  uGlobal,uTreeUtil,uframeTreeFindDialog,uShopGlobal, ufrmBasic, uDsUtil;

{$R *.dfm}

procedure TfrmUserRights.btnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmUserRights.Init(InUserID,InUser_NAME,User_ACCOUNT: string; ROLE_IDS: String);
var
  i:integer;
  Str,Cnd: string;
  adoRs: TZQuery;
begin
  //初始化显示
  User_ID:=InUserID;
  Label1.Caption:=InUser_NAME;
  Label2.Caption:=InUser_NAME;
  Label11.Caption := InUser_NAME;
  Label9.Caption := User_ACCOUNT;
  Label3.Caption:=User_ACCOUNT;
  Label5.Caption:=User_ACCOUNT;

  Cnd:='Select ROLE_ID as ROLE_ID1  From CA_ROLE_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') and ROLE_ID in ('''+StringReplace(ROLE_IDS,',',''',''',[rfReplaceAll])+''')';
  Str:='Select (case when B.ROLE_ID1 is null then 0 else 1 end) as selflag,A.* from  '+
       ' (select ROLE_ID,ROLE_NAME,RIGHT_FORDATA,REMARK from CA_ROLE_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'')) A '+
       ' Left Join ('+Cnd+')B On A.ROLE_ID=B.ROLE_ID1 order by ROLE_ID ';
  RoleList.Close;
  RoleList.SQL.Text:=str;
  RoleList.Params.ParamByName('TENANT_ID').AsInteger:=shopGlobal.TENANT_ID;
  Factor.Open(RoleList);

  try
    adoRs:=TZQuery.Create(nil);
    adoRs.Close;
    adoRs.SQL.Text:='select MODU_ID,MODU_NAME,LEVEL_ID,SEQNo,0 Tag from CA_MODULE where PROD_ID=:PROD_ID and MODU_TYPE in (1,2) and  COMM not in (''02'',''12'')  order by LEVEL_ID';
    if adoRs.Params.FindParam('PROD_ID')<>nil then
      adoRs.ParamByName('PROD_ID').AsString:=ProductID;
    Factor.Open(adoRs);
    CreateLevelTree(adoRs,rzCheckTree,'333333','MODU_ID','MODU_NAME','LEVEL_ID');
    if rzCheckTree.Items.Count>0 then rzCheckTree.TopItem.Selected:=True;
  finally
    adoRs.Free;
  end;

  //读取当前角色IDS的Checked值
  OpenRight(ROLE_IDS);
  GetShop_DeptRight;
  RzPage.ActivePageIndex := 0;
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
    Str:='select MODU_ID,R.ROLE_ID as ROLE_ID,CHK from CA_RIGHTS R,CA_ROLE_INFO B where R.ROLE_TYPE=1 and R.TENANT_ID=B.TENANT_ID and '+
      ' R.ROLE_ID=B.ROLE_ID and R.TENANT_ID=:TENANT_ID and B.ROLE_ID in ('''+stringReplace(ROLE_IDS,',',''',''',[rfReplaceAll])+''') '+
      ' union all '+
      ' select MODU_ID,ROLE_ID,CHK from CA_RIGHTS where ROLE_TYPE=0 and TENANT_ID=:TENANT_ID and ROLE_ID=:USER_ID ';
    RsRight.Close;
    RsRight.SQL.Text:=Str;
    if RsRight.Params.FindParam('TENANT_ID')<>nil then
      RsRight.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    if RsRight.Params.FindParam('USER_ID')<>nil then
      RsRight.ParamByName('USER_ID').AsString:=User_ID;
    Factor.Open(RsRight);

    locked:=true;
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
    locked:=false;
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
    if Self.ROLE_IDS <> '' then
      Params.ParamByName('ROLE_IDS').asString:=self.ROLE_IDS
    else
      Params.ParamByName('ROLE_IDS').asString:='#';
    if Self.ROLE_NAMES <> '' then
      Params.ParamByName('ROLE_NAMES').asString:=self.ROLE_NAMES
    else
      Params.ParamByName('ROLE_NAMES').asString:='#';
    FReROLE_IDS:=Params.ParamByName('ROLE_IDS').asString;

    WriteDataRight;
    Factor.BeginTrans;
    try
      Factor.ExecProc('TUserRolesList',Params);
      Factor.UpdateBatch(CdsShop_DeptRight,'TUserRightsData');
      Factor.CommitTrans;
    except
      Factor.RollbackTrans;
      Raise;
    end;
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
  if not RoleList.Active then exit;
  if RoleList.State = dsEdit then RoleList.Post; //判断是否编辑状态并Post
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
  if (RzPage.ActivePage=tabDataRight) then
  begin
    InitDataRight;
    ReadDataRight;
  end;
end;

class function TfrmUserRights.ShowUserRight(InUserID, InUser_NAME,User_ACCOUNT: string; var ROLE_IDS: string): Boolean;
var FrmObj: TfrmUserRights;
begin
  try
    FrmObj:=TfrmUserRights.Create(nil);
    FrmObj.Init(InUserID, InUser_NAME,User_ACCOUNT,ROLE_IDS);  //初始化显示数据(RoleGird和CheckeTree)
    FrmObj.ShowModal;
    if FrmObj.ModalResult=MROK then
    begin
      ROLE_IDS:=FrmObj.FReROLE_IDS;
      result:=true;
    end;
  finally
    freeandnil(FrmObj);
  end;
end;

procedure TfrmUserRights.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  RzPage.OnChange:=nil;
end;

procedure TfrmUserRights.InitDeptTree;
var CdsDept:TZQuery;
    Sql_Str,Join_Str:String;
begin
  Join_Str := GetStrJoin(Factor.iDbType);
  CdsDept:=TZQuery.Create(nil);
  try
    CdsDept.Close;
    CdsDept.SQL.Text:=
    'select DEPT_ID as DATA_OBJECT,DEPT_NAME as DATA_NAME,''001'' as LEVEL_ID from CA_DEPT_INFO where TENANT_ID='+IntToStr(ShopGlobal.TENANT_ID)+
    ' and DEPT_TYPE=''1'' and COMM not in (''02'',''12'') order by DEPT_ID';
    Factor.Open(CdsDept);
    CreateLevelTree(CdsDept,DataRightTree,'333333','DATA_OBJECT','DATA_NAME','LEVEL_ID');
    if DataRightTree.Items.Count>0 then DataRightTree.TopItem.Selected:=True;
  finally
    CdsDept.Free;
  end;

end;

procedure TfrmUserRights.InitShopTree;
var CdsShop:TZQuery;
    Sql_Str,Join_Str,zxTab:String;
begin
  Join_Str := GetStrJoin(Factor.iDbType);
  CdsShop:=TZQuery.Create(nil);
  try
    zxTab:=
      'select distinct substr(CODE_ID,1,2) as CODE_ID from PUB_CODE_INFO '+
      ' where TENANT_ID=0 and CODE_TYPE=''8'' and COMM not in (''02'',''12'') and substr(CODE_ID,3,4)=''0000'' '+
      ' and substr(CODE_ID,1,2) not in(select distinct substr(CODE_ID,1,2) from PUB_CODE_INFO where TENANT_ID=0 and CODE_TYPE=''8'' and COMM not in (''02'',''12'') and substr(CODE_ID,3,2)<>''00'' and substr(CODE_ID,5,2)=''00'' and substr(CODE_ID,3,4)<>''0000'')';

    Sql_Str :=
      'select DATA_OBJECT,DATA_NAME,LEVEL_ID from '+
        '(select distinct a.CODE_ID as DATA_OBJECT,a.CODE_NAME as DATA_NAME, '+
        '  case when a.CODE_ID=''#'' then ''0099'''+
        '       when substr(a.CODE_ID,3,4)=''0000'' then ''00'''+Join_Str+'substr(a.CODE_ID,1,2) '+
        '       when substr(a.CODE_ID,5,2)=''00''   then ''00'''+Join_Str+'substr(a.CODE_ID,1,2) '+Join_Str+'''00'''+Join_Str+'substr(a.CODE_ID,3,2) '+
     // '       when substr(a.CODE_ID,5,2)<>''00''  and zt.CODE_ID is not null then ''00'''+Join_Str+'substr(a.CODE_ID,1,2) '+Join_Str+'''00'''+Join_Str+'substr(a.CODE_ID,5,2) '+
        '       else ''00'''+Join_Str+'substr(a.CODE_ID,1,2)'+Join_Str+'''00'''+Join_Str+'substr(a.CODE_ID,3,2)'+Join_Str+'''00'''+Join_Str+'substr(a.CODE_ID,5,2) end as LEVEL_ID '+
        ' from '+
        '  (select CODE_ID,CODE_NAME,LEVEL_ID,(case when substr(CODE_ID,3,4)=''0000'' then substr(CODE_ID,1,2) else '' '' end) as FID, '+
        '    (case when (substr(CODE_ID,3,4)<>''0000'') and (substr(CODE_ID,5,2)=''00'') then substr(CODE_ID,1,4) else '' '' end) as SID from PUB_CODE_INFO where TENANT_ID=0 and CODE_TYPE=''8'' '+
        '   union all '+
        '   select ''#'' as CODE_ID,''无'' as CODE_NAME,'''' as LEVEL_ID,'' '' as FID,'' '' as SID from CA_TENANT where TENANT_ID='+IntToStr(Global.TENANT_ID)+
        '   ) a,CA_SHOP_INFO b '+
        '  left outer join ('+zxTab+') zt on substr(b.REGION_ID,1,2)=zt.CODE_ID  '+
        ' where b.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and b.COMM not in (''02'',''12'') and ((a.CODE_ID=b.REGION_ID)or(a.FID=substr(b.REGION_ID,1,2))or(a.SID=substr(b.REGION_ID,1,4)))  '+
       ' union all ' +
        ' select SHOP_ID as DATA_OBJECT,SHOP_NAME as DATA_NAME,'+
        '    case when REGION_ID=''#'' then ''0099'''+Join_Str+GetShopNo+
        '         when substr(REGION_ID,3,4)=''0000'' then ''00'''+Join_Str+'substr(REGION_ID,1,2)'+Join_Str+GetShopNo+
        '         when substr(REGION_ID,5,2)=''00''   then ''00'''+Join_Str+'substr(REGION_ID,1,2)'+Join_Str+'''00'''+Join_Str+'substr(REGION_ID,3,2)'+Join_Str+GetShopNo+
    //  '         when substr(REGION_ID,5,2)<>''00'' and zt.CODE_ID is not null  then ''00'''+Join_Str+'substr(REGION_ID,1,2)'+Join_Str+'''00'''+Join_Str+'substr(REGION_ID,3,2)'+Join_Str+'substr(REGION_ID,5,2)'+Join_Str+GetShopNo+  //直辖市直（2级）
        '         else ''00'''+Join_Str+'substr(REGION_ID,1,2)'+Join_Str+'''00'''+Join_Str+'substr(REGION_ID,3,2)'+Join_Str+'''00'''+Join_Str+'substr(REGION_ID,5,2)'+Join_Str+GetShopNo+' end as LEVEL_ID '+
        '  from CA_SHOP_INFO sh left outer join ('+zxTab+') zt on substr(sh.REGION_ID,1,2)=zt.CODE_ID '+
        '  where sh.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and sh.COMM not in (''02'',''12'') '+
        '  )tmp '+
      ' order by LEVEL_ID';

    CdsShop.Close;
    CdsShop.SQL.Text:=ParseSQL(Factor.iDbType,Sql_Str);
    Factor.Open(CdsShop);
    CreateLevelTree(CdsShop,DataRightTree,'444444','DATA_OBJECT','DATA_NAME','LEVEL_ID');
    if DataRightTree.Items.Count>0 then DataRightTree.TopItem.Selected:=True;
  finally
    CdsShop.Free;
  end;
end;

procedure TfrmUserRights.GetShop_DeptRight;
var Str:String;
    Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('USER_ID').AsString := User_ID;
    Factor.Open(CdsShop_DeptRight,'TUserRightsData',Params);
  finally
    Params.Free;
  end;
end;

procedure TfrmUserRights.WriteDataRight;
var i,r:Integer;
    ID:String;
begin
  if edtDataRight.Properties.Items.Count < 0 then Exit;
  if edtDataRight.ItemIndex<0 then Exit;
  r := TRecord_(edtDataRight.Properties.Items.Objects[edtDataRight.ItemIndex]).FieldByName('CODE_ID').AsInteger;

  for i := 0 to DataRightTree.Items.Count - 1 do
    begin
      if DataRightTree.Items[i].hasChildren then continue;
      ID := TRecord_(DataRightTree.Items[i].Data).FieldByName('DATA_OBJECT').AsString;
      if DataRightTree.ItemState[i] in [csChecked] then
        begin
          if not CdsShop_DeptRight.Locate('TENANT_ID,DATA_TYPE,USER_ID,DATA_OBJECT',VarArrayOf([IntToStr(Global.TENANT_ID),inttostr(r),User_ID,ID]),[]) then
            begin
              CdsShop_DeptRight.Append;
              CdsShop_DeptRight.FieldByName('ROWS_ID').AsString := TSequence.NewId;
              CdsShop_DeptRight.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
              CdsShop_DeptRight.FieldByName('DATA_TYPE').AsString := inttostr(r);
              CdsShop_DeptRight.FieldByName('USER_ID').AsString := User_ID;//Global.UserID;
              CdsShop_DeptRight.FieldByName('DATA_OBJECT').AsString := ID;
              CdsShop_DeptRight.Post;
            end;
        end
      else
        begin
          if CdsShop_DeptRight.Locate('TENANT_ID,DATA_TYPE,USER_ID,DATA_OBJECT',VarArrayOf([IntToStr(Global.TENANT_ID),inttostr(r),User_ID,ID]),[]) then
            CdsShop_DeptRight.Delete;
        end;
    end;
end;

function TfrmUserRights.IntToVarchar(FieldName: string): string;
begin
  result:=trim(FieldName);
  case Factor.iDbType of
   0,5:
      result:='cast('+FieldName+' as varchar)';
   1: result:='to_char('+FieldName+')';
   3: result:='str('+FieldName+')';
   4: result:='ltrim(rtrim(char('+FieldName+')))';
  end;
end;

procedure TfrmUserRights.ReadDataRight;
var i,r:Integer;
    SId:String;
begin
  ClearTree(DataRightTree);
  if edtDataRight.Properties.Items.Count < 0 then Exit;
  if edtDataRight.ItemIndex<0 then Exit;
  r := TRecord_(edtDataRight.Properties.Items.Objects[edtDataRight.ItemIndex]).FieldByName('CODE_ID').AsInteger;
  case r of
  1:InitShopTree;
  2:InitDeptTree;
  end;
  locked := true;
  try
  if Copy(DataFlag,r,1) = '1' then
    begin
      for i := 0 to DataRightTree.Items.Count - 1 do
        begin
          SId := TRecord_(DataRightTree.Items[i].Data).FieldbyName('DATA_OBJECT').AsString;
          if CdsShop_DeptRight.Locate('DATA_OBJECT;DATA_TYPE',varArrayOf([SId,inttostr(r)]),[]) then
            DataRightTree.ItemState[i] := csChecked
          else
            DataRightTree.ItemState[i] := csUnchecked;
        end;
    end
  else
    begin
      for i := 0 to DataRightTree.Items.Count - 1 do
        DataRightTree.ItemState[i] := csUnchecked;
    end;
  finally
    locked := false;
  end;
end;

procedure TfrmUserRights.SetDataRightState(const Value: Boolean);
begin
  FDataRightState := Value;
end;

procedure TfrmUserRights.InitDataRight;
var
  v,i:integer;
  rStr:string;
  rs:TZQuery;
  AObj:TRecord_;
begin
  locked := true;
  try
    TdsItems.ClearItems(edtDataRight.Properties.Items);
    v := 0;
    RoleList.First;
    while not RoleList.Eof do
      begin
        if RoleList.FieldbyName('selflag').asInteger=1 then
        v := (v or round(BintoInt(FnString.FormatStringBack(RoleList.FieldbyName('RIGHT_FORDATA').AsString,10))));
        RoleList.Next;
      end;
    rStr := FnString.FormatStringEx(inttoBin(v),10);
    DataFlag := rStr;
    rs := Global.GetZQueryFromName('PUB_PARAMS');
    for i:=1 to length(rStr) do
      begin
        if (rStr[i]='1') and rs.Locate('CODE_ID;TYPE_CODE',varArrayOf([inttostr(i),'DATA_TYPE']),[]) then
           begin
             AObj := TRecord_.Create;
             AObj.ReadFromDataSet(rs);
             edtDataRight.Properties.Items.AddObject(rs.FieldbyName('CODE_NAME').AsString,AObj);
           end;
      end;
    if edtDataRight.Properties.Items.Count > 0 then edtDataRight.ItemIndex := 0;
    edtDataRight.Enabled := (edtDataRight.Properties.Items.Count>0);
    if not edtDataRight.Enabled then edtDataRight.Text := '没启用'; 
  finally
    locked := false;
  end;
end;

procedure TfrmUserRights.SetDataFlag(const Value: string);
begin
  FDataFlag := Value;
end;

procedure TfrmUserRights.edtDataRightPropertiesChange(Sender: TObject);
begin
  inherited;
  if Locked then Exit;
  ReadDataRight;
end;

procedure TfrmUserRights.DataRightTreeStateChange(Sender: TObject;
  Node: TTreeNode; NewState: TRzCheckState);
begin
  inherited;
  if Locked then Exit;
  WriteDataRight;
end;

function TfrmUserRights.GetShopNo(AliasTabName: string=''): string;
var
  AliasName,SEQ_NO,SHOP_ID: string;
begin
  result:='';
  AliasName:='';
  if AliasTabName<>'' then
  begin
    if pos('.',AliasTabName)>0 then
      AliasName:=AliasTabName
    else
      AliasName:=AliasTabName+'.';
  end;

  SEQ_NO:=AliasName+'SEQ_NO';
  SHOP_ID:=AliasName+'SHOP_ID';

  case Factor.iDbType of
   0,5:
      SEQ_NO:='cast('+SEQ_NO+' as varchar)';
   1: SEQ_NO:='to_char('+SEQ_NO+')';
   3: SEQ_NO:='str('+SEQ_NO+')';
   4: SEQ_NO:='ltrim(rtrim(char('+SEQ_NO+')))';
  end;

  SEQ_NO:='isnull('+SEQ_NO+','+'substr('+SHOP_ID+',10,4))';
  result:=ParseSQL(Factor.iDbType,SEQ_NO);
end;

end.
