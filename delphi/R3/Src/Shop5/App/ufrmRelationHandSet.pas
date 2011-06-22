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
  //�����̲ݹ�Ӧ��ID:1000006
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
    procedure btnCancelClick(Sender: TObject);
    procedure Grid_RelationDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh;State: TGridDrawState);
    procedure Grid_RelationCellClick(Column: TColumnEh);
    procedure btnOKClick(Sender: TObject);
    function  CheckIsExistsRelation(var MsgStr: string): Boolean;
  private
    ReRun: integer;
    FSecond_IDS: string;
    function  FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
    procedure InitParams(vData: OleVariant);
  public
    class function FrmShow(vData: OleVariant): Integer;
    class function FrmShowCancel(Aobj: TRecord_): Integer;
  end;

implementation

uses uGlobal, ObjCommon;

{$R *.dfm}

class function TfrmRelationHandSet.FrmShow(VData: OleVariant):Integer;
begin
  result:=0;
  with TfrmRelationHandSet.Create(Application.MainForm) do
  begin
    try
      InitParams(vData);
      ShowModal;
      result:=ReRun;
    finally
      free;
    end;
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
  ReRun:=0;
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
  Edt_RimGods.Text:='���ţ�'+CdsTable.fieldbyName('GODS_CODE').AsString+
                    '  ����:'+CdsTable.fieldbyName('GODS_NAME').AsString;  
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
    Grid_Relation.Canvas.Brush.Color := clAqua;   //ѡ����ɫ״̬
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
  Edt_RimGods.Text:='���ţ�'+CdsTable.fieldbyName('GODS_CODE').AsString+
                    '  ����:'+CdsTable.fieldbyName('GODS_NAME').AsString; 
end;

procedure TfrmRelationHandSet.btnOKClick(Sender: TObject);
var
  Msg: string;
begin
  if R3_GODS_ID.AsString='' then raise Exception.Create('��ѡ��R3����Ʒ');
  //�жϵ�ǰѡ����Ƿ��Ѵ��ڶ��չ�ϵ��
  SaveQry.Close;     //������Ծ�����ҵ�ã��̶���Ӧ��:
  SaveQry.SQL.Text:='select * from PUB_GOODS_RELATION where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and RELATION_ID='+IntToStr(NT_RELATION_ID)+' and GODS_ID='''+R3_GODS_ID.AsString+''' ';
  Factor.Open(SaveQry);

  //�༭ǰ�жϵ�ǰ��ѡ��Ʒ�Ƿ����ڹ�Ӧ��
  CheckIsExistsRelation(Msg);
  if MessageBox(Handle,pChar(Msg),'������ʾ..',MB_YESNO+MB_ICONQUESTION)<>6 then Abort;

  //����
  SaveQry.Edit;
  if SaveQry.FieldByName('ROWS_ID').AsString='' then //���ؿռ�¼
  begin
    SaveQry.FieldByName('ROWS_ID').AsString:=NewId('');
    SaveQry.FieldByName('GODS_ID').AsString:=R3_GODS_ID.AsString;
    SaveQry.FieldByName('GODS_CODE').AsString:=R3_GODS_ID.DataSet.fieldbyName('GODS_CODE').AsString;
    SaveQry.FieldByName('GODS_NAME').AsString:=R3_GODS_ID.DataSet.fieldbyName('GODS_NAME').AsString;
    SaveQry.FieldByName('GODS_SPELL').AsString:=R3_GODS_ID.DataSet.fieldbyName('GODS_SPELL').AsString;
    SaveQry.FieldByName('COMM').AsString:='00';
    SaveQry.FieldByName('TIME_STAMP').AsInteger:=1; //���ò��գ���̨��ȡ
  end;
  SaveQry.FieldByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
  SaveQry.FieldByName('RELATION_ID').AsInteger:=NT_RELATION_ID;
  SaveQry.FieldByName('COMM_ID').AsString:=FSecond_IDS; 
  SaveQry.FieldByName('SECOND_ID').AsString:=CdsTable.fieldbyName('SECOND_ID').AsString;  //Rim��GODS_ID
  SaveQry.FieldByName('SORT_ID2').AsString:=CdsTable.fieldbyName('SORT_ID2').AsString;
  SaveQry.FieldByName('SORT_ID6').AsString:=CdsTable.fieldbyName('SORT_ID6').AsString;
  SaveQry.FieldByName('NEW_INPRICE').AsFloat:=CdsTable.fieldbyName('NEW_INPRICE').AsFloat;
  SaveQry.FieldByName('NEW_OUTPRICE').AsFloat:=CdsTable.fieldbyName('NEW_OUTPRICE').AsFloat;
  SaveQry.Post;

  //�ύ
  if Factor.UpdateBatch(SaveQry,'THandSetRelation',nil) then
  begin
    MessageBox(Application.Handle,pchar('����ɹ���'),'������ʾ...',MB_OK+MB_ICONQUESTION);
    Global.RefreshTable('PUB_GOODSINFO');
    ModalResult:=MROK;
    ReRun:=1;
    self.Close;
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
      if COMM_ID<>'' then //���ֹ�����
        Rs.SQL.Text:='select * from PUB_GOODS_RELATION where SECOND_ID in ('''+stringReplace(COMM_ID,',',''',''',[rfReplaceAll])+''')'
      else
        Rs.SQL.Text:='select * from PUB_GOODS_RELATION where SECOND_ID='''+trim(SaveQry.FieldByName('SECOND_ID').AsString)+''' ' ;
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
              COMM_ID:='         ('+InttoStr(Rs.RecNo)+')����:'+Rs.FieldbyName('GODS_CODE').AsString+' �����ƣ�'+Rs.FieldbyName('GODS_NAME').AsString+'�������룺'+Rs.FieldbyName('PACK_BARCODE').AsString
            else
              COMM_ID:=COMM_ID+#13+'         ('+InttoStr(Rs.RecNo)+')����:'+Rs.FieldbyName('GODS_CODE').AsString+' �����ƣ�'+Rs.FieldbyName('GODS_NAME').AsString+'�������룺'+Rs.FieldbyName('PACK_BARCODE').AsString;
            Rs.Next;
          end;
          Str:='��ѡ����̡�'+NT_GOODSINFO.FieldByName('GODS_NAME').AsString+'���Ѵ��ڶ��չ�ϵ��'+#13+COMM_ID+#13+'�� ���Ҫ������';
        end else
        if Rs.RecordCount=1 then
        begin
          Str:='��ѡ����̡�'+NT_GOODSINFO.FieldByName('GODS_NAME').AsString+'���Ѵ��ڶ��չ�ϵ��'+#13+
               '        ����:'+Rs.FieldbyName('GODS_CODE').AsString+' �����ƣ�'+Rs.FieldbyName('GODS_NAME').AsString+'�������룺'+Rs.FieldbyName('PACK_BARCODE').AsString+#13+'�� ���Ҫ������';
        end;
      end;
      result:=true;
    finally
      Rs.Free;
    end;
  end else
  begin
    Str:='��ѡ����̡�'+NT_GOODSINFO.FieldByName('GODS_NAME').AsString+'��δ������̹�Ӧ��, ȷ��Ҫ������';
    if MessageBox(Handle,pChar(Str),'������ʾ..',MB_YESNO+MB_ICONQUESTION)<>6 then Abort;
    result:=true;
  end;
end;

class function TfrmRelationHandSet.FrmShowCancel(Aobj: TRecord_): Integer;
begin

end;

end.
