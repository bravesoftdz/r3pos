{
说明:
   (1)报表中有关系计算，SQLITE两数相除: 先乘以 *1.00 转化浮点数，DB2有关Sum字段，
      除数和被除数均要转成: cast(参数值 as decimal(18,3))
   (2)2011年3月27日晚确定关于小数的点位数控制:
      数量用:   #0.###
      单价用:   #0.00#
      金额用:   #0.00
      毛利率用: #0.00%
      折扣率用: #0% 

}



unit uframeBaseAnaly;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ToolWin, ComCtrls, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, RzButton, DB, RzBckgnd, CheckLst,
  RzLstBox, RzChkLst, RzCmboBx, Mask, RzEdit, Grids, DBGridEh, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, PrnDbgeh,
  DBGridEhImpExp,inifiles, jpeg, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, zrComboBoxList, ZBase, cxCalendar,zrMonthEdit,cxButtonEdit,
  cxRadioGroup, Buttons;


type
  TframeBaseAnaly = class(TframeToolForm)
    dsadoReport1: TDataSource;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    actFilter: TAction;
    actExport: TAction;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    Panel4: TPanel;
    SaveDialog1: TSaveDialog;
    w1: TRzPanel;
    RzPanel7: TRzPanel;
    actPrior: TAction;
    ToolButton2: TToolButton;
    actFindNext: TAction;
    adoReport1: TZQuery;
    procedure ActCloseExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;  State: TGridDrawState);
    procedure actPriorExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actFilterExecute(Sender: TObject);
  private
    procedure Dofnd_SHOP_TYPEChange(Sender: TObject);   //门店管理群组OnChange
    procedure Dofnd_TYPE_IDChange(Sender: TObject);     //商品统计指标OnChange
  public
    constructor Create(AOwner: TComponent); override;
    //返回字符的右侧子串
    function  RightStr(Str: string; vlen: integer): string;
    //返回指定控件名中数序号如: ('fndP3_D1','fndP'); 返回: 3;
    function  GetCmpNum(CmpName,BegName: string): string;

    {=======  2011.03.02 Add TDBGridEh =======}
    //添加商品指标的ItemsList[SetFlag对应位数，1..20位，若为1表添加，若为0表不添加]
    procedure AddGoodSortTypeItems(GoodSortList: TcxComboBox; SetFlag: string='01111100000000000000');
    //动态设置商品指标的ItemsList: ItemsIdx对应商品表字段：SORT_IDX1..8
    procedure AddGoodSortTypeItemsList(Sender: TObject; SortTypeList: TzrComboBoxList);
    //添加统计单位Items
    procedure AddTongjiUnitList(TJUnit: TcxComboBox);
    //选择商品类别[带供应链] 返回名称[类别名称]
    function SelectGoodSortType(var SortID:string; var SortRelID: string; var SortName: string):Boolean;
    //不同数据库类型转换：输入字段名称，返回转化后表达式:
    function IntToVarchar(FieldName: string): string;

    {=======  2011.03.03 Add 商品统计单位换算关系   =======}
    //参数: CalcIdx: 0:默认(管理)单位; 1:计量单位;  2:小包装单位; 3:大包装单位;
    //参数: AliasTabName: 传入表的别名;  AliasFileName: 传入字段别名;
    function GetUnitID(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string; //返回统计单位UNIT_ID
    function GetUnitTO_CALC(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string; //返回统计单位换算关系
    //根据统计条件关联查询数据（参数以上的返回字段）
    function GetUnitIDCnd(CalcIdx: integer; AliasTabName: string): string;   
    //返回输入日期的星期几
    function GetWeekID(FieldDate: string): string;
    function GetWeekName(WeekIdx: integer; WeekName: string='周'): string;  //返回周
    function ConStr(Fields,begIdx,endIdx: string): string;  //返回[Constr]SQL字符函数

    //判断最大结帐日期[传入]
    function  CheckAccDate(BegDate, EndDate: integer;ShopID: string=''):integer; //返回台帐表最大结帐日期
    procedure PrintBefore;virtual;
  end;

implementation

uses
  uGlobal,uShopGlobal,uShopUtil,ufrmEhLibReport,uCtrlUtil,
  ufrmSelectGoodSort;

{$R *.dfm}

procedure TframeBaseAnaly.ActCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TframeBaseAnaly.PrintBefore;
begin

end;

procedure TframeBaseAnaly.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var ARect:TRect;
begin
  if TDBGridEh(Sender).DataSource.DataSet=nil then Exit;
  if not TDBGridEh(Sender).DataSource.DataSet.Active then Exit;

  if (Rect.Top = Column.Grid.CellRect(Column.Grid.Col, Column.Grid.Row).Top) and
     (not (gdFocused in State) or not Column.Grid.Focused) then
  begin
    Column.Grid.Canvas.Brush.Color := clAqua;   //选中颜色状态
  end;
  Column.Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    DrawText(Column.Grid.Canvas.Handle,pchar(Inttostr(Column.Grid.DataSource.DataSet.RecNo)),length(Inttostr(Column.Grid.DataSource.DataSet.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

procedure TframeBaseAnaly.actPriorExecute(Sender: TObject);
var i,MaxCount: integer;
begin
  inherited;
  MaxCount:=rzPage.ActivePageIndex;
  for i:=0 to MaxCount do
  begin
    if rzPage.ActivePageIndex=0 then Exit;
    if rzPage.Pages[MaxCount-1].TabVisible then
    begin
      rzPage.ActivePageIndex := MaxCount - 1;
      break;
    end;
  end;
end;

procedure TframeBaseAnaly.FormCreate(Sender: TObject);
var
  i:integer;
  CmpName,FName,vName: string;
  Cbx: TcxComboBox;
begin
  inherited;
  //初始化参数:
  for i:=0 to self.ComponentCount -1 do
  begin
    //初始化Cbx下拉选择Items
    if (Components[i] is TcxComboBox) then
    begin
      Cbx:=TcxComboBox(Components[i]);
      CmpName:=trim(UpperCase(Cbx.Name));
      FName:=copy(CmpName,1,4);
      if FName='FNDP' then
      begin
        if RightStr(CmpName,8)='_UNIT_ID' then    //统计单位
          AddTongjiUnitList(Cbx)
        else if RightStr(CmpName,12)='_REPORT_FLAG' then  //统计类型
        begin
          AddGoodSortTypeItems(Cbx,'11111100');
          Cbx.ItemIndex:=0;
        end else
        if RightStr(CmpName,10)='_SHOP_TYPE' then //管理群组
        begin
          Cbx.Properties.OnChange:=Dofnd_SHOP_TYPEChange;
          Cbx.ItemIndex:=0;
        end else
        if RightStr(CmpName,8)='_TYPE_ID' then //商品指标
        begin
          AddGoodSortTypeItems(Cbx);
          Cbx.Properties.OnChange:=Dofnd_TYPE_IDChange;
          Cbx.ItemIndex:=0;
        end;
      end;
    end;

    //设置TzrComboBoxList属性:
    if Components[i] is TzrComboBoxList then
    begin
      CmpName:=trim(UpperCase(TzrComboBoxList(Components[i]).Name));
      //门店名称
      if (Copy(CmpName,1,4)='FNDP') and (RightStr(CmpName,8)='_SHOP_ID') then
      begin
        TzrComboBoxList(Components[i]).ShowButton:=true;
        TzrComboBoxList(Components[i]).Buttons:=[zbClear];
        if TzrComboBoxList(Components[i]).DropWidth< TzrComboBoxList(Components[i]).Width then
          TzrComboBoxList(Components[i]).DropWidth:=TzrComboBoxList(Components[i]).Width+20;
        TzrComboBoxList(Components[i]).DataSet:=Global.GetZQueryFromName('CA_SHOP_INFO');
      end;
      //部门名称
      if (Copy(CmpName,1,4)='FNDP') and (RightStr(CmpName,8)='_DEPT_ID') then
      begin
        TzrComboBoxList(Components[i]).ShowButton:=true;
        TzrComboBoxList(Components[i]).Buttons:=[zbClear];
        if TzrComboBoxList(Components[i]).DropWidth<TzrComboBoxList(Components[i]).Width then
          TzrComboBoxList(Components[i]).DropWidth:=TzrComboBoxList(Components[i]).Width+20;
        TzrComboBoxList(Components[i]).DataSet:=Global.GetZQueryFromName('CA_DEPT_INFO');
      end;
      //商品统计指标
      if (Copy(CmpName,1,4)='FNDP') and (RightStr(CmpName,11)='_SHOP_VALUE') then
      begin
        TzrComboBoxList(Components[i]).ShowButton:=true;
        TzrComboBoxList(Components[i]).Buttons:=[zbClear];
        if TzrComboBoxList(Components[i]).DropWidth< TzrComboBoxList(Components[i]).Width then
          TzrComboBoxList(Components[i]).DropWidth:=TzrComboBoxList(Components[i]).Width+20;
      end;
      //商品名称
      if (Copy(CmpName,1,4)='FNDP') and (RightStr(CmpName,8)='_GODS_ID') then
      begin
        TzrComboBoxList(Components[i]).ShowButton:=true;
        TzrComboBoxList(Components[i]).Buttons:=[zbClear];
        if TzrComboBoxList(Components[i]).DropWidth< TzrComboBoxList(Components[i]).Width then
          TzrComboBoxList(Components[i]).DropWidth:=TzrComboBoxList(Components[i]).Width+20;
        TzrComboBoxList(Components[i]).DataSet:=Global.GetZQueryFromName('PUB_GOODSINFO');
      end;
      //制单人
      if (Copy(CmpName,1,4)='FNDP') and (RightStr(CmpName,8)='_USER_ID') then
      begin
        TzrComboBoxList(Components[i]).ShowButton:=true;
        TzrComboBoxList(Components[i]).Buttons:=[zbClear];
        if TzrComboBoxList(Components[i]).DropWidth<TzrComboBoxList(Components[i]).Width then
          TzrComboBoxList(Components[i]).DropWidth:=TzrComboBoxList(Components[i]).Width+20;        
        TzrComboBoxList(Components[i]).DataSet:=Global.GetZQueryFromName('CA_USERS');
      end;
    end;
  end;
end;

constructor TframeBaseAnaly.Create(AOwner: TComponent);
begin
  inherited;
  LoadFormRes(self);
end;

procedure TframeBaseAnaly.actFilterExecute(Sender: TObject);
begin
  inherited;
 
end;

//宽度: 80个字节 最后一列不加格式，尽量靠右对齐
procedure TframeBaseAnaly.AddGoodSortTypeItemsList(Sender: TObject; SortTypeList: TzrComboBoxList);
var
  CodeID: string;
  ItemsIdx: integer;
  Cbx: TcxComboBox;
begin
  if (Sender is TcxComboBox) and (TcxComboBox(Sender).ItemIndex<>-1) then
  begin
    Cbx:=TcxComboBox(Sender);
    CodeID:=trim(TRecord_(Cbx.Properties.Items.Objects[Cbx.ItemIndex]).fieldbyName('CODE_ID').AsString);
    ItemsIdx:=StrtoIntDef(CodeID,0);
  end;
  if ItemsIdx<=0 then Exit;
  case ItemsIdx of
   3:
    begin
      SortTypeList.KeyField:='CLIENT_ID';
      SortTypeList.ListField:='CLIENT_NAME';
      SortTypeList.FilterFields:='CLIENT_ID;CLIENT_NAME;CLIENT_SPELL';
    end;
   else
    begin
      SortTypeList.KeyField:='SORT_ID';
      SortTypeList.ListField:='SORT_NAME';
      SortTypeList.FilterFields:='SORT_ID;SORT_NAME;SORT_SPELL';
    end;
  end;
  SortTypeList.Columns[0].FieldName:=SortTypeList.ListField;
  if SortTypeList.Columns.Count>1 then
    SortTypeList.Columns[1].FieldName:=SortTypeList.KeyField;
  case ItemsIdx of
   //1: fndP1_STAT_ID.DataSet:=Global.GetZQueryFromName('PUB_GOODSSORT');    //分类[大类][在供应链中]
   2: SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_CATE_INFO');    //类别[烟草:一类烟、二类烟、三类烟]
   3: SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_CLIENTINFO');   //主供应商
   4: SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_BRAND_INFO');   //品牌
   5: SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_IMPT_INFO');    //重点品牌
   6: SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_AREA_INFO');    //省内外
   7: SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_COLOR_GROUP');  //颜色
   8: SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_SIZE_GROUP');   //尺码
  end;
end;


//添加商品指标的ItemsList[SetFlag对应位数，1..8位，若为1表添加，若为0表不添加]
procedure TframeBaseAnaly.AddGoodSortTypeItems(GoodSortList: TcxComboBox; SetFlag: string);
 procedure AddItems(Cbx: TcxComboBox; Rs: TZQuery; CodeID: string);
 var CurObj: TRecord_;
 begin
   if (not Rs.Active) or (Rs.IsEmpty) then Exit;
   Rs.First;
   while not Rs.Eof do
   begin
     if trim(Rs.FieldByName('CODE_ID').AsString)=trim(CodeID) then
     begin
       CurObj:=TRecord_.Create;
       CurObj.ReadFromDataSet(Rs);
       Cbx.Properties.Items.AddObject(CurObj.fieldbyName('CODE_NAME').AsString,CurObj);
       break;
     end;
     Rs.Next;
   end;
 end;
var
  Rs: TZQuery;
  i,InValue: integer;
begin
  try
    Rs:=Global.GetZQueryFromName('PUB_STAT_INFO');
    {Rs.Filtered:=False;
    Rs.Filter:=' TYPE_CODE=''SORT_TYPE'' ';
    Rs.Filtered:=true;}
    ClearCbxPickList(GoodSortList);  //清除节点及Object对象
    for i:=1 to length(SetFlag) do
    begin
      InValue:=StrtoIntDef(SetFlag[i],0);
      if InValue=1 then
        AddItems(GoodSortList, Rs, inttostr(i));
    end;
  finally
    Rs.Filtered:=False;
    Rs.Filter:='';
  end;
end;

{===返回GoodInfo的统计[CalUNIT_ID][TabName表名，AliasFileName 字段别名]===}
function TframeBaseAnaly.GetUnitID(CalcIdx: Integer; AliasTabName, AliasFileName: string): string;
var
  AliasTab: string;
begin
  AliasTab:='';
  if trim(AliasTabName)<>'' then AliasTab:=AliasTabName+'.';
  case CalcIdx of
   0: result:='(case when isnull('+AliasTab+'UNIT_ID,'''')='''' then '+AliasTab+'CALC_UNITS else '+AliasTab+'UNIT_ID end) ';  //若[默认单位]为空则 取 [计量单位]
   1: result:=' '+AliasTab+'CALC_UNITS ';   //[计量单位]  不能为空
   2: result:='(case when isnull('+AliasTab+'SMALL_UNITS,'''')='''' then '+AliasTab+'CALC_UNITS else '+AliasTab+'SMALL_UNITS end) ';  //小包装单位
   3: result:='(case when isnull('+AliasTab+'BIG_UNITS,'''')='''' then '+AliasTab+'CALC_UNITS else '+AliasTab+'BIG_UNITS end) ';      //大包装单位
  end;
  if AliasFileName<>'' then
    result:=result+' as '+AliasFileName+' ';
end;

{===返回GoodInfo的统计换算关系[CalUNIT_ID][TabName表名，AliasFileName 字段别名]===}
function TframeBaseAnaly.GetUnitTO_CALC(CalcIdx: Integer; AliasTabName, AliasFileName: string): string;
var
  str,AliasTab,SmallCalc,BigCalc: string;
begin
  AliasTab:='';
  if trim(AliasTabName)<>'' then AliasTab:=AliasTabName+'.';
  SmallCalc:='case when isnull('+AliasTab+'SMALLTO_CALC,0)=0 then 1.0 else '+AliasTab+'SMALLTO_CALC end';
  BigCalc  :='case when isnull('+AliasTab+'BIGTO_CALC,0)=0 then 1.0 else '+AliasTab+'BIGTO_CALC end';

  str:=' case when '+AliasTab+'UNIT_ID='+AliasTab+'CALC_UNITS then 1.0 '+            //默认单位为 计量单位
            ' when '+AliasTab+'UNIT_ID='+AliasTab+'SMALL_UNITS then SMALLTO_CALC '+  //默认单位为 小单位
            ' when '+AliasTab+'UNIT_ID='+AliasTab+'BIG_UNITS then BIGTO_CALC '+      //默认单位为 大单位
            ' else 1.0 end ';

  case CalcIdx of 
   0: result:=' '+str+' ';       //默认单位
   1: result:=' 1.0 ';   //计量单位
   2: result:=' '+SmallCalc+' '; //小包装单位
   3: result:=' '+BigCalc+' ';   //大包装单位
  end;
  if AliasFileName<>'' then
    result:=result+' as '+AliasFileName+' ';
end;

function TframeBaseAnaly.GetUnitIDCnd(CalcIdx: integer;AliasTabName: string): string;
var
  AliasTab: string;
begin
  result:='';
  AliasTab:='';
  if trim(AliasTabName)<>'' then AliasTab:=AliasTabName+'.';
  case CalcIdx of
   0: result:='((case when isnull('+AliasTab+'UNIT_ID,'''')='''' then '+AliasTab+'CALC_UNITS else '+AliasTab+'UNIT_ID end)='+AliasTab+'BARCODE_UNIT_ID) ';  //若[默认单位]为空则 取 [计量单位]
   1: result:='('+AliasTab+'CALC_UNITS='+AliasTab+'.BARCODE_UNIT_ID) ';   //[计量单位]  不能为空
   2: result:='((case when isnull('+AliasTab+'SMALL_UNITS,'''')='''' then '+AliasTab+'CALC_UNITS else '+AliasTab+'SMALL_UNITS end)='+AliasTab+'BARCODE_UNIT_ID) ';  //小包装单位
   3: result:='((case when isnull('+AliasTab+'BIG_UNITS,'''')='''' then '+AliasTab+'CALC_UNITS else '+AliasTab+'BIG_UNITS end)='+AliasTab+'BARCODE_UNIT_ID) ';      //大包装单位
  end;
end;      

//添加统计单位Items
procedure TframeBaseAnaly.AddTongjiUnitList(TJUnit: TcxComboBox);
begin
  //按顺序添加[统计时取索引也是按此顺序]
  TJUnit.Properties.Items.Clear;
  TJUnit.Properties.Items.Add('默认单位');   
  TJUnit.Properties.Items.Add('计量单位');
  TJUnit.Properties.Items.Add('包装1');
  TJUnit.Properties.Items.Add('包装2');
  TJUnit.ItemIndex:=0;
end;

function TframeBaseAnaly.SelectGoodSortType(var SortID:string; var SortRelID: string; var SortName: string):Boolean;
var
  rs:TRecord_;
begin
  result:=False;
  rs := TRecord_.Create;
  try
    if TfrmSelectGoodSort.FindDialog(self,rs) then
    begin
      SortID := rs.FieldbyName('LEVEL_ID').AsString;
      SortRelID := rs.FieldbyName('RELATION_ID').AsString;
      SortName := rs.FieldbyName('SORT_NAME').AsString;
      result:=true;
    end;
  finally
    rs.Free;
  end;
end;


function TframeBaseAnaly.RightStr(Str: string; vlen: integer): string;
var aLen: integer; 
begin
  aLen:=Length(Str);
  if aLen>vlen then
    result:=Copy(Str,alen-vlen+1,vlen)
  else
    result:=Str;   
end;

function TframeBaseAnaly.GetCmpNum(CmpName, BegName: string): string;
var i,PosIdx: integer; ReStr: string;
begin
  result:='';
  ReStr:='';
  PosIdx:=Pos(BegName,CmpName);
  if PosIdx=1 then //在第一位置
  begin
    for i:=PosIdx+length(BegName) to 100 do
    begin
      if CmpName[i] in ['0'..'9'] then 
        ReStr:=ReStr+CmpName[i]
      else
        break;
    end;
    result:=ReStr;    
  end;
end;

procedure TframeBaseAnaly.Dofnd_SHOP_TYPEChange(Sender: TObject);
var
  CmpName: string;
  FindCmp: TComponent;
begin
  CmpName:=GetCmpNum(TcxComboBox(Sender).Name,'fndP'); //返回控件Num
  if CmpName<>'' then
  begin
    CmpName:='fndP'+CmpName+'_SHOP_VALUE';
    FindCmp:=self.FindComponent(CmpName);
    if (FindCmp<>nil) and (FindCmp is TzrComboBoxList) then
    begin
      case TcxComboBox(Sender).ItemIndex of
       0: TzrComboBoxList(FindCmp).DataSet:=Global.GetZQueryFromName('PUB_REGION_INFO');
       1: TzrComboBoxList(FindCmp).DataSet:=Global.GetZQueryFromName('PUB_SHOP_TYPE');
      end;
      TzrComboBoxList(FindCmp).KeyValue:=null;
      TzrComboBoxList(FindCmp).Text:='';
    end;
  end;
end;

procedure TframeBaseAnaly.Dofnd_TYPE_IDChange(Sender: TObject);
var
  CmpName: string;
  FindCmp: TComponent;
begin
  CmpName:=GetCmpNum(TcxComboBox(Sender).Name,'fndP'); //返回控件Num
  if CmpName<>'' then
  begin
    CmpName:='fndP'+CmpName+'_STAT_ID';
    FindCmp:=self.FindComponent(CmpName);
    if (FindCmp<>nil) and (FindCmp is TzrComboBoxList) then
      AddGoodSortTypeItemsList(Sender,TzrComboBoxList(FindCmp));
  end;
end;

function TframeBaseAnaly.CheckAccDate(BegDate, EndDate: integer; ShopID: string): integer;
var
  str: string;
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    str:='select max(CREA_DATE) as CREA_DATE from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID ';
    if trim(ShopID)<>'' then str:=str+' and SHOP_ID=:SHOP_ID '; //过滤门店ID
    str:=str+' and CREA_DATE>=:CREA_DATE ';
    rs.SQL.Text :=str;
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.ParamByName('SHOP_ID').AsString:= ShopID;
    if rs.Params.FindParam('CREA_DATE')<>nil then rs.ParamByName('CREA_DATE').AsInteger :=BegDate;
    Factor.Open(rs);
    if trim(rs.Fields[0].AsString)='' then
      result := BegDate-1
    else
      result := rs.Fields[0].AsInteger;
  finally
    rs.Free;
  end;
end;

function TframeBaseAnaly.IntToVarchar(FieldName: string): string;
begin
  result:=trim(FieldName);
  case Factor.iDbType of
   0,5: result:='cast('+FieldName+' as varchar)';
   4:   result:='trim(char('+FieldName+'))';
  end;
end;

function TframeBaseAnaly.GetWeekID(FieldDate: string): string;
begin
  case Factor.iDbType of
   0: result:='datepart(weekday,convert(Datetime,cast('+FieldDate+' as varchar),112))-1 ';  //返回值-1 刚好是：从0开始
   1: result:='cast(to_char(TO_DATE(cast('+FieldDate+' as varchar(8)),''yyyy-mm-dd''),''day'') as int)-1 ';
   4: result:='dayofweek(TO_DATE(cast('+FieldDate+' as varchar(8)),''yyyy-mm-dd''),''day'')-1 ';
   5: result:='strftime(''%w'',substr(SALES_DATE,1,4)||''-''||substr(SALES_DATE,5,2)||''-''||substr(SALES_DATE,7,2),''localtime'') ';
  end;
end;

function TframeBaseAnaly.ConStr(Fields,begIdx,endIdx: string): string;
begin
  case Factor.iDbType of
   0,2: //Ms SQL Server | SYSBASE  [substring]
     result :='substring('+Fields+','+begIdx+','+endIdx+')';
   3:  //ACCESS
     result :='mid('+Fields+','+begIdx+','+endIdx+')';
   1,4,5: //Oracle | DB2 | SQLITE
     result :='substr('+Fields+','+begIdx+','+endIdx+')';
  end;
end;

function TframeBaseAnaly.GetWeekName(WeekIdx: integer; WeekName: string): string;
begin
  case WeekIdx of
   0: result:=WeekName+'日';
   1: result:=WeekName+'一';
   2: result:=WeekName+'二';
   3: result:=WeekName+'三';
   4: result:=WeekName+'四';
   5: result:=WeekName+'五';
   6: result:=WeekName+'六';
  end;
end;

end.
