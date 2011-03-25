unit ObjGetPrice;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ZDataSet,ObjCommon,DB;
type
  TGetSalesPrice=class(TZFactory)
  public
    //读取CommandText之前，通常用于处理 CommandText
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
implementation
uses uFnUtil;
{ TGetSalesPrice }
function TGetSalesPrice.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  rs,ps:TZQuery;
  MyPrice:Real;
  uFlag:string;
  GDPC_ID,SORT_ID:string;
  MinPrice:Real;
  PolicyType,HasIntegral:integer;
//计算会员打扣率
function CalcPrice(Price:real;DataSet:TZQuery):real;
var
  rs,ss:TZQuery;
  vList:TStringList;
  agio:real;
begin
  if Params.ParamByName('CLIENT_ID').AsString = '' then
     begin
       result := Price;
     end
  else
     begin
       rs := TZQuery.Create(nil);
       ss := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select A.PRICE_ID,A.AGIO_TYPE,A.AGIO_PERCENT,A.AGIO_SORTS from PUB_PRICEGRADE A where A.PRICE_ID=:PRICE_ID and A.TENANT_ID=:TENANT_ID';
         rs.Params.AssignValues(Params);
         AGlobal.Open(rs);
         case rs.FieldbyName('AGIO_TYPE').AsInteger of
         0:result := Price;//不打折
         1:begin
             result := FnNumber.ConvertToFight(StrtoFloat(formatfloat('#0.000',Price*rs.FieldbyName('AGIO_PERCENT').AsFloat/100)),Params.ParambyName('CarryRule').asInteger,Params.ParambyName('Deci').asInteger);
           end;//统一折
         2:begin //分类折
             vList := TStringList.Create;
             try
               vList.CommaText := rs.FieldbyName('AGIO_SORTS').AsString;
               ss.Close;
               ss.SQL.Text :=
                 ParseSQL(AGlobal.iDbType,
                 'select SORT_ID,LEVEL_ID from VIW_GOODSSORT where TENANT_ID=:TENANT_ID and RELATION_ID=:RELATION_ID order by length(LEVEL_ID) desc');
               ss.ParambyName('TENANT_ID').AsInteger := Params.ParambyName('TENANT_ID').asInteger;
               ss.ParambyName('RELATION_ID').asInteger := DataSet.FieldbyName('RELATION_ID').AsInteger;
               AGlobal.Open(ss);
               agio := 100;
               ss.First;
               while not ss.Eof do
                 begin
                    if vList.IndexOfName(ss.Fields[0].asString)>=0 then
                       begin
                         agio := StrtoFloatDef(vList.Values[ss.Fields[0].asString],100);
                         break;
                       end;
                    ss.Next;
                 end;
               if agio<>100 then
                  result := FnNumber.ConvertToFight(StrtoFloat(formatfloat('#0.000',Price*agio/100)),Params.ParambyName('CarryRule').asInteger,Params.ParambyName('Deci').asInteger)
               else
                  result := price;
             finally
               vList.Free;
             end;
           end;
         3:begin //指定会员价
             ss.Close;
             ss.SQL.Text :=
               'select NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,SHOP_ID from PUB_GOODSPRICE where TENANT_ID=:TENANT_ID and SHOP_ID in ('''+Params.ParambyName('TENANT_ID').AsString+'0001'+''',:SHOP_ID) and PRICE_ID=:PRICE_ID and GODS_ID=:GODS_ID';
             ss.ParambyName('TENANT_ID').AsInteger := Params.ParambyName('TENANT_ID').asInteger;
             ss.ParambyName('SHOP_ID').AsString := Params.ParambyName('SHOP_ID').AsString;
             ss.ParambyName('PRICE_ID').AsString := rs.FieldbyName('PRICE_ID').AsString;
             ss.ParambyName('GODS_ID').AsString := Params.ParambyName('GODS_ID').AsString;
             AGlobal.Open(ss);
             if ss.IsEmpty then result := price else
                begin
                  ss.Locate('SHOP_ID',Params.ParambyName('SHOP_ID').AsString,[]);
                  if not ss.FieldbyName('NEW_OUTPRICE'+uFlag).IsNull then
                     result := ss.FieldbyName('NEW_OUTPRICE'+uFlag).AsFloat
                  else
                     result := Price;
                end;
             //如果指定的会员价高于现价时，取现价为准
             if result > Price then result := Price;
           end;//代理价
         end;
       finally
         rs.Free;
         ss.Free;
       end;
      end;
end;
var
  tmp:TZQuery;
  s:string;
  V_ORG_PRICE:real;
  V_POLICY_TYPE:integer;
  V_HAS_INTEGRAL:integer;
  V_APRICE:real;
begin
  result := true;
  rs := TZQuery.Create(nil);
  ps := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text :=
       'select POLICY_TYPE,SMALL_UNITS,CALC_UNITS,BIG_UNITS,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,SORT_ID1,RELATION_ID,HAS_INTEGRAL '+
       'from VIW_GOODSPRICE  where GODS_ID=:GODS_ID and SHOP_ID=:SHOP_ID and TENANT_ID=:TENANT_ID and PRICE_ID=''#''';
    rs.Params.AssignValues(Params);
    AGlobal.Open(rs);
