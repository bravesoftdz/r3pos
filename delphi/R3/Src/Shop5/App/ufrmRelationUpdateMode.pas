unit ufrmRelationUpdateMode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzButton, StdCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  Grids, DBGridEh, DB, RzLabel, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, zBase, ExtCtrls, RzPanel, RzTabs, DBGrids;

type
  TfrmRelationUpdateMode = class(TfrmBasic)
    TitlePanel: TPanel;
    Bevel2: TBevel;
    RzPage: TRzPageControl;
    TabUpMode: TRzTabSheet;
    RzPanel2: TRzPanel;
    TabUpResult: TRzTabSheet;
    RzPanel1: TRzPanel;
    edtCHECK_TYPE: TGroupBox;
    RB_ALL: TRadioButton;
    RB_NEW: TRadioButton;
    RB_PRICE: TRadioButton;
    BottonPanel: TPanel;
    Bevel1: TBevel;
    btnOK: TRzBitBtn;
    btnCancel: TRzBitBtn;
    Grid_Relation: TDBGridEh;
    CdsTable: TZQuery;
    Ds: TDataSource;
    LblMsg: TLabel;
    PnlMsg: TPanel;
    RB_ViewAll: TRadioButton;
    RB_ViewOld: TRadioButton;
    RB_ViewNot: TRadioButton;
    RB_ViewNew: TRadioButton;
    RB_DT: TRadioButton;
    RB_Hander: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure Grid_RelationDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure RB_ViewAllClick(Sender: TObject);
    procedure Grid_RelationDblClick(Sender: TObject);
  private
    FAllcount, //当前返回总记录数
    FNotcount, //未对上
    FNewcount, //新对上
    FDtcount,  //重复条码
    FHandcount,  //手工对照
    FOldCount: integer;  //原对上
    function  DoUpdateRelation: Boolean; //更新对照关系
    procedure SetResultMsg;  //设置结果显示
    procedure SetPageTable(PageIdx: integer); //设置分页
    procedure DoFilterResultData;   //过滤数据
    procedure SetUpdateModeResult;  //设置返回结果
    function  GetUpdateMode: integer;  //返回刷新模式
    function  FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
    procedure AddMenu;
    procedure HandRelation(Sender: TObject);  //手工对照
    procedure CancelHandRelation(Sender: TObject);  //取消对照
    procedure CopyCellToClipboard(Sender: TObject); //复制单元格到剪贴板
    procedure SetChoice;
  public
    class function FrmShow: Integer;
  end;

implementation

uses uGlobal, ufrmRelationHandSet;

{$R *.dfm}

class function TfrmRelationUpdateMode.FrmShow:Integer;
begin
  result:=0;
  with TfrmRelationUpdateMode.Create(Application.MainForm) do
  begin
    try    
      if ShowModal=MROK then
        result:=1;
    finally
      free;
    end;
  end;
end;

function TfrmRelationUpdateMode.GetUpdateMode: integer;
begin
  if RB_ALL.Checked then
    result:=1
  else if RB_NEW.Checked then
    result:=2
  else if RB_PRICE.Checked then
    result:=3;
end;

procedure TfrmRelationUpdateMode.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRelationUpdateMode.SetPageTable(PageIdx: integer);
begin
  RzPage.ActivePageIndex:=PageIdx;
  btnOK.Visible:=(PageIdx=0);
  LblMsg.Visible:=(PageIdx=1);
  case PageIdx of
   0:
    begin
      Width:=425;
      Height:=265;
    end;
   1:
    begin
      self.Top:=self.Top-85;
      self.Left:=self.Left-100;
      Width:=630;
      Height:=470;
      btnCancel.Left:=BottonPanel.Width - btnCancel.Width - 30;
      btnCancel.Caption:='关闭(&C)';
      if RB_ALL.Checked then
        LblMsg.Caption:='刷新方式：'+RB_ALL.Caption
      else if RB_NEW.Checked then
        LblMsg.Caption:='刷新方式：'+RB_NEW.Caption
      else if RB_PRICE.Checked then
        LblMsg.Caption:='刷新方式：'+RB_PRICE.Caption;
      LblMsg.Left:=TitlePanel.Width - LblMsg.Width - 30;      
    end;
  end;
end;

procedure TfrmRelationUpdateMode.FormCreate(Sender: TObject);
var
  i: integer;
begin
  inherited;
  for i:=0 to RzPage.PageCount-1 do
    RzPage.Pages[i].TabVisible:=False;
  self.SetPageTable(0);
end;

