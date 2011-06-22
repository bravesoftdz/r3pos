unit ufrmRelationHandSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzButton, StdCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  Grids, DBGridEh, DB, RzLabel, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, zBase, ExtCtrls, RzPanel, RzTabs, DBGrids, cxButtonEdit,
  zrComboBoxList;

const
  //国家烟草供应链ID:1000006
  NT_RELATION_ID=1000006;  

type
  TfrmRelationHandSet = class(TfrmBasic)
    TitlePanel: TPanel;
    labTitle: TLabel;
    Bevel2: TBevel;
    HintL: TLabel;
    BottonPanel: TPanel;
    Bevel1: TBevel;
    btnOK: TRzBitBtn;
    btnCancel: TRzBitBtn;
    CdsTable: TZQuery;
    Ds: TDataSource;
    R3_GODS_ID: TzrComboBoxList;
    RzPage: TRzPageControl;
    TabUpResult: TRzTabSheet;
    RzPanel1: TRzPanel;
    Grid_Relation: TDBGridEh;
    Label1: TLabel;
    Edt_RimGods: TcxTextEdit;
    Label2: TLabel;
    Label3: TLabel;
    SaveQry: TZQuery;
    NT_GOODSINFO: TZQuery;
    edt_R3Gods: TcxTextEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure Grid_RelationDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh;State: TGridDrawState);
    procedure Grid_RelationCellClick(Column: TColumnEh);
    procedure btnOKClick(Sender: TObject);
  private
    FCOMM_ID: string;
    FGods_ID: string;
    FInObj: TRecord_;
    vType: integer;
    ReRun: integer;
    FSecond_IDS: string;
    function  FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
    function  CheckIsExistsRelation(var MsgStr: string): Boolean;
    procedure InitParams(vData: OleVariant);
    procedure DoHandSetRelation;  //手工对照过程
    procedure InitParamsCancel(Aobj: TRecord_);
    procedure DoCancelHandSetRelation;  //取消手工对照过程
  public
    class function FrmShow(vData: OleVariant): Integer;
    class function FrmShowCancel(Aobj: TRecord_): Integer;
  end;

implementation

uses uGlobal, ObjCommon;

{$R *.dfm}

class function TfrmRelationHandSet.FrmShow(VData: OleVariant):Integer;
var
  FrmObj: TfrmRelationHandSet;
begin
  result:=0;
  try
    FrmObj:=TfrmRelationHandSet.Create(Application.MainForm);
    FrmObj.InitParams(vData);
    FrmObj.ShowModal;
    result:=FrmObj.ReRun;
  finally
    FrmObj.free;
  end;
end;

class function TfrmRelationHandSet.FrmShowCancel(Aobj: TRecord_): Integer;
var
  FrmObj: TfrmRelationHandSet;
begin
  result:=0;
  try
    FrmObj:=TfrmRelationHandSet.Create(Application.MainForm);
    FrmObj.InitParamsCancel(Aobj);
    FrmObj.ShowModal;
    result:=FrmObj.ReRun;
  finally
    FrmObj.free;
  end;
end;

procedure TfrmRelationHandSet.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;
 

