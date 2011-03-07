{   31300001	0	ְ�񵵰�	1	��ѯ 	2	����	3	�޸�	4	ɾ��	5	��ӡ	6	����     }

unit ufrmDutyInfoList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ExtCtrls, ComCtrls, RzTreeVw, Grids, DBGridEh,
  cxEdit, cxTextEdit, ActnList, Menus, ToolWin, cxControls, cxContainer,
  StdCtrls, RzLabel, RzTabs, RzPanel, DB, zBase, RzButton, PrnDbgeh, jpeg,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;
 

type
  TfrmDutyInfoList = class(TframeToolForm)
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    RzPanel1: TRzPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtKey: TcxTextEdit;
    rzTree: TRzTreeView;
    Splitter1: TSplitter;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    DataSource1: TDataSource;
    actRIGHTS: TAction;
    PopupMenu2: TPopupMenu;
    N2: TMenuItem;
    actRIGHTS1: TAction;
    btnOk: TRzBitBtn;
    Panel3: TPanel;
    DBGridEh1: TDBGridEh;
    stbPanel: TPanel;
    Label2: TLabel;
    cdsBrowser: TZQuery;
    pmSort: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    Sort_First: TMenuItem;
    Sort_Prior: TMenuItem;
    Sort_Next: TMenuItem;
    Sort_Last: TMenuItem;
    PrintDBGridEh1: TPrintDBGridEh;    
    procedure actFindExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure edtKeyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtKeyPropertiesChange(Sender: TObject);
    procedure rzTreeChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure cdsBrowserAfterScroll(DataSet: TDataSet);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure Sort_FirstClick(Sender: TObject);
    procedure Sort_PriorClick(Sender: TObject);
    procedure Sort_NextClick(Sender: TObject);
    procedure Sort_LastClick(Sender: TObject);
    procedure edtKeyKeyPress(Sender: TObject; var Key: Char);
  private
    procedure SetRecNo;  //���ü�¼���
    procedure DutyTreeSort(SortType: string); //ְ����������
    function  FindNode(ID: string): TTreeNode;
    function  FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
    function  CheckCanExport:boolean; override;
  public
    // locked,IsCompany : boolean;
    procedure DoOnTreeChange(Sender: TObject; Node: TTreeNode);
    procedure AddRecord(AObj:TRecord_);  //����GridList����
    procedure InitGrid; //��ʼ��Gird��KeyList
    procedure CreateTree;
    procedure Open;
  end;

 

implementation

uses
  uGlobal,ufrmDutyInfo,uTreeUtil,uShopGlobal, ufrmEhLibReport, ObjCommon;

{$R *.dfm}

procedure TfrmDutyInfoList.actFindExecute(Sender: TObject);
begin
  Open;
end;