procedure TfrmRelationUpdateMode.btnOKClick(Sender: TObject);
begin
  inherited;
  if (RzPage.ActivePageIndex=0) and (btnOK.Visible) then
  begin
    if DoUpdateRelation then
    begin
      self.SetPageTable(1);
      self.SetUpdateModeResult;
    end;
  end;
end;

function TfrmRelationUpdateMode.DoUpdateRelation: Boolean;
var
  vParams: TftParamList;
begin
  result:=False;
  try
    FAllcount:=0;
    vParams:=TftParamList.Create(nil);
    vParams.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    vParams.ParamByName('UPDATE_MODE').AsInteger:=GetUpdateMode;
    Factor.Open(CdsTable,'TSynchronGood_Relation',vParams);  //==RspServer连接模式时执行
    result:=CdsTable.Active;
    if result then SetResultMsg;  //显示结果说明
  finally
    vParams.Free;
  end;
end;

procedure TfrmRelationUpdateMode.Grid_RelationDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  ARect: TRect;
  GridDs: TDataSet;
begin
  inherited;
  GridDs:=Grid_Relation.DataSource.DataSet;
  if (GridDs=nil) or (not GridDs.Active) then Exit;
  if (Rect.Top = Grid_Relation.CellRect(Grid_Relation.Col, Grid_Relation.Row).Top) and (not
    (gdFocused in State) or not Grid_Relation.Focused) then
  begin
    Grid_Relation.Canvas.Brush.Color := clAqua;
  end;
  if (trim(GridDs.FieldByName('Update_Flag').AsString)='0') and (trim(LowerCase(Column.FieldName))='updatecase') then
  begin
    Grid_Relation.Canvas.Font.Color := clRed;
    Grid_Relation.Canvas.Font.Style:=[fsBold];
  end else
  if (trim(GridDs.FieldByName('Update_Flag').AsString)='4') and (trim(LowerCase(Column.FieldName))='updatecase') then
  begin
    Grid_Relation.Canvas.Font.Color := clBlue;
    Grid_Relation.Canvas.Font.Style:=[fsBold];
  end;
  
  Grid_Relation.DefaultDrawColumnCell(Rect, DataCol, Column, State);


  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    Grid_Relation.canvas.FillRect(ARect);
    DrawText(Grid_Relation.Canvas.Handle,pchar(Inttostr(GridDs.RecNo)), length(Inttostr(GridDs.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

procedure TfrmRelationUpdateMode.SetUpdateModeResult;
begin
  //设置控件显示
  RB_ViewAll.Visible:=true;
  RB_ViewNot.Visible:=true;
  RB_DT.Left:=268;
  RB_Hander.Left:=349;
  if RB_ALL.Checked then
  begin
    RB_ViewAll.Checked:=true;
    RB_ViewNew.Visible:=true;
    RB_ViewOld.Visible:=true;
    RB_DT.Visible:=true;
    RB_Hander.Visible:=true;
  end else
  if RB_NEW.Checked then
  begin
    RB_ViewNew.Visible:=true;
    RB_ViewNew.Checked:=true;
    RB_DT.Visible:=true;
    RB_DT.Left:=RB_ViewOld.Left;
    RB_Hander.Visible:=true;
    RB_DT.Left:=RB_ViewOld.Left;
    RB_Hander.Left:=275;
  end else
  if RB_PRICE.Checked then
  begin
    RB_ViewAll.Visible:=False;
    RB_ViewNot.Visible:=False;
    RB_ViewNew.Visible:=False;
    RB_ViewOld.Visible:=false;
    RB_DT.Visible:=false;
    RB_Hander.Visible:=false;
  end;                     
  SetChoice;
end;

procedure TfrmRelationUpdateMode.DoFilterResultData;
var
  FilterCnd: string;
begin
  if not CdsTable.Active then Exit;
  if RB_ViewAll.Checked then
  begin
    FilterCnd:='';
    if trim(CdsTable.Filter)='' then Exit;
  end else
  if RB_ViewNot.Checked then
    FilterCnd:=' Update_Flag=0 '
  else
  begin
    if RB_ALL.Checked then
    begin
      if RB_ViewOld.Checked then
        FilterCnd:=' Update_Flag=1 '
      else if RB_ViewNew.Checked then
        FilterCnd:=' Update_Flag=2 '
      else if RB_DT.Checked then
        FilterCnd:=' Update_Flag=4 '
      else if RB_Hander.Checked then
        FilterCnd:=' Update_Flag=5 ';
    end else
    if RB_NEW.Checked then
    begin
      if RB_ViewNew.Checked then
        FilterCnd:=' Update_Flag=2 '
      else if RB_DT.Checked then
        FilterCnd:=' Update_Flag=4 '
      else if RB_Hander.Checked then
        FilterCnd:=' Update_Flag=5 ';
    end;
  end;
  try
    CdsTable.Filtered:=False;
    CdsTable.Filter:=FilterCnd;
    CdsTable.Filtered:=true;
  except
  end;
end;

procedure TfrmRelationUpdateMode.RB_ViewAllClick(Sender: TObject);
begin
  inherited;
  DoFilterResultData;
  //判断并添加菜单
  AddMenu;
  //设置菜单是否显示
  SetChoice;
end;

procedure TfrmRelationUpdateMode.SetResultMsg;
var
  FieldIdx: integer;
begin
  FAllcount:=0;
  FNotcount:=0;
  FNewcount:=0;
  FOldCount:=0;
  FDtcount:=0;
  FHandcount:=0;
  if not CdsTable.Active then Exit;

  FAllcount:=CdsTable.RecordCount;  //返回总记录数据
  FieldIdx:=CdsTable.fieldbyName('Update_Flag').Index; 
  try
    CdsTable.DisableControls;
    CdsTable.First;
    while not CdsTable.Eof do
    begin
      case CdsTable.Fields[FieldIdx].AsInteger of
       0: inc(FNotcount);
       1: inc(FOldCount);
       2: inc(FNewcount);
       4: inc(FDtcount);
       5: inc(FHandcount);
      end;
      CdsTable.Next;
    end;
    if RB_ALL.Checked then
      PnlMsg.Caption:=' 对照结果：总数：'+Inttostr(FAllcount)+'，其中未对上：'+Inttostr(FNotcount)+'，本次对照：'+inttostr(FNewcount)+'，原对照：'+inttostr(FOldCount)+'，条码重复：'+inttoStr(FDtCount)+'，手工对照：'+inttoStr(FHandcount)+' ' 
    else if RB_NEW.Checked then
      PnlMsg.Caption:=' 对照结果：总数：'+Inttostr(FAllcount)+'，其中未对上：'+Inttostr(FNotcount)+'，本次新对照：'+inttostr(FNewcount)+'，条码重复：'+inttoStr(FDtCount)+'，手工对照：'+inttoStr(FHandcount)+' ' 
    else if RB_PRICE.Checked then
      PnlMsg.Caption:=' 刷新结果：总数：'+Inttostr(FAllcount)+' ';
  finally
    CdsTable.EnableControls;
  end; 
end;

function TfrmRelationUpdateMode.FindColumn(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
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

procedure TfrmRelationUpdateMode.AddMenu;
var
  p: TPopupMenu;
  Item :TMenuItem;
  Cmp: TComponent;
  IsExists: Boolean;  
begin
  p := Grid_Relation.PopupMenu;
  if p=nil then Exit;
  //判断[取消手工对照]
  IsExists:=False;
  Cmp:=p.FindComponent('CopyToClipboard');
  if (Cmp<>nil) and (Cmp is TMenuItem) and (Cmp.Tag=11) then
    IsExists:=true;
  if not IsExists then
  begin
    Item := TMenuItem.Create(nil);
    Item.Tag:=10;
    Item.Caption := '-';
    p.Items.Add(Item);
    Item := TMenuItem.Create(nil);
    Item.Caption := '复制';
    Item.Tag:=11;
    Item.Name:='CopyToClipboard';
    Item.OnClick:=CopyCellToClipboard;
    p.Items.Add(Item);
  end;
  
  //判断[手工对照卷烟是否存在]
  IsExists:=False;
  Cmp:=p.FindComponent('AddHandRelation');
  if (Cmp<>nil) and (Cmp is TMenuItem) and (Cmp.Tag=13) then  
    IsExists:=true;
  if not IsExists then
  begin
    Item := TMenuItem.Create(nil);
    Item.Tag:=12;
    Item.Caption := '-';
    p.Items.Add(Item);
    Item := TMenuItem.Create(nil);
    Item.Caption := '手工对照卷烟';
    Item.Tag:=13;
    Item.Name:='AddHandDz';
    Item.OnClick:=HandRelation;
    p.Items.Add(Item);
  end;
  
end;

procedure TfrmRelationUpdateMode.HandRelation(Sender: TObject);
var
  CName: string;
  IsCHoice: Boolean;
  ReData: OleVariant;
begin
  IsCHoice:=False;
  try
    if CdsTable.State in [dsEdit,dsInsert] then CdsTable.Post;
    CdsTable.DisableControls;
    CdsTable.First;
    while not CdsTable.Eof do
    begin
      if CdsTable.FieldByName('FLAG').AsString='1' then
      begin
        IsCHoice:=true;
        break;
      end;
      CdsTable.Next;
    end;
  finally
    CdsTable.EnableControls;
  end;
  if not IsCHoice then Raise Exception.Create('请先选择手工对照的卷烟'); 
  ReData:=CdsTable.Data;
  if TfrmRelationHandSet.FrmShow(ReData)=1 then
  begin
    try
      CdsTable.Filtered:=False;
      CdsTable.DisableControls;
      CdsTable.First;
      while not CdsTable.Eof do
      begin
        if CdsTable.FieldByName('FLAG').AsString='1' then
        begin
          CdsTable.Edit;
          CdsTable.FieldByName('FLAG').AsString:='0';
          CdsTable.FieldByName('Update_Flag').AsString:='5';
          CdsTable.FieldByName('UpdateCase').AsString:='手工对照';
          CdsTable.Post;
        end;
        CdsTable.Next;
      end;  
    finally
      CdsTable.EnableControls;
      DoFilterResultData;
    end;
  end;
end;

procedure TfrmRelationUpdateMode.SetChoice;
var
  i: integer;
  Pm: TPopupMenu;
  Item: TMenuItem;
  SetCol: TColumnEh;
begin
  SetCol:=FindColumn(Grid_Relation,'FLAG');
  if SetCol<>nil then
  begin
    SetCol.Visible:=False;
    SetCol.Visible:=(RB_ViewNot.Visible and RB_ViewNot.Checked) or
                    (RB_DT.Visible and RB_DT.Checked);  //是否显示

    Pm:=Grid_Relation.PopupMenu;
    for i:=0 to Pm.Items.Count-1 do
    begin
      Item:=Pm.Items[i];
      if Pos('手工对照卷烟', Item.Caption)>0 then
        Item.Enabled:=SetCol.Visible;
    end;
  end;
end;

procedure TfrmRelationUpdateMode.Grid_RelationDblClick(Sender: TObject);
var
  i: integer;
  R3GodsInfo,MainGodsInfo,Cnd,MainID,COMM_ID,vFields: string;
  Rs: TZQuery;
  StrList: TStringList;
begin
  //手工对照查看对照关系：
  if (RB_Hander.Visible) and (RB_Hander.Checked) then
  begin
    try
      R3GodsInfo:='';
      Cnd:=','+trim(CdsTable.fieldbyName('SECOND_ID').AsString)+',';
      case Factor.iDbType of
       0: Cnd:=' and CHARINDEX('''+Cnd+''',COMM_ID)>0 ';
       1: Cnd:=' and INSTR(COMM_ID,'''+Cnd+''',1,1)>0 ';
       4: Cnd:=' and LOCATE('''+Cnd+''',COMM_ID)>0 ';
      end;
      StrList:=TStringList.Create;
      Rs:=TZQuery.Create(nil);
      Rs.SQL.Text:='select GODS_ID,GODS_CODE,GODS_NAME,SECOND_ID,COMM_ID,BARCODE from VIW_GOODSINFO '+
                   ' where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and RELATION_ID='+IntToStr(NT_RELATION_ID)+Cnd;
      Factor.Open(Rs);
      if (Rs.Active) and (Rs.RecordCount=1) then
      begin
        R3GodsInfo:='R3的卷烟：编码:'+Rs.fieldbyName('GODS_CODE').AsString+'， 名称：'+Rs.fieldbyName('GODS_NAME').AsString+'， 条码:'+Rs.fieldbyName('BARCODE').AsString;
        COMM_ID:=trim(Rs.fieldbyName('COMM_ID').AsString);
        MainID:=trim(Rs.fieldbyName('SECOND_ID').AsString);
        case Factor.iDbType of
         0:
          begin
            Cnd:=' and CHARINDEX(SECOND_ID,'''+COMM_ID+''')>0 ';
            vFields:='(case when CHARINDEX('',''+SECOND+'','','''+COMM_ID+''')>0 then 1 else 0 end) as IsFlag ';
          end;
         1:
          begin
            Cnd:=' and INSTR('''+COMM_ID+''',SECOND_ID,1,1)>0 ';
            vFields:='(case when INSTR('''+COMM_ID+''','','' || SECOND_ID || '','',1,1)>0 then 1 else 0 end) as IsFlag ';
          end;
         4:
          begin
            Cnd:=' and LOCATE(SECOND_ID,'''+COMM_ID+''')>0 ';
            vFields:='(case when LOCATE('','' || SECOND_ID || '','','''+COMM_ID+''',1,1)>0 then 1 else 0 end) as IsFlag ';
          end;
        end;
        Rs.Close;
        Rs.SQL.Text:='select SECOND_ID,GODS_CODE,GODS_NAME,PACK_BARCODE,'+vFields+' from INF_GOODS_RELATION where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and RELATION_ID='+IntToStr(NT_RELATION_ID)+Cnd;
        Factor.Open(Rs);
        while not Rs.Eof do
        begin
          if trim(Rs.FieldByName('SECOND_ID').AsString)=MainID then 
            MainGodsInfo:='第三方主对照卷烟：  编码:'+Rs.fieldbyName('GODS_CODE').AsString+'， 名称：'+Rs.fieldbyName('GODS_NAME').AsString+'， 条码:'+Rs.fieldbyName('PACK_BARCODE').AsString
          else
            StrList.Add('编码:'+Rs.fieldbyName('GODS_CODE').AsString+'， 名称：'+Rs.fieldbyName('GODS_NAME').AsString+'， 条码:'+Rs.fieldbyName('PACK_BARCODE').AsString);
          Rs.Next;
        end;
        if StrList.Count=1 then
        begin
          Cnd:=R3GodsInfo+#13+
               '--------------------------------------------------------------------------------------------------------------'+#13+
               MainGodsInfo+#13+
               '第三方共同对照卷烟：'+StrList.Strings[0];
        end else
        begin
          Cnd:='';
          for i:=0 to StrList.Count-1 do
          begin
            if Cnd='' then
              Cnd:='('+InttoStr(i+1)+')'+trim(StrList.Strings[i])+';' 
            else
              Cnd:=Cnd+#13+'('+InttoStr(i+1)+')'+trim(StrList.Strings[i])+';';
          end;

          Cnd:=R3GodsInfo+#13+
               '--------------------------------------------------------------------------------------------------------------                 '+#13+
               MainGodsInfo+#13+
               '第三方共同对照卷烟：'+#13+
               Cnd;
        end;
        MessageBox(self.Handle,pchar('  '+#13+Cnd+#13+' '),'友情提示...',MB_OK+MB_ICONQUESTION);
      end;
    finally
      Rs.Free;
      StrList.Free;
    end;
  end;
end;

procedure TfrmRelationUpdateMode.CopyCellToClipboard(Sender: TObject);
var
  pmem: Pchar;
  CopyStr: Pchar;
  hMem: THandle;
  ColName: string;
  GridDs: TDataSet;
begin
  ColName:=trim(Grid_Relation.SelectedField.FieldName);
  GridDs:=Grid_Relation.DataSource.DataSet;
  if GridDs.FindField(ColName)<>nil then
  begin
    CopyStr:=Pchar(trim(GridDs.FindField(ColName).AsString));
    if CopyStr<>'' then
    begin
      hMem:=GlobalAlloc(GHND or GMEM_DDESHARE,20);
      if hMem <> 0 then
      begin
        pMem:=GlobalLock(hMem);  {加锁全局内存块}
        if pMem <> nil then
        begin
          StrCopy(pMem,CopyStr); {向全局内存块写入数据}
          GlobalUnlock(hMem);    {解锁全局内存块}
        end;
      end;
      OpenClipboard(0);
      EmptyClipboard();
      SetClipboardData(CF_TEXT,hMem);
      CloseClipboard();
      GlobalFree(hMem);
    end;
  end;
end;

procedure TfrmRelationUpdateMode.CancelHandRelation(Sender: TObject);
var
  CName: string;
  InObj: TRecord_;
begin
{
  if trim(CdsTable.fieldbyName('GODS_CODE').AsString)='' then
    Raise Exception.Create('请先选择手工对照的卷烟');
  try
    InObj:=TRecord_.Create;
    if TfrmRelationHandSet.FrmShowCancel(InObj)=1 then
    begin
      CdsTable.Filtered:=False;
      CdsTable.DisableControls;
      CdsTable.First;
      while not CdsTable.Eof do
      begin
        if CdsTable.FieldByName('FLAG').AsString='1' then
        begin
          CdsTable.Edit;
          CdsTable.FieldByName('FLAG').AsString:='0';
          CdsTable.FieldByName('Update_Flag').AsString:='5';
          CdsTable.FieldByName('UpdateCase').AsString:='手工对照';
          CdsTable.Post;
        end;
        CdsTable.Next;
      end;
      finally
        CdsTable.EnableControls;
        DoFilterResultData;
      end;
    end;
  end;
 }
end;

end.