//视图已改为会智能判断了    
{    if rs.IsEmpty or (rs.FieldbyName('POLICY_TYPE').AsInteger=1) then  //没有门店定价取总店定价
       begin
        rs.Close;
        rs.SQL.Text :=
           'select POLICY_TYPE,SMALL_UNITS,CALC_UNITS,BIG_UNITS,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,SORT_ID1,RELATION_ID,HAS_INTEGRAL '+
           'from VIW_GOODSPRICE  where GODS_ID=:GODS_ID and SHOP_ID=:SHOP_ID_ROOT and TENANT_ID=:TENANT_ID and PRICE_ID=''#''';
        rs.Params.AssignValues(Params);
        rs.ParamByName('SHOP_ID_ROOT').AsString := Params.ParambyName('TENANT_ID').AsString+'0001';
        AGlobal.Open(rs);
       end;  }
    if Params.ParamByName('UNIT_ID').asString=rs.FieldbyName('SMALL_UNITS').AsString then
       uFlag := '1'
    else
    if Params.ParamByName('UNIT_ID').asString=rs.FieldbyName('BIG_UNITS').AsString then
       uFlag := '2'
    else
       uFlag := '';
    SORT_ID := rs.FieldbyName('SORT_ID1').AsString;
    V_ORG_PRICE := rs.FieldbyName('NEW_OUTPRICE'+uFlag).AsFloat;
    V_POLICY_TYPE := rs.FieldbyName('POLICY_TYPE').AsInteger;
    V_HAS_INTEGRAL := rs.FieldbyName('HAS_INTEGRAL').AsInteger;
    if (Params.ParamByName('CLIENT_ID').AsString <> '') then
       begin
         V_APRICE := CalcPrice(V_ORG_PRICE,rs);
       end
    else
       V_APRICE := CalcPrice(V_ORG_PRICE,rs);
    //默认为原价,不促销
    PolicyType := V_POLICY_TYPE;
    MinPrice := V_APRICE;
    HasIntegral := V_HAS_INTEGRAL;
    GDPC_ID := '';
    // end
    //读取促销信息
    ps.Close;
    ps.SQL.Text :=
      'select * from VIW_PROM_PRICE where GODS_ID=:GODS_ID and PRICE_ID in (''#'',:PRICE_ID ) and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';
    ps.Params.AssignValues(Params); 
    AGlobal.Open(ps);
    //多种促销手段时，取最低价原则
    ps.First;
    while not ps.Eof do
       begin
         MyPrice := ps.FieldbyName('NEW_OUTPRICE'+uFlag).asFloat;
         case ps.FieldbyName('RATE_OFF').AsInteger of
         1:MyPrice := CalcPrice(MyPrice,rs);
         2:MyPrice := FnNumber.ConvertToFight(StrtoFloat(formatfloat('#0.000',MyPrice*ps.FieldbyName('AGIO_RATE').AsFloat/100)),Params.ParambyName('CarryRule').asInteger,Params.ParambyName('Deci').asInteger);
         end;
         if MyPrice<MinPrice then //取最低价
            begin
              MinPrice := MyPrice;
              PolicyType := 3;
              HasIntegral := ps.FieldByName('ISINTEGRAL').AsInteger;
            end
         else
         if MinPrice=MyPrice then //同价时，看是否还有其他优惠条件
            begin
              if (ps.FieldByName('ISINTEGRAL').AsInteger=1) and (HasIntegral=0) then
                 begin
                   MinPrice := MyPrice;
                   PolicyType := 3;
                   HasIntegral := ps.FieldByName('ISINTEGRAL').AsInteger;
                 end;
            end;
         ps.Next;
       end;
    //end
    //价比较完毕，开始应用到记录中
    V_APRICE := MinPrice;
    V_POLICY_TYPE := PolicyType;
    V_HAS_INTEGRAL := HasIntegral;
  finally
    ps.Free;
    rs.Free;
  end;
  case AGlobal.iDbType of
  0,5:SelectSQL.Text := 'select '+formatFloat('#0.000',V_ORG_PRICE)+' as V_ORG_PRICE,'+inttostr(V_POLICY_TYPE)+' as V_POLICY_TYPE,'+inttostr(V_HAS_INTEGRAL)+' as V_HAS_INTEGRAL,'+formatFloat('#0.000',V_APRICE)+' as V_APRICE';
  4:SelectSQL.Text := 'select '+formatFloat('#0.000',V_ORG_PRICE)+' as V_ORG_PRICE,'+inttostr(V_POLICY_TYPE)+' as V_POLICY_TYPE,'+inttostr(V_HAS_INTEGRAL)+' as V_HAS_INTEGRAL,'+formatFloat('#0.000',V_APRICE)+' as V_APRICE from SYSIBM.SYSDUMMY1';
  1:SelectSQL.Text := 'select '+formatFloat('#0.000',V_ORG_PRICE)+' as V_ORG_PRICE,'+inttostr(V_POLICY_TYPE)+' as V_POLICY_TYPE,'+inttostr(V_HAS_INTEGRAL)+' as V_HAS_INTEGRAL,'+formatFloat('#0.000',V_APRICE)+' as V_APRICE from DUAL';
  end;
end;

procedure TGetSalesPrice.InitClass;
begin
  inherited;

end;

initialization
  RegisterClass(TGetSalesPrice);
end.
