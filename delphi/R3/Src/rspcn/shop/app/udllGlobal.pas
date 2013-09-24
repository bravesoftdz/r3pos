unit udllGlobal;

interface

uses
  SysUtils, Classes, ZDataSet, DB, ZAbstractRODataset, ZAbstractDataset, RzTreeVw,
  ZBase, ObjCommon, EncDec;

type
  TdllGlobal = class(TDataModule)
    CA_TENANT: TZQuery;
    CA_SHOP_INFO: TZQuery;
    SYS_DEFINE: TZQuery;
    CA_USERS: TZQuery;
    PUB_CUSTOMER: TZQuery;
    PUB_CLIENTINFO: TZQuery;
    PUB_GOODSINFO: TZQuery;
    PUB_MEAUNITS: TZQuery;
    PUB_PARAMS: TZQuery;
    PUB_PRICEGRADE: TZQuery;
    CA_RELATIONS: TZQuery;
    PUB_UNION_INFO: TZQuery;
    PUB_PAYMENT: TZQuery;
    PUB_GOODSSORT: TZQuery;
    PUB_REGION_INFO: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    QQ,Telephone:string;
    SFVersion: string;
    ProductId: string;
    FAuthMode: integer;
    procedure OpenPubGoodsInfo;
    procedure SetAuthMode(const Value: integer);
  public
    function GetZQueryFromName(Name:string):TZQuery;
    function Refresh(Name:string):boolean;
    function OpenSqlite(DataSet:TZQuery):boolean;
    function OpenRemote(DataSet:TZQuery):boolean;
    //按条码检索商品
    function GetGodsFromBarcode(ds:TZQuery;barcode:string):boolean;
    function GetGodsFromGodsCode(ds:TZQuery;godsCode:string):boolean;
    function getMyDeptId:string;
    function GetChkRight(MID: string; SequNo: integer=1; userid:string=''):boolean;

    function GetQQ:string;
    function GetTelephone:string;
    function GetServiceInfo:string;
    function GetProductId:string;
    function GetSFVersion:string;
    function GetVersionFlag:integer;
    function sysDate:TDatetime;
    function GetParameter(paramname:string):string;
    //获取服务端时间戳
    function GetDBTimeStamp:int64;
    //得到供应链企业 in ();
    function GetRelatTenantInWhere:string;
    //得么商品视图
    function GetViwGoodsInfo(s:string;all:boolean=true):string;
    //取得我加入的商盟企业
    function GetUnionTenantInWhere:string;
    //取商品标准进价
    function GetNewInPrice(GodsId,UnitId:string):real;
    //取商品标准售价
    function GetNewOutPrice(GodsId,UnitId:string):real;
    //读取成本价
    function GetCostPrice(GodsId:string):real;
    //检测供应链是否允许调价 还回true 允许调价
    function checkChangePrice(relationId:integer):boolean;
    //创建分类树
    function CreateGoodsSortTree(rzTree:TRzTreeView;IsAll:boolean;ShowCgtSort:boolean=true;ShowNoSort:boolean=true):boolean;overload;
    function CreateGoodsSortTree(rzTree:TRzTreeView;RelationId:string;ShowSelfRoot:boolean=false):boolean;overload;
    //认证方式 1:rsp 2:xsm
    property AuthMode:integer read FAuthMode write SetAuthMode;
  end;

var dllGlobal: TdllGlobal;

implementation

uses utokenFactory,udataFactory,iniFiles,uTreeUtil,uFnUtil;

{$R *.dfm}

{ TdllGlobal }

function TdllGlobal.GetChkRight(MID: string; SequNo: integer; userid: string): boolean;
begin
  result := true;
end;

function TdllGlobal.GetGodsFromBarcode(ds: TZQuery; barcode: string): boolean;
var
  bs:TZQuery;
