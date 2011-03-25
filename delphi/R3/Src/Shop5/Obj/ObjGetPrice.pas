unit ObjGetPrice;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ZDataSet,ObjCommon,DB;
type
  TGetSalesPrice=class(TZFactory)
  public
    //��ȡCommandText֮ǰ��ͨ�����ڴ��� CommandText
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
//�����Ա�����
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
         0:result := Price;//������
         1:begin
             result := FnNumber.ConvertToFight(StrtoFloat(formatfloat('#0.000',Price*rs.FieldbyName('AGIO_PERCENT').AsFloat/100)),Params.ParambyName('CarryRule').asInteger,Params.ParambyName('Deci').asInteger);
           end;//ͳһ��
         2:begin //������
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
         3:begin //ָ����Ա��
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
             //���ָ���Ļ�Ա�۸����ּ�ʱ��ȡ�ּ�Ϊ׼
             if result > Price then result := Price;
           end;//�����
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
//��ͼ�Ѹ�Ϊ�������ж���    
{    if rs.IsEmpty or (rs.FieldbyName('POLICY_TYPE').AsInteger=1) then  //û���ŵ궨��ȡ�ܵ궨��
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
    //Ĭ��Ϊԭ��,������
    PolicyType := V_POLICY_TYPE;
    MinPrice := V_APRICE;
    HasIntegral := V_HAS_INTEGRAL;
    GDPC_ID := '';
    // end
    //��ȡ������Ϣ
    ps.Close;
    ps.SQL.Text :=
      'select * from VIW_PROM_PRICE where GODS_ID=:GODS_ID and PRICE_ID in (''#'',:PRICE_ID ) and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';
    ps.Params.AssignValues(Params); 
    AGlobal.Open(ps);
    //���ִ����ֶ�ʱ��ȡ��ͼ�ԭ��
    ps.First;
    while not ps.Eof do
       begin
         MyPrice := ps.FieldbyName('NEW_OUTPRICE'+uFlag).asFloat;
         case ps.FieldbyName('RATE_OFF').AsInteger of
         1:MyPrice := CalcPrice(MyPrice,rs);
         2:MyPrice := FnNumber.ConvertToFight(StrtoFloat(formatfloat('#0.000',MyPrice*ps.FieldbyName('AGIO_RATE').AsFloat/100)),Params.ParambyName('CarryRule').asInteger,Params.ParambyName('Deci').asInteger);
         end;
         if MyPrice<MinPrice then //ȡ��ͼ�
            begin
              MinPrice := MyPrice;
              PolicyType := 3;
              HasIntegral := ps.FieldByName('ISINTEGRAL').AsInteger;
            end
         else
         if MinPrice=MyPrice then //ͬ��ʱ�����Ƿ��������Ż�����
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
    //�۱Ƚ���ϣ���ʼӦ�õ���¼��
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