procedure TfrmDutyInfoList.actExitExecute(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmDutyInfoList.actNewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('31300001', 2) then Raise Exception.Create('��û������ְ���Ȩ��,��͹���Ա��ϵ.');
  with TfrmDutyInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Append;
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmDutyInfoList.actEditExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('31300001', 3) then Raise Exception.Create('��û���޸�'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  if not cdsBrowser.Active then Raise Exception.Create('û�����ݣ�');
  if cdsBrowser.IsEmpty then Raise Exception.Create('û�����ݣ�');
  with TfrmDutyInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //2011.01.25�رյ� [��ϵͳʹ��]Ҫ���Ȩ�� 
        // if not IsCompany then Open(cdsBrowser.FieldByName('DUTY_ID').AsString)
        //else
        Edit(cdsBrowser.FieldByName('DUTY_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmDutyInfoList.actDeleteExecute(Sender: TObject);
  procedure UpdateToGlobal(str:string);
  var Temp:TZQuery;
  begin
    Temp := Global.GetZQueryFromName('CA_DUTY_INFO');
    Temp.Filtered :=false;
    if Temp.Locate('DUTY_ID',str,[]) then
    begin
      Temp.Delete;
      Temp.CommitUpdates;
    end;
  end;
var
  rzNode: TTreeNode;
  Params: TftParamList;
begin
  inherited;
  if not ShopGlobal.GetChkRight('31300001', 4) then Raise Exception.Create('��û��ɾ��'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  if not cdsBrowser.Active then Raise Exception.Create('û�����ݣ�');
  if cdsBrowser.IsEmpty then Raise Exception.Create('û�����ݣ�');
  if MessageBox(Handle,Pchar('�Ƿ�Ҫɾ����?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1)=6 then
  begin
    Params:=TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
      Params.ParamByName('DUTY_ID').asString:=cdsBrowser.FieldByName('DUTY_ID').AsString;
      Params.ParamByName('DUTY_NAME').asString:=cdsBrowser.FieldByName('DUTY_NAME').AsString;
      Params.ParamByName('LEVEL_ID').asString:=cdsBrowser.FieldByName('LEVEL_ID').AsString;
      Factor.ExecProc('TDutyInfoDelete',Params);
    finally
      Params.Free;
    end;
    //����ShopGlobal����
    UpdateToGlobal(cdsBrowser.FieldByName('DUTY_ID').AsString);
    //�ͷ���������ڵ�
    rzNode:=FindNode(cdsBrowser.FieldByName('DUTY_ID').AsString);
    if rzNode<>nil then
    begin
      TRecord_(rzNode.Data).Free;
      rzNode.Delete;
    end;
    cdsBrowser.Delete;
  end;
end;

procedure TfrmDutyInfoList.edtKeyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key=VK_DOWN then
     cdsBrowser.Next;
  if Key=VK_UP then
     cdsBrowser.Prior;
end;

procedure TfrmDutyInfoList.edtKeyPropertiesChange(Sender: TObject);
// var KeyValue: string;
begin
  inherited;
  //TZQuery���ݼ���֧��Filtered like ���� 
  {
  locked:=True;
  try
    KeyValue:=trim(edtKEY.Text);
    if (KeyValue<>'') and (rzTree.Items.Count>0) then rzTree.TopItem.Selected := true;
    cdsBrowser.Filtered := false;
    cdsBrowser.Filter := 'DUTY_ID like ''%'+KeyValue+'%'' or DUTY_NAME like ''%'+KeyValue+'%'' or DUTY_SPELL like ''%'+KeyValue+'%'' ';
    cdsBrowser.Filtered := (KeyValue<>'');
  finally
    locked:=False;
  end;
  }
end;

procedure TfrmDutyInfoList.rzTreeChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
begin
  inherited;
  if edtKey.Text<>'' then edtKey.Text:='';

  {
  if locked then exit;
  locked := true;
  try
   if edtKey.Text<>'' then edtKey.Text:='';
  finally
    locked := false;
  end; }
end;

procedure TfrmDutyInfoList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQ_NO' then
  begin
    ARect := Rect;
    DbGridEh1.canvas.FillRect(ARect);
    DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsBrowser.RecNo)),length(Inttostr(cdsBrowser.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

procedure TfrmDutyInfoList.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQ_NO' then
     Background := clBtnFace;
end;

procedure TfrmDutyInfoList.FormShow(Sender: TObject);
begin
  inherited;
  //���봰����ʾ���ݣ�
  if not cdsBrowser.Active then Open;
  if edtKey.CanFocus then edtKey.SetFocus;
end;

procedure TfrmDutyInfoList.actInfoExecute(Sender: TObject);
begin
  if not cdsBrowser.Active then Raise Exception.Create('û�����ݣ�');
  if cdsBrowser.IsEmpty then Raise Exception.Create('û�����ݣ�');
  with TfrmDutyInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      //Ҫ���Ȩ��
      Open(cdsBrowser.FieldByName('DUTY_ID').AsString);
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmDutyInfoList.AddRecord(AObj: TRecord_);
var
  i: integer;
  IsCreate: Boolean;
  CurID,CurName: string;
  str,cdsUPDUTY_ID,AObjUPDUTY_ID,DUTY_ID:string;
begin
  str:='';
  CurID:='';
  CurName:='';
  IsCreate:=False;
  if not cdsBrowser.Active  then exit;
  AObjUPDUTY_ID:=AObj.FieldByName('LEVEL_ID').AsString;  //Ϊ�ձ�ʾû���ϼ��������ڵ�
  if cdsBrowser.Locate('DUTY_ID',AObj.FieldByName('DUTY_ID').AsString,[]) then
  begin
    //2011.02.26 Add �ж��Ƿ��޸����ڵ�����:
    if trim(AObj.FieldByName('DUTY_NAME').AsString)<> trim(cdsBrowser.FieldByName('DUTY_NAME').AsString) then
    begin
      CurID:=trim(AObj.FieldByName('DUTY_ID').AsString);
      CurName:=trim(AObj.FieldByName('DUTY_NAME').AsString);
    end;

    cdsUPDUTY_ID:=cdsBrowser.FieldByName('LEVEL_ID').AsString;
    DUTY_ID:=cdsBrowser.FieldByName('DUTY_ID').AsString;
    cdsBrowser.Edit;      
    AObj.WriteToDataSet(cdsBrowser,false);
    cdsBrowser.Post;
  end else
  begin
    cdsUPDUTY_ID:='';
    DUTY_ID:=AObj.FieldByName('DUTY_ID').AsString;
    cdsBrowser.Append;
    AObj.WriteToDataSet(cdsBrowser,false);
    cdsBrowser.Post;
  end;
  //ˢ��Gird��KeyList
  InitGrid;
  //ˢ����
  if (cdsUPDUTY_ID<>AObjUPDUTY_ID) or (AObjUPDUTY_ID='') then
  begin
    if rzTree.Items.Count=1 then
    begin
      CreateTree;
      FindNode(DUTY_ID).Selected:=True;
      IsCreate:=true;
    end else
    begin 
      if not rzTree.TopItem.Selected then
        str:=TRecord_(rzTree.Selected.Data).FieldByName('DUTY_ID').AsString;
      CreateTree;
      IsCreate:=true;
      if str<>'' then
        FindNode(str).Selected:=True;
    end;
  end;

  //2011.02.26 Add  �޸Ľڵ����Ƶ���û�����´���
  if (not IsCreate) and (CurID<>'') and (CurName<>'') then
  begin
    for i:=0 to rzTree.Items.Count-1 do
    begin
      if trim(TRecord_(rzTree.Items[i].Data).FieldByName('DUTY_ID').AsString)=CurID then
      begin
        TRecord_(rzTree.Items[i].Data).FieldByName('DUTY_NAME').AsString:=CurName;
        rzTree.Items[i].Text:=CurName;
      end;
    end;
  end;
  
  //���¶�λGrid�ڵ�ǰ�������޸ĵļ�¼��
  cdsBrowser.Locate('DUTY_ID',DUTY_ID,[]);
end;

//��ʼ��Gird��KeyList
procedure TfrmDutyInfoList.InitGrid;
var
  rs: TZQuery;
  GridCol: TColumnEh;
begin
  GridCol:=FindColumn(DBGridEh1,'UPDUTY_ID');
  if GridCol=nil then exit;
  rs := Global.GetZQueryFromName('CA_DUTY_INFO');
  if not rs.Active then Exit;
  GridCol.KeyList.Clear;
  GridCol.PickList.Clear;
  rs.First;
  while not rs.Eof do
  begin
    GridCol.KeyList.Add(rs.FieldByName('LEVEL_ID').asstring);
    GridCol.PickList.Add(rs.FieldByName('DUTY_NAME').AsString);
    rs.Next;
  end;
end;

procedure TfrmDutyInfoList.FormCreate(Sender: TObject);
begin
  inherited;
  //�ж��Ƿ�Ϊ��˾�ܵ�
  //ShopGlobal.GetIsCompany(Global.UserID);
  // IsCompany:=true;
  InitGrid;  //��ʼ��Gird��KeyList
  CreateTree;
end;

procedure TfrmDutyInfoList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actInfoExecute(nil);
  //actEditExecute(nil);
end;

function TfrmDutyInfoList.FindNode(ID: string): TTreeNode;
var
  i:Integer;
begin
  Result := nil;
  for i:=1 to rzTree.Items.Count -1 do
  begin
    if (UpperCase(ID)=UpperCase(TRecord_(rzTree.Items[i].Data).FieldByName('DUTY_ID').AsString))  then
    begin
      Result := rzTree.Items[i];
      exit;
    end;
  end;
end;

procedure TfrmDutyInfoList.CreateTree;
var
  rs: TZQuery;
  Obj: TRecord_;
  Root,P: TTreeNode;
begin
  rzTree.OnChange:=nil;
  rs := Global.GetZQueryFromName('CA_DUTY_INFO');
  rs.SortedFields:='LEVEL_ID';
  rs.SortType:=stAscending;
  CreateLevelTree(rs,rzTree,'333333333','Duty_ID','Duty_NAME','LEVEL_ID',1,3,'');
  Obj  := TRecord_.Create;
  try
    Obj.ReadField(rs);
    Root := rzTree.Items.AddObject(nil,'����ְ��',Obj);
    P := Root.getPrevSibling;
    while P<>nil do
    begin
      P.MoveTo(Root,naAddChildFirst);
      P := Root.getPrevSibling;
    end;
    Root.Selected := True;
  finally
  end;
  rzTree.OnChange:=DoOnTreeChange;
end;

procedure TfrmDutyInfoList.cdsBrowserAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if cdsBrowser.RecNo<=0 then  str:='0'
  else str:=IntToStr(cdsBrowser.RecNo);
  stbPanel.Caption:='��'+str+'��/��'+inttostr(cdsBrowser.RecordCount)+'��';
end;

procedure TfrmDutyInfoList.actPrintExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('31300001', 5) then Raise Exception.Create('��û�д�ӡ'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  if not DBGridEh1.DataSource.DataSet.Active then Raise Exception.Create('û�����ݣ�');
  SetRecNo; //�������
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  PrintDBGridEh1.Print;
end;

procedure TfrmDutyInfoList.actPreviewExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('31300001', 5) then Raise Exception.Create('��û��Ԥ��'+Caption+'��Ȩ��,��͹���Ա��ϵ.');
  if not DBGridEh1.DataSource.DataSet.Active then Raise Exception.Create('û�����ݣ�');
  SetRecNo; //�������
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  with TfrmEhLibReport.Create(self) do
  begin
    try
      Preview(PrintDBGridEh1);
    finally
      free;
    end;
  end; 
end;

procedure TfrmDutyInfoList.DutyTreeSort(SortType: string);
var
  CurObj: TRecord_;
  Params: TftParamList;
begin
  if rzTree.Selected=nil then Exit;
  if rzTree.Selected.Level=0 then Raise Exception.Create('���ڵ㲻��������ѡ���ӽڵ㣡');
  CurObj:=TRecord_(rzTree.Selected.Data);
  if CurObj=nil then Exit;
  if MessageBox(Handle,Pchar('  ���Ҫ����������?   '),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1)=6 then
  begin
    Params:=TftParamList.Create(nil);
    try
      Params.ParamByName('MoveKind').AsString:=SortType;
      Params.ParamByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;   
      Params.ParamByName('LEVEL_ID').asString:=CurObj.fieldbyName('LEVEL_ID').AsString;
      Factor.ExecProc('TDutyInfoSort',Params);
      ShopGlobal.RefreshTable('Ca_DUTY_INFO');
      CreateTree; //���´���Tree
      InitGrid;   //ˢ�µ�Grid���ϼ�ְ��
    finally
      Params.Free;
    end;
  end; 
end;

procedure TfrmDutyInfoList.Sort_FirstClick(Sender: TObject);
begin
  inherited;
  DutyTreeSort('FIRST');
end;

procedure TfrmDutyInfoList.Sort_PriorClick(Sender: TObject);
begin
  inherited;
  DutyTreeSort('PRIOR');
end;

procedure TfrmDutyInfoList.Sort_NextClick(Sender: TObject);
begin
  inherited;
  DutyTreeSort('NEXT');
end;

procedure TfrmDutyInfoList.Sort_LastClick(Sender: TObject);
begin
  inherited;
  DutyTreeSort('LAST');
end;
       
procedure TfrmDutyInfoList.Open;
var
  SQL,Cnd,LEVEL_ID: String;
begin
  inherited;
  Cnd:='';
  SQL:='';
  if (rzTree.Selected <> nil) and (rzTree.Selected.Level>0) then //Tree�ڵ���Ϊ����
  begin
    LEVEL_ID:=trim(TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString);
    if LEVEL_ID<>'' then
      Cnd:=' and substring(LEVEL_ID,1,'+InttoStr(length(LEVEL_ID))+')=:LEVEL_ID ';
  end;
  if edtKey.Text<>'' then //�ؼ��ֲ�ѯ
    Cnd:=Cnd+GetLikeCnd(Factor.iDbType,['DUTY_ID','DUTY_NAME','DUTY_SPELL'],':KEYVALUE','and');

  SQL:='Select 1 as SEQ_NO,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,TENANT_ID,REMARK,SubString(LEVEL_ID,1,len(LEVEL_ID)-3) as UPDUTY_ID '+
       'From CA_DUTY_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') '+Cnd+' order by DUTY_ID ';
  SQL:=ParseSQL(Factor.iDbType,SQL); //����ƥ��ת��

  cdsBrowser.Close;
  cdsBrowser.SQL.Text:=SQL;
  //���ò���:
  if cdsBrowser.Params.FindParam('TENANT_ID')<>nil then
     cdsBrowser.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
  if cdsBrowser.Params.FindParam('LEVEL_ID')<>nil then
     cdsBrowser.ParamByName('LEVEL_ID').AsString:=LEVEL_ID;
  if cdsBrowser.Params.FindParam('KEYVALUE')<>nil then
     cdsBrowser.ParamByName('KEYVALUE').AsString:=trim(edtKey.Text);
  Factor.Open(cdsBrowser);
end;

procedure TfrmDutyInfoList.DoOnTreeChange(Sender: TObject; Node: TTreeNode);
begin
  Open;
end;

function TfrmDutyInfoList.FindColumn(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
var i:integer;
begin
  result := nil;
  for i:=0 to DBGrid.Columns.Count - 1 do
  begin
    if DBGrid.Columns[i].FieldName = FieldName then
    begin
      result := DBGrid.Columns[i];
      Exit;
    end;
  end;
end;

procedure TfrmDutyInfoList.SetRecNo;
begin
  //���������ֶζ�Ӧ��ţ���ӡGridElh��Ҫ�õ�
  if (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then exit;
  try
    cdsBrowser.DisableControls;
    cdsBrowser.First;
    while not cdsBrowser.eof do
    begin
      if cdsBrowser.FieldByName('SEQ_NO').AsInteger<>cdsBrowser.RecNo then
      begin
        cdsBrowser.Edit;
        cdsBrowser.FieldByName('SEQ_NO').AsString:=InttoStr(cdsBrowser.RecNo);
        cdsBrowser.Post;
      end;
      cdsBrowser.Next;
    end;
  finally
    cdsBrowser.EnableControls;
  end;
end;

procedure TfrmDutyInfoList.edtKeyKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
    self.Open;
end;

function TfrmDutyInfoList.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('31300001',6);
end;

end.