begin
  ds.Close;
  ds.SQL.Text := 'select GODS_ID,UNIT_ID,PROPERTY_01,PROPERTY_02,BATCH_NO from PUB_BARCODE where TENANT_ID in ('+GetRelatTenantInWhere+') and BARCODE=:BARCODE and COMM not in (''02'',''12'')';
  ds.ParamByName('BARCODE').AsString := barcode;
  OpenSqlite(ds);
  bs := GetZQueryFromName('PUB_GOODSINFO');
  ds.First;
  while not ds.Eof do
    begin
      if bs.Locate('GODS_ID',ds.Fields[0].asString,[]) then
         ds.Next
      else
         ds.Delete;
    end;
  result := not ds.IsEmpty;
end;

function TdllGlobal.GetGodsFromGodsCode(ds: TZQuery; godsCode: string): boolean;
begin
  ds.Close;
  ds.SQL.Text := 'select GODS_ID,GODS_CODE,GODS_NAME,NEW_OUTPRICE,UNIT_ID from VIW_GOODSINFO where TENANT_ID=:TENANT_ID and GODS_CODE=:GODS_CODE and COMM not in (''02'',''12'')';
  ds.ParamByName('TENANT_ID').AsString := token.tenantId;
  ds.ParamByName('GODS_CODE').AsString := godsCode;
  OpenSqlite(ds);
  result := not ds.IsEmpty;
end;

function TdllGlobal.getMyDeptId: string;
var rs:TZQuery;
begin
  rs := GetZQueryFromName('CA_USERS');
  if rs.Locate('USER_ID',token.userId,[]) then
     result := rs.FieldbyName('DEPT_ID').AsString
  else
     Raise Exception.Create('当前操作用户没有找到，请刷新系统缓存');
end;

function TdllGlobal.GetParameter(paramname: string): string;
var rs:TZQuery;
begin
  rs := GetZQueryFromName('SYS_DEFINE');
  if rs.Locate('DEFINE',paramname,[]) then
     result := rs.FieldbyName('VALUE').AsString
  else
     result := '';
  if paramname='USING_PAYMENT' then result := '1';
end;

function TdllGlobal.GetRelatTenantInWhere: string;
var rs:TZQuery;
begin
  rs := GetZQueryFromName('CA_RELATIONS');
  result := ''+token.tenantId+'';
  rs.first;
  while not rs.eof do
    begin
      result := result + ','+rs.FieldbyName('TENANT_ID').asString+'';
      rs.next;
    end;
end;

function TdllGlobal.GetUnionTenantInWhere: string;
var rs:TZQuery;
begin
  rs := GetZQueryFromName('PUB_UNION_INFO');
  result := ''+token.tenantId+'';
  rs.first;
  while not rs.eof do
    begin
      result := result + ','+rs.FieldbyName('TENANT_ID').asString+'';
      rs.next;
    end;
end;

function TdllGlobal.GetNewInPrice(GodsId,UnitId:string):real;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select CALC_UNITS,SMALL_UNITS,BIG_UNITS,NEW_INPRICE,NEW_INPRICE1,NEW_INPRICE2 from VIW_GOODSPRICEEXT where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and GODS_ID=:GODS_ID';
    rs.ParamByName('TENANT_ID').AsInteger  := StrtoInt(token.tenantId);
    rs.ParamByName('SHOP_ID').AsString  := token.shopId;
    rs.ParamByName('GODS_ID').AsString := GodsId;
    OpenSqlite(rs);
    if rs.IsEmpty then Raise Exception.Create('经营商品中没找到“'+GodsId+'”');
    if UnitId = rs.FieldbyName('SMALL_UNITS').AsString then
      begin
        result := rs.FieldbyName('NEW_INPRICE1').AsFloat;
      end
    else
    if UnitId = rs.FieldbyName('BIG_UNITS').AsString then
      begin
        result := rs.FieldbyName('NEW_INPRICE2').AsFloat;
      end
    else
      begin
        result := rs.FieldbyName('NEW_INPRICE').AsFloat;
      end;
  finally
    rs.Free;
  end;
