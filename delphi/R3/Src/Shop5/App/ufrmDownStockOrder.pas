{ ������ȷ�ϣ�
  (1)����Ӧ��: ���̲ݹ�˾;
  (2)������һ��ֻ��һ���������ڶ൥�������кϲ�Ϊһ�š�

}


unit ufrmDownStockOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzButton, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, StdCtrls, DB, 
  ExtCtrls, RzPanel, DBClient, Grids, DBGridEh, cxButtonEdit, zrComboBoxList,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, zBase, DBGrids, Buttons;

type
  TfrmDownStockOrder = class(TfrmBasic)
    RzPanel1: TRzPanel;
    Ds: TDataSource;
    cdsTable: TZQuery;
    TitlePanel: TPanel;
    LblMsg: TLabel;
    Bevel2: TBevel;
    HintL: TLabel;
    BottonPanel: TPanel;
    Bevel1: TBevel;
    btnOK: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    CdsStockData: TZQuery;
    LblCount: TLabel;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FXsm: boolean;
    procedure SetINDEOrderMsg; //���ü�¼��Ϣ
    function CheckIsOrderDown: Boolean; //�жϱ����Ƿ������ع�
    function FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
    function GetOrderDate: TDate;
    function GetINDE_ID: string;

    //���ض������Զ�������
    procedure AmountToCalc(edtTable: TDataSet; Amount: Real);  //����
    function  IndeOrderWriteToStock(AObj: TRecord_; vData: OleVariant): Boolean;
    procedure SetXsm(const Value: boolean); //���1��
    procedure DoXsmAutoStockOrder; //�������Զ����
  public
    FAobj: TRecord_;
    FReData: OleVariant; //�������ݰ�
    procedure OpenIndeOrderList(DownType: integer=0);  //��ѯ������������
    procedure DoCopyIndeOrderData;    //��ѡ�еĶ�����ϸ�����м��
    class function DownStockOrder(var Aobj: TRecord_;var vData: Olevariant):boolean;
    class function AutoDownStockOrder(const IndeDate: string):Boolean; //�Զ�����ȷ��[IndeDate='YYYYMMDD']
    class function XsmShow:boolean;
    property OrderDate: TDate read GetOrderDate;
    property Xsm:boolean read FXsm write SetXsm;
  end;


implementation

uses
  uFnUtil, uDsUtil, ZLogFile, uGlobal, uShopGlobal,uSyncFactory;  //ufrmCallIntf,

{$R *.dfm}

{ TfrmDownStockOrder }

{ �������ڣ�IndeDate �磺20110527 }
class function TfrmDownStockOrder.AutoDownStockOrder(const IndeDate: string):Boolean; //�Զ�����ȷ��
var
  MsgStr,ErrMsg: string;
begin
  Result:=False;
  MsgStr:='';
  ErrMsg:='';
  with TfrmDownStockOrder.Create(nil) do
  begin
    try
      FAobj:=TRecord_.Create;
      //1������ԭȡOrade�б���̣����ؽ�30�충��
      OpenIndeOrderList(1);  //��ѯ������������
      if cdsTable.IsEmpty then
      begin
        LogFile.AddLogFile(0,'�Զ����ض���<û�ж���>');  //�Զ�����д��־
        exit;   //û�ж���List�Ͳ��˳�
      end;
      //2��ѭ���������
      cdsTable.First;
      while not cdsTable.Eof do
      begin
        if cdsTable.FieldByName('INDE_DATE').AsString=IndeDate then  //ָ����������
        begin
          try
            if CheckIsOrderDown=False then //��黹û���������
            begin
              DoCopyIndeOrderData;   //���ƶ�����ϸ����
              FAobj.ReadFromDataSet(cdsTable);  //��ȡ����ֵ
              IndeOrderWriteToStock(FAobj, FReData); //�������
              if cdsTable.FindField('INDE_ID')<>nil then
              begin
                if MsgStr='' then MsgStr:=cdsTable.FindField('INDE_ID').AsString
                else MsgStr:=MsgStr+','+cdsTable.FindField('INDE_ID').AsString;
              end;
            end else
            begin
              if cdsTable.FindField('INDE_ID')<>nil then
              begin
                if ErrMsg='' then ErrMsg:=cdsTable.FindField('INDE_ID').AsString
                else ErrMsg:=ErrMsg+','+cdsTable.FindField('INDE_ID').AsString;
              end;
            end;
            //�Զ�����д��־:
            if MsgStr<>'' then LogFile.AddLogFile(0,'�Զ����ض���<���سɹ�:'+MsgStr+'; ��⵽��⣺'+ErrMsg+'>');
          except
            MessageBox(Handle,pchar('�Զ����ն���ʧ�ܣ����ֹ�ִ�У�'),'������ʾ...',MB_OK+MB_ICONWARNING);
          end;
        end;
        cdsTable.Next;
      end;
    finally
      FAobj.Free;
      Free;
    end;
  end;