function TfrmRelationHandSet.FindColumn(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
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

procedure TfrmRelationHandSet.InitParams(vData: OleVariant);
var
  Str: string;
begin
  vType:=1;
  ReRun:=0;
  edt_R3Gods.Visible:=False;
  Grid_Relation.DataSource:=nil;
  Str:='select GODS_ID,GODS_CODE,GODS_NAME,GODS_SPELL,BARCODE from VIW_GOODSINFO '+
       ' where TENANT_ID=110000001 and RELATION_ID=0 and COMM not in (''02'',''12'')';
  NT_GOODSINFO.Close;
  NT_GOODSINFO.SQL.Text:=Str;
  Factor.Open(NT_GOODSINFO);
  
  R3_GODS_ID.DataSet:=NT_GOODSINFO; //Global.GetZQueryFromName('PUB_GOODSINFO');
  CdsTable.Close;
  CdsTable.Data:=vData;
  CdsTable.Filtered:=False;
  CdsTable.Filter:=' FLAG=''1'' ';
  CdsTable.Filtered:=true;
  FSecond_IDS:=',';
  CdsTable.First;
  while not CdsTable.Eof do
  begin
    FSecond_IDS:=FSecond_IDS+trim(CdsTable.fieldbyName('SECOND_ID').AsString)+',';
    CdsTable.Next;
  end;
  CdsTable.First;
  Edt_RimGods.Text:='货号：'+CdsTable.fieldbyName('GODS_CODE').AsString+
                    '  名称:'+CdsTable.fieldbyName('GODS_NAME').AsString;  
  Grid_Relation.DataSource:=Ds;
end;

procedure TfrmRelationHandSet.Grid_RelationDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = Column.Grid.CellRect(Column.Grid.Col, Column.Grid.Row).Top) and
     (not (gdFocused in State) or not Column.Grid.Focused) then
  begin
    Grid_Relation.Canvas.Font.Style :=[fsBold];
    Grid_Relation.Canvas.Brush.Color := clAqua;   //选中颜色状态
  end else
    Grid_Relation.Canvas.Font.Style :=[];

  Column.Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    Grid_Relation.canvas.Brush.Color := clBtnFace;
    Grid_Relation.canvas.FillRect(ARect);
    DrawText(Grid_Relation.Canvas.Handle,pchar(Inttostr(cdsTable.RecNo)),length(Inttostr(cdsTable.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

procedure TfrmRelationHandSet.Grid_RelationCellClick(Column: TColumnEh);
begin
  inherited;
  if self.vType=1 then
  begin
    Edt_RimGods.Text:='货号：'+CdsTable.fieldbyName('GODS_CODE').AsString+
                      '  名称:'+CdsTable.fieldbyName('GODS_NAME').AsString;
  end;
end;

function TfrmRelationHandSet.CheckIsExistsRelation(var MsgStr: string): Boolean;
var
  Rs: TZQuery;
  Str,COMM_ID: string;
begin
  result:=false;
  if SaveQry.FieldByName('ROWS_ID').AsString<>'' then
  begin
    COMM_ID:=trim(SaveQry.FieldByName('COMM_ID').AsString);
    try
      Rs:=TZQuery.Create(nil);
      if COMM_ID<>'' then //是手工对照
        Rs.SQL.Text:='select * from PUB_GOODS_RELATION where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and SECOND_ID in ('''+stringReplace(COMM_ID,',',''',''',[rfReplaceAll])+''')'
      else
        Rs.SQL.Text:='select * from PUB_GOODS_RELATION where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and SECOND_ID='''+trim(SaveQry.FieldByName('SECOND_ID').AsString)+''' ' ;
      Factor.Open(Rs);
      if Rs.RecordCount>0 then
      begin
        COMM_ID:='';
        if Rs.RecordCount>1 then
        begin
          Rs.First;
          while not Rs.Eof do
          begin
            if COMM_ID='' then
              COMM_ID:='         ('+InttoStr(Rs.RecNo)+')编码:'+Rs.FieldbyName('GODS_CODE').AsString+' ，名称：'+Rs.FieldbyName('GODS_NAME').AsString+' '
            else
              COMM_ID:=COMM_ID+#13+'         ('+InttoStr(Rs.RecNo)+')编码:'+Rs.FieldbyName('GODS_CODE').AsString+' ，名称：'+Rs.FieldbyName('GODS_NAME').AsString;
            Rs.Next;
          end;
          Str:='您选择卷烟〖'+NT_GOODSINFO.FieldByName('GODS_NAME').AsString+'〗已存在对照关系：'+#13+COMM_ID+#13+'， 真的要覆盖吗？';
        end else
        if Rs.RecordCount=1 then
        begin
          Str:='您选择卷烟〖'+NT_GOODSINFO.FieldByName('GODS_NAME').AsString+'〗已存在对照关系：'+#13+
               '        编码:'+Rs.FieldbyName('GODS_CODE').AsString+' ，名称：'+Rs.FieldbyName('GODS_NAME').AsString+#13+'， 真的要覆盖吗？';
        end;
      end;
      result:=true;
    finally
      Rs.Free;
    end;
  end else
  begin
    Str:=' 您选择卷烟“'+NT_GOODSINFO.FieldByName('GODS_NAME').AsString+'”, 确定要对照吗？';
    result:=true;
  end;
  MsgStr:=Str;
end;

procedure TfrmRelationHandSet.InitParamsCancel(Aobj: TRecord_);
var
  i: integer;
  R3GodsInfo,MainGodsInfo,Cnd,MainID,COMM_ID,vFields: string;
  StrList: TStringList;
begin
  ReRun:=0;
  vType:=2;
  edt_R3Gods.Visible:=true;
  R3_GODS_ID.Visible:=False;
  btnOK.Left:=btnOK.Left-15;
  btnOK.Width:=btnOK.Width+15;
  btnOK.Caption:='取消对照关系';
  FInObj:= Aobj; //外面传入

  //手工对照查看对照关系：
  R3GodsInfo:='';
  Cnd:=','+trim(Aobj.fieldbyName('SECOND_ID').AsString)+',';
  case Factor.iDbType of
   0: Cnd:=' and CHARINDEX('''+Cnd+''',COMM_ID)>0 ';
   1: Cnd:=' and INSTR(COMM_ID,'''+Cnd+''',1,1)>0 ';
   4: Cnd:=' and LOCATE('''+Cnd+''',COMM_ID)>0 ';
  end;
  StrList:=TStringList.Create;
  CdsTable.Close;
  CdsTable.SQL.Text:='select GODS_ID,GODS_CODE,GODS_NAME,SECOND_ID,COMM_ID,BARCODE from VIW_GOODSINFO '+
               ' where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and RELATION_ID='+IntToStr(NT_RELATION_ID)+Cnd;
  Factor.Open(CdsTable);
  if (CdsTable.Active) and (CdsTable.RecordCount=1) then
  begin
    FCOMM_ID:=trim(CdsTable.fieldbyName('COMM_ID').AsString);
    FGods_ID:=trim(CdsTable.fieldbyName('GODS_ID').AsString);
    edt_R3Gods.Text:='编码:'+CdsTable.fieldbyName('GODS_CODE').AsString+'， 名称：'+CdsTable.fieldbyName('GODS_NAME').AsString+'， 条码:'+CdsTable.fieldbyName('BARCODE').AsString;
    COMM_ID:=trim(CdsTable.fieldbyName('COMM_ID').AsString);
    MainID:=trim(CdsTable.fieldbyName('SECOND_ID').AsString);

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
    CdsTable.Close;
    CdsTable.SQL.Text:='select 0 as A,SECOND_ID,GODS_CODE,GODS_NAME,PACK_BARCODE,'+vFields+',NEW_INPRICE,NEW_OUTPRICE from INF_GOODS_RELATION where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and RELATION_ID='+IntToStr(NT_RELATION_ID)+Cnd;
    Factor.Open(CdsTable);
    CdsTable.First;
    while not CdsTable.Eof do
    begin
      if CdsTable.FieldByName('IsFlag').AsString='1' then //主对照
      begin
        Edt_RimGods.Text:='货号：'+CdsTable.fieldbyName('GODS_CODE').AsString+'   名称:'+CdsTable.fieldbyName('GODS_NAME').AsString;
      end;
      CdsTable.Next;
    end;
    Ds.DataSet:=CdsTable;
    Grid_Relation.DataSource:=Ds;      
  end;
end;

procedure TfrmRelationHandSet.DoHandSetRelation;
var
  Msg: string;
begin
  if R3_GODS_ID.AsString='' then raise Exception.Create('请选择R3的商品');
  //判断当前选入的是否已存在对照关系：
  SaveQry.Close;     //对照针对卷烟行业用，固定供应链:
  SaveQry.SQL.Text:='select * from PUB_GOODS_RELATION where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and RELATION_ID='+IntToStr(NT_RELATION_ID)+' and GODS_ID='''+R3_GODS_ID.AsString+''' ';
  Factor.Open(SaveQry);

  //编辑前判断当前所选商品是否已在供应两
  CheckIsExistsRelation(Msg);
  if MessageBox(Handle,pChar(Msg),'友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Abort;

  //保存
  SaveQry.Edit;
  if SaveQry.FieldByName('ROWS_ID').AsString='' then //返回空记录
  begin
    SaveQry.FieldByName('ROWS_ID').AsString:=NewId('');
    SaveQry.FieldByName('GODS_ID').AsString:=R3_GODS_ID.AsString;
    SaveQry.FieldByName('GODS_CODE').AsString:=R3_GODS_ID.DataSet.fieldbyName('GODS_CODE').AsString;
    SaveQry.FieldByName('GODS_NAME').AsString:=R3_GODS_ID.DataSet.fieldbyName('GODS_NAME').AsString;
    SaveQry.FieldByName('GODS_SPELL').AsString:=R3_GODS_ID.DataSet.fieldbyName('GODS_SPELL').AsString;
    SaveQry.FieldByName('COMM').AsString:='00';
    SaveQry.FieldByName('TIME_STAMP').AsInteger:=1; //设置不空，后台在取
  end;
  SaveQry.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
  SaveQry.FieldByName('RELATION_ID').AsInteger:=NT_RELATION_ID;
  SaveQry.FieldByName('COMM_ID').AsString:=FSecond_IDS; 
  SaveQry.FieldByName('SECOND_ID').AsString:=CdsTable.fieldbyName('SECOND_ID').AsString;  //Rim的GODS_ID
  SaveQry.FieldByName('SORT_ID2').AsString:=CdsTable.fieldbyName('SORT_ID2').AsString;
  SaveQry.FieldByName('SORT_ID6').AsString:=CdsTable.fieldbyName('SORT_ID6').AsString;
  SaveQry.FieldByName('NEW_INPRICE').AsFloat:=CdsTable.fieldbyName('NEW_INPRICE').AsFloat;
  SaveQry.FieldByName('NEW_OUTPRICE').AsFloat:=CdsTable.fieldbyName('NEW_OUTPRICE').AsFloat;
  SaveQry.Post;

  //提交
  if Factor.UpdateBatch(SaveQry,'THandSetRelation',nil) then
  begin
    MessageBox(Application.Handle,pchar('保存成功！'),'友情提示...',MB_OK+MB_ICONQUESTION);
    Global.RefreshTable('PUB_GOODSINFO');
    ModalResult:=MROK;
    ReRun:=1;
    self.Close;
  end;
end;

procedure TfrmRelationHandSet.DoCancelHandSetRelation;
var
  i: integer;
  str: string;
begin
  if MessageBox(Handle,pChar('真的要取消手工对照？'),'友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  str:='delete from PUB_GOODS_RELATION where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and RELATION_ID='+IntToStr(NT_RELATION_ID)+
       ' and GODS_ID='''+FGods_ID+''' and COMM_ID='''+FCOMM_ID+''' ';
  try
   if Factor.ExecSQL(str)=1 then
   begin
     MessageBox(Application.Handle,pchar('取消手工对照成功！'),'友情提示...',MB_OK+MB_ICONQUESTION);
     Global.RefreshTable('PUB_GOODSINFO');
     ModalResult:=MROK;
     ReRun:=1;
     self.Close;
   end;
  Except
    Raise Exception.Create('取消手工对照错误！');
  end; 
end;

procedure TfrmRelationHandSet.btnOKClick(Sender: TObject);
begin
  case self.vType of
   1: DoHandSetRelation;
   2: DoCancelHandSetRelation;
  end;
end;

end.