end;

function TdllGlobal.GetNewOutPrice(GodsId,UnitId:string):real;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select CALC_UNITS,SMALL_UNITS,BIG_UNITS,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2 from VIW_GOODSINFOEXT where TENANT_ID=:TENANT_ID and GODS_ID=:GODS_ID';
    rs.ParamByName('TENANT_ID').AsInteger  := StrtoInt(token.tenantId);
    rs.ParamByName('GODS_ID').AsString := GodsId;
    OpenSqlite(rs);
    if rs.IsEmpty then Raise Exception.Create('经营商品中没找到“'+GodsId+'”');
    if UnitId = rs.FieldbyName('SMALL_UNITS').AsString then
      begin
        result := rs.FieldbyName('NEW_OUTPRICE1').AsFloat;
      end
    else
    if UnitId = rs.FieldbyName('BIG_UNITS').AsString then
      begin
        result := rs.FieldbyName('NEW_OUTPRICE2').AsFloat;
      end
    else
      begin
        result := rs.FieldbyName('NEW_OUTPRICE').AsFloat;
      end;
  finally
    rs.Free;
  end;
end;

function TdllGlobal.GetServiceInfo:string;
var qq,tel:string;
begin
  qq := GetQQ;
  tel := GetTelephone;
  if (trim(qq) <> '') and (trim(qq) <> '123456789')then
     result := result + #10#13+'客服QQ：'+trim(qq);
  if (trim(tel) <> '') and (trim(tel) <> '123456789') then
     result := result + #10#13+'客服电话：'+trim(tel);
end;

function TdllGlobal.GetQQ: string;
var F:TIniFile;
begin
  if QQ = '' then
     begin
       F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
       try
         QQ := F.ReadString('soft','qq','123456789');
       finally
         F.Free;
       end;
     end;
  result := QQ;
end;

function TdllGlobal.GetTelephone: string;
var F:TIniFile;
begin
  if Telephone = '' then
     begin
       F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
       try
         Telephone := F.ReadString('soft','telephone','123456789');
       finally
         F.Free;
       end;
     end;
  result := Telephone;
end;

function TdllGlobal.GetProductId: string;
var F:TIniFile;
begin
  if ProductId = '' then
     begin
       F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
       try
         ProductId := F.ReadString('soft','ProductID','R3_RYC');
       finally
         F.Free;
       end;
     end;
  result := ProductId;
end;

function TdllGlobal.GetSFVersion:string;
var F:TIniFile;
begin
  if SFVersion = '' then
     begin
       F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
       try
         SFVersion := F.ReadString('soft','SFVersion','.LCL');
       finally
         F.Free;
       end;
     end;
  result := SFVersion;
end;

function TdllGlobal.GetVersionFlag: integer;
var
  F:TIniFile;
  CLVersion:string;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    CLVersion := F.ReadString('soft','CLVersion','.MKT');
  finally
    F.Free;
  end;
  if CLVersion='.FIG' then //服装版
     result := 1
  else
  if CLVersion='.MKT' then //中小超市版
     result := 2
  else
  if CLVersion='.DLI' then //食品业
     result := 4
  else
  if CLVersion='.TGS' then //食杂店-小型夫妻店精简版
     result := 5
  else
     result := 3          //默认
end;

