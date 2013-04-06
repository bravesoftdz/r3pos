{ 32600001	0	商品档案	1	查询  2	新增	3	修改	4	删除	5	打印	6	导出    }
unit ufrmGoodsInfoList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, cxControls,ADODB,
  cxContainer, cxEdit, cxTextEdit, RzButton, zBase, DB, DBClient, RzTreeVw,
  FR_Class, PrnDbgeh, jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  DBGrids, Buttons, cxMaskEdit, cxDropDownEdit;

type
  TfrmGoodsInfoList = class(TframeToolForm)
    RzPanel1: TRzPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label2: TLabel;
    edtKey: TcxTextEdit;
    DataSource1: TDataSource;
    Splitter1: TSplitter;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    btnOk: TRzBitBtn;
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    stbPanel: TPanel;
    Label1: TLabel;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    actCopyNew: TAction;
    N7: TMenuItem;
    actPrintBarCode: TAction;
    cdsBrowser: TZQuery;
    AddSortTree: TPopupMenu;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    PrintDBGridEh1: TPrintDBGridEh;
    ToolButton3: TToolButton;
    actDefineState: TAction;
    Excel1: TMenuItem;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    Panel2: TPanel;
    rzTree: TRzTreeView;
    RzPanel6: TRzPanel;
    Label3: TLabel;
    fndGODS_FLAG1: TcxComboBox;
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure actFindExecute(Sender: TObject);
    procedure edtKeyKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtKeyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actNewExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure rzTreeChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
    procedure ToolButton8Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure actCopyNewExecute(Sender: TObject);
    procedure actPrintBarCodeExecute(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure cdsBrowserAfterScroll(DataSet: TDataSet);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure N8Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure actDefineStateExecute(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure fndGODS_FLAG1PropertiesChange(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
  private
     edtProperty1,edtProperty2: TZQuery;
     procedure PrintView;
     procedure GetNo;
     procedure DoTreeChange(Sender: TObject; Node: TTreeNode);  //
     function  FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
     function  CheckCanExport: boolean; override;
     function  GetReCount: integer;
  public
    IsEnd: boolean;
    MaxId:string;
    locked:boolean;
    rcAmt:integer;
    CSQL:string;
    procedure LoadTree; //刷新SortTree树
    procedure LoadList;
    procedure LoadProv;
    procedure AddRecord(AObj:TRecord_);
    procedure InitGrid;
    function  EncodeSQL(id:string; QryType: integer=0):string; {QryType: 0表示取数据查询; 1表示取总记录数}
    procedure Open(Id:string);
    function  FindNode(ID: string): TTreeNode;
    function  PropertyEnabled:boolean;
    procedure GetProperty;
    procedure PrintBarcode;
  end;

implementation

uses
  uTreeUtil,uGlobal,ufrmGoodsInfo, uShopGlobal,uCtrlUtil, ufrmBarCodePrint, uDsUtil,
  uShopUtil,uFnUtil,ufrmEhLibReport, ufrmSelectGoodSort, ufrmDefineStateInfo,
  ufrmGoodssortTree, ObjCommon, ufrmExcelFactory, ufrmBasic, uMsgBox;
   

{$R *.dfm}
 
procedure TfrmGoodsInfoList.AddRecord(AObj: TRecord_);
var
  GODS_ID,SORT:string;
  EditObj: TRecord_;
  rs:TZQuery;
begin
  //SORT:='';   //zhangsenrong 不刷新树就代表不需要OPEN数据集，树结点不会改变，所以可以不要。
  //if rzTree.Selected<>nil then
  //  SORT:=TRecord_(rzTree.Selected.Data).FieldByName('SORT_ID').AsString;
  //进入商品资料修改没有维护到分类，不需刷新Tree
  // LoadTree;
  //if SORT<>'' THEN FindNode(SORT).Selected:=True;
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  cdsBrowser.DisableControls;
  try
  if not cdsBrowser.Active then Exit;
  if cdsBrowser.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then
  begin
    try
      AObj.WriteToDataSet(cdsBrowser,false);

      if rs.Locate('UNIT_ID',AObj.FieldbyName('UNIT_ID').AsString,[]) then
         begin
           cdsBrowser.Edit;
           cdsBrowser.FieldByName('UNIT_NAME').AsString := rs.FieldByName('UNIT_NAME').AsString;
           cdsBrowser.Post;
         end;
      EditObj:=TRecord_.Create;
      EditObj.ReadFromDataSet(cdsBrowser);
      GODS_ID:=EditObj.FieldByName('GODS_ID').AsString;
      if EditObj.FieldbyName('NEW_OUTPRICE').AsFloat <> 0 then
        EditObj.FieldByName('PROFIT_RATE').AsString := formatfloat('#0',EditObj.FieldbyName('NEW_INPRICE').AsFloat*100/EditObj.FieldbyName('NEW_OUTPRICE').AsFloat)
      else
        EditObj.FieldByName('PROFIT_RATE').AsValue := null;
      EditObj.FieldByName('selflag').AsString:='0';
      cdsBrowser.Edit;
      EditObj.WriteToDataSet(cdsBrowser);

      if cdsBrowser.State=dsEdit then
        cdsBrowser.Post;
    finally
      EditObj.Free;
    end;
  end else
  begin
    GODS_ID:=AObj.FieldByName('GODS_ID').AsString;
    cdsBrowser.Append;
    AObj.WriteToDataSet(cdsBrowser,false);
    if not (cdsBrowser.State in [dsInsert,dsEdit]) then cdsBrowser.Edit;
    cdsBrowser.Post;
    if rs.Locate('UNIT_ID',AObj.FieldbyName('UNIT_ID').AsString,[]) then
       begin
         cdsBrowser.Edit;
         cdsBrowser.FieldByName('UNIT_NAME').AsString := rs.FieldByName('UNIT_NAME').AsString;
         cdsBrowser.Post;
       end;
    try
      EditObj:=TRecord_.Create;
      EditObj.ReadFromDataSet(cdsBrowser);
      EditObj.FieldByName('RELATION_FLAG').AsString:='2'; //新增的商品: 自主经营
      EditObj.FieldByName('RELATION_ID').AsString:='0';   //新增的商品: 自主经营
      EditObj.FieldByName('selflag').AsString:='0';       //标记位
      if EditObj.FieldbyName('NEW_OUTPRICE').AsFloat <> 0 then
        EditObj.FieldByName('PROFIT_RATE').AsString := formatfloat('#0',EditObj.FieldbyName('NEW_INPRICE').AsFloat*100/EditObj.FieldbyName('NEW_OUTPRICE').AsFloat)
      else
        EditObj.FieldByName('PROFIT_RATE').AsValue := null;
      EditObj.WriteToDataSet(cdsBrowser);
      if not (cdsBrowser.State in [dsInsert,dsEdit]) then cdsBrowser.Edit;
      cdsBrowser.Post;
    finally
      EditObj.Free;
    end;
    Inc(rcAmt); //新插入增加一条
    GetNo; //刷新显示记录数
  end;
  InitGrid;
  finally
    cdsBrowser.EnableControls;
  end;
end;

procedure TfrmGoodsInfoList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if not DBGridEh1.DataSource.DataSet.active then Exit;  

  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsBrowser.RecNo)),length(Inttostr(cdsBrowser.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmGoodsInfoList.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
//  if Column.FieldName = 'SEQ_NO' then
//     Background := clBtnFace;
end;

function TfrmGoodsInfoList.EncodeSQL(id: string; QryType: integer): string;
var
  w,GodsFields,OperChar,sc:string;
begin
  case Factor.iDbType of
   0: sc := '+';
   1,4,5: sc := '||';
  end;
  GodsFields:='';
  OperChar:=GetStrJoin(Factor.iDbType); //字符连接操作符

  w := ' and j.TENANT_ID=:TENANT_ID and j.SHOP_ID=:SHOP_ID and j.COMM not in (''02'',''12'') ';

  if id<>'' then w := w + ' and j.GODS_ID>:MAXID';

  if (rzTree.Selected<>nil) and (rzTree.Selected.Data<>nil) then //and (rzTree.Selected.Level>0)
     begin
      case TRecord_(fndGODS_FLAG1.Properties.Items.Objects[fndGODS_FLAG1.ItemIndex]).FieldByName('CODE_ID').AsInteger of
      1:begin
          if rzTree.Selected.Level>0 then
             w := w + ' and b.LEVEL_ID like :LEVEL_ID '+sc+'''%'' and b.RELATION_ID=:RELATION_ID '
          else
             w := w + ' and b.RELATION_ID=:RELATION_ID ';
        end;
      else
        begin
          if (rzTree.Selected.Level>0) then
             w := w + ' and j.SORT_ID'+TRecord_(fndGODS_FLAG1.Properties.Items.Objects[fndGODS_FLAG1.ItemIndex]).FieldByName('CODE_ID').AsString+' = :SORT_ID ';
        end;
      end;
     end;

  if trim(edtKey.Text)<>'' then
  begin
    w := w+' and '+GetLikeCnd(Factor.iDbType,['j.GODS_CODE','j.GODS_NAME','j.GODS_SPELL','br.BARCODE'],':KEYVALUE','')+' ';
  end;

  GodsFields:=
    ' b.RELATION_Flag,j.TENANT_ID,j.RELATION_ID,j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS,m.UNIT_NAME,j.RTL_OUTPRICE,j.NEW_LOWPRICE,j.NEW_OUTPRICE,j.NEW_INPRICE,'+
    '(case when j.NEW_OUTPRICE<>0 then cast(Round((j.NEW_INPRICE*100.0)/(j.NEW_OUTPRICE*1.000),0) as int) else null end) as PROFIT_RATE,SORT_ID3,SORT_ID4,GODS_TYPE ';
  case Factor.iDbType of
   0:
    begin
      if QryType=0 then
      begin
        result :=
          'select top 600 0 as selflag,l.*,p.*,r.AMOUNT as AMOUNT from '+
          '(select distinct '+GodsFields+' from VIW_GOODSPRICEEXT j '+
          '  inner join VIW_GOODSSORT b on  j.TENANT_ID=b.TENANT_ID and j.SORT_ID1=b.SORT_ID '+
          '  left join VIW_BARCODE br on j.TENANT_ID=br.TENANT_ID and j.GODS_ID=br.GODS_ID '+
          ' left join VIW_MEAUNITS m on j.TENANT_ID=m.TENANT_ID and j.CALC_UNITS=m.UNIT_ID '+
          ' where b.SORT_TYPE=1 '+w+') l '+
          'left outer join '+
          '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID group by GODS_ID) r '+
          'on l.GODS_ID=r.GODS_ID left outer join ('+CSQL+') p on l.GODS_ID=p.GODS_ID order by l.GODS_ID';
      end else
      if QryType=1 then
      begin
        result :=
          ' select Count(distinct j.GODS_ID) as ReSum from VIW_GOODSPRICEEXT j '+
          '  inner join VIW_GOODSSORT b on  j.TENANT_ID=b.TENANT_ID and j.SORT_ID1=b.SORT_ID '+
          '  left join VIW_BARCODE br on j.TENANT_ID=br.TENANT_ID and j.GODS_ID=br.GODS_ID '+
          ' where b.SORT_TYPE=1 '+w+' ';
      end;
    end;
  1:
    begin
      if QryType=0 then
      begin
        result :=
          'select * from ('+
          'select 0 as selflag,l.*,p.*,r.AMOUNT as AMOUNT from '+
          '(select distinct '+GodsFields+' from VIW_GOODSPRICEEXT j '+
          '  inner join VIW_GOODSSORT b on  j.TENANT_ID=b.TENANT_ID and j.SORT_ID1=b.SORT_ID '+
          '  left join VIW_BARCODE br on j.TENANT_ID=br.TENANT_ID and j.GODS_ID=br.GODS_ID '+
          ' left join VIW_MEAUNITS m on j.TENANT_ID=m.TENANT_ID and j.CALC_UNITS=m.UNIT_ID '+
          ' where b.SORT_TYPE=1 '+w+') l '+
          'left outer join '+
          '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID group by GODS_ID) r '+
          ' on l.GODS_ID=r.GODS_ID left outer join ('+CSQL+') p on l.GODS_ID=p.GODS_ID order by l.GODS_ID) where ROWNUM<=600 ';
      end else
      if QryType=1 then
      begin
        result :=
          'select Count(distinct j.GODS_ID) as ReSum from VIW_GOODSPRICEEXT j '+
          ' inner join VIW_GOODSSORT b on  j.TENANT_ID=b.TENANT_ID and j.SORT_ID1=b.SORT_ID '+
          ' left join VIW_BARCODE br on j.TENANT_ID=br.TENANT_ID and j.GODS_ID=br.GODS_ID '+
          ' where b.SORT_TYPE=1 '+w+' ';
      end;
    end;
  4:
    begin
      if QryType=0 then
      begin
        result :=
          'select tp.* from ('+
          'select 0 as selflag,l.*,p.*,r.AMOUNT as AMOUNT from '+
          '(select distinct '+GodsFields+' from VIW_GOODSPRICEEXT j '+
          ' inner join VIW_GOODSSORT b on  j.TENANT_ID=b.TENANT_ID and j.SORT_ID1=b.SORT_ID '+
          ' left join VIW_BARCODE br on j.TENANT_ID=br.TENANT_ID and j.GODS_ID=br.GODS_ID '+
          ' left join VIW_MEAUNITS m on j.TENANT_ID=m.TENANT_ID and j.CALC_UNITS=m.UNIT_ID '+
          ' where b.SORT_TYPE=1 '+w+') l '+
          'left outer join '+
          '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID group by GODS_ID) r '+
          ' on l.GODS_ID=r.GODS_ID  left outer join ('+CSQL+') p on l.GODS_ID=p.GODS_ID  order by l.GODS_ID)tp fetch first 600 rows only ';
      end else
      if QryType=1 then
      begin
        result :=
          ' select Count(distinct j.GODS_ID) as ReSum from VIW_GOODSPRICEEXT j '+
          ' inner join VIW_GOODSSORT b on  j.TENANT_ID=b.TENANT_ID and j.SORT_ID1=b.SORT_ID '+
          ' left join VIW_BARCODE br on j.TENANT_ID=br.TENANT_ID and j.GODS_ID=br.GODS_ID '+
          ' where b.SORT_TYPE=1 '+w+' ';
      end;
    end;
  5:
    begin
      if QryType=0 then
      begin
        result :=
          'select 0 as selflag,l.*,p.*,r.AMOUNT as AMOUNT from '+
          '(select distinct '+GodsFields+' from VIW_GOODSPRICEEXT j '+
          ' inner join VIW_GOODSSORT b on  j.TENANT_ID=b.TENANT_ID and j.SORT_ID1=b.SORT_ID '+
          ' left join VIW_BARCODE br on j.TENANT_ID=br.TENANT_ID and j.GODS_ID=br.GODS_ID '+
          ' left join VIW_MEAUNITS m on j.TENANT_ID=m.TENANT_ID and j.CALC_UNITS=m.UNIT_ID '+
          ' where b.SORT_TYPE=1 '+w+') l '+
          'left outer join '+
          '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID group by GODS_ID) r '+
          ' on l.GODS_ID=r.GODS_ID left outer join ('+CSQL+') p on l.GODS_ID=p.GODS_ID  order by l.GODS_ID limit 600 ';
      end else
      if QryType=1 then
      begin
        result :=
          ' select Count(distinct j.GODS_ID) as ReSum from VIW_GOODSPRICEEXT j '+
          ' inner join VIW_GOODSSORT b on  j.TENANT_ID=b.TENANT_ID and j.SORT_ID1=b.SORT_ID '+
          ' left join VIW_BARCODE br on j.TENANT_ID=br.TENANT_ID and j.GODS_ID=br.GODS_ID '+
          ' where b.SORT_TYPE=1 '+w+' ';
      end;
    end;
  end;
end;

procedure TfrmGoodsInfoList.Open(Id: string);
var
  StrmData: TStream;
  rs:TZQuery;
begin
  if not Visible then Exit;
  if Id='' then cdsBrowser.close;
  rs := TZQuery.Create(nil);
  cdsBrowser.DisableControls;
  try
    StrmData:=TMemoryStream.Create;
    rs.SQL.Text:=EncodeSQL(Id);
    if rs.Params.FindParam('TENANT_ID')<>nil then rs.ParamByName('TENANT_ID').AsInteger:=SHopGlobal.TENANT_ID;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.ParamByName('SHOP_ID').AsString:=SHopGlobal.SHOP_ID;
    if rs.Params.FindParam('SHOP_ID_ROOT')<>nil then rs.ParamByName('SHOP_ID_ROOT').AsString:=InttoStr(SHopGlobal.TENANT_ID)+'0001';
    if rs.Params.FindParam('MAXID')<>nil then rs.ParamByName('MAXID').AsString := MaxId;
    if rs.Params.FindParam('KEYVALUE')<>nil then rs.ParamByName('KEYVALUE').AsString := trim(edtKey.Text);
    if TRecord_(fndGODS_FLAG1.Properties.Items.Objects[fndGODS_FLAG1.ItemIndex]).FieldByName('CODE_ID').AsInteger = 3 then
      begin
        if rs.Params.FindParam('SORT_ID')<>nil then
           rs.Params.ParamByName('SORT_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('CLIENT_ID').AsString;
      end
    else
      begin
        if rs.Params.FindParam('SORT_ID')<>nil then
           rs.Params.ParamByName('SORT_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('SORT_ID').AsString;
      end;
    if rs.Params.FindParam('LEVEL_ID')<>nil then
       rs.Params.ParamByName('LEVEL_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString;
    if rs.Params.FindParam('RELATION_ID')<>nil then
       rs.Params.ParamByName('RELATION_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('GODS_ID').AsString;
    rs.IndexFieldNames := 'GODS_CODE';
    rs.SortedFields:='GODS_CODE';
    rs.SaveToStream(StrmData);
    if Id='' then
    begin
      cdsBrowser.LoadFromStream(StrmData);
      cdsBrowser.IndexFieldNames := 'GODS_CODE';
      cdsBrowser.SortedFields:='GODS_CODE';
      if rs.RecordCount <600 then
        rcAmt:=rs.RecordCount
      else
        rcAmt:=GetReCount;
      GetNo;
    end else
      cdsBrowser.AddFromStream(StrmData);
    if rs.RecordCount <600 then IsEnd := True else IsEnd := false;
    if Id='' then cdsBrowser.First;  //重新查询指针指向第一条
  finally
    cdsBrowser.EnableControls;
    StrmData.Free;
    rs.Free;
  end;
end;

procedure TfrmGoodsInfoList.actFindExecute(Sender: TObject);
begin
  inherited;
  locked:=True;
  try
//    if (trim(edtKEY.Text)<>'') and (rzTree.Items.Count>0) then rzTree.TopItem.Selected := true;
    Open('');
  finally
    locked:=False;
  end;
end;

procedure TfrmGoodsInfoList.edtKeyKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    actFindExecute(nil);
    Key:=#0;
  end;
end;

procedure TfrmGoodsInfoList.InitGrid;
var
  rs: TZQuery;
  SetCol,Column: TColumnEh;
begin
  {rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  SetCol:=FindColumn(DBGridEh1,'CALC_UNITS');
  if (SetCol<>nil) and (rs.Active) and (rs.RecordCount>0) then
  begin
    SetCol.KeyList.Clear;
    SetCol.PickList.Clear;
    rs.First;
    while not rs.Eof do
    begin
      SetCol.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      SetCol.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
     //DBGridEh1.FieldColumns['SMALL_UNITS'].KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      //DBGridEh1.FieldColumns['SMALL_UNITS'].PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      //DBGridEh1.FieldColumns['BIG_UNITS'].KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      //DBGridEh1.FieldColumns['BIG_UNITS'].PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
  end;}

  //供货商[生产厂家]
  rs := Global.GetZQueryFromName('PUB_CLIENTINFO');
  SetCol:=FindColumn(DBGridEh1,'SORT_ID3');
  if (SetCol<>nil) and (rs.Active) and (rs.RecordCount>0) then
  begin
    SetCol.KeyList.Clear;
    SetCol.PickList.Clear;
    rs.First;
    while not rs.Eof do
    begin
      SetCol.KeyList.Add(rs.FieldbyName('CLIENT_ID').AsString);
      SetCol.PickList.Add(rs.FieldbyName('CLIENT_NAME').AsString);
      rs.Next;
    end;
  end;

  //商品品牌
  rs:=Global.GetZQueryFromName('PUB_BRAND_INFO');
  SetCol:=FindColumn(DBGridEh1,'SORT_ID4');
  if (SetCol<>nil) and (rs.Active) and (not rs.IsEmpty) then
  begin
    SetCol.KeyList.Clear;
    SetCol.PickList.Clear;
    rs.First;
    while not rs.Eof do
    begin
      SetCol.KeyList.Add(rs.FieldbyName('SORT_ID').AsString);
      SetCol.PickList.Add(rs.FieldbyName('SORT_NAME').AsString);
      rs.Next;
    end;
  end;
  //判断是否有查看成本价权限
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetCol:=FindColumn(DBGridEh1, 'NEW_INPRICE');
    if SetCol<>nil then SetCol.Free;
    SetCol:=FindColumn(DBGridEh1, 'PROFIT_RATE');
    if SetCol<>nil then SetCol.Free;
  end;
end;

procedure TfrmGoodsInfoList.FormCreate(Sender: TObject);
var
  tmp,rs: TZQuery;
  Column,SetCol:TColumnEh;
begin
  inherited;
  InitGrid;
  CSQL := '';
  //会员价
  rs := Global.GetZQueryFromName('PUB_PRICEGRADE');
  rs.First;
  while not rs.Eof do
     begin
       Column := DBGridEh1.Columns.Add;
       Column.FieldName := 'PRICE_'+formatFloat('000',rs.recNo);
       Column.Title.Caption := '会员价|'+rs.FieldbyName('PRICE_NAME').AsString;
       SetCol:=FindColumn(DBGridEh1,'SORT_ID3');
       if SetCol<>nil then
         Column.Index := SetCol.Index
       else
         Column.Index := DBGridEh1.Columns.Count-3; //默认后倒数第4列
       Column.Width := 64;
       Column.DisplayFormat := '#0.0##';
       CSQL := CSQL +',max(case when PRICE_ID='''+rs.FieldbyName('PRICE_ID').AsString+''' then NEW_OUTPRICE else null end) as '+Column.FieldName;
       rs.Next;
     end;
  CSQL := 'select GODS_ID'+CSQL+' from PUB_GOODSPRICE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRICE_ID<>''#'' group by GODS_ID';
  Locked := true;
  try
    rs := Global.GetZQueryFromName('PUB_STAT_INFO');
    TdsItems.AddDataSetToItems(rs,fndGODS_FLAG1.Properties.Items,'CODE_NAME');
    fndGODS_FLAG1.ItemIndex := 0;
    LoadTree;
  finally
    Locked := false;
  end;
  edtProperty1:=TZQuery.Create(nil);
  edtProperty2:=TZQuery.Create(nil);
  edtProperty1.Data:=ShopGlobal.GetZQueryFromName('PUB_SIZE_RELATION').Data;
  edtProperty2.Data:=ShopGlobal.GetZQueryFromName('PUB_COLOR_RELATION').Data;
  
  //暂关闭Gird表头排序
  TDbGridEhSort.InitForm(self);   
end;

procedure TfrmGoodsInfoList.edtKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_DOWN then
     cdsBrowser.Next;
  if Key=VK_UP then
     cdsBrowser.Prior;
end;

procedure TfrmGoodsInfoList.actNewExecute(Sender: TObject);
var
  CurObj: TRecord_;
  SortID,SortName:string;
begin
  inherited;
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('连锁版不允许离线操作!');
  SortID:='';
  SortName:='';
  if not ShopGlobal.GetChkRight('32600001',2) then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
  if TRecord_(fndGODS_FLAG1.Properties.Items.Objects[fndGODS_FLAG1.ItemIndex]).FieldByName('CODE_ID').AsInteger=1 then
     begin
        if rzTree.Selected=nil then Raise Exception.Create(' 商品分类没有节点，请先选择分类节点！');
        CurObj:=TRecord_(rzTree.Selected.Data);
        if CurObj=nil then Raise Exception.Create(' 请选择Tree的节点！ ');
        if (trim(CurObj.FieldByName('RELATION_ID').AsString)='0') and (trim(CurObj.FieldByName('LEVEL_ID').AsString)<>'') then  // RELATION_FLAG=2 自主经营
        begin
          //Raise Exception.Create(' 当前分类的节点是供应链的，只能在“自主经营”下新增商品！ ');
          SortID := CurObj.FieldbyName('SORT_ID').AsString;
          SortName := CurObj.FieldbyName('SORT_NAME').AsString;
        end;
     end;
  with TfrmGoodsInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Append(SortID,SortName,'');
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmGoodsInfoList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if not cdsBrowser.Active   then exit;
  if cdsBrowser.IsEmpty then exit;
  with TfrmGoodsInfo.Create(self) do
    begin
      try
        //OnSave := AddRecord;
        Open(cdsBrowser.FieldByName('GODS_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmGoodsInfoList.actEditExecute(Sender: TObject);
begin
  inherited;
  if (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then Raise Exception.Create('   没有数据，请先查询！  ');
  if cdsBrowser.FieldByName('GODS_ID').AsString='' then Raise Exception.Create('   没有数据，请先查询！  ');
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('连锁版不允许离线操作!');
  if not ShopGlobal.GetChkRight('32600001',3) then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');

  with TfrmGoodsInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //得加权限判断的，及是总店可改公司经营商品及门店可改自经营商品，
        Edit(cdsBrowser.FieldByName('GODS_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmGoodsInfoList.actDeleteExecute(Sender: TObject);
var
  i,n:integer;
  tmpGlobal,GodsList: TZQuery;
begin
  inherited;
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  if cdsBrowser.State=dsEdit then cdsBrowser.Post;
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('连锁版不允许离线操作!');
  if not ShopGlobal.GetChkRight('32600001',4) then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');

  //2011.03.18 Add 判断是否选择非自主经营的商品:
  try
    GodsList:=TZQuery.Create(nil);
    GodsList.Data:=cdsBrowser.Data; 
    GodsList.Filtered := false;
    GodsList.Filter := 'selFlag=''1'' '; //and (RELATION_ID=''0'')
    GodsList.Filtered := true;
    if GodsList.IsEmpty then Raise Exception.Create('请选择要删除的商品...');
    GodsList.First;
    while not GodsList.Eof do
    begin
      if trim(GodsList.FieldByName('RELATION_ID').AsString)<>'0' then //只有等于0才能删除
      begin
        Raise Exception.Create('商品 "'+GodsList.FieldByName('GODS_NAME').AsString+'"'+'是加盟经营不删除！ ');
      end;
      GodsList.Next;
    end;
  finally
    GodsList.Free;
  end;

  try
    cdsBrowser.DisableControls;
    i:=MessageBox(Handle,Pchar('是否要删除吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1+MB_ICONQUESTION);
    if i=6 then
    begin
      tmpGlobal := Global.GetZQueryFromName('PUB_GOODSINFO');
      tmpGlobal.Filtered :=false;
      cdsBrowser.CommitUpdates;
      n := 0;
      tmpGlobal.CommitUpdates;
      cdsBrowser.First;
      while not cdsBrowser.Eof do //缓存删除记录
      begin
        if (trim(cdsBrowser.FieldByName('selflag').AsString)='1') and (trim(cdsBrowser.FieldByName('RELATION_ID').AsString)='0') then
        begin
          if tmpGlobal.Locate('GODS_ID',cdsBrowser.FieldByName('GODS_ID').AsString,[]) then
            tmpGlobal.Delete;
          inc(n);
          cdsBrowser.Delete;
        end else cdsBrowser.Next;
      end;

      //提交数据保存
      try
        Factor.UpdateBatch(cdsBrowser,'TGoodsInfo');
        rcAmt := rcAmt - n;
        tmpGlobal.CommitUpdates;
      except
        cdsBrowser.CancelUpdates;
        tmpGlobal.CancelUpdates;
        Raise;
      end;
    end;
  finally
    cdsBrowser.EnableControls;
  end;

  GetNo;
  //删除代码别做，要支持批量删除，同时也要删除条码库
end;

procedure TfrmGoodsInfoList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actInfoExecute(nil);
end;

procedure TfrmGoodsInfoList.N1Click(Sender: TObject);
begin
  inherited;
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  while not IsEnd do Open(MaxID);   
  cdsBrowser.DisableControls;
  try
    cdsBrowser.First;
    while not cdsBrowser.Eof do
    begin
      cdsBrowser.Edit;
      cdsBrowser.FieldByName('selflag').AsString:='1';
      cdsBrowser.Post;
      cdsBrowser.Next;
    end;
  finally
    cdsBrowser.First;
    cdsBrowser.EnableControls;
  end;
end;

procedure TfrmGoodsInfoList.N2Click(Sender: TObject);
begin
  inherited;
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  while not IsEnd do Open(MaxID); 
  cdsBrowser.DisableControls;
  try
    cdsBrowser.First;
    while not cdsBrowser.Eof do
    begin
      cdsBrowser.Edit;
      if trim(cdsBrowser.FieldByName('selflag').AsString)='1' then
         cdsBrowser.FieldByName('selflag').AsString:='0'
      else
         cdsBrowser.FieldByName('selflag').AsString:='1';
      cdsBrowser.Post;
      cdsBrowser.Next;
    end;
  finally
    cdsBrowser.First;
    cdsBrowser.EnableControls;
  end;
end;

procedure TfrmGoodsInfoList.N3Click(Sender: TObject);
begin
  inherited;
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  while not IsEnd do Open(MaxID);   
  cdsBrowser.DisableControls;
  try
    cdsBrowser.First;
    while not cdsBrowser.Eof do
    begin
      cdsBrowser.Edit;
      cdsBrowser.FieldByName('selflag').AsString:='0';
      cdsBrowser.Post;
      cdsBrowser.Next;
    end;
  finally
    cdsBrowser.First;
    cdsBrowser.EnableControls;
  end;
end;

procedure TfrmGoodsInfoList.rzTreeChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
  inherited;
  if locked then exit;
  locked := true;
  try
   if edtKey.Text<>''
        then edtKey.Text:='';
  finally
    locked := false;
  end;
end;

procedure TfrmGoodsInfoList.ToolButton8Click(Sender: TObject);
begin
  inherited;   
  if not ShopGlobal.GetChkRight('32600001',5) then
    Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
end;

procedure TfrmGoodsInfoList.FormShow(Sender: TObject);
begin
  inherited;
  if edtKey.CanFocus then
    edtKey.SetFocus;
  if cdsBrowser.Active then cdsBrowser.First;
end;

function TfrmGoodsInfoList.FindNode(ID: string): TTreeNode;
var i:Integer;
begin
  Result := nil;
  for i:=0 to rzTree.Items.Count -1 do
  begin
      if (UpperCase(ID)=UpperCase(TRecord_(rzTree.Items[i].Data).FieldByName('SORT_ID').AsString))  then
      begin
        Result := rzTree.Items[i];
        exit;
      end;
  end;
end;

procedure TfrmGoodsInfoList.GetNo;
var str:string;
begin
  inherited;
  if cdsBrowser.IsEmpty then  str:='0'
  else str:=IntToStr(cdsBrowser.RecNo);
  stbPanel.Caption:='第'+str+'条/共'+inttostr(rcAmt)+'条';
end;

procedure TfrmGoodsInfoList.FormDestroy(Sender: TObject);
begin
  inherited;
  edtProperty1.Free;
  edtProperty2.Free;
  //暂关闭Gird表头排序
  TDbGridEhSort.FreeForm(self);
end;

procedure TfrmGoodsInfoList.N4Click(Sender: TObject);
begin
  inherited;
  if not cdsBrowser.Active then exit;
  while not IsEnd do Open(MaxID);
end;

procedure TfrmGoodsInfoList.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if not edtKey.Focused then inherited;
end;

procedure TfrmGoodsInfoList.DBGridEh1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then  actEditExecute(nil);
end;

procedure TfrmGoodsInfoList.actCopyNewExecute(Sender: TObject);
begin
  inherited;
  if cdsBrowser.IsEmpty then exit;
  if not ShopGlobal.GetChkRight('32600001',2) then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
  with TfrmGoodsInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        Append('','',cdsBrowser.FieldByName('GODS_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmGoodsInfoList.PrintBarcode;
procedure AddTo(DataSet:TDataSet;ID,P1,P2:string;amt:Integer);
function PubGetBarCode:string;
var rs:TZQuery;
begin
  rs := Global.GetZQueryFromName('PUB_BARCODE');
  if rs.Locate('GODS_ID,PROPERTY_01,PROPERTY_02',VarArrayOf([ID,P1,P2]),[]) then
    Result := rs.FieldbyName('BARCODE').AsString
  else
    Result := '';
end;
var
  rs:TZQuery;
begin
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if rs.Locate('GODS_ID',ID,[]) then
  begin
    DataSet.Append;
    DataSet.FieldByName('A').AsBoolean := true;
    DataSet.FieldByName('GODS_ID').AsString := rs.FieldByName('GODS_ID').AsString;
    DataSet.FieldByName('GODS_NAME').AsString := rs.FieldByName('GODS_NAME').AsString;
    DataSet.FieldByName('GODS_CODE').AsString := rs.FieldByName('GODS_CODE').AsString;;
    DataSet.FieldByName('NEW_OUTPRICE').AsString := rs.FieldByName('NEW_OUTPRICE').AsString;
    DataSet.FieldByName('NEW_OUTPRICE1').AsString := rs.FieldByName('NEW_OUTPRICE1').AsString;
    DataSet.FieldByName('NEW_OUTPRICE2').AsString := rs.FieldByName('NEW_OUTPRICE2').AsString;
    DataSet.FieldByName('NEW_LOWPRICE').AsString := rs.FieldByName('NEW_LOWPRICE').AsString;
    DataSet.FieldByName('PROPERTY_01').AsString := P1;
    DataSet.FieldByName('PROPERTY_02').AsString := P2;
    DataSet.FieldByName('AMOUNT').AsInteger := amt;
    if (p1='#') and (p2='#') then
    begin
      DataSet.FieldByName('BARCODE').AsString := rs.FieldByName('BARCODE').AsString;
      DataSet.Post;
    end else
    begin
      DataSet.FieldByName('BARCODE').AsString := PubGetBarCode;
      if trim(DataSet.FieldByName('BARCODE').AsString)='' then
        DataSet.Delete
      else
        DataSet.Post;
    end;
  end;
end;
var amt,i,RecNo:integer;

begin
  inherited;

  RecNo := cdsBrowser.RecNo;
  cdsBrowser.DisableControls;
  try
    with TfrmBarCodePrint.Create(self) do
    begin
      try
        adoPrint.Close;
        adoPrint.CreateDataSet;
        cdsBrowser.First;
        while not cdsBrowser.Eof do
        begin
          if PropertyEnabled then
          begin
            GetProperty;
            edtProperty1.First;
            while not edtProperty1.Eof do
            begin
              edtProperty2.First;
              while not edtProperty2.Eof do
              begin
                AddTo(adoPrint,
                      cdsBrowser.FieldbyName('GODS_ID').AsString,
                      edtProperty1.FieldbyName('SIZE_ID').AsString,
                      edtProperty2.FieldbyName('COLOR_ID').AsString,
                      1);
                edtProperty2.Next;
              end;
              edtProperty1.Next;
            end;
          end else
          begin
            AddTo(adoPrint,cdsBrowser.FieldbyName('GODS_ID').AsString,'#','#',1);
          end;
          cdsBrowser.Next;
        end;
        ShowModal;
      finally
        free;
      end;
    end;
  finally
    if RecNo>0 then cdsBrowser.RecNo := RecNo;
    cdsBrowser.EnableControls;
  end;
end;

function TfrmGoodsInfoList.PropertyEnabled: boolean;
var
  rs:TZQuery;
begin
  result := false;
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if rs.Locate('GODS_ID',cdsBrowser.FieldbyName('GODS_ID').AsString,[]) then
  result := not (
       ((rs.FieldbyName('SORT_ID7').AsString = '') or (rs.FieldbyName('SORT_ID7').AsString = '#'))
         and
       ((rs.FieldbyName('SORT_ID8').AsString = '') or (rs.FieldbyName('SORT_ID8').AsString = '#'))
       );

 {rs := Global.GetZQueryFromName('PUB_BARCODE');
  if rs.Locate('GODS_ID',cdsBrowser.FieldbyName('GODS_ID').AsString,[]) then
  result := not (
       ((rs.FieldbyName('PROPERTY_01').AsString = '') or (rs.FieldbyName('PROPERTY_01').AsString = '#'))
         and
       ((rs.FieldbyName('PROPERTY_02').AsString = '') or (rs.FieldbyName('PROPERTY_02').AsString = '#'))
       );
  }
end;

procedure TfrmGoodsInfoList.actPrintBarCodeExecute(Sender: TObject);
begin
  inherited;
  PrintBarcode;
end;

procedure TfrmGoodsInfoList.DBGridEh1TitleClick(Column: TColumnEh);
begin
  if Column.FieldName='selflag' then
    N1Click(nil)
  else
  begin
    //2011.02.26 Add TZQuery不支持的修改: IndexFieldNames
    //cdsBrowser.IndexFieldNames := '';
    //cdsBrowser.IndexFieldNames := 'GODS_CODE';
  end;
end;

procedure TfrmGoodsInfoList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('32600001',5) then
    Raise Exception.Create('你没有预览'+Caption+'的权限,请和管理员联系.');
  try
    DBGridEh1.Columns[0].Visible := False;
    PrintView;
    with TfrmEhLibReport.Create(self) do
    begin
      try
        Preview(PrintDBGridEh1);
      finally
        free;
      end;
    end;
  finally
    DBGridEh1.Columns[0].Visible := True;
  end;
end;

function TfrmGoodsInfoList.FindColumn(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
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

procedure TfrmGoodsInfoList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('32600001',5) then
    Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
  try
    DBGridEh1.Columns[0].Visible := False;
    PrintView;
    PrintDBGridEh1.Print;
  finally
    DBGridEh1.Columns[0].Visible := True;
  end;
end;

procedure TfrmGoodsInfoList.cdsBrowserAfterScroll(DataSet: TDataSet);
begin
  GetNO;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsBrowser.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TfrmGoodsInfoList.DBGridEh1CellClick(Column: TColumnEh);
begin
  inherited;
  if (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then Exit;
end;

procedure TfrmGoodsInfoList.LoadTree;
var
  IsRoot: Boolean;
  rs:TZQuery;
  i:integer;
  Rel_ID,Rel_IDS: string;
  AObj,CurObj:TRecord_;
begin
  Rel_ID:='';
  Rel_IDS:='';
  IsRoot:=False;
  ClearTree(rzTree);
  rs := Global.GetZQueryFromName('PUB_GOODSSORT');
  //rs.SortedFields := 'RELATION_ID';  //2011.08.27 排序错乱关闭
  rs.First;
  while not rs.Eof do
  begin
    Rel_ID:=','+InttoStr(rs.FieldByName('RELATION_ID').AsInteger)+','; //2011.09.25 add 当前供应链ID
    if Pos(Rel_ID,Rel_IDS)<=0 then
    begin
      Rel_IDS:=Rel_IDS+Rel_ID;  //2011.09.25 add 
      if trim(rs.FieldByName('RELATION_ID').AsString)='0' then //自主经营
      begin
        CurObj:=TRecord_.Create;
        CurObj.ReadFromDataSet(rs);
        // 2011.03.12 Add 可选择[供应链节点]的作为查询条件
        CurObj.FieldByName('LEVEL_ID').AsString:='';
        CurObj.FieldByName('SORT_NAME').AsString:=rs.FieldbyName('RELATION_NAME').AsString;
        IsRoot:=true;
      end else
      begin
        AObj := TRecord_.Create;
        AObj.ReadFromDataSet(rs);
        // 2011.03.12 Add 可选择[供应链节点]的作为查询条件
        AObj.FieldByName('LEVEL_ID').AsString:='';
        AObj.FieldByName('SORT_NAME').AsString:=rs.FieldbyName('RELATION_NAME').AsString;
        rzTree.Items.AddObject(nil,rs.FieldbyName('RELATION_NAME').AsString,AObj);
      end;
    end;
    rs.Next;
  end;
  if (IsRoot) and (CurObj<>nil) and (CurObj.FindField('SORT_NAME')<>nil) then
    rzTree.Items.AddObject(nil,CurObj.FieldbyName('SORT_NAME').AsString,CurObj);

  for i:=rzTree.Items.Count-1 downto 0 do
    begin
      rs.Filtered := false;
      rs.filter := 'RELATION_ID='+TRecord_(rzTree.Items[i].Data).FieldbyName('RELATION_ID').AsString;
      rs.Filtered := true;
      //rs.SortedFields := 'LEVEL_ID';  //2011.08.27 排序错乱关闭
      CreateLevelTree(rs,rzTree,'4444444','SORT_ID','SORT_NAME','LEVEL_ID',0,0,'',rzTree.Items[i]);
    end;
end;

procedure TfrmGoodsInfoList.DoTreeChange(Sender: TObject; Node: TTreeNode);
begin
  Open('');
end;

procedure TfrmGoodsInfoList.N8Click(Sender: TObject);
var
  CurObj: TRecord_;
begin
  inherited;
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then Raise Exception.Create('连锁版不允许离线操作!');
  try
    CurObj:=TRecord_.Create;
    if not ShopGlobal.GetChkRight('32100001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
    if TfrmGoodsSortTree.AddDialog(self,CurObj,1) then
    begin
      fndGODS_FLAG1PropertiesChange(nil);
    end;
  finally
    CurObj.Free;
  end;
end;

function TfrmGoodsInfoList.CheckCanExport: boolean;
begin 
  result:=ShopGlobal.GetChkRight('32600001',6);
end;

procedure TfrmGoodsInfoList.N10Click(Sender: TObject);
begin
  inherited;
  locked := true;
  try
    fndGODS_FLAG1PropertiesChange(nil);
  finally
    locked := false;
  end;
end;

function TfrmGoodsInfoList.GetReCount: integer;
var
  Qry:TZQuery;
begin
  result:=0;
  Qry:=TZQuery.Create(nil);
  try
    Qry.Close;
    Qry.SQL.Text:=EncodeSQL('',1);
    if Qry.Params.FindParam('TENANT_ID')<>nil then Qry.ParamByName('TENANT_ID').AsInteger:=SHopGlobal.TENANT_ID;
    if Qry.Params.FindParam('SHOP_ID')<>nil then Qry.ParamByName('SHOP_ID').AsString:=SHopGlobal.SHOP_ID;
    if Qry.Params.FindParam('SHOP_ID_ROOT')<>nil then Qry.ParamByName('SHOP_ID_ROOT').AsString:=InttoStr(SHopGlobal.TENANT_ID)+'0001';
    if Qry.Params.FindParam('MAXID')<>nil then Qry.ParamByName('MAXID').AsString := MaxId;
    if Qry.Params.FindParam('KEYVALUE')<>nil then Qry.ParamByName('KEYVALUE').AsString := trim(edtKey.Text);
    if Qry.Params.FindParam('LEVEL_ID')<>nil then Qry.ParamByName('LEVEL_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString;
    if Qry.Params.FindParam('RELATION_ID')<>nil then Qry.ParamByName('RELATION_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString;
    Factor.Open(Qry);
    Result := Qry.Fields[0].AsInteger;
  finally
    FreeAndNil(Qry);
  end;
end;

procedure TfrmGoodsInfoList.PrintView;
begin
    PrintDBGridEh1.PageHeader.CenterText.Text := '商品档案管理';
    PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[whr]','']);
    DBGridEh1.DataSource.DataSet.Filtered := False;
    PrintDBGridEh1.DBGridEh := DBGridEh1;
end;

procedure TfrmGoodsInfoList.actDefineStateExecute(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  if TfrmDefineStateInfo.ShowDialog(self) then
     begin
      fndGODS_FLAG1PropertiesChange(nil);
     end;
end;

procedure TfrmGoodsInfoList.Excel1Click(Sender: TObject);
  function Check(Source,Dest:TDataSet;SFieldName:string;DFieldName:string):Boolean;
  var rs:TZQuery;
  begin
    if (SFieldName <> '') and (DFieldName <> '') then
      begin
        Result := False;
        // *******************计量单位********************
        if DFieldName = 'CALC_UNITS' then
          begin
            if Source.FieldByName(SFieldName).AsString <> '' then
              begin
                rs := Global.GetZQueryFromName('PUB_MEAUNITS');
                if rs.Locate('UNIT_NAME,RELATION_FLAG',VarArrayOf([Trim(Source.FieldByName(SFieldName).AsString),'2']),[]) then
                  begin
                    Dest.FieldByName('CALC_UNITS').AsString := rs.FieldByName('UNIT_ID').AsString;
                    Result := True;
                    Exit;
                  end
                else
                  Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的计量单位...');
              end
            else
              Raise Exception.Create('计量单位不能为空!');
          end;

        // *******************包装1单位********************
        if DFieldName = 'SMALL_UNITS' then
          begin
            if Source.FieldByName(SFieldName).AsString <> '' then
              begin
                rs := Global.GetZQueryFromName('PUB_MEAUNITS');
                if rs.Locate('UNIT_NAME,RELATION_FLAG',VarArrayOf([Trim(Source.FieldByName(SFieldName).AsString),'2']),[]) then
                  begin
                    Dest.FieldByName('SMALL_UNITS').AsString := rs.FieldByName('UNIT_ID').AsString;
                    Result := True;
                    Exit;
                  end
                else
                  Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的包装1单位...');
              end;
          end;

        // *******************包装2单位********************
        if DFieldName = 'BIG_UNITS' then
          begin
            if Source.FieldByName(SFieldName).AsString <> '' then
              begin
                rs := Global.GetZQueryFromName('PUB_MEAUNITS');
                if rs.Locate('UNIT_NAME,RELATION_FLAG',VarArrayOf([Trim(Source.FieldByName(SFieldName).AsString),'2']),[]) then
                  begin
                    Dest.FieldByName('BIG_UNITS').AsString := rs.FieldByName('UNIT_ID').AsString;
                    Result := True;
                    Exit;
                  end
                else
                  Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的包装2单位...');
              end;
          end;

        //*******************商品分类*****************
        if DFieldName = 'SORT_ID1' then
          begin
            if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
              begin
                rs := Global.GetZQueryFromName('PUB_GOODSSORT');
                if rs.Locate('SORT_NAME,RELATION_ID',VarArrayOf([Trim(Source.FieldByName(SFieldName).AsString),'0']),[]) then
                  begin
                    Dest.FieldByName('SORT_ID1').AsString := rs.FieldbyName('SORT_ID').AsString;
                    Result := True;
                    Exit;
                  end
                else
                  Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的商品分类...');
              end
            else
              Raise Exception.Create('商品分类不能为空!');
          end;

        //*******************颜色组*****************
        if DFieldName = 'SORT_ID7' then
          begin
            if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
              begin
                rs := Global.GetZQueryFromName('PUB_COLOR_INFO');
                if rs.Locate('COLOR_NAME,RELATION_FLAG',VarArrayOf([Trim(Source.FieldByName(SFieldName).AsString),'2']),[]) then
                  begin
                    Dest.FieldByName('SORT_ID7').AsString := rs.FieldbyName('COLOR_ID').AsString;
                    Result := True;
                    Exit;
                  end
                else
                  Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的颜色...');
              end;
          end;

        //*******************尺码组*****************
        if DFieldName = 'SORT_ID8' then
          begin
            if Trim(Source.FieldByName(SFieldName).AsString) <> '' then
              begin
                rs := Global.GetZQueryFromName('PUB_SIZE_INFO');
                if rs.Locate('SIZE_NAME,RELATION_FLAG',VarArrayOf([Trim(Source.FieldByName(SFieldName).AsString),'2']),[]) then
                  begin
                    Dest.FieldByName('SORT_ID8').AsString := rs.FieldbyName('SIZE_ID').AsString;
                    Result := True;
                    Exit;
                  end
                else
                  Raise Exception.Create('没找到"'+Source.FieldByName(SFieldName).AsString+'"对应的尺码...');
              end;
          end;

        //货号
        if DFieldName = 'GODS_CODE' then
          begin
            if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
              begin
                if Length(Source.FieldByName(SFieldName).AsString) > 20 then
                  Raise Exception.Create('货号应在20个字符以内!')
                else
                  begin
                    Dest.FieldbyName('GODS_CODE').AsString := Source.FieldByName(SFieldName).AsString;
                  end;
              end
            else
              begin     
                Dest.FieldbyName('GODS_CODE').AsString := TSequence.GetSequence('GODS_CODE',InttoStr(ShopGlobal.TENANT_ID),'',6);  //企业内码ID
              end;
            Result := True;
            Exit;
          end;

        //条形码1
        if DFieldName = 'BARCODE1' then
          begin
            if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
              begin
                if Length(Source.FieldByName(SFieldName).AsString) > 30 then
                  Raise Exception.Create('条形码应在30个字符以内!')
                else
                  begin
                    if (Dest.FieldByName('BARCODE2').AsString <> '') and (Source.FieldByName(SFieldName).AsString = Source.FieldByName('BARCODE2').AsString) then
                      raise Exception.Create('计量单位的条码不能和小包装条码一样!');
                    if (Dest.FieldByName('BARCODE3').AsString <> '') and (Source.FieldByName(SFieldName).AsString = Dest.FieldByName('BARCODE3').AsString) then
                      raise Exception.Create('计量单位的条码不能和大包装条码一样!');

                    Dest.FieldbyName('BARCODE1').AsString := Source.FieldByName(SFieldName).AsString;
                  end;
              end
            else
              begin
                Dest.FieldbyName('BARCODE1').AsString := GetBarCode(TSequence.GetSequence('BARCODE_ID',InttoStr(ShopGlobal.TENANT_ID),'',6),'#','#');
              end;
            Result := True;
            Exit;
          end;

        //条形码2
        if DFieldName = 'BARCODE2' then
          begin
            if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
              begin
                if Length(Source.FieldByName(SFieldName).AsString) > 30 then
                  Raise Exception.Create('条形码应在30个字符以内!')
                else
                  begin
                    if (Dest.FieldByName('BARCODE1').AsString <> '') and (Dest.FieldByName('BARCODE1').AsString = Source.FieldByName(SFieldName).AsString) then
                      raise Exception.Create('计量单位的条码不能和小包装条码一样!');
                    if (Dest.FieldByName('BARCODE3').AsString <> '') and (Source.FieldByName(SFieldName).AsString = Dest.FieldByName('BARCODE3').AsString) then
                      raise Exception.Create('小包装条码不能和大包装条码一样!');

                    Dest.FieldbyName('BARCODE2').AsString := Source.FieldByName(SFieldName).AsString;
                    Result := True;
                    Exit;
                  end;
              end;
          end;

        //条形码3
        if DFieldName = 'BARCODE3' then
          begin
            if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
              begin
                if Length(Source.FieldByName(SFieldName).AsString) > 30 then
                  Raise Exception.Create('条形码应在30个字符以内!')
                else
                  begin
                    if (Dest.FieldByName('BARCODE1').AsString <> '') and (Dest.FieldByName('BARCODE1').AsString = Source.FieldByName(SFieldName).AsString) then
                      raise Exception.Create('计量单位的条码不能和大包装条码一样!');
                    if (Dest.FieldByName('BARCODE2').AsString <> '') and (Source.FieldByName(SFieldName).AsString = Dest.FieldByName('BARCODE2').AsString) then
                      raise Exception.Create('小包装条码不能和大包装条码一样!');

                    Dest.FieldbyName('BARCODE3').AsString := Source.FieldByName(SFieldName).AsString;
                    Result := True;
                    Exit;
                  end;
              end;
          end;

        //商品名称
        if DFieldName = 'GODS_NAME' then
          begin
            if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
              begin
                if Length(Source.FieldByName(SFieldName).AsString) > 50  then
                  Raise Exception.Create('商品名称就在50个字符以内!')
                else
                  begin
                    Dest.FieldbyName('GODS_NAME').AsString := Source.FieldByName(SFieldName).AsString;
                    Result := True;
                    Exit;
                  end;
              end
            else
              Raise Exception.Create('商品名称不能为空!');
          end;

        //商品拼音码
        if DFieldName = 'GODS_SPELL' then
          begin
            if (Trim(Source.FieldByName(SFieldName).AsString) <> '') then
              begin
                if Length(Source.FieldByName(SFieldName).AsString) > 50  then
                  Raise Exception.Create('商品拼音码就在50个字符以内!')
                else
                  begin
                    Dest.FieldbyName('GODS_SPELL').AsString := Source.FieldByName(SFieldName).AsString;
                    Result := True;
                    Exit;
                  end;
              end;
          end;
      end
    else
      begin
        //单条数据作比较 包装1参数对比
        if (Dest.FieldByName('BARCODE2').AsString <> '') or (Dest.FieldByName('SMALL_UNITS').AsString <> '') or (Dest.FieldByName('SMALLTO_CALC').AsInteger <> 0) then
          begin
            if (Dest.FieldByName('BARCODE2').AsString = '') or (Dest.FieldByName('SMALL_UNITS').AsString = '') or (Dest.FieldByName('SMALLTO_CALC').AsInteger = 0) then
              raise Exception.Create('包装1参数不完整!')
            else
              begin
                if Dest.FieldByName('MY_OUTPRICE1').AsString = '' then
                  Dest.FieldByName('MY_OUTPRICE1').AsInteger := Dest.FieldByName('SMALLTO_CALC').AsInteger * Dest.FieldByName('MY_OUTPRICE').AsInteger;
              end;
          end;

        //单条数据作比较 包装2参数对比
        if (Dest.FieldByName('BARCODE3').AsString <> '') or (Dest.FieldByName('BIG_UNITS').AsString <> '') or (Dest.FieldByName('BIGTO_CALC').AsInteger <> 0) then
          begin
            if (Dest.FieldByName('BARCODE3').AsString = '') or (Dest.FieldByName('BIG_UNITS').AsString = '') or (Dest.FieldByName('BIGTO_CALC').AsInteger = 0) then
              raise Exception.Create('包装2参数不完整!')
            else
              begin
                if Dest.FieldByName('MY_OUTPRICE2').AsString = '' then
                  Dest.FieldByName('MY_OUTPRICE2').AsInteger := Dest.FieldByName('BIGTO_CALC').AsInteger * Dest.FieldByName('MY_OUTPRICE').AsInteger;
              end;
          end;

      end;
  end;

  function SaveExcel(CdsExcel:TDataSet):Boolean;
    procedure WriteToBarcode(Data_Bar:TZQuery;Gods_Id,Unit_Id,BarCode,BarcodeType:String);
    begin
      Data_Bar.Append;
      Data_Bar.FieldByName('RELATION_FLAG').AsString := '2';
      Data_Bar.FieldByName('TENANT_ID').AsInteger := ShopGlobal.TENANT_ID;
      Data_Bar.FieldByName('GODS_ID').AsString := Gods_Id;
      Data_Bar.FieldByName('ROWS_ID').AsString := TSequence.NewId;  //行号[GUID编号]
      Data_Bar.FieldByName('PROPERTY_01').AsString := '#';
      Data_Bar.FieldByName('PROPERTY_02').AsString := '#';
      Data_Bar.FieldByName('BARCODE_TYPE').AsString := BarcodeType;
      Data_Bar.FieldByName('UNIT_ID').AsString := Unit_Id;
      Data_Bar.FieldByName('BATCH_NO').AsString := '#';
      Data_Bar.FieldByName('BARCODE').AsString := BarCode;
      Data_Bar.Post;
    end;
  var DsGoods,DsBarcode,rs:TZQuery;
      GodsId,Bar,Code,Name,Error_Info:String;
      SumBarcode,SumCode,SumName:Integer;
      Params:TftParamList;
  begin
    Result := False;
    DsGoods := TZQuery.Create(nil);
    DsBarcode := TZQuery.Create(nil);
    rs := Global.GetZQueryFromName('PUB_GOODSINFO');

    try
      Params := TftParamList.Create(nil);
      Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
      Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
      Params.ParamByName('GODS_ID').asString :='';
      Factor.BeginBatch;
      try
        Factor.AddBatch(DsGoods,'TGoodsInfo',Params);
        Factor.AddBatch(DsBarcode,'TPUB_BARCODE',Params);
        Factor.OpenBatch;
      except
        Factor.CancelBatch;
        Raise;
      end;

      CdsExcel.First;
      while not CdsExcel.Eof do
        begin
          Bar := CdsExcel.FieldByName('BARCODE1').AsString;
          Code := CdsExcel.FieldByName('GODS_CODE').AsString;
          Name := CdsExcel.FieldByName('GODS_NAME').AsString;
          if rs.Locate('BARCODE',Bar,[]) then
            Inc(SumBarcode);
          if rs.Locate('GODS_CODE',Code,[]) then
            Inc(SumCode);
          if rs.Locate('GODS_NAME',Name,[]) then
            Inc(SumName);
          if DsGoods.Locate('BARCODE',Bar,[]) then
            Inc(SumBarcode);
          if DsGoods.Locate('GODS_CODE',Code,[]) then
            Inc(SumCode);
          if DsGoods.Locate('GODS_NAME',Name,[]) then
            Inc(SumName);

          DsGoods.Append;
          GodsId := TSequence.NewId;
          DsGoods.FieldByName('GODS_ID').AsString := GodsId;
          DsGoods.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
          DsGoods.FieldByName('GODS_CODE').AsString := Code;
          DsGoods.FieldByName('GODS_NAME').AsString := Name;
          if CdsExcel.FieldByName('GODS_SPELL').AsString <> '' then
            DsGoods.FieldByName('GODS_SPELL').AsString := CdsExcel.FieldByName('GODS_SPELL').AsString
          else
            DsGoods.FieldByName('GODS_SPELL').AsString := fnString.GetWordSpell(Trim(Name),3);
          DsGoods.FieldByName('SORT_ID1').AsString := CdsExcel.FieldByName('SORT_ID1').AsString;
          DsGoods.FieldByName('SORT_ID7').AsString := CdsExcel.FieldByName('SORT_ID7').AsString;
          DsGoods.FieldByName('SORT_ID8').AsString := CdsExcel.FieldByName('SORT_ID8').AsString;
          DsGoods.FieldByName('UNIT_ID').AsString := CdsExcel.FieldByName('CALC_UNITS').AsString;
          DsGoods.FieldByName('CALC_UNITS').AsString := CdsExcel.FieldByName('CALC_UNITS').AsString;

          //2011.08.25加判断条码是否为空:
          if Bar <> '' then
          begin
            DsGoods.FieldByName('BARCODE').AsString := Bar;
            WriteToBarcode(DsBarcode,GodsId,CdsExcel.FieldByName('CALC_UNITS').AsString,CdsExcel.FieldByName('BARCODE1').AsString,'0');
          end;
          
          if CdsExcel.FieldByName('BARCODE2').AsString <> '' then
            begin
              DsGoods.FieldByName('SMALL_UNITS').AsString := CdsExcel.FieldByName('SMALL_UNITS').AsString;
              DsGoods.FieldByName('SMALLTO_CALC').AsString := CdsExcel.FieldByName('SMALLTO_CALC').AsString;
              WriteToBarcode(DsBarcode,GodsId,CdsExcel.FieldByName('SMALL_UNITS').AsString,CdsExcel.FieldByName('BARCODE2').AsString,'1');
            end;

          if CdsExcel.FieldByName('BARCODE3').AsString <> '' then
            begin
              DsGoods.FieldByName('BIG_UNITS').AsString := CdsExcel.FieldByName('BIG_UNITS').AsString;
              DsGoods.FieldByName('BIGTO_CALC').AsString := CdsExcel.FieldByName('BIGTO_CALC').AsString;
              WriteToBarcode(DsBarcode,GodsId,CdsExcel.FieldByName('BIG_UNITS').AsString,CdsExcel.FieldByName('BARCODE3').AsString,'2');
            end;

          DsGoods.FieldByName('NEW_INPRICE').AsFloat := CdsExcel.FieldByName('NEW_INPRICE').AsFloat;
          DsGoods.FieldByName('RTL_OUTPRICE').AsFloat := CdsExcel.FieldByName('NEW_OUTPRICE').AsFloat;
          DsGoods.FieldByName('NEW_LOWPRICE').AsFloat := CdsExcel.FieldByName('NEW_LOWPRICE').AsFloat;
          DsGoods.FieldByName('NEW_OUTPRICE').AsFloat := CdsExcel.FieldByName('MY_OUTPRICE').AsFloat;
          DsGoods.FieldByName('NEW_OUTPRICE1').AsFloat := CdsExcel.FieldByName('MY_OUTPRICE1').AsFloat;
          DsGoods.FieldByName('NEW_OUTPRICE2').AsFloat := CdsExcel.FieldByName('MY_OUTPRICE2').AsFloat;
          DsGoods.FieldByName('SHOP_ID').AsString := Global.SHOP_ID;

          DsGoods.FieldByName('USING_PRICE').AsInteger := 1;
          DsGoods.FieldByName('HAS_INTEGRAL').AsInteger := 1;
          DsGoods.FieldByName('USING_BATCH_NO').AsInteger := 2;

          DsGoods.FieldByName('USING_BARTER').AsInteger := 1;
          DsGoods.FieldByName('USING_LOCUS_NO').AsInteger := 2;
          DsGoods.FieldByName('BARTER_INTEGRAL').AsInteger := 0;

          DsGoods.Post;
          CdsExcel.Next;

        end;
        rs := Global.GetZQueryFromName('SYS_DEFINE');
        rs.Filtered := False;
        rs.Filter := ' DEFINE=''DUPBARCODE'' ';
        rs.Filtered := True;

        if (SumBarcode > 0 ) and (rs.FieldByName('VALUE').AsString<>'1') then
          Raise Exception.Create('系统设置不允许条码重复使用（即一码多品）');

        if (SumBarcode > 0 ) or (SumCode > 0 ) or (SumName > 0) then
          begin
            Error_Info := '在导入数据中:'+#13#10;

            if SumBarcode > 0 then
              Error_Info := Error_Info + '条形码相同有"'+IntToStr(SumBarcode)+'"条;'+#13#10;
            if SumCode > 0 then
              Error_Info := Error_Info + '货号相同有"'+IntToStr(SumCode)+'"条;'+#13#10;
            if SumName > 0 then
              Error_Info := Error_Info + '商品名称相同有"'+IntToStr(SumName)+'"条;'+#13#10;
            Error_Info := Error_Info + '是否导入！';

            if ShowMsgBox(Pchar(Error_Info),'提示信息..',MB_YESNO+MB_ICONQUESTION) <> 6 then
              begin
                Exit;
              end;
          end;

        Factor.BeginBatch;
        try
          Factor.AddBatch(DsGoods,'TGoodsInfo');
          Factor.AddBatch(DsBarcode,'TPUB_BARCODE');
          Factor.CommitBatch;
        except
          Factor.CancelBatch;
          Raise;
        end;
    finally
      DsGoods.Free;
      DsBarcode.Free;
      Params.Free;
    end;
    Result := True;
  end;

  function FindColumn(CdsCol:TDataSet):Boolean;
  begin
    Result := True;
    if not CdsCol.Locate('FieldName','GODS_NAME',[]) then
      begin
        Result := False;
        Raise Exception.Create('缺少商品名称字段!');
      end;
    if not CdsCol.Locate('FieldName','CALC_UNITS',[]) then
      begin
        Result := False;
        Raise Exception.Create('缺少计量单位字段!');  
      end;
    if not CdsCol.Locate('FieldName','SORT_ID1',[]) then
      begin
        Result := False;
        Raise Exception.Create('缺少商品分类字段!');   
      end;
    if not CdsCol.Locate('FieldName','NEW_OUTPRICE',[]) then
      begin
        Result := False;
        Raise Exception.Create('缺少标准售价字段!');
      end;
  end;
var FieldsString,FormatString:String;
    Params:TftParamList;
    rs:TZQuery;
begin
  inherited;
  rs := TZQuery.Create(nil);
  try
    with rs.FieldDefs do
      begin
        Add('BARCODE1',ftString,30,False);
        Add('GODS_CODE',ftString,20,False);
        Add('GODS_NAME',ftString,50,False);
        Add('GODS_SPELL',ftString,50,False);
        Add('CALC_UNITS',ftString,36,False);
        Add('SORT_ID1',ftString,36,False);
        Add('NEW_OUTPRICE',ftFloat,0,False);
        Add('NEW_INPRICE',ftFloat,0,False);
        Add('NEW_LOWPRICE',ftFloat,0,False);
        Add('MY_OUTPRICE',ftFloat,0,False);
        Add('SORT_ID7',ftString,36,False);
        Add('SORT_ID8',ftString,36,False);
        Add('SMALL_UNITS',ftString,36,False);
        Add('SMALLTO_CALC',ftFloat,0,False);
        Add('BARCODE2',ftString,30,False);
        Add('MY_OUTPRICE1',ftFloat,0,False);
        Add('BIG_UNITS',ftString,36,False);
        Add('BIGTO_CALC',ftFloat,0,False);
        Add('BARCODE3',ftString,30,False);
        Add('MY_OUTPRICE2',ftFloat,0,False);
      end;
    rs.CreateDataSet;
    FieldsString :=
    'BARCODE1=条形码,GODS_CODE=货号,GODS_NAME=商品名称,GODS_SPELL=拼音码,CALC_UNITS=计量单位,SORT_ID1=商品分类,NEW_OUTPRICE=标准售价,'+
    'NEW_INPRICE=最新进价,NEW_LOWPRICE=最低售价,MY_OUTPRICE=本店售价,SORT_ID7=颜色组,SORT_ID8=尺码组,SMALL_UNITS=小包装单位,SMALLTO_CALC=小包装换算系数,'+
    'BARCODE2=小包装条码,MY_OUTPRICE1=小包装本店售价,BIG_UNITS=大包装单位,BIGTO_CALC=大包装换算系数,BARCODE3=大包装条码,MY_OUTPRICE2=大包装本店售价';

    FormatString :=
    '0=BARCODE1,1=GODS_CODE,2=GODS_NAME,3=GODS_SPELL,4=CALC_UNITS,5=SORT_ID1,6=NEW_OUTPRICE,7=NEW_INPRICE,8=NEW_LOWPRICE,9=MY_OUTPRICE,'+
    '10=SORT_ID7,11=SORT_ID8,12=SMALL_UNITS,13=SMALLTO_CALC,14=BARCODE2,15=MY_OUTPRICE1,16=BIG_UNITS,17=BIGTO_CALC,18=BARCODE3,19=MY_OUTPRICE2';

    if TfrmExcelFactory.ExcelFactory(rs,FieldsString,@Check,@SaveExcel,@FindColumn,FormatString,1) then
      Global.RefreshTable('PUB_GOODSINFO');

  finally
    rs.Free;
  end;
end;

procedure TfrmGoodsInfoList.ToolButton11Click(Sender: TObject);
begin
  inherited;
  N8.OnClick(Sender);
end;

procedure TfrmGoodsInfoList.LoadList;
var
  rs:TZQuery;
  AObj:TRecord_;
begin
  ClearTree(rzTree);
  rs := Global.GetZQueryFromName('PUB_GOODS_INDEXS');
  rs.Filtered := false;
  rs.Filter := 'SORT_TYPE='+TRecord_(fndGODS_FLAG1.Properties.Items.Objects[fndGODS_FLAG1.ItemIndex]).FieldByName('CODE_ID').asString;
  rs.Filtered := true;
  if (rs<>nil) and (rs.Active) then
  begin
    rs.First;
    while not rs.Eof do
      begin
        AObj := TRecord_.Create(rs);
        AObj.ReadFromDataSet(rs);
        rzTree.Items.AddObject(nil,rs.FieldbyName('SORT_NAME').AsString,AObj);
        rs.Next;
      end;
    AddRoot(rzTree,'全部商品');
    if rzTree.Items.Count>0 then rzTree.Items[0].Selected:=true;
  end;
end;

procedure TfrmGoodsInfoList.LoadProv;
var
  rs:TZQuery;
  AObj:TRecord_;
begin
  ClearTree(RzTree);
  rs := Global.GetZQueryFromName('PUB_CLIENTINFO'); 
  rs.First;
  while not rs.Eof do
    begin
      AObj := TRecord_.Create(rs);
      AObj.ReadFromDataSet(rs);
      rzTree.Items.AddObject(nil,rs.FieldbyName('CLIENT_NAME').AsString,AObj); 
      rs.Next;
    end;
  AddRoot(rzTree,'全部商品');
  if rzTree.Items.Count>0 then rzTree.Items[0].Selected:=true;
end;

procedure TfrmGoodsInfoList.fndGODS_FLAG1PropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then Exit;
  locked := true;
  try
    case TRecord_(fndGODS_FLAG1.Properties.Items.Objects[fndGODS_FLAG1.ItemIndex]).FieldByName('CODE_ID').AsInteger of
    1:LoadTree;
    3:LoadProv;
    else LoadList;
    end;
    Open('');
  finally
    locked := false;
  end;

end;

procedure TfrmGoodsInfoList.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  if locked then Exit;
  Open('');
end;

procedure TfrmGoodsInfoList.GetProperty;  //SORT_ID8
var
  rs: TZQuery;
  Size_IDS,Color_IDS:string;
begin
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if rs.Locate('GODS_ID',cdsBrowser.FieldbyName('GODS_ID').AsString,[]) then
  begin
    Color_IDS:=trim(rs.FieldbyName('SORT_ID7').AsString);
    Size_IDS:=trim(rs.FieldbyName('SORT_ID8').AsString);
    if not ((Size_IDS='#') or (Size_IDS='')) then
    begin
      edtProperty1.Filtered:=False;
      edtProperty1.Filter:='SORT_ID='''+Size_IDS+''' ';
      edtProperty1.Filtered:=True;
    end;
    if not ((Color_IDS='#') or (Color_IDS='')) then
    begin
      edtProperty2.Filtered:=False;
      edtProperty2.Filter:='SORT_ID='''+Color_IDS+''' ';
      edtProperty2.Filtered:=True;
    end;
  end;
end;

end.