end;


class function TfrmDownStockOrder.DownStockOrder(var Aobj: TRecord_;var vData: Olevariant):boolean;
var
  FrmObj: TfrmDownStockOrder;
begin
  Result:=False;
  try
    FrmObj:=TfrmDownStockOrder.Create(nil);
    FrmObj.FAobj:=Aobj;
    FrmObj.OpenIndeOrderList;  //��ѯ��������������
    if FrmObj.ShowModal=MROK then
    begin
      vData:=FrmObj.FReData;
      result:=true;
    end;
  finally
    FrmObj.Free;
  end;
end;

procedure TfrmDownStockOrder.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDownStockOrder.btnOKClick(Sender: TObject);
begin
  inherited;
  //2011.09.20Add �жϵ����Ƿ�Ϊ��������
  if not SyncFactory.SyncLockCheck then Raise Exception.Create('  �Ǳ��ŵ��ר�õ��Բ���������ȷ�ϣ� ');

  if not Xsm then //�ֹ�ȷ��
  begin
    if not ShopGlobal.GetChkRight('11200001',2) then Raise Exception.Create('��û��Ȩ�޲�������ȷ�ϣ�������ⵥ����');
    if cdsTable.IsEmpty then Raise Exception.Create(' û�ж����� ');
    if trim(CdsTable.fieldbyName('INDE_ID').AsString)<>'' then
     begin
      //2011.05.10 Add�ж��Ƿ񱾵������ع�
      if CheckIsOrderDown then
      begin
        cdsTable.Delete;
        SetINDEOrderMsg;  //��ʾ������
        Raise Exception.Create('��ǰ������'+CdsTable.fieldbyName('INDE_ID').AsString+'�ѱ������ز����ظ����أ�');
      end;

      DoCopyIndeOrderData;  //������ϸ����
      FAobj.ReadFromDataSet(cdsTable);  //��ȡ����ֵ
      ModalResult:=MROK; //��������
    end;
  end else
  begin  //�����˵�½
    DoXsmAutoStockOrder;
  end;
end;

procedure TfrmDownStockOrder.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if cdsTable.RecNo = 1 then AFont.Style := [fsBold];
end;