function TdllGlobal.GetZQueryFromName(Name: string): TZQuery;
var i:Integer;
begin
  result := nil;
  for i:=0 to ComponentCount -1 do
    begin
       if UpperCase(TComponent(Components[i]).Name) = UpperCase(Name) then
          begin
            result := TZQuery(Components[i]);
            break;
          end;
    end;
  if result = nil then Raise Exception.CreateFmt('%s数据表没找到。',[Name]);
  if not result.Active then
     begin
       if TZQuery(result).Params.FindParam('SHOP_ID')<>nil then
          TZQuery(result).Params.FindParam('SHOP_ID').AsString := token.shopId;
       if TZQuery(result).Params.FindParam('SHOP_ID_ROOT')<>nil then
          TZQuery(result).Params.FindParam('SHOP_ID_ROOT').AsString := token.tenantId+'0001';
       if TZQuery(result).Params.FindParam('TENANT_ID')<>nil then
          TZQuery(result).Params.FindParam('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
       if TZQuery(result).Params.FindParam('USER_ID')<>nil then
          TZQuery(result).Params.FindParam('USER_ID').AsString := token.userId;
       if Trim(TZQuery(result).SQL.Text) = '' then Exit;
       dataFactory.MoveToSqlite;
       try
         dataFactory.Open(result);
       finally
         dataFactory.MoveToDefault;
       end;
     end;
  if result.Filtered then result.Filtered := false;
  result.OnFilterRecord := nil;
  result.CommitUpdates;
end;

procedure TdllGlobal.OpenPubGoodsInfo;
begin
  dataFactory.MoveToSqlite;
  try
    PUB_GOODSINFO.SQL.Text := '';
    dataFactory.Open(PUB_GOODSINFO);
  finally
    dataFactory.MoveToDefault;
  end;
end;

function TdllGlobal.OpenRemote(DataSet: TZQuery): boolean;
begin
  dataFactory.MoveToRemote;
  try
    dataFactory.Open(DataSet);
  finally
    dataFactory.MoveToDefault;
  end;
end;

function TdllGlobal.OpenSqlite(DataSet: TZQuery): boolean;
begin
  dataFactory.MoveToSqlite;
  try
    dataFactory.Open(DataSet);
  finally
    dataFactory.MoveToDefault;
  end;
end;

function TdllGlobal.sysDate: TDatetime;
begin
  if token.LDate=0 then
     result := date()
  else
     result := fnTime.fnStrtoDate(inttostr(token.LDate));
end;

function TdllGlobal.CreateGoodsSortTree(rzTree:TRzTreeView;IsAll:boolean;ShowCgtSort:boolean=true;ShowNoSort:boolean=true): boolean;
var IsRoot: Boolean;
    rs:TZQuery;
    i:Integer;
    Rel_ID,Rel_IDS: string;
    Aobj,CurObj:TRecord_;
begin
  // rzTree.Items.BeginUpdate;
  try
    Rel_ID:='';
    Rel_IDS:='';
    IsRoot:=False;
    ClearTree(rzTree);
    rs := GetZQueryFromName('PUB_GOODSSORT');
    rs.First;
    while not rs.Eof do
    begin
      Rel_ID:=','+InttoStr(rs.FieldByName('RELATION_ID').AsInteger)+','; //2011.09.25 add 当前供应链ID
      if (Pos(Rel_ID,Rel_IDS)<=0) and (rs.FieldByName('RELATION_ID').asString<>'1000008') then   //1000008为平台内置条码库，不显示
      begin
        if not ShowCgtSort then
           begin
             if rs.FieldByName('RELATION_ID').asString='1000006' then
                begin
                  rs.Next;
                  continue;
                end;
           end;
        Rel_IDS:=Rel_IDS+Rel_ID;  //2011.09.25 add
        if trim(rs.FieldByName('RELATION_ID').AsString)='0' then //自主经营
        begin
          CurObj := TRecord_.Create;
          CurObj.ReadFromDataSet(rs);
          CurObj.FieldByName('SORT_ID').AsString := '0000000';
          CurObj.FieldByName('LEVEL_ID').AsString := '';
          CurObj.FieldByName('SORT_NAME').AsString := rs.FieldbyName('RELATION_NAME').AsString;
          IsRoot:=true;
        end else
        begin
          Aobj := TRecord_.Create;
          Aobj.ReadFromDataSet(rs);
          Aobj.FieldByName('LEVEL_ID').AsString := '';
          Aobj.FieldByName('SORT_ID').AsString := rs.FieldByName('RELATION_ID').AsString;
          Aobj.FieldByName('SORT_NAME').AsString := rs.FieldbyName('RELATION_NAME').AsString;
          rzTree.Items.AddObject(nil,Aobj.FieldbyName('SORT_NAME').AsString,Aobj);
        end;
      end;
      rs.Next;
    end;

    if IsRoot and (CurObj<>nil) and (CurObj.FindField('SORT_NAME')<>nil) then
       rzTree.Items.AddObject(nil,CurObj.FieldbyName('SORT_NAME').AsString,CurObj);

    for i:=rzTree.Items.Count-1 downto 0 do
      begin
        rs.Filtered := False;
        rs.Filter := 'RELATION_ID='+TRecord_(rzTree.Items[i].Data).FieldbyName('RELATION_ID').AsString;
        rs.Filtered := True;
        CreateLevelTree(rs,rzTree,'44444444','SORT_ID','SORT_NAME','LEVEL_ID',0,0,'',rzTree.Items[i]);
      end;

    if ShowNoSort then
       begin
         Aobj := TRecord_.Create;
         Aobj.ReadField(rs);
         Aobj.FieldByName('SORT_ID').AsString := '#';
         Aobj.FieldByName('RELATION_ID').AsString := '0';
         Aobj.FieldByName('LEVEL_ID').AsString := '';
         Aobj.FieldByName('SORT_NAME').AsString := '无 分 类';
         rzTree.Items.AddObject(nil,Aobj.FieldbyName('SORT_NAME').AsString,Aobj);
       end;

    if IsAll then AddRoot(rzTree,'所有分类');
  finally
    // rzTree.Items.EndUpdate;
  end;
end;

function TdllGlobal.CreateGoodsSortTree(rzTree:TRzTreeView;RelationId:string;ShowSelfRoot:boolean=false): boolean;
var IsRoot: Boolean;
    rs:TZQuery;
    i:Integer;
    Rel_ID,Rel_IDS: string;
    Aobj,CurObj:TRecord_;
begin
  // rzTree.Items.BeginUpdate;
  try
    Rel_ID:='';
    Rel_IDS:='';
    IsRoot:=False;                                               
    ClearTree(rzTree);
    rs := GetZQueryFromName('PUB_GOODSSORT');
    rs.First;
    while not rs.Eof do
    begin
      Rel_ID:=','+InttoStr(rs.FieldByName('RELATION_ID').AsInteger)+','; //2011.09.25 add 当前供应链ID
      if (Pos(Rel_ID,Rel_IDS)<=0) and (rs.FieldByName('RELATION_ID').asString=RelationId) then
      begin
        Rel_IDS:=Rel_IDS+Rel_ID;  //2011.09.25 add
        if trim(rs.FieldByName('RELATION_ID').AsString)='0' then //自主经营
        begin
          CurObj := TRecord_.Create;
          CurObj.ReadFromDataSet(rs);
          CurObj.FieldByName('LEVEL_ID').AsString := '';
          CurObj.FieldByName('SORT_ID').AsString := '0000000';
          CurObj.FieldByName('SORT_NAME').AsString := rs.FieldbyName('RELATION_NAME').AsString;
          IsRoot:=true;
        end else
        begin
          Aobj := TRecord_.Create;
          Aobj.ReadFromDataSet(rs);
          Aobj.FieldByName('LEVEL_ID').AsString := '';
          Aobj.FieldByName('SORT_ID').AsString := rs.FieldByName('RELATION_ID').AsString;
          Aobj.FieldByName('SORT_NAME').AsString := rs.FieldbyName('RELATION_NAME').AsString;
          rzTree.Items.AddObject(nil,Aobj.FieldbyName('SORT_NAME').AsString,Aobj);
        end;
      end;
      rs.Next;
    end;

    if IsRoot and (CurObj<>nil) and (CurObj.FindField('SORT_NAME')<>nil) then
       rzTree.Items.AddObject(nil,CurObj.FieldbyName('SORT_NAME').AsString,CurObj)
    else if ShowSelfRoot then
       begin
         CurObj := TRecord_.Create;
         CurObj.AddField('SORT_ID','#',ftString);
         CurObj.AddField('SORT_NAME','自主经营',ftString);
         CurObj.AddField('LEVEL_ID','',ftString);
         CurObj.AddField('RELATION_ID',0,ftInteger);
         rzTree.Items.AddObject(nil,CurObj.FieldbyName('SORT_NAME').AsString,CurObj);
       end;

    for i:=rzTree.Items.Count-1 downto 0 do
      begin
        rs.Filtered := False;
        rs.Filter := 'RELATION_ID='+TRecord_(rzTree.Items[i].Data).FieldbyName('RELATION_ID').AsString;
        rs.Filtered := True;
        CreateLevelTree(rs,rzTree,'44444444','SORT_ID','SORT_NAME','LEVEL_ID',0,0,'',rzTree.Items[i]);
      end;
  finally
    // rzTree.Items.EndUpdate;
  end;
end;

function TdllGlobal.GetViwGoodsInfo(s:string;all:boolean=true): string;
function getFields(relation:integer=0):string;
var
  list:TStringList;
  fields:string;
  i:integer;
begin
  list := TStringList.Create;
  try
    list.DelimitedText := s;
    fields := '';
    for i:=0 to list.Count-1 do
      begin
        if fields<>'' then fields := fields + ',';
        if
          (list[i]<>'BARCODE')
          and
          (list[i]<>'CALC_UNITS')
          and
          (list[i]<>'SMALL_UNITS')
          and
          (list[i]<>'BIG_UNITS')
          and
          (list[i]<>'SMALLTO_CALC')
          and
          (list[i]<>'BIGTO_CALC')
          and
          (list[i]<>'GODS_TYPE')
        then
           begin
           if list[i]='TENANT_ID' then
              fields := fields+ ''+token.tenantId+' as TENANT_ID'
           else
           if list[i]='SHOP_ID' then
              fields := fields+ ''''+token.tenantId+'0001'' as SHOP_ID'
           else
           if list[i]='PRICE_ID' then
              fields := fields+ '''#'' as PRICE_ID'
           else
           if list[i]='RELATION_ID' then
              begin
                 if relation=0 then
                    fields := fields+' 0 as RELATION_ID'
                 else
                    fields := fields+' B.RELATION_ID as RELATION_ID'
              end
           else
              begin
                 if relation=0 then
                    fields := fields+list[i]
                 else
                    fields := fields+ 'isnull(B.'+list[i]+',A.'+list[i]+') as '+list[i]
              end;
           end
        else
           begin
              if relation=0 then
                 fields := fields+list[i]
              else
                 fields := fields+ 'A.'+list[i];
           end;
      end;
  finally
    list.Free;
  end;
  result := fields;
end;
var
  rs:TZQuery;
  w,sql:string;
begin
  if all then
     sql := 'select '+getFields(0)+' from PUB_GOODSINFO where TENANT_ID='+token.tenantId+' '
  else
     sql := 'select '+getFields(0)+' from PUB_GOODSINFO where TENANT_ID='+token.tenantId+' and COMM not in (''02'',''12'') ';
  rs := GetZQueryFromName('CA_RELATIONS');
  rs.first;
  while not rs.eof do
    begin
      case rs.FieldByName('RELATION_TYPE').AsInteger of
      1:begin
          if not all then
             w := ' and A.TENANT_ID='+rs.FieldbyName('TENANT_ID').asString+' and B.TENANT_ID='+token.tenantId+' and B.RELATION_ID='+rs.FieldbyName('RELATION_ID').AsString+' and B.COMM not in (''02'',''12'') '
          else
             w := ' and A.TENANT_ID='+rs.FieldbyName('TENANT_ID').asString+' and B.TENANT_ID='+token.tenantId+' and B.RELATION_ID='+rs.FieldbyName('RELATION_ID').AsString+' ';
        end
      else
        begin
          if not all then
             w := ' and A.TENANT_ID='+rs.FieldbyName('TENANT_ID').asString+' and B.TENANT_ID='+rs.FieldbyName('P_TENANT_ID').AsString+' and B.RELATION_ID='+rs.FieldbyName('RELATION_ID').AsString+' and B.COMM not in (''02'',''12'') '
          else
             w := ' and A.TENANT_ID='+rs.FieldbyName('TENANT_ID').asString+' and B.TENANT_ID='+rs.FieldbyName('P_TENANT_ID').AsString+' and B.RELATION_ID='+rs.FieldbyName('RELATION_ID').AsString+' ';
        end;
      end;
      sql := sql + ' union all select '+getFields(1)+' from PUB_GOODSINFO A,PUB_GOODS_RELATION B where A.GODS_ID=B.GODS_ID '+ w;
      rs.next;
    end;
  result := ParseSQL(dataFactory.iDbType,sql);
end;

function TdllGlobal.checkChangePrice(relationId: integer): boolean;
var rs: TZQuery;
begin
  result:=true;
  if relationId=0 then Exit;
  rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
  if rs.Locate('RELATION_ID',relationId,[]) then
  begin
    result := (trim(Rs.FieldByName('CHANGE_PRICE').AsString)<>'2');
  end;
end;

function TdllGlobal.GetCostPrice(GodsId: string): real;
begin

end;

function TdllGlobal.Refresh(Name: string): boolean;
var i:Integer;
begin
  for i:=0 to ComponentCount -1 do
    begin
       if UpperCase(TComponent(Components[i]).Name) = UpperCase(Name) then
          begin
            if not TZQuery(Components[i]).Active then Exit;
            TZQuery(Components[i]).Close;
            break;
          end;
    end;
  GetZQueryFromName(Name); 
end;

procedure TdllGlobal.SetAuthMode(const Value: integer);
begin
  FAuthMode := Value;
end;

procedure TdllGlobal.DataModuleCreate(Sender: TObject);
var
  uc:string;
  F:TIniFile;
begin
  AuthMode := 1;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    uc := F.ReadString('soft', 'xsm', '');
    if (uc <> '') and (uc[1] = '#') then
       begin
         delete(uc,1,1);
         uc := DecStr(uc,ENC_KEY);
       end;
    if uc <> '' then AuthMode := 2;
  finally
    F.Free;
  end;
end;

function TdllGlobal.GetDBTimeStamp: int64;
var
  str:string;
  rs:TZQuery;
begin
  case dataFactory.remote.iDbType of
    0:str := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
    1:str := '86400*floor(sysdate - to_date(''20110101'',''yyyymmdd''))+(sysdate - trunc(sysdate))*24*60*60';
    4:str := '86400*(DAYS(CURRENT DATE)-DAYS(DATE(''2011-01-01'')))+MIDNIGHT_SECONDS(CURRENT TIMESTAMP)';
    5:str := 'strftime(''%s'',''now'',''localtime'')-1293840000';
    else str := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
  end;

  case dataFactory.remote.iDbType of
    0,5: str := 'select ' + str + ' as time_stamp ';
    4:   str := 'select ' + str + ' as time_stamp from SYSIBM.SYSDUMMY1';
    1:   str := 'select ' + str + ' as time_stamp from DUAL';
  end;

  rs := TZQuery.Create(nil);
  dataFactory.MoveToRemote;
  try
    rs.SQL.Text := str;
    dataFactory.Open(rs);
    result := StrtoInt64(rs.Fields[0].Asstring);
  finally
    dataFactory.MoveToDefault;
    rs.Free;
  end;
end;

initialization
  dllGlobal := TdllGlobal.Create(nil);
finalization
  if Assigned(dllGlobal) then FreeAndNil(dllGlobal);
end.
