unit ufrmNoteBook;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ImgList, ExtCtrls, RzPanel, ActnList, Menus, RzBckgnd,
  RzBmpBtn, RzTabs, Grids, DBGridEh, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, StdCtrls, ComCtrls,ObjCommon, ZBase, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, RzLabel, cxCalendar,
  cxButtonEdit, zrComboBoxList;

type
  TfrmNoteBook = class(TfrmBasic)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzBackground1: TRzBackground;
    Image1: TImage;
    RzPanel7: TRzPanel;
    RzPanel6: TRzPanel;
    RzPanel8: TRzPanel;
    RzPanel9: TRzPanel;
    RzPanel10: TRzPanel;
    btn_Message0: TRzBmpButton;
    btn_Message1: TRzBmpButton;
    btn_Message2: TRzBmpButton;
    btn_Message3: TRzBmpButton;
    btn_Message4: TRzBmpButton;
    Image2: TImage;
    Image3: TImage;
    btn_Close: TRzBmpButton;
    RzPage: TRzPageControl;
    TabTittle: TRzTabSheet;
    TabContents: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    DsNewsPaper: TDataSource;
    CdsNoteBook: TZQuery;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    RzPanel11: TRzPanel;
    RzPanel12: TRzPanel;
    edtNB_TEXT: TRichEdit;
    btnReturn: TRzBmpButton;
    btn_Message5: TRzBmpButton;
    Pm_NB_Group: TPopupMenu;
    Edit_Group: TMenuItem;
    NoteBookType: TZQuery;
    BtnNew: TRzBmpButton;
    Pm_NoteBook: TPopupMenu;
    NewNote: TMenuItem;
    lab_IDX_TYPE: TRzLabel;
    edtNB_TYPE: TcxComboBox;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    edtNB_GROUP: TcxComboBox;
    RzLabel4: TRzLabel;
    lblSTOCK_DATE: TLabel;
    edtNB_DATE: TcxDateEdit;
    Label2: TLabel;
    Label1: TLabel;
    edtNB_TITLE: TcxTextEdit;
    RzLabel1: TRzLabel;
    edtUSER_ID: TzrComboBoxList;
    CdsNoteBookInfo: TZQuery;
    LblMsg: TLabel;
    Btn_new: TRzBmpButton;
    Btn_save: TRzBmpButton;
    DelNote: TMenuItem;
    ActNewNB: TAction;
    ActSaveNB: TAction;
    ActEditNB: TAction;
    ActDeleteNB: TAction;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure Edit_GroupClick(Sender: TObject);
    procedure btn_Message0Click(Sender: TObject);
    procedure btn_Message1Click(Sender: TObject);
    procedure btn_Message2Click(Sender: TObject);
    procedure btn_Message3Click(Sender: TObject);
    procedure btn_Message4Click(Sender: TObject);
    procedure btn_Message5Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActNewNBExecute(Sender: TObject);
    procedure ActEditNBExecute(Sender: TObject);
    procedure ActSaveNBExecute(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
    procedure edtNB_TYPEKeyPress(Sender: TObject; var Key: Char);
    procedure edtNB_TEXTChange(Sender: TObject);
    procedure edtNB_TITLEPropertiesChange(Sender: TObject);
    procedure edtNB_GROUPPropertiesChange(Sender: TObject);
    procedure edtNB_TYPEPropertiesChange(Sender: TObject);
    procedure edtUSER_IDPropertiesChange(Sender: TObject);
    procedure edtNB_DATEPropertiesChange(Sender: TObject);
    procedure Pm_NoteBookPopup(Sender: TObject);
    procedure NewNoteClick(Sender: TObject);
    procedure ActDeleteNBExecute(Sender: TObject);
    procedure DelNoteClick(Sender: TObject);
    procedure edtNB_TEXTKeyPress(Sender: TObject; var Key: Char);
  private
    FBtnIdx: integer; //默认按钮
    FdbState: TDataSetState;  //记录状态
    ID:String;
    FOldID: string;
    MSG_Tpye:Integer;
    SelObj: TRecord_;
    AObj: TRecord_;
    sFlag:Integer;
    NB_GROUP: array[0..5] of string;
    FNoteBookType: TZQuery;
    procedure SetRecordNum;
    procedure CreateNoteBookType; //创建分类
    procedure SetBtnProperty(BtnIdx: integer); //设置按钮索引等属性
    procedure SetdbState(Value: TDataSetState);
    procedure SetdsEdit;
  public
    procedure OpenNoteBookList; //打开List
    procedure OpenNoteBookInfo(NB_ID: string); //打开Info
    procedure ReadFromObj(Aobj: TRecord_);  //读取数据
    procedure WriteToObj(Aobj: TRecord_);   //写入对象
    procedure LoadPic32;
    class function ShowNoteBook(Title_ID:String;Msg_Class:Integer=0;Flag:Integer=0):Boolean;
    property dbState: TDataSetState read FdbState write SetdbState; 
  end;


implementation

uses
  uShopUtil, ufrmMain, uShopGlobal, uGlobal, uDsUtil, uFnUtil, uRcFactory,
  ufrmCodeInfo;

{$R *.dfm}

{ TfrmNoteBook }

class function TfrmNoteBook.ShowNoteBook(Title_ID: String;Msg_Class:Integer;Flag:Integer): Boolean;
begin
  with TfrmNoteBook.Create(Application.MainForm) do
    begin
      try
        ID := Title_ID;
        MSG_Tpye := Msg_Class;
        sFlag := Flag;
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmNoteBook.btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmNoteBook.FormCreate(Sender: TObject);
var i:Integer;
begin
  inherited;
  Initform(self);
  //记事本分类
  CreateNoteBookType;
  for i := 0 to RzPage.PageCount - 1 do
    RzPage.Pages[i].TabVisible := False;
  RzPage.ActivePageIndex := 0;
  LoadPic32;
  OpenNoteBookList;
  i:=CdsNoteBook.RecordCount;
  SetRecordNum;
  edtUSER_ID.DataSet:=Global.GetZQueryFromName('CA_USERS');
  //默认第一个按钮
  SetBtnProperty(0);
  AObj:=TRecord_.Create;
  SelObj:=TRecord_.Create;
  BtnNew.Action:=ActNewNB;
  if i=0 then
    ActNewNBExecute(Sender);  
end;

procedure TfrmNoteBook.OpenNoteBookList;
var
  Str: string;
begin
  Str:=
    'select ROWS_ID,USER_ID,NB_SEQNO,NB_GROUP,NB_TYPE,NB_DATE,''·'''+GetStrJoin(Factor.iDbType)+'NB_TITLE as NB_TITLE from OA_NOTEBOOK '+
    ' where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and ((NB_TYPE=''2'') or ((NB_TYPE=''1'') and (USER_ID='''+Global.UserID+''')))'+
    ' order by NB_DATE DESC,NB_SEQNO DESC';
  CdsNoteBook.Close;
  CdsNoteBook.SortedFields:='';
  CdsNoteBook.SQL.Text := Str;
  Factor.Open(CdsNoteBook);
  CdsNoteBook.SortedFields:='NB_DATE DESC;NB_SEQNO DESC';
end;

procedure TfrmNoteBook.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var  ARect: TRect;
  AFont:TFont;
begin
  inherited;
  if CdsNoteBook.IsEmpty then Exit;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;

  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'NB_INFO' then
    begin
      ARect := Rect;
      AFont := TFont.Create;
      AFont.Assign(DBGridEh1.Canvas.Font);
      try
        DBGridEh1.canvas.FillRect(ARect);
        DBGridEh1.Canvas.Font.Color := clBlue;
        DBGridEh1.Canvas.Font.Style := [fsUnderline];
        DrawText(DBGridEh1.Canvas.Handle,pchar('详情'),length('详情'),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER);
      finally
        DBGridEh1.Canvas.Font.Assign(AFont);
        AFont.Free;
      end;
    end;
end;

procedure TfrmNoteBook.SetRecordNum;
 procedure SetCdsFilter(RsNote: TZQuery; NB_GROUP: string);
 begin
   RsNote.Filtered:=False;
   RsNote.Filter:='NB_GROUP='''+NB_GROUP+''' ';
   RsNote.Filtered:=True; 
 end;
var
  RsNote: TZQuery;
  CodeName: string;
begin
  try
    RsNote:=TZQuery.Create(nil);
    RsNote.Data:=NoteBookType.Data;
    //btn_Message0
    if (NB_GROUP[0]<>'') and (btn_Message0.Visible) then
    begin
      SetCdsFilter(RsNote,NB_GROUP[0]);
      if RsNote.RecordCount>0 then
      begin
        CodeName:=trim(btn_Message0.Caption);
        btn_Message0.Caption:='    '+CodeName+' ('+IntToStr(RsNote.RecordCount)+')'
      end;
    end;
    //btn_Message1
    if (NB_GROUP[1]<>'') and (btn_Message1.Visible) then
    begin
      SetCdsFilter(RsNote,NB_GROUP[1]);
      if RsNote.RecordCount>0 then
      begin
        CodeName:=trim(btn_Message1.Caption);
        btn_Message1.Caption:='    '+CodeName+' ('+IntToStr(RsNote.RecordCount)+')'
      end;
    end;
    //btn_Message2
    if (NB_GROUP[2]<>'') and (btn_Message2.Visible) then
    begin
      SetCdsFilter(RsNote,NB_GROUP[2]);
      if RsNote.RecordCount>0 then
      begin
        CodeName:=trim(btn_Message2.Caption);
        btn_Message2.Caption:='    '+CodeName+' ('+IntToStr(RsNote.RecordCount)+')'
      end;
    end;
    //btn_Message3
    if (NB_GROUP[3]<>'') and (btn_Message3.Visible) then
    begin
      SetCdsFilter(RsNote,NB_GROUP[3]);
      if RsNote.RecordCount>0 then
      begin
        CodeName:=trim(btn_Message3.Caption);
        btn_Message3.Caption:='    '+CodeName+' ('+IntToStr(RsNote.RecordCount)+')'
      end;
    end;
    //btn_Message4
    if (NB_GROUP[4]<>'') and (btn_Message4.Visible) then
    begin
      SetCdsFilter(RsNote,NB_GROUP[4]);
      if RsNote.RecordCount>0 then
      begin
        CodeName:=trim(btn_Message4.Caption);
        btn_Message4.Caption:='    '+CodeName+' ('+IntToStr(RsNote.RecordCount)+')'
      end;
    end;
    //btn_Message5
    if (NB_GROUP[5]<>'') and (btn_Message5.Visible) then
    begin
      SetCdsFilter(RsNote,NB_GROUP[5]);
      if RsNote.RecordCount>0 then
      begin
        CodeName:=trim(btn_Message5.Caption);
        btn_Message5.Caption:='    '+CodeName+' ('+IntToStr(RsNote.RecordCount)+')'
      end;
    end;                                          
  finally
    RsNote.Free;
  end;
end;

procedure TfrmNoteBook.DBGridEh1CellClick(Column: TColumnEh);
begin
  inherited;
  if CdsNoteBook.IsEmpty then Exit;
  if trim(Column.FieldName)='NB_INFO' then
    DBGridEh1DblClick(nil);
end;

procedure TfrmNoteBook.LoadPic32;
var
  sflag:String;
begin
  sflag := 's'+rcFactory.GetResString(1)+'_';
  //Top
  //Image1.Picture.Graphic := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Top');
  //Mid
  Image2.Picture.Graphic := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid2');
  Image3.Picture.Graphic := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid3');
  btn_Message0.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Up');
  btn_Message0.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Down');
  btn_Message0.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Hot');
  btn_Message1.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Up');
  btn_Message1.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Down');
  btn_Message1.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Hot');
  btn_Message2.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Up');
  btn_Message2.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Down');
  btn_Message2.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Hot');
  btn_Message3.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Up');
  btn_Message3.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Down');
  btn_Message3.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Hot');
  btn_Message4.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Up');
  btn_Message4.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Down');
  btn_Message4.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid1_Hot');
  btn_Message5.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid4_Up');
  btn_Message5.Bitmaps.Down := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid4_Down');
  btn_Message5.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Mid4_Hot');
  btnReturn.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Return');
  //Bottom
  btn_Close.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Bottom_Close_Up');
  btn_Close.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Bottom_Close_Hot');
  //新增：
  BtnNew.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Bottom_Close_Up');
  BtnNew.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'NewsPaperReader_Bottom_Close_Hot');
end;

procedure TfrmNoteBook.SetBtnProperty(BtnIdx: integer);
begin
  btn_Message0.Font.Color := clWindowText;
  btn_Message1.Font.Color := clWindowText;
  btn_Message2.Font.Color := clWindowText;
  btn_Message3.Font.Color := clWindowText;
  btn_Message4.Font.Color := clWindowText;
  btn_Message5.Font.Color := clWindowText;
  case BtnIdx of
   0: btn_Message0.Font.Color := clRed;
   1: btn_Message1.Font.Color := clRed;
   2: btn_Message2.Font.Color := clRed;
   3: btn_Message3.Font.Color := clRed;
   4: btn_Message4.Font.Color := clRed;
   5: btn_Message5.Font.Color := clRed;
  end; 
  if RzPage.ActivePageIndex = 1 then RzPage.ActivePageIndex := 0;
  CdsNoteBook.Filtered := False;
  CdsNoteBook.Filter := ' NB_GROUP='''+NB_GROUP[BtnIdx]+''' ';
  CdsNoteBook.Filtered := True;
  // DBGridEh1.Visible:=(CdsNoteBook.RecordCount>0);
  if self.Visible then
  begin
    DBGridEh1.SetFocus;
    DBGridEh1.SelectedIndex:=1;
  end;
  FBtnIdx:=BtnIdx;
  dbState:=dsBrowse;
end;

procedure TfrmNoteBook.CreateNoteBookType;
var
  Str,NewID,CodeName: string;
  NBObj: TRecord_;
begin
  ClearCbxPickList(edtNB_GROUP);
  NoteBookType.Close;
  NoteBookType.SQL.Text:='select SEQ_NO,CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''19'' and COMM not in (''02'',''12'') order by SEQ_NO';
  Factor.Open(NoteBookType);
  if NoteBookType.IsEmpty then
  begin
    NewID:=TSequence.NewId();
    Str:='insert into PUB_CODE_INFO '+
               '(TENANT_ID,CODE_ID,LEVEL_ID,CODE_TYPE,CODE_NAME,CODE_SPELL,SEQ_NO,COMM,TIME_STAMP)'+
         'values('+IntToStr(Global.TENANT_ID)+','''+NewID+''','''',''19'',''我的记事本'',''WDJSB'',1,''00'','+GetTimeStamp(Factor.iDbType)+')';
    Factor.ExecSQL(Str);
    NoteBookType.Append;
    NoteBookType.FieldByName('SEQ_NO').AsInteger:=1;
    NoteBookType.FieldByName('CODE_ID').AsString:=NewID;
    NoteBookType.FieldByName('CODE_NAME').AsString:='我的记事本';
    NoteBookType.Post;
  end;
  //设置成空
  btn_Message0.Caption:='';
  btn_Message1.Caption:='';
  btn_Message2.Caption:='';
  btn_Message3.Caption:='';
  btn_Message4.Caption:='';
  btn_Message5.Caption:='';
  NB_GROUP[0]:='';
  NB_GROUP[1]:='';
  NB_GROUP[2]:='';
  NB_GROUP[3]:='';
  NB_GROUP[4]:='';
  NB_GROUP[5]:='';
  NoteBookType.First;
  while not NoteBookType.Eof do
  begin
    CodeName:=trim(NoteBookType.FieldByName('CODE_NAME').AsString);
    case NoteBookType.RecNo-1 of
     0: btn_Message0.Caption:=CodeName;
     1: btn_Message1.Caption:=CodeName;
     2: btn_Message2.Caption:=CodeName;
     3: btn_Message3.Caption:=CodeName;
     4: btn_Message4.Caption:=CodeName;
     5: btn_Message5.Caption:=CodeName;
    end;
    if NoteBookType.RecNo-1<6 then
      NB_GROUP[NoteBookType.RecNo-1]:=trim(NoteBookType.FieldByName('CODE_ID').AsString);
    //添加到:edtNB_GROUP
    NBObj:=TRecord_.Create;
    NBObj.ReadFromDataSet(NoteBookType); 
    edtNB_GROUP.Properties.Items.AddObject(CodeName,NBObj); 
    NoteBookType.Next;
  end;
  btn_Message0.Visible:=(btn_Message0.Caption<>'');
  btn_Message1.Visible:=(btn_Message1.Caption<>'');
  btn_Message2.Visible:=(btn_Message2.Caption<>'');
  btn_Message3.Visible:=(btn_Message3.Caption<>'');
  btn_Message4.Visible:=(btn_Message4.Caption<>'');
  btn_Message5.Visible:=(btn_Message5.Caption<>'');
end;


procedure TfrmNoteBook.Edit_GroupClick(Sender: TObject);
begin
  try
    TfrmCodeInfo.ShowDialogMax(self,6,19);
  finally
    CreateNoteBookType;
  end;
end;

procedure TfrmNoteBook.btn_Message0Click(Sender: TObject);
begin
  SetBtnProperty(0);
end;

procedure TfrmNoteBook.btn_Message1Click(Sender: TObject);
begin
  SetBtnProperty(1);
end;

procedure TfrmNoteBook.btn_Message2Click(Sender: TObject);
begin
  SetBtnProperty(2);
end;

procedure TfrmNoteBook.btn_Message3Click(Sender: TObject);
begin
  SetBtnProperty(3);
end;

procedure TfrmNoteBook.btn_Message4Click(Sender: TObject);
begin
  SetBtnProperty(4);
end;

procedure TfrmNoteBook.btn_Message5Click(Sender: TObject);
begin
  SetBtnProperty(5);
end;

procedure TfrmNoteBook.DBGridEh1DblClick(Sender: TObject);
begin
  if CdsNoteBook.IsEmpty then Exit;
  SelObj.ReadFromDataSet(CdsNoteBook);
  ActEditNB.Execute;
end;

procedure TfrmNoteBook.FormDestroy(Sender: TObject);
begin
  inherited;
  Freeform(self);
  AObj.Free;
  SelObj.Free;
end;

procedure TfrmNoteBook.OpenNoteBookInfo(NB_ID: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('USER_ID').asString := Global.UserID;
    Params.ParamByName('ROWS_ID').asString := NB_ID;
    CdsNoteBookInfo.Close;
    Factor.Open(CdsNoteBookInfo,'TNoteBook',Params);
    AObj.ReadFromDataSet(CdsNoteBookInfo);
    ReadFromObj(AObj); 
  finally
    Params.Free;
  end;   
end;

procedure TfrmNoteBook.SetdbState(Value: TDataSetState);
 procedure SetComponentColor(setColor: TColor);
 begin
   edtNB_TITLE.Style.Color:=setColor;
   edtNB_GROUP.Style.Color:=setColor;
   edtNB_TYPE.Style.Color:=setColor;
   edtNB_TEXT.Color:=setColor;
   edtUSER_ID.Style.Color:=setColor;
   edtNB_DATE.Style.Color:=setColor;
 end;
var
  NB_TYPE:string;
begin
  FdbState:=Value;
  edtNB_TITLE.Properties.ReadOnly:=False;
  edtNB_GROUP.Properties.ReadOnly:=False;
  edtNB_TYPE.Properties.ReadOnly:=False;
  edtNB_TEXT.ReadOnly:=False;
  edtUSER_ID.Properties.ReadOnly:=False;
  edtNB_DATE.Properties.ReadOnly:=False;
  case dbState of
   dsInsert,dsEdit:
    begin
      BtnNew.Action:=ActSaveNB;  //保存
      BtnNew.Bitmaps.Hot:=Btn_save.Bitmaps.Hot;
      BtnNew.Bitmaps.Up:=Btn_save.Bitmaps.Up;
      SetComponentColor(clWindow);
    end;
   dsBrowse:
    begin
      BtnNew.Action:=ActNewNB;   //新单
      BtnNew.Bitmaps.Hot:=Btn_new.Bitmaps.Hot;
      BtnNew.Bitmaps.Up:=Btn_new.Bitmaps.Up;
      if RzPage.ActivePage=TabContents then
      begin
        NB_TYPE:=trim(AObj.FieldByName('NB_TYPE').AsString);
        if ((NB_TYPE='2')and(AObj.FieldByName('USER_ID').AsString<>Global.UserID)) then
        begin
          edtNB_TITLE.Properties.ReadOnly:=(dbState=dsBrowse);
          edtNB_GROUP.Properties.ReadOnly:=(dbState=dsBrowse);
          edtNB_TYPE.Properties.ReadOnly:=(dbState=dsBrowse);
          edtNB_TEXT.ReadOnly:=(dbState=dsBrowse);
          edtUSER_ID.Properties.ReadOnly:=(dbState=dsBrowse);
          edtNB_DATE.Properties.ReadOnly:=(dbState=dsBrowse);
          SetComponentColor($00EAEAEA)
        end else
          SetComponentColor(clWindow);
      end;
    end;
  end;
end;

procedure TfrmNoteBook.ActSaveNBExecute(Sender: TObject);
begin
  if trim(edtNB_TITLE.Text)='' then
  begin
    if (RzPage.ActivePage=TabContents) and edtNB_TITLE.CanFocus then edtNB_TITLE.SetFocus;
    Raise Exception.Create('   请记事本输入标题...    ');
  end;
  if edtNB_GROUP.ItemIndex=-1 then
  begin
    if (RzPage.ActivePage=TabContents) and edtNB_GROUP.CanFocus then edtNB_GROUP.SetFocus;
    Raise Exception.Create('   请记事本分类...    ');
  end;
  if edtNB_TYPE.ItemIndex=-1 then
  begin
    if (RzPage.ActivePage=TabContents) and edtNB_TYPE.CanFocus then edtNB_TYPE.SetFocus;
    Raise Exception.Create('   请记事本类型...    ');
  end;
  if Length(edtNB_TEXT.Text)>255 then
  begin
    if (RzPage.ActivePage=TabContents) and edtNB_TEXT.CanFocus then edtNB_TEXT.SetFocus;
    Raise Exception.Create('   记录本内容超过长度(255)，请重新编辑   ');
  end;
  WriteToObj(AObj);
  if dbState=dsInsert then
    CdsNoteBookInfo.Append
  else if dbState=dsEdit then
    CdsNoteBookInfo.Edit;
  AObj.WriteToDataSet(CdsNoteBookInfo);
  if CdsNoteBookInfo.State in [dsInsert,dsEdit] then CdsNoteBookInfo.Post;
  if Factor.UpdateBatch(CdsNoteBookInfo,'TNoteBook',nil) then
  begin
    FOldID:='';
    //写入到列表
    case dbState of
     dsInsert:
      begin
        OpenNoteBookInfo(AObj.FieldByName('ROWS_ID').AsString); 
        CdsNoteBook.Append;
        CdsNoteBook.FieldByName('ROWS_ID').AsString:=AObj.FieldByName('ROWS_ID').AsString;
        CdsNoteBook.FieldByName('USER_ID').AsString:=AObj.FieldByName('USER_ID').AsString;
        CdsNoteBook.FieldByName('NB_SEQNO').AsInteger:=AObj.FieldByName('NB_SEQNO').AsInteger;
        CdsNoteBook.FieldByName('NB_GROUP').AsString:=AObj.FieldByName('NB_GROUP').AsString;
        CdsNoteBook.FieldByName('NB_TYPE').AsString:=AObj.FieldByName('NB_TYPE').AsString;
        CdsNoteBook.FieldByName('NB_DATE').AsString:=AObj.FieldByName('NB_DATE').AsString;
        CdsNoteBook.FieldByName('NB_TITLE').AsString:='·'+AObj.FieldByName('NB_TITLE').AsString;  
        CdsNoteBook.Post;
     end;
     dsEdit:
      begin
        if CdsNoteBook.Locate('ROWS_ID',AObj.FieldByName('ROWS_ID').AsString,[]) then
        begin
          CdsNoteBook.Edit;
          CdsNoteBook.FieldByName('USER_ID').AsString:=AObj.FieldByName('USER_ID').AsString;
          CdsNoteBook.FieldByName('NB_GROUP').AsString:=AObj.FieldByName('NB_GROUP').AsString;
          CdsNoteBook.FieldByName('NB_TYPE').AsString:=AObj.FieldByName('NB_TYPE').AsString;
          CdsNoteBook.FieldByName('NB_DATE').AsString:=AObj.FieldByName('NB_DATE').AsString;
          CdsNoteBook.FieldByName('NB_TITLE').AsString:='·'+AObj.FieldByName('NB_TITLE').AsString;
          CdsNoteBook.Post;
        end;
      end;
    end;
    FOldID:=trim(CdsNoteBook.FieldByName('ROWS_ID').AsString);
    dbState:=dsBrowse;
    BtnNew.Action:=ActNewNB;
  end;
end;

procedure TfrmNoteBook.ActNewNBExecute(Sender: TObject);
var CurValue: string;
begin
  if RzPage.ActivePage<>TabContents then
    RzPage.ActivePage:=TabContents;
  OpenNoteBookInfo('');
  dbState:=dsInsert;
  //默认记录
  CurValue:=trim(NB_GROUP[FBtnIdx]);
  edtNB_GROUP.ItemIndex:=TdsItems.FindItems(edtNB_GROUP.Properties.Items,'CODE_ID',CurValue);
  if edtNB_TYPE.Properties.Items.Count>0 then edtNB_TYPE.ItemIndex:=0;
  edtUSER_ID.KeyValue:=Global.UserID;
  edtUSER_ID.Text:=Global.UserName;
  edtNB_DATE.Date:=Global.SysDate;
end;

procedure TfrmNoteBook.ReadFromObj(Aobj: TRecord_);
var
  SetReadOnly: Boolean;
  ReValue: string;
  UserDs: TDataSet;
begin
  //标题:
  edtNB_TITLE.Text:=trim(AObj.FieldByName('NB_TITLE').AsString);
  //类型(公共、私密):
  ReValue:=trim(AObj.FieldByName('NB_GROUP').AsString);
  SetReadOnly:=edtNB_GROUP.Properties.ReadOnly;
  if SetReadOnly then edtNB_GROUP.Properties.ReadOnly:=False;
  edtNB_GROUP.ItemIndex:=TdsItems.FindItems(edtNB_GROUP.Properties.Items,'CODE_ID',ReValue);
  if SetReadOnly then edtNB_GROUP.Properties.ReadOnly:=true;
  //分类:
  ReValue:=trim(AObj.FieldByName('NB_TYPE').AsString);
  SetReadOnly:=edtNB_TYPE.Properties.ReadOnly;
  if SetReadOnly then edtNB_TYPE.Properties.ReadOnly:=False;
  edtNB_TYPE.ItemIndex:=TdsItems.FindItems(edtNB_TYPE.Properties.Items,'CODE_ID',ReValue);
  if SetReadOnly then edtNB_TYPE.Properties.ReadOnly:=true;
  //记事本内容:
  edtNB_TEXT.Text:=trim(AObj.FieldByName('NB_TEXT').AsString);
  //签名:
  ReValue:=trim(AObj.FieldByName('USER_ID').AsString);
  UserDs:=edtUSER_ID.DataSet;
  if (UserDs.Active) and (UserDs.Locate('USER_ID',ReValue,[])) then
  begin
    edtUSER_ID.KeyValue:=ReValue;
    edtUSER_ID.Text:=trim(UserDs.FieldByName('USER_NAME').AsString);
  end;
  //日期:
  if AObj.FieldbyName('NB_DATE').AsInteger>0 then
    edtNB_DATE.Date := fnTime.fnStrtoDate(AObj.FieldbyName('NB_DATE').AsString)
  else
    edtNB_DATE.EditValue:=null;
end;

procedure TfrmNoteBook.WriteToObj(Aobj: TRecord_);
var
  ReValue: string;
  SelObj: TRecord_;
  UserDs: TDataSet;
begin
  if dbState=dsInsert then
  begin
    Aobj.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    Aobj.FieldByName('ROWS_ID').AsString:=TSequence.NewId();
  end;
  //标题:
  AObj.FieldByName('NB_TITLE').AsString:=edtNB_TITLE.Text;
  //类型(公共、私密):
  if edtNB_GROUP.ItemIndex<>-1 then
  begin
    SelObj:=TRecord_(edtNB_GROUP.Properties.Items.Objects[edtNB_GROUP.ItemIndex]);
    SelObj.Fields[0].asstring;
    if SelObj<>nil then
      AObj.FieldByName('NB_GROUP').AsString:=SelObj.FieldByName('CODE_ID').AsString;
  end;
  //分类:
  if edtNB_TYPE.ItemIndex<>-1 then
  begin
    SelObj:=TRecord_(edtNB_TYPE.Properties.Items.Objects[edtNB_TYPE.ItemIndex]);
    if SelObj<>nil then
      AObj.FieldByName('NB_TYPE').AsString:=SelObj.FieldByName('CODE_ID').AsString;
  end;
  //记事本内容:
  AObj.FieldByName('NB_TEXT').AsString:=trim(edtNB_TEXT.Text);
  //签名:
  AObj.FieldByName('USER_ID').AsString:=edtUSER_ID.AsString;
  //日期:
  AObj.FieldByName('NB_DATE').AsInteger:=StrToInt(FormatDatetime('YYYYMMDD',edtNB_DATE.Date));
end;

procedure TfrmNoteBook.ActEditNBExecute(Sender: TObject);
begin
  if CdsNoteBook.IsEmpty then Exit;
  if RzPage.ActivePage<>TabContents then
  begin
    RzPage.ActivePage:=TabContents;
    OpenNoteBookInfo(trim(SelObj.FieldByName('ROWS_ID').AsString));
    if trim(SelObj.FieldByName('USER_ID').AsString)=Global.UserID then
    begin
      dbState:=dsEdit;
      FOldID:=trim(SelObj.FieldByName('ROWS_ID').AsString);
    end else
    begin
      dbState:=dsBrowse;
      FOldID:='';
    end;
  end;
end;

procedure TfrmNoteBook.btnReturnClick(Sender: TObject);
var
  ReRun,ChangeCount: integer;
  MsgStr: string;
  SelObj: TRecord_;
begin
  if (dbState in [dsInsert,dsEdit]) and (RzPage.ActivePage=TabContents) then
  begin
    ReRun:=-1;
    case dbState of
     dsInsert:
      begin
        if (trim(edtNB_TITLE.Text)<>'') and (edtNB_GROUP.ItemIndex<>-1) and (edtNB_TYPE.ItemIndex<>-1) and
           (trim(edtNB_TEXT.Text)<>'')  and (trim(edtUSER_ID.AsString)<>'') and (edtNB_DATE.EditValue<>null) then
          ReRun:=MessageBox(self.Handle,Pchar('     '+#13+'     新单还没保存，是否保存？   '+#13+'      '),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
      end;
     dsEdit:
      begin
        ChangeCount:=0;
        if trim(AObj.FieldByName('NB_TITLE').AsString)<>trim(edtNB_TITLE.Text) then Inc(ChangeCount);
        if ChangeCount=0 then
        begin
          SelObj:=TRecord_(edtNB_GROUP.Properties.Items.Objects[edtNB_GROUP.ItemIndex]);
          if trim(AObj.FieldByName('NB_GROUP').AsString)<>trim(SelObj.FieldByName('CODE_ID').AsString) then Inc(ChangeCount);
        end;
        if ChangeCount=0 then
        begin
          SelObj:=TRecord_(edtNB_TYPE.Properties.Items.Objects[edtNB_TYPE.ItemIndex]);
          if trim(AObj.FieldByName('NB_TYPE').AsString)<>trim(SelObj.FieldByName('CODE_ID').AsString) then Inc(ChangeCount);
        end;
        if (ChangeCount=0) and (trim(AObj.FieldByName('USER_ID').AsString)<>trim(edtUSER_ID.AsString)) then Inc(ChangeCount);
        if ChangeCount>0 then
          ReRun:=MessageBox(self.Handle,Pchar('     '+#13+'     当前还没保存，是否保存？   '+#13+'      '),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
      end;
    end;
    case ReRun of
     6: ActSaveNB.Execute;
     else
       dbState:=dsBrowse;
    end;
  end else
    dbState:=dsBrowse;

  if RzPage.ActivePage=TabContents then
  begin
    RzPage.ActivePage:=TabTittle;
    DBGridEh1.SetFocus;
    if DBGridEh1.DataSource.DataSet.RecordCount=0 then
      DBGridEh1.SelectedIndex:=0
    else
      DBGridEh1.SelectedIndex:=1;
  end;
end;

procedure TfrmNoteBook.edtNB_TYPEKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
    edtNB_TEXT.SetFocus;
end;

procedure TfrmNoteBook.SetdsEdit;
begin
  if (dbState=dsBrowse) and (trim(FOldID)<>'') then
    dbState:=dsEdit;
end;

procedure TfrmNoteBook.edtNB_TEXTChange(Sender: TObject);
var
  NoteLen: integer;
  NoteText: string;
begin
  inherited;
  SetdsEdit;
  NoteText:=trim(edtNB_TEXT.Text);
  NoteLen:=Length(NoteText);
  if NoteLen=255 then
  begin
    LblMsg.Font.Color:=clNavy;
    LblMsg.Caption:='记录内容长度已经是最大长度(255);';
  end else
  if NoteLen>255 then
  begin
    LblMsg.Font.Color:=clRed;
    LblMsg.Caption:='记录内容长度超长(255);';
  end;
  LblMsg.Visible:=(NoteLen>=255);
end;

procedure TfrmNoteBook.edtNB_TITLEPropertiesChange(Sender: TObject);
begin
  inherited;
  SetdsEdit;
end;

procedure TfrmNoteBook.edtNB_GROUPPropertiesChange(Sender: TObject);
begin
  inherited;
  SetdsEdit;
end;

procedure TfrmNoteBook.edtNB_TYPEPropertiesChange(Sender: TObject);
begin
  inherited;
  SetdsEdit;
end;

procedure TfrmNoteBook.edtUSER_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  SetdsEdit;
end;

procedure TfrmNoteBook.edtNB_DATEPropertiesChange(Sender: TObject);
begin
  inherited;
  SetdsEdit;
end;

procedure TfrmNoteBook.Pm_NoteBookPopup(Sender: TObject);
var i: integer;
begin
  for i:=0 to Pm_NoteBook.Items.Count-1 do
  begin
    if Pm_NoteBook.Items[i].Name <> NewNote.Name then
      Pm_NoteBook.Items[i].Visible:=DBGridEh1.Visible;
  end;
end;

procedure TfrmNoteBook.NewNoteClick(Sender: TObject);
begin
  ActNewNBExecute(Sender);
end;

procedure TfrmNoteBook.ActDeleteNBExecute(Sender: TObject);
var
  Str: string;
begin
  SelObj.ReadFromDataSet(CdsNoteBook);
  if trim(SelObj.FieldByName('ROWS_ID').AsString)<>'' then
  begin
    Str:='delete from OA_NOTEBOOK where TENANT_ID='+IntToStr(Global.TENANT_ID)+
         ' and ROWS_ID='''+SelObj.FieldByName('ROWS_ID').AsString+''' ';
    if Factor.ExecSQL(Str)=1 then  //删除1条记录
      CdsNoteBook.Delete; 
  end;
end;

procedure TfrmNoteBook.DelNoteClick(Sender: TObject);
begin
  inherited;
  ActDeleteNB.Execute;
end;

procedure TfrmNoteBook.edtNB_TEXTKeyPress(Sender: TObject; var Key: Char);
begin
  if (LblMsg.Visible) and (not (Key in [#8,#13,#46])) then
    Key:=#0;
end;

end.