procedure TfrmDownStockOrder.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = Column.Grid.CellRect(Column.Grid.Col, Column.Grid.Row).Top) and
     (not (gdFocused in State) or not Column.Grid.Focused) then
  begin
    DBGridEh1.Canvas.Font.Style :=[fsBold];
    DBGridEh1.Canvas.Brush.Color := clAqua;   //ѡ����ɫ״̬
  end else
    DBGridEh1.Canvas.Font.Style :=[];

  Column.Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    DBGridEh1.canvas.Brush.Color := $0000F2F2;
    DBGridEh1.canvas.FillRect(ARect);
    DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsTable.RecNo)),length(Inttostr(cdsTable.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

function TfrmDownStockOrder.GetOrderDate: TDate;
begin
  if cdsTable.Active then
    fnTime.fnStrtoDate(cdsTable.fieldbyName('CRT_DATE').AsString);
end;

function TfrmDownStockOrder.GetINDE_ID: string;
begin
  if cdsTable.Active then
    result:=trim(CdsTable.fieldbyName('INDE_ID').AsString);
end;

//��������:
procedure TfrmDownStockOrder.OpenIndeOrderList(DownType: integer);
var
  whereCnd, UseDate,Arr_Day,OrderStatus: string; //��������,��������
  Rs: TZQuery;
  vParam: TftParamList;
begin
  try
    //��������
    Rs:=Global.GetZQueryFromName('SYS_DEFINE');
    if (Rs<>nil) and (Rs.Active) then
    begin
      if Rs.Locate('DEFINE','USING_DATE', []) then
      begin
        UseDate:=trim(Rs.fieldbyName('VALUE').AsString);
        UseDate:=FormatDateTime('YYYYMMDD', fnTime.fnStrtoDate(UseDate));
      end else
        UseDate:=FormatDateTime('YYYYMMDD', Date()); //Ĭ�Ͻ���
    end;

    Rs:=TZQuery.Create(nil);
    vParam:=TftParamList.Create(nil);
    vParam.ParamByName('ExeType').AsInteger:=1;
    vParam.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    vParam.ParamByName('SHOP_ID').AsString:=Global.SHOP_ID;
    vParam.ParamByName('USING_DATE').AsString:=UseDate;
    Global.RemoteFactory.Open(CdsTable,'TDownOrder',vParam);  //==RspServer����ģʽʱִ��
    //����ȡ�����ݺš����˲�ѯ���ؿ�
    if not CdsTable.IsEmpty then //�ж����뱾�ضԱ�
    begin
      whereCnd:='';
      CdsTable.First;
      while not CdsTable.Eof do
      begin
        if whereCnd='' then
          whereCnd:=''''+CdsTable.fieldbyName('INDE_ID').AsString+''' ' 
        else
          whereCnd:=whereCnd+','''+CdsTable.fieldbyName('INDE_ID').AsString+''' ';
        CdsTable.Next;
      end;

      Rs.Close;
      Rs.SQL.Text:='select COMM_ID from STK_STOCKORDER where COMM_ID in ('+whereCnd+') ';
      Factor.Open(Rs);
      Rs.First;
      while not Rs.Eof do
      begin
        if CdsTable.Locate('INDE_ID',trim(Rs.fieldbyName('COMM_ID').AsString),[]) then
           CdsTable.Delete;
      Rs.Next;
      end;

      //2011.08.25 Add���˵�������С���������ڣ�
      CdsTable.First;
      while not CdsTable.Eof do
      begin
        Arr_Day:=trim(CdsTable.FieldByName('ARR_DATE').AsString);
        if (Arr_Day<>'') and (Arr_Day < UseDate) then  //�������ڲ�Ϊ�գ�����С���������ڹ��˵�
          CdsTable.Delete
        else
          CdsTable.Next; 
      end;
      //���˵�״̬Ϊ:
      if DownType=1 then
      begin
        CdsTable.First;
        while not CdsTable.Eof do
        begin
          OrderStatus:=trim(CdsTable.FieldByName('STATUS').AsString);
          if (OrderStatus='05') or (OrderStatus='06') then  //����0
            CdsTable.Next 
          else
            CdsTable.Delete;
        end;
      end;
    end;
    CdsTable.First;
    SetINDEOrderMsg; //��ʾ������
  finally
    CdsTable.EnableControls;
    vParam.Free;
    Rs.Free;
  end;
end;

procedure TfrmDownStockOrder.DoCopyIndeOrderData;
var
  i: integer;
  Msg,Str: String;
  vParam: TftParamList;
begin
  i:=0;
  try                              
    CdsStockData.Close;
    vParam:=TftParamList.Create(nil);
    vParam.ParamByName('ExeType').AsInteger:=2;
    vParam.ParamByName('INDE_ID').AsString:=GetINDE_ID;
    vParam.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    Global.RemoteFactory.Open(CdsStockData,'TDownIndeData',vParam);  //==RspServer����ģʽʱִ��
    if (CdsStockData.Active) and (CdsStockData.RecordCount>0) then
    begin
      Msg:='';
      CdsStockData.First;
      while not CdsStockData.Eof do
      begin
        if trim(CdsStockData.FieldByName('GODS_ID').AsString)='' then
          Inc(i);
        CdsStockData.Next; 
      end;
      if i>0 then
      begin
        Str:='ϵͳ��⵽��ǰ���صĶ���,��'+inttoStr(i)+'����Ʒ��';
        Raise Exception.Create(Str);
      end;
      FReData:=CdsStockData.Data;
    end;
  finally
    vParam.Free;
  end;
end;
 

function TfrmDownStockOrder.FindColumn(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
var
  i:integer;
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

procedure TfrmDownStockOrder.FormCreate(Sender: TObject);
var
  Rs: TZQuery;
  SetCol: TColumnEh;
begin
  inherited;
  Xsm := false;
  Rs:=Global.GetZQueryFromName('CA_TENANT'); 
  SetCol:=FindColumn(DBGridEh1,'TENANT_ID');
  if (SetCol<>nil) and (Rs.Active) then
  begin
    SetCol.KeyList.Clear;
    SetCol.PickList.Clear;
    Rs.First;
    while not Rs.Eof do
    begin
      SetCol.KeyList.Add(trim(Rs.FieldByName('TENANT_ID').AsString));
      SetCol.PickList.Add(trim(Rs.FieldByName('TENANT_NAME').AsString));  
      Rs.Next;
    end;
  end;
end;

function TfrmDownStockOrder.CheckIsOrderDown: Boolean;
var
  Rs: TZQuery;
  Str,IndeID: string;
begin
  result:=False;
  IndeID:=trim(CdsTable.fieldbyName('INDE_ID').AsString);
  Str:='select Count(*) as ReSum from STK_STOCKORDER where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and COMM_ID='''+IndeID+''' ';
  try
    Rs:=TZQuery.Create(nil);
    Rs.Close;
    Rs.SQL.Text:=Str;
    Factor.Open(Rs);
    if Rs.FieldByName('ReSum').AsInteger>0 then
      result:=true;
  finally
    Rs.Free;
  end;
end;

function TfrmDownStockOrder.IndeOrderWriteToStock(AObj: TRecord_; vData: OleVariant): Boolean;
  function GetDeptID: string;
  var Rs: TZQuery;
  begin
    result:='';
    Rs:=ShopGlobal.GetDeptInfo;
    if Rs<>nil then
      result:=Rs.fieldbyname('DEPT_ID').AsString;
  end;
var
  i,DefInvIdx: integer;
  mny,amt: real;
  TenantID,ShopID,CurName: string;
  Params:TftParamList;
  Rs, RsGods, RsUnit,cdsHeader,cdsDetail: TZQuery;
begin
  result:=False;
  mny:=0;
  amt:=0;
  try
    Rs:=TZQuery.Create(nil);
    cdsHeader:=TZQuery.Create(nil);
    cdsDetail:=TZQuery.Create(nil);
    Params := TftParamList.Create(nil);
    Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
    Params.ParamByName('STOCK_ID').asString :='';
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TStockOrder',Params);
      Factor.AddBatch(cdsDetail,'TStockData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    //Ĭ��Ʊ�����͡�˰��
    DefInvIdx:=StrtoIntDef(ShopGlobal.GetParameter('IN_INV_FLAG'),1);
    
    //д���ͷ����
    cdsHeader.Edit;
    cdsHeader.FieldByName('STOCK_ID').AsString:=TSequence.NewId();
    cdsHeader.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsHeader.FieldbyName('SHOP_ID').AsString := Aobj.FieldbyName('SHOP_ID').AsString;
    cdsHeader.FieldByName('STOCK_TYPE').AsInteger := 1;
    cdsHeader.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
    cdsHeader.FieldByName('CREA_USER').AsString := Global.UserID;   //����Ա
    cdsHeader.FieldByName('GUIDE_USER').AsString :=Global.UserID;   //�ջ���
    cdsHeader.FieldByName('CLIENT_ID').AsString := Aobj.FieldbyName('CLIENT_ID').AsString; //�̲ݹ�˾ID
    cdsHeader.FieldByName('STOCK_DATE').AsString :=AObj.fieldbyName('INDE_DATE').AsString; //��������;
    cdsHeader.FieldByName('STOCK_DATE').AsString :=AObj.fieldbyName('INDE_DATE').AsString; //��������;
    cdsHeader.FieldByName('COMM_ID').AsString := Aobj.FieldbyName('INDE_ID').AsString;     //������
    cdsHeader.FieldByName('DEPT_ID').AsString := GetDeptID;     //Ĭ�ϲ���
    cdsHeader.FieldByName('INVOICE_FLAG').AsString :=inttostr(DefInvIdx);  //Ʊ������
    case DefInvIdx of                                                      //˰��  
     1: cdsHeader.FieldByName('TAX_RATE').AsFloat := 0;
     2: cdsHeader.FieldByName('TAX_RATE').AsFloat := StrtoFloatDef(ShopGlobal.GetParameter('IN_RATE2'),0.05);
     3: cdsHeader.FieldByName('TAX_RATE').AsFloat := StrtoFloatDef(ShopGlobal.GetParameter('IN_RATE3'),0.17);   
    end;
    cdsHeader.Post;

    if ShopGlobal.GetParameter('STK_AUTO_CHK')<>'0' then
    begin
      cdsHeader.Edit;
      cdsHeader.FieldbyName('CHK_DATE').AsString := formatdatetime('YYYY-MM-DD',date());
      cdsHeader.FieldbyName('CHK_USER').AsString := Global.UserID;
      cdsHeader.Post;
    end;
    //д���������
    Rs.Data:=vData;
    RsGods := Global.GetZQueryFromName('PUB_GOODSINFO');
    RsUnit := Global.GetZQueryFromName('PUB_MEAUNITS');

    cdsDetail.IndexFieldNames:='SEQNO';
    cdsDetail.SortedFields:='SEQNO';
    Rs.First;
    while not Rs.Eof do
    begin
      if cdsDetail.IsEmpty then cdsDetail.Edit else cdsDetail.Append;
      cdsDetail.FieldByName('STOCK_ID').AsString:=cdsHeader.FieldByName('STOCK_ID').AsString;
      cdsDetail.FieldByName('TENANT_ID').AsString:=cdsHeader.FieldByName('TENANT_ID').AsString;
      cdsDetail.FieldByName('SHOP_ID').AsString:=cdsHeader.FieldByName('SHOP_ID').AsString;
      cdsDetail.FieldbyName('SEQNO').AsInteger := Rs.RecNo;
      cdsDetail.FieldbyName('GODS_ID').AsString := Rs.FieldbyName('GODS_ID').AsString;
      if RsGods.Locate('GODS_ID',Rs.FieldbyName('GODS_ID').AsString,[]) then
      begin
        cdsDetail.FieldbyName('GODS_NAME').AsString := RsGods.FieldbyName('GODS_NAME').AsString;
        cdsDetail.FieldbyName('GODS_CODE').AsString := RsGods.FieldbyName('GODS_CODE').AsString;
        // cdsDetail.FieldbyName('BARCODE').AsString := RsGods.FieldbyName('BARCODE').AsString;
        //���ۼ�: ORG_PRICE
        if trim(Rs.FieldByName('UNIT_ID').AsString)=trim(RsGods.FieldByName('SMALL_UNITS').AsString) then //С����λ
          cdsDetail.FieldbyName('ORG_PRICE').AsFloat :=RsGods.FieldbyName('NEW_OUTPRICE1').AsFloat
        else if trim(Rs.FieldByName('UNIT_ID').AsString)=trim(RsGods.FieldByName('BIG_UNITS').AsString) then     //�����λ
          cdsDetail.FieldbyName('ORG_PRICE').AsFloat :=RsGods.FieldbyName('NEW_OUTPRICE2').AsFloat
        else
          cdsDetail.FieldbyName('ORG_PRICE').AsFloat := RsGods.FieldbyName('NEW_OUTPRICE').AsFloat;
      end else
      begin
        cdsDetail.Close;
        cdsDetail.CreateDataSet;
        Exit; // �˳�
      end;
      //��λ����:
      cdsDetail.FieldbyName('UNIT_ID').AsString := Rs.FieldbyName('UNIT_ID').AsString;
      // UnitToCalc(cdsDetail.FieldbyName('UNIT_ID').AsString);

      cdsDetail.FieldbyName('AMOUNT').AsFloat := Rs.FieldbyName('AMOUNT').AsFloat;   //����
      cdsDetail.FieldbyName('AMONEY').AsFloat := Rs.FieldbyName('AMONEY').AsFloat;   //���
      cdsDetail.FieldbyName('AGIO_MONEY').AsFloat := Rs.FieldbyName('AGIO_MONEY').AsFloat;  //�ۿۣ����������
      if Rs.FieldbyName('AMOUNT').AsFloat<>0 then
        cdsDetail.FieldbyName('APRICE').AsString := formatFloat('#0.000', Rs.FieldbyName('AMONEY').AsFloat / Rs.FieldbyName('AMOUNT').AsFloat);

      AMountToCalc(cdsDetail, cdsDetail.FieldbyName('AMOUNT').AsFloat);
      cdsDetail.FieldbyName('REMARK').AsString := '';
      if Rs.FieldbyName('NEED_AMT').AsFloat<>0 then
         cdsDetail.FieldbyName('REMARK').AsString := '������:'+Rs.FieldbyName('NEED_AMT').AsString;
      if Rs.FieldbyName('CHK_AMT').AsFloat<>0 then
         cdsDetail.FieldbyName('REMARK').AsString := cdsDetail.FieldbyName('REMARK').AsString+'�����:'+Rs.FieldbyName('CHK_AMT').AsString;
      //�����ۼ���
      mny := mny + cdsDetail.FieldbyName('CALC_MONEY').asFloat;
      amt := amt + cdsDetail.FieldbyName('AMOUNT').asFloat;

      //����Ϊ���ֶ�:
      cdsDetail.FieldbyName('BATCH_NO').AsString:='#';
      cdsDetail.FieldbyName('PROPERTY_01').AsString:='#';
      cdsDetail.FieldbyName('PROPERTY_02').AsString:='#';
      cdsDetail.FieldbyName('IS_PRESENT').AsInteger:=0;
      cdsDetail.Post;
      Rs.Next;
    end;
    //���������
    cdsHeader.Edit;
    cdsHeader.FieldbyName('STOCK_MNY').asFloat := mny;
    cdsHeader.FieldbyName('STOCK_AMT').asFloat := amt;
    cdsHeader.Post;
    try
      //�ύ����
      Factor.BeginBatch;
      Factor.AddBatch(cdsHeader,'TStockOrder');
      Factor.AddBatch(cdsDetail,'TStockData');
      Factor.CommitBatch;
      result:=true;
    except
      Factor.CancelBatch;
      cdsHeader.CancelUpdates;
      cdsDetail.CancelUpdates;
      Raise;
    end;
  finally
    cdsHeader.Free;
    cdsDetail.Free;
    Rs.Free;
    Params.Free;
  end;    
end;

procedure TfrmDownStockOrder.AmountToCalc(edtTable: TDataSet; Amount: Real);
var
  rs:TZQuery;
  AMoney,APrice,Agio_Rate,Agio_Money,SourceScale:Real;
  Field:TField;
begin
  if not (edtTable.State in [dsEdit,dsInsert]) then edtTable.Edit;
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not rs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then
    Raise Exception.Create('��Ӫ��Ʒ��û�ҵ���'+edtTable.FieldbyName('GODS_NAME').AsString+'��');  
  if edtTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('CALC_UNITS').AsString then
     begin
      SourceScale := 1;
     end
  else
  if edtTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('BIG_UNITS').AsString then
     begin
      SourceScale := rs.FieldByName('BIGTO_CALC').asFloat;
     end
  else
  if edtTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('SMALL_UNITS').AsString then
     begin
      SourceScale := rs.FieldByName('SMALLTO_CALC').asFloat;
     end
  else
     begin
      SourceScale := 1;
     end;

  Field := edtTable.FindField('CALC_AMOUNT');
  if Field<>nil then
  begin
     Field.AsFloat := AMount * SourceScale;
  end;

  Field := edtTable.FindField('APRICE');
  if Field=nil then Exit;
  Field.AsString := FormatFloat('#0.000',Field.AsFloat);
  //ȡ����
  APrice := Field.asFloat;
  //����
  AMoney := StrtoFloat(FormatFloat('#0.00',APrice * AMount));
  Field := edtTable.FindField('AMONEY');
  if Field<>nil then
     Field.AsString := FormatFloat('#0.00',AMoney);
  if edtTable.FindField('ORG_PRICE') = nil then
    begin
      //�����ۿ�
      Field := edtTable.FindField('AGIO_RATE');
      if Field<>nil then
         Agio_Rate := (Field.AsFloat / 100)
      else
         Agio_Rate := 1;
      //���=0Ϊ������
      if Agio_Rate=0 then Agio_Rate := 1;

      Agio_Money := (AMoney/Agio_Rate) - AMoney;
    end
  else
    begin
      if edtTable.FindField('ORG_PRICE').AsFloat=0 then
         Agio_Money := 0
      else
         Agio_Money := edtTable.FindField('ORG_PRICE').AsFloat*Amount-AMoney;

      //�����ۿ�
      Field := edtTable.FindField('AGIO_RATE');
      if (Field<>nil) and (AMount<>0) then
         begin
            if edtTable.FindField('ORG_PRICE').AsFloat<>0 then
               Field.AsString := formatFloat('#0.0',AMoney *100 /(edtTable.FindField('ORG_PRICE').AsFloat*Amount))
            else
               Field.AsString := '100';
         end;
    end;
  Field := edtTable.FindField('AGIO_MONEY');
  if Field<>nil then
     Field.AsString := FormatFloat('#0.00',Agio_Money);

  Field := edtTable.FindField('CALC_MONEY');
  if Field<>nil then
     Field.AsString := FormatFloat('#0.00',AMoney) ;
  edtTable.Post;
  edtTable.Edit;
end;

class function TfrmDownStockOrder.XsmShow: boolean;
var
  FrmObj: TfrmDownStockOrder;
begin
  Result:=False;
  FrmObj:=TfrmDownStockOrder.Create(nil);
  try
    FrmObj.Xsm := true;
    FrmObj.Show;
    FrmObj.OpenIndeOrderList(1);  //��ѯ��������������
    result:=true;
  except
    FrmObj.free;
  end;
end;

procedure TfrmDownStockOrder.SetXsm(const Value: boolean);
begin
  FXsm := Value;
end;

procedure TfrmDownStockOrder.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if xsm then Action := caFree;
end;

procedure TfrmDownStockOrder.DoXsmAutoStockOrder;
var
  ReRun: Boolean;
  CurObj: TRecord_;
begin
  if MessageBox(self.Handle,pchar('���Ҫ���е���ȷ����'),'������ʾ...',MB_YESNO+MB_ICONQUESTION)=6 then
  begin
    try
      if CheckIsOrderDown=False then //��黹û���������
      begin
        DoCopyIndeOrderData;   //���ƶ�����ϸ����
        try
          CurObj:=TRecord_.Create;
          CurObj.ReadFromDataSet(cdsTable);  //��ȡ����ֵ
          ReRun:=IndeOrderWriteToStock(CurObj, FReData); //�������
          if ReRun then //����ȷ�ϳɹ�
          begin
            cdsTable.Delete;
            if cdsTable.State in [dsEdit,dsInsert] then
              cdsTable.Post;
          end;
        finally
          CurObj.Free;
        end;
      end;
    except
      FAobj.Free;
      MessageBox(Handle,pchar('�Զ����ն���ʧ�ܣ����ֹ�ִ�У�'),'������ʾ...',MB_OK+MB_ICONWARNING);
    end;
  end;
end;

procedure TfrmDownStockOrder.SetINDEOrderMsg;
begin
  LblMsg.Visible:=False;
  LblCount.Visible:=False;
  if cdsTable.Active then
  begin
    LblCount.Caption:=Inttostr(cdsTable.RecordCount);
    LblMsg.Visible:=true;
    LblCount.Visible:=true;
  end;
end;

end.
