unit uKpiCalculate;

interface
uses
  Windows, Messages, SysUtils, Classes, InvokeRegistry, Types, ZBase, Variants,
  ObjCommon, ZDataset, DateUtils, ZAbstractRODataset;

type
  TKpiInfo=record
    TenantId:Integer;  //企业ID
    KpiYear:Integer;   //年度
    KpiId:String;      //指标ID
    ClientId:String;   //经销商ID
    IdxType:String;    //指标类型
    KpiType:String;    //考核类型
    KpiData:String;    //考核标准
    KpiCalc:String;    //计算标准
    KpiOptn:String;    //是否启用阶梯
    KpiAgio:Real;      //标准系数
    PlanAmt:Real;      //签约销量
    PlanMny:Real;      //签约金额
  end;
  TKpiIndexInfo=record   //指标信息记录
    TenantId:Integer;  //企业ID
    KpiYear:Integer;   //年度
    KpiId:String;      //指标ID
    ClientId:String;   //经销商ID
    IdxType:String;    //指标类型
    KpiType:String;    //考核类型
    LevelId:String;    //签约等级
    LevelAmt:Real;     //签约量
    LevelLowRate:Real; //等级最低返利系数
    PlanAmt:Real;      //签约销量
    PlanMny:Real;      //签约金额
  end;
  TKpiSeqNo=record     //达标档位信息记录
    SeqNoId:String;    //档位ID
    KpiAmt:Real;       //达标量/达标系数
  end;
  TKpiSite=record
    LastLv:String;
    LastSeqNo:Integer;
    LastParam:Real;
    LastAmt:Real;
    ThisLv:String;
    ThisSeqNo:Integer;
    ThisParam:Real;
    ThisAmt:Real;
  end;
  TKpiIndex=Record
    LV:String;
    SEQNO:Integer;
    KpiRate:Real;
    KpiAgio:Real;
    FshVle:Real;
    KpiMny:Real;
  end;
  //PKpiInfo=^TKpiInfo;
  PKpiIndex=^TKpiIndex;
  TClientRebate=class
  private
    ContainerBrrw:Real; //借量值容器
    MaxRate:Real;       //最大返利系数
    GoodsRate:Real;     //商品转换系数
    IsFlag:Boolean;     //是否开始计算促销时段
    CdsGoods: TZQuery;  //记录某一时间段内各商品的相关参数
    KpiData,KpiCalc,RatioType:Integer;  //存储当前时间段内的 考核标准、计算标准、返利设定 参数
    SmallToCalc,BigToCalc:Real;         //小换算率、大换算率
    FKpiLevel: TZQuery;
    FKpiGoods: TZQuery;
    FKpiSeqNo: TZQuery;
    FKpiRatio: TZQuery;
    FKpiTimes: TZQuery;
    FKpiDetail: TZQuery;
    FActiveRatio: TZQuery;
    procedure SetKpiGoods(const Value: TZQuery);
    procedure SetKpiLevel(const Value: TZQuery);
    procedure SetKpiRatio(const Value: TZQuery);
    procedure SetKpiSeqNo(const Value: TZQuery);
    procedure SetKpiTimes(const Value: TZQuery);
    procedure SetKpiDetail(const Value: TZQuery);
    function UnitToCalc(GoodsId,UnitId:String):Real;
    procedure SetActiveRatio(const Value: TZQuery);
  public
    FKpiIndexInfo:TKpiIndexInfo;
    FSeqNo:TKpiSeqNo;
    constructor Create;
    destructor Destroy; override;
    procedure YearCheck;            //年度考核
    procedure SeasonCheck;          //季度考核
    procedure DateSectionCheck;     //时间段考核
    procedure CalculationRebate;    //计算返利
    procedure CalculationRaito(GodId:String;GodNum:Real);     //计算计提
    procedure LocateLevel(SumNum:Real);    //定位签约等级
    function LocateTapPosition(CheckNum:Real;Brrow:boolean=false):real;//定位达标档位
    function KpiDataNum(Num:Real):Real;    //计算当前考核达标系数
    function GetSaleMoney(StartDate,EndDate:Integer):Real;
    procedure ReachJudge(KpiRate,CheckNum:Real);
    procedure PromJudge(KpiRate:Real);
    function UseBrrw(CurAmt:Real;IsBrrw:Boolean):Real;
    property KpiGoods:TZQuery read FKpiGoods write SetKpiGoods;
    property KpiLevel:TZQuery read FKpiLevel write SetKpiLevel;
    property KpiTimes:TZQuery read FKpiTimes write SetKpiTimes;
    property KpiSeqNo:TZQuery read FKpiSeqNo write SetKpiSeqNo;
    property KpiRatio:TZQuery read FKpiRatio write SetKpiRatio;
    property ActiveRatio:TZQuery read FActiveRatio write SetActiveRatio;
    property KpiDetail:TZQuery read FKpiDetail write SetKpiDetail;
  end;

  TKpiCalculate=class
  private
    FDataSet_Kpi: TZQuery;
    FList:TList;
    Type_Brrw:Boolean;//有关跨年度、季度中与每条档位的比较值
    LV_MNY:Real; //在某个时间段内的销售量(销售额/毛利)
    ContainerBrrw:Real; //借量值容器
    LastProNum:Real;//上次累进数
    ProNum:Real;//累进数
    FKpiSite:TKpiSite;//记录考核标准定位参数
    function GetKpiMny(LV:String):Real;
    function GetCurSeq(LV:String):Integer;
    procedure SetDataSet_Kpi(const Value: TZQuery);

    procedure DateCalculate(var StartDate,EndDate:Integer);//日期计算
    function ReachJudge(CurAmt,CurPrarm,Param1,Param2,CurAgio:Real):Real;   //判断达标情况并得出考核结果值
    function UseBrrw(CurAmt,CurPrarm,Param1,Param2:Real;IsBrrw:Boolean):Real;   //有关借量
    function KpiDataNum(Num:Real):Real;     //返回对应考核类型的参数值(销量、金额、毛利)
  public
    FKpiInfo:TKpiInfo;

    constructor Create;
    destructor Destroy; override;
    procedure BeginCalculate;     //开始计算

    function GetLvFshVle(KpiLv:String;SeqNo:Integer):Real;
    function FindKipIndex(LV:String;SeqNo:Integer):PKpiIndex;

    procedure AddKpiIndex(KpiIndex:PKpiIndex);
    procedure Clear;
    property KpiMny[LV:String]:Real read GetKpiMny;    //返回当前时间段的考核结果
    property CurSeq[LV:String]:Integer read GetCurSeq;  //返回当前时间段的已经达标的档位序号
    property DataSet_Kpi:TZQuery read FDataSet_Kpi write SetDataSet_Kpi;
  end;

implementation
uses uShopGlobal,uGlobal,uDsUtil,DB;


{ TKpiCalculate }

constructor TKpiCalculate.Create;
begin
  FList := TList.Create;
end;

destructor TKpiCalculate.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TKpiCalculate.ReachJudge(CurAmt,CurPrarm,Param1,Param2,CurAgio:Real): Real;
var Rate:Integer;
    D_Value:Real;
begin
  Result := 0;

  LastProNum := ProNum;
  if StrToInt(FKpiInfo.KpiCalc) in [1,4] then Rate := 1 else Rate := 100;
  if StrToInt(FKpiInfo.KpiCalc) in [1,2,3] then
  begin
     if CurPrarm >= Param2 then
     begin
        //Result := CurAmt * CurAgio*FKpiInfo.KpiAgio/Rate;
        Result := CurAmt * CurAgio/Rate;
        ProNum := 0;
     end
     else
     begin
        Result := CurAmt * FKpiInfo.KpiAgio/Rate;
        ProNum := 0;
     end;
  end
  else if StrToInt(FKpiInfo.KpiCalc) in [4,5,6] then
  begin
     if FKpiInfo.KpiType <> '3' then
     begin
       if (CurPrarm >= Param2) and (Param1 = Param2 ) then
       begin
          if FKpiInfo.KpiData = '1' then
          begin
             //Result := FKpiInfo.PlanAmt*Param2*CurAgio*FKpiInfo.KpiAgio/Rate;
             //ProNum := CurAmt*CurAgio*FKpiInfo.KpiAgio/Rate;
             Result := FKpiInfo.PlanAmt*Param2*CurAgio/Rate;
             ProNum := CurAmt*CurAgio/Rate;
          end
          else if FKpiInfo.KpiData = '2' then
          begin
             //Result := FKpiInfo.PlanMny*Param2*CurAgio*FKpiInfo.KpiAgio/Rate;
             //ProNum := CurAmt*CurAgio*FKpiInfo.KpiAgio/Rate;
             Result := FKpiInfo.PlanMny*Param2*CurAgio/Rate;
             ProNum := CurAmt*CurAgio/Rate;
          end
          else if FKpiInfo.KpiData = '3' then
          begin
             //Result := FKpiInfo.PlanMny*Param2*CurAgio*FKpiInfo.KpiAgio/Rate;
             //ProNum := CurAmt*CurAgio*FKpiInfo.KpiAgio/Rate;
             Result := FKpiInfo.PlanMny*Param2*CurAgio/Rate;
             ProNum := CurAmt*CurAgio/Rate;
          end
          else if FKpiInfo.KpiData = '4' then
          begin
             {Result := (Param2)*CurAgio*FKpiInfo.KpiAgio/Rate;
             D_Value := CurAmt-Param2;
             if D_Value <= 0 then
                ProNum := 0
             else
                ProNum := (D_Value)*CurAgio*FKpiInfo.KpiAgio/Rate;}
             Result := (Param2)*CurAgio/Rate;
             D_Value := CurAmt-Param2;
             if D_Value <= 0 then
                ProNum := 0
             else
                ProNum := (D_Value)*CurAgio/Rate;
          end
          else if FKpiInfo.KpiData = '5' then
          begin
             {Result := (Param2)*CurAgio*FKpiInfo.KpiAgio/Rate;
             D_Value := CurAmt-Param2;
             if D_Value <= 0 then
                ProNum := 0
             else
                ProNum := (CurAmt-Param2)*CurAgio*FKpiInfo.KpiAgio/Rate;}
             Result := (Param2)*CurAgio/Rate;
             D_Value := CurAmt-Param2;
             if D_Value <= 0 then
                ProNum := 0
             else
                ProNum := (CurAmt-Param2)*CurAgio/Rate;
          end
          else if FKpiInfo.KpiData = '6' then
          begin
             {Result := (Param2)*CurAgio*FKpiInfo.KpiAgio/Rate;
             D_Value := CurAmt-Param2;
             if D_Value <= 0 then
                ProNum := 0
             else
                ProNum := (CurAmt-Param2)*CurAgio*FKpiInfo.KpiAgio/Rate;}
             Result := (Param2)*CurAgio/Rate;
             D_Value := CurAmt-Param2;
             if D_Value <= 0 then
                ProNum := 0
             else
                ProNum := (CurAmt-Param2)*CurAgio/Rate;
          end;
       end
       else if (CurPrarm >= Param2) and (Param2 > Param1) then
       begin
          if FKpiInfo.KpiData = '1' then
          begin
             {D_Value := CurAmt-FKpiInfo.PlanAmt*Param2;
             if D_Value <= 0 then
             begin
                Result := 0;
                ProNum := 0;
             end
             else
             begin
                Result := (FKpiInfo.PlanAmt*Param2-FKpiInfo.PlanAmt*Param1)*CurAgio*FKpiInfo.KpiAgio/Rate;
                ProNum := (CurAmt-FKpiInfo.PlanAmt*Param1)*CurAgio*FKpiInfo.KpiAgio/Rate;
             end;}
             D_Value := CurAmt-FKpiInfo.PlanAmt*Param2;
             if D_Value <= 0 then
             begin
                Result := 0;
                ProNum := 0;
             end
             else
             begin
                Result := (FKpiInfo.PlanAmt*Param2-FKpiInfo.PlanAmt*Param1)*CurAgio/Rate;
                ProNum := (CurAmt-FKpiInfo.PlanAmt*Param1)*CurAgio/Rate;
             end;
          end
          else if FKpiInfo.KpiData = '2' then
          begin
             {D_Value := CurAmt-FKpiInfo.PlanMny*Param2;
             if D_Value <= 0 then
             begin
                Result := 0;
                ProNum := 0;
             end
             else
             begin
                Result := (FKpiInfo.PlanMny*Param2-FKpiInfo.PlanMny*Param1)*CurAgio*FKpiInfo.KpiAgio/Rate;
                ProNum := (CurAmt-FKpiInfo.PlanMny*Param1)*CurAgio*FKpiInfo.KpiAgio/Rate;
             end;}
             D_Value := CurAmt-FKpiInfo.PlanMny*Param2;
             if D_Value <= 0 then
             begin
                Result := 0;
                ProNum := 0;
             end
             else
             begin
                Result := (FKpiInfo.PlanMny*Param2-FKpiInfo.PlanMny*Param1)*CurAgio/Rate;
                ProNum := (CurAmt-FKpiInfo.PlanMny*Param1)*CurAgio/Rate;
             end;
          end
          else if FKpiInfo.KpiData = '3' then
          begin
             {D_Value := CurAmt-FKpiInfo.PlanMny*Param2;
             if D_Value <= 0 then
             begin
                Result := 0;
                ProNum := 0;
             end
             else
             begin
                Result := (FKpiInfo.PlanMny*Param2-FKpiInfo.PlanMny*Param1)*CurAgio*FKpiInfo.KpiAgio/Rate;
                ProNum := (CurAmt-FKpiInfo.PlanMny*Param1)*CurAgio*FKpiInfo.KpiAgio/Rate;
             end;}
             D_Value := CurAmt-FKpiInfo.PlanMny*Param2;
             if D_Value <= 0 then
             begin
                Result := 0;
                ProNum := 0;
             end
             else
             begin
                Result := (FKpiInfo.PlanMny*Param2-FKpiInfo.PlanMny*Param1)*CurAgio/Rate;
                ProNum := (CurAmt-FKpiInfo.PlanMny*Param1)*CurAgio/Rate;
             end;
          end
          else if FKpiInfo.KpiData = '4' then
          begin
             {D_Value := CurAmt-Param2;
             if D_Value <= 0 then
             begin
                Result := 0;
                ProNum := 0;
             end
             else
             begin
                Result := (Param2-Param1)*CurAgio*FKpiInfo.KpiAgio/Rate;
                ProNum := (CurAmt-Param1)*CurAgio*FKpiInfo.KpiAgio/Rate;
             end;}
             D_Value := CurAmt-Param2;
             if D_Value <= 0 then
             begin
                Result := 0;
                ProNum := 0;
             end
             else
             begin
                Result := (Param2-Param1)*CurAgio/Rate;
                ProNum := (CurAmt-Param1)*CurAgio/Rate;
             end;
          end
          else if FKpiInfo.KpiData = '5' then
          begin
             {D_Value := CurAmt-Param2;
             if D_Value <= 0 then
             begin
                Result := 0;
                ProNum := 0;
             end
             else
             begin
                Result := (Param2-Param1)*CurAgio*FKpiInfo.KpiAgio/Rate;
                ProNum := (CurAmt-Param1)*CurAgio*FKpiInfo.KpiAgio/Rate;
             end;}
             D_Value := CurAmt-Param2;
             if D_Value <= 0 then
             begin
                Result := 0;
                ProNum := 0;
             end
             else
             begin
                Result := (Param2-Param1)*CurAgio/Rate;
                ProNum := (CurAmt-Param1)*CurAgio/Rate;
             end;
          end
          else if FKpiInfo.KpiData = '6' then
          begin
             {D_Value := CurAmt-Param2;
             if D_Value <= 0 then
             begin
                Result := 0;
                ProNum := 0;
             end
             else
             begin
                Result := (Param2-Param1)*CurAgio*FKpiInfo.KpiAgio/Rate;
                ProNum := (CurAmt-Param1)*CurAgio*FKpiInfo.KpiAgio/Rate;
             end;}
             D_Value := CurAmt-Param2;
             if D_Value <= 0 then
             begin
                Result := 0;
                ProNum := 0;
             end
             else
             begin
                Result := (Param2-Param1)*CurAgio/Rate;
                ProNum := (CurAmt-Param1)*CurAgio/Rate;
             end;
          end;
       end
       else
          ProNum := 0;
     end
     else
     begin
       if (CurPrarm >= Param2) then
       begin
          Result := CurAmt*Param2*CurAgio/Rate;
          ProNum := 0;
       end
       else
       begin
          Result := CurAmt*Param2*FKpiInfo.KpiAgio/Rate;
          ProNum := 0;
       end;
     end;
  end;
end;

procedure TKpiCalculate.SetDataSet_Kpi(const Value: TZQuery);
begin
  FDataSet_Kpi := Value;
end;

function TKpiCalculate.GetKpiMny(LV:String):Real;
var i:Integer;
begin
  Result := 0;
  for i := 0 to FList.Count - 1 do
  begin
    if PKpiIndex(FList[i]).LV = LV then
    begin
       if StrToInt(FKpiInfo.KpiCalc) in [1,2,3] then
       begin
          if PKpiIndex(FList[i]).KpiMny > Result then
             Result := PKpiIndex(FList[i]).KpiMny;
       end
       else
          Result := Result + PKpiIndex(FList[i]).KpiMny;
    end;
  end;
end;

procedure TKpiCalculate.Clear;
var i:Integer;
begin
  for i:=FList.Count-1 downto 0 do
  begin
    Dispose(FList[i]);
  end;
  FList.Clear;
end;

function TKpiCalculate.GetLvFshVle(KpiLv: String; SeqNo: Integer): Real;
begin

end;

procedure TKpiCalculate.AddKpiIndex(KpiIndex: PKpiIndex);
begin
  FList.Add(KpiIndex);
end;

function TKpiCalculate.FindKipIndex(LV: String; SeqNo: Integer): PKpiIndex;
var i:integer;
begin
  result := nil;

  for i:=0 to FList.Count -1 do
    begin
      if (PKpiIndex(FList[i]).LV=LV) and (PKpiIndex(FList[i]).SEQNO=SeqNo) then
         begin
           result := PKpiIndex(FList[i]);
           Exit;
         end;
    end;
end;

procedure TKpiCalculate.BeginCalculate;
function GetUnitTO_CALC: string;
var
  str: string;
begin
  str:=' case when B.UNIT_ID=C.CALC_UNITS then 1.0 '+            //默认单位为 计量单位
            ' when B.UNIT_ID=C.SMALL_UNITS then cast(C.SMALLTO_CALC*1.00 as decimal(18,3)) '+  //默认单位为 小单位
            ' when B.UNIT_ID=C.BIG_UNITS then cast(C.BIGTO_CALC*1.00 as decimal(18,3)) '+      //默认单位为 大单位
            ' else 1.0 end ';
  result:=str;
end;
var rs:TZQuery;
    IsAdd,Brrw:Boolean;
    Kpi_Index:PKpiIndex;
//当前时间段内的达标量、当前考核结果、当前达标率/达标量、上一指标达标率/达标量、当前指标达标率/达标量,当前折扣系数
    CurAmount,CurMny,CurRate_Amt,LastParam,CurParam,CurAgio:Real;
    // 返利计算
    CalculateAmt,ActAmt:Real;
begin
  if FDataSet_Kpi.IsEmpty then Exit;

  IsAdd := False;
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    if FKpiInfo.IdxType = '1' then
    begin
      rs.SQL.Text := 'select sum(CALC_AMOUNT/'+GetUnitTO_CALC+') as CALC_AMOUNT,sum(CALC_MONEY) as CALC_MONEY from VIW_SALESDATA A,MKT_KPI_GOODS B,VIW_GOODSINFO C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID and A.IS_PRESENT=0 '+
      ' and A.TENANT_ID=:TENANT_ID and A.CLIENT_ID=:CLIENT_ID and A.SALES_DATE >= :SALES_DATE1 and A.SALES_DATE <= :SALES_DATE2'+
      ' and B.KPI_ID=:KPI_ID ';
    end
    else if FKpiInfo.IdxType = '2' then
    begin
      rs.SQL.Text := 'select sum(CALC_AMOUNT/'+GetUnitTO_CALC+') as CALC_AMOUNT,sum(CALC_MONEY) as CALC_MONEY from VIW_SALESDATA A,MKT_KPI_GOODS B,VIW_GOODSINFO C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID and A.IS_PRESENT=0 '+
      ' and A.TENANT_ID=:TENANT_ID and A.CLIENT_ID=:CLIENT_ID and A.SALES_DATE >= :SALES_DATE1 and A.SALES_DATE <= :SALES_DATE2'+
      ' and B.KPI_ID=:KPI_ID ';
    end
    else if FKpiInfo.IdxType = '3' then
    begin
      rs.SQL.Text := 'select sum(CALC_AMOUNT/'+GetUnitTO_CALC+') as CALC_AMOUNT,sum(CALC_MONEY) as CALC_MONEY from VIW_SALESDATA A,MKT_KPI_GOODS B,VIW_GOODSINFO C '+
      ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID and A.IS_PRESENT=0 '+
      ' and A.TENANT_ID=:TENANT_ID and A.GUIDE_USER=:CLIENT_ID and A.SALES_DATE >= :SALES_DATE1 and A.SALES_DATE <= :SALES_DATE2'+
      ' and B.KPI_ID=:KPI_ID ';
    end;
    rs.Params.ParamByName('TENANT_ID').AsInteger := FKpiInfo.TenantId;
    rs.Params.ParamByName('CLIENT_ID').AsString := FKpiInfo.ClientId;
    rs.Params.ParamByName('KPI_ID').AsString := FKpiInfo.KpiId;
    FDataSet_Kpi.First;
    while not FDataSet_Kpi.Eof do
    begin
      //      从此处开始对日期、
      if FKpiInfo.KpiType = '3' then
      begin
         if (FDataSet_Kpi.FieldByName('SEQNO').AsInteger = 1) then
         begin
             if StrToInt(FKpiInfo.KpiData) in [1,2,3] then
             begin
                CurParam := FDataSet_Kpi.FieldByName('KPI_RATE').AsFloat/100;
                LastParam := FDataSet_Kpi.FieldByName('KPI_RATE').AsFloat/100;
             end
             else
             begin
                CurParam := FDataSet_Kpi.FieldByName('KPI_AMT').AsFloat;
                LastParam := FDataSet_Kpi.FieldByName('KPI_AMT').AsFloat;
             end;
         end
         else
         begin
             if StrToInt(FKpiInfo.KpiData) in [1,2,3] then
             begin
                CurParam := LastParam;
                LastParam := FDataSet_Kpi.FieldByName('KPI_RATE').AsFloat/100;
             end
             else
             begin
                CurParam := LastParam;
                LastParam := FDataSet_Kpi.FieldByName('KPI_AMT').AsFloat;
             end;
         end;
         IsAdd := True;
         if FDataSet_Kpi.FieldByName('KPI_DATE1').AsInteger > FDataSet_Kpi.FieldByName('KPI_DATE2').AsInteger then
            begin
              rs.Params.ParamByName('SALES_DATE1').AsInteger := (FKpiInfo.KpiYear)*10000+FDataSet_Kpi.FieldByName('KPI_DATE1').AsInteger;
              rs.Params.ParamByName('SALES_DATE2').AsInteger := (FKpiInfo.KpiYear+1)*10000+FDataSet_Kpi.FieldByName('KPI_DATE2').AsInteger;
            end
         else
            begin
              rs.Params.ParamByName('SALES_DATE1').AsInteger := (FKpiInfo.KpiYear)*10000+FDataSet_Kpi.FieldByName('KPI_DATE1').AsInteger;
              rs.Params.ParamByName('SALES_DATE2').AsInteger := (FKpiInfo.KpiYear)*10000+FDataSet_Kpi.FieldByName('KPI_DATE2').AsInteger;
            end;
         CurAgio := FDataSet_Kpi.FieldByName('KPI_AGIO').AsFloat;
      end
      else
      begin
        if (FDataSet_Kpi.FieldByName('SEQNO').AsInteger = 1) then
        begin
          if StrToInt(FKpiInfo.KpiData) in [1,2,3] then
          begin
             CurParam := FDataSet_Kpi.FieldByName('KPI_RATE').AsFloat/100;
             LastParam := FDataSet_Kpi.FieldByName('KPI_RATE').AsFloat/100;
          end
          else
          begin
             CurParam := FDataSet_Kpi.FieldByName('KPI_AMT').AsFloat;
             LastParam := FDataSet_Kpi.FieldByName('KPI_AMT').AsFloat;
          end;
          IsAdd := True;
          if FDataSet_Kpi.FieldByName('KPI_DATE1').AsInteger > FDataSet_Kpi.FieldByName('KPI_DATE2').AsInteger then
             begin
               rs.Params.ParamByName('SALES_DATE1').AsInteger := (FKpiInfo.KpiYear)*10000+FDataSet_Kpi.FieldByName('KPI_DATE1').AsInteger;
               rs.Params.ParamByName('SALES_DATE2').AsInteger := (FKpiInfo.KpiYear+1)*10000+FDataSet_Kpi.FieldByName('KPI_DATE2').AsInteger;
             end
          else
             begin
               rs.Params.ParamByName('SALES_DATE1').AsInteger := (FKpiInfo.KpiYear)*10000+FDataSet_Kpi.FieldByName('KPI_DATE1').AsInteger;
               rs.Params.ParamByName('SALES_DATE2').AsInteger := (FKpiInfo.KpiYear)*10000+FDataSet_Kpi.FieldByName('KPI_DATE2').AsInteger;
             end;
        end
        else
        begin
          LastParam := CurParam;
          if StrToInt(FKpiInfo.KpiData) in [1,2,3] then
             CurParam := FDataSet_Kpi.FieldByName('KPI_RATE').AsFloat/100
          else
             CurParam := FDataSet_Kpi.FieldByName('KPI_AMT').AsFloat;
        end;

        CurAgio := FDataSet_Kpi.FieldByName('KPI_AGIO').AsFloat;
      end;
      // 从此处结束对日期段的判断

      FKpiSite.LastLv := FKpiSite.ThisLv;
      FKpiSite.LastSeqNo := FKpiSite.ThisSeqNo;
      FKpiSite.ThisLv := FDataSet_Kpi.FieldByName('KPI_LV').AsString;
      FKpiSite.ThisSeqNo := FDataSet_Kpi.FieldByName('SEQNO').AsInteger;

      if IsAdd then       //在某一时间段中的销售量/销售额/毛利
      begin
         Factor.Open(rs);
         if rs.IsEmpty then
         begin
            CurAmount := 0;
            CurRate_Amt := 0;
         end
         else
         begin
            if StrToInt(FKpiInfo.KpiData) in [1,4] then
               CurAmount := rs.FieldByName('CALC_AMOUNT').AsFloat
            else if StrToInt(FKpiInfo.KpiData) in [2,5] then
               CurAmount := rs.FieldByName('CALC_MONEY').AsFloat
            else if StrToInt(FKpiInfo.KpiData) in [3,6] then
               CurAmount := rs.FieldByName('CALC_MONEY').AsFloat;

            if StrToInt(FKpiInfo.KpiCalc) in [1,4] then
               CalculateAmt := rs.FieldByName('CALC_AMOUNT').AsFloat
            else if StrToInt(FKpiInfo.KpiCalc) in [2,5] then
               CalculateAmt := rs.FieldByName('CALC_MONEY').AsFloat
            else if StrToInt(FKpiInfo.KpiCalc) in [3,6] then
               CalculateAmt := rs.FieldByName('CALC_MONEY').AsFloat;
         end;
         ActAmt := CurAmount;
         IsAdd := False;
      end;
      
      if (FDataSet_Kpi.FieldByName('KPI_LV').AsString = '1') and (FDataSet_Kpi.FieldByName('SEQNO').AsInteger = 1) then
      begin
         FKpiSite.LastParam := CurParam;
         FKpiSite.ThisParam := CurParam;
         FKpiSite.LastAmt := CurAmount;
         FKpiSite.ThisAmt := CurAmount;
      end
      else
      begin
         FKpiSite.LastParam := FKpiSite.ThisParam;
         FKpiSite.ThisParam := CurParam;
         FKpiSite.LastAmt := FKpiSite.ThisAmt;
         FKpiSite.ThisAmt := CurAmount;
      end;
      //此处判断是否加借量值
      if FDataSet_Kpi.FieldByName('USING_BRRW').AsString = '1' then Brrw := True else Brrw := False;
      CurAmount := UseBrrw(CurAmount,CurRate_Amt,LastParam,CurParam,Brrw);
      //根据考核标准 得出当前时间段 是否达标的系数
      CurRate_Amt := KpiDataNum(CurAmount);
      //得出当前档位的考核结果
      CurMny := ReachJudge(CalculateAmt,CurRate_Amt,LastParam,CurParam,CurAgio);
      if (CurMny = 0) and (FDataSet_Kpi.FieldByName('KPI_LV').AsString <> '0') and (FDataSet_Kpi.FieldByName('SEQNO').AsInteger = 1) then
      begin
         New(Kpi_Index);
         Kpi_Index.LV := FDataSet_Kpi.FieldByName('KPI_LV').AsString;
         Kpi_Index.SEQNO := 0;
         Kpi_Index.KpiRate := 0;
         Kpi_Index.KpiAgio := FKpiInfo.KpiAgio;
         Kpi_Index.FshVle := ActAmt;
         Kpi_Index.KpiMny := CalculateAmt * FKpiInfo.KpiAgio;
         AddKpiIndex(Kpi_Index);
      end;

      New(Kpi_Index);
      Kpi_Index.LV := FDataSet_Kpi.FieldByName('KPI_LV').AsString;
      Kpi_Index.SEQNO := FDataSet_Kpi.FieldByName('SEQNO').AsInteger;
      if StrToInt(FKpiInfo.KpiData) in [1,2,3] then
      begin
         if CurRate_Amt > CurParam then
            Kpi_Index.KpiRate := FDataSet_Kpi.FieldByName('KPI_RATE').AsFloat
         else
            Kpi_Index.KpiRate := 0;
      end
      else
      begin
         if CurRate_Amt > CurParam then
            Kpi_Index.KpiRate := FDataSet_Kpi.FieldByName('KPI_AMT').AsFloat
         else
            Kpi_Index.KpiRate := 0;
      end;

      if CurRate_Amt > CurParam then
        Kpi_Index.KpiAgio := FDataSet_Kpi.FieldByName('KPI_AGIO').AsFloat
      else
        Kpi_Index.KpiAgio := FKpiInfo.KpiAgio;

      Kpi_Index.FshVle := ActAmt;
      Kpi_Index.KpiMny := CurMny;
      AddKpiIndex(Kpi_Index);
      //有关累进计算，重新赋值
      if (StrToInt(FKpiInfo.KpiCalc) in [4,5,6]) and (FKpiInfo.KpiType<>'3')
         and
         (((FKpiSite.LastLv<>FKpiSite.ThisLv) and (LastProNum <> 0)) or ((FKpiSite.LastLv=FKpiSite.ThisLv) and (FKpiSite.LastSeqNo<>FKpiSite.ThisSeqNo) and (ProNum = 0) and (LastProNum <> 0))) then
      begin
         if FindKipIndex(FKpiSite.LastLv,FKpiSite.LastSeqNo) <> nil then
            FindKipIndex(FKpiSite.LastLv,FKpiSite.LastSeqNo).KpiMny := LastProNum;
      end;

      FDataSet_Kpi.Next;
    end;
    //有关累进计算，在最后一档重新赋值
    if (StrToInt(FKpiInfo.KpiCalc) in [4,5,6]) and (ProNum <> 0) and (FKpiInfo.KpiType<>'3') then
    begin
       if FindKipIndex(FKpiSite.ThisLv,FKpiSite.ThisSeqNo) <> nil then
          FindKipIndex(FKpiSite.ThisLv,FKpiSite.ThisSeqNo).KpiMny := ProNum;
    end;
  finally
    rs.Free;
  end;
end;

function TKpiCalculate.KpiDataNum(Num:Real): Real;
begin
  if FKpiInfo.KpiData = '1' then
  begin
     if FKpiInfo.PlanAmt = 0 then
        Result := 1
     else
        Result := Num/FKpiInfo.PlanAmt;
  end
  else if FKpiInfo.KpiData = '2' then
  begin
     if FKpiInfo.PlanMny = 0 then
        Result := 1
     else
        Result := Num/FKpiInfo.PlanMny;
  end
  else if FKpiInfo.KpiData = '3' then
  begin
     if FKpiInfo.PlanMny = 0 then
        Result := 1
     else
        Result := Num/FKpiInfo.PlanMny;
  end
  else
     Result := Num;
end;

function TKpiCalculate.UseBrrw(CurAmt,CurPrarm,Param1,Param2:Real;IsBrrw:Boolean):Real;
begin
  if FKpiInfo.KpiType = '3' then
  begin
     if CurPrarm < Param2 then       //当前时间段内的达标系数 小于 当前档位的达标系数
     begin
        if IsBrrw then    //当前档位是否允许借量
        begin
           Result := CurAmt + ContainerBrrw;     //当前时间段内的销售量/金额 从借量容器中获得借量值
           if FKpiInfo.KpiData = '1' then
              ContainerBrrw := Result - FKpiInfo.PlanAmt*Param2
           else if FKpiInfo.KpiData = '2' then
              ContainerBrrw := Result - FKpiInfo.PlanMny*Param2
           else if FKpiInfo.KpiData = '3' then
              ContainerBrrw := Result - FKpiInfo.PlanMny*Param2
           else 
              ContainerBrrw := Result - Param2;   //借量后把超额的值返还给 借量容器
           if ContainerBrrw < 0 then ContainerBrrw := 0;       // 如果没有超额则把 借量容器 为 0
        end;
     end
     else
     begin
       // 已经超额，超额的向借量容器中流动
       if FKpiInfo.KpiData = '1' then
          ContainerBrrw := ContainerBrrw + CurAmt - FKpiInfo.PlanAmt*Param2
       else if FKpiInfo.KpiData = '2' then
          ContainerBrrw := ContainerBrrw + CurAmt - FKpiInfo.PlanMny*Param2
       else if FKpiInfo.KpiData = '3' then
          ContainerBrrw := ContainerBrrw + CurAmt - FKpiInfo.PlanMny*Param2
       else
          ContainerBrrw := ContainerBrrw + CurAmt - Param2;
       Result := CurAmt;
     end;
  end
  else
  begin
     Result := CurAmt;
     if (FKpiSite.LastLv <> FKpiSite.ThisLv) and Type_Brrw then   //在 LastLv与ThisLv 不同时,说明上一个LastLv、LastSeqNo为上一周期的最后一档
     begin                                                        //再计算最后一档的超额放入 借量容器 中
       if FKpiInfo.KpiData = '1' then
          ContainerBrrw := FKpiSite.LastAmt - FKpiInfo.PlanAmt*FKpiSite.LastParam
       else if FKpiInfo.KpiData = '2' then
          ContainerBrrw := FKpiSite.LastAmt - FKpiInfo.PlanMny*FKpiSite.LastParam
       else if FKpiInfo.KpiData = '3' then
          ContainerBrrw := FKpiSite.LastAmt - FKpiInfo.PlanMny*FKpiSite.LastParam
       else
          ContainerBrrw := FKpiSite.LastAmt - FKpiSite.LastParam;
       Result := CurAmt + ContainerBrrw;
       ContainerBrrw := 0;
     end;

     if CurPrarm < Param2 then Type_Brrw := False else Type_Brrw := True;
  end;

end;

procedure TKpiCalculate.DateCalculate(var StartDate,EndDate:Integer);
begin

end;

function TKpiCalculate.GetCurSeq(LV: String): Integer;
var i,Seq:Integer;
    Mny:Real;
begin
  Seq := 1;
  Mny := 0;
  for i := 0 to FList.Count - 1 do
  begin
    if PKpiIndex(FList[i]).LV = LV then
    begin
       if StrToInt(FKpiInfo.KpiCalc) in [1,2,3] then
       begin
          if PKpiIndex(FList[i]).KpiMny > Mny then
          begin
             Mny := PKpiIndex(FList[i]).KpiMny;
             Seq := PKpiIndex(FList[i]).SEQNO;
          end;
       end
       else
          if PKpiIndex(FList[i]).KpiMny <> 0 then
          begin
             //Mny := PKpiIndex(FList[i]).KpiMny;
             Seq := PKpiIndex(FList[i]).SEQNO;
          end;
    end;
  end;
  Result := Seq;
end;

{ TClientRebate }

procedure TClientRebate.CalculationRaito(GodId: String; GodNum: Real);
var MidCalc,CurUnitNum:Real;
begin
  if ActiveRatio.Locate('GODS_ID',GodId,[]) then
  begin
     KpiGoods.Locate('GODS_ID',GodId,[]);
     MidCalc := UnitToCalc(GodId,KpiGoods.FieldByName('UNIT_ID').AsString);
     CurUnitNum := GodNum*MidCalc;
     MidCalc := UnitToCalc(GodId,ActiveRatio.FieldByName('UNIT_ID').AsString);
     KpiDetail.FieldByName('ACTR_RATIO').AsFloat := ActiveRatio.FieldByName('ACTR_RATIO').AsFloat;
     KpiDetail.FieldByName('BUDG_KPI').AsFloat := CurUnitNum/MidCalc*ActiveRatio.FieldByName('ACTR_RATIO').AsFloat;
  end;
end;

procedure TClientRebate.CalculationRebate;
begin
  if FKpiIndexInfo.KpiType = '1' then
     YearCheck
  else if FKpiIndexInfo.KpiType = '2' then
     SeasonCheck
  else if FKpiIndexInfo.KpiType = '3' then
     DateSectionCheck;
end;

constructor TClientRebate.Create;
begin
  CdsGoods := TZQuery.Create(nil);
  ContainerBrrw := 0;
end;

procedure TClientRebate.DateSectionCheck;
var CheckNum,ResultValue,CurKpiRate,AdjsAmt:Real;
    IsBorrow:Boolean;
begin
  LocateLevel(FKpiIndexInfo.PlanAmt);
  IsFlag := False;
  KpiTimes.First;
  while not KpiTimes.Eof do
  begin
    if KpiTimes.FieldByName('KPI_FLAG').AsString = '0' then
    begin
      KpiData := KpiTimes.FieldByName('KPI_DATA').AsInteger;
      KpiCalc := KpiTimes.FieldByName('KPI_CALC').AsInteger;
      RatioType := KpiTimes.FieldByName('RATIO_TYPE').AsInteger;

      CheckNum := GetSaleMoney(KpiTimes.FieldByName('KPI_DATE1').AsInteger,KpiTimes.FieldByName('KPI_DATE2').AsInteger);

      if (KpiTimes.FieldByName('USING_BRRW').AsString = '1') then IsBorrow := True else IsBorrow := False;
      CurKpiRate := LocateTapPosition(CheckNum,IsBorrow); //定位达标档位并获取相关参数
      ReachJudge(CurKpiRate,CheckNum);
    end;
    KpiTimes.Next;
  end;
end;

destructor TClientRebate.Destroy;
begin
  CdsGoods.Free;
  inherited;
end;

function TClientRebate.GetSaleMoney(StartDate, EndDate: Integer): Real;
function GetUnitTO_CALC: string;
var str:string;
begin
  str:='( case when B.UNIT_ID=C.CALC_UNITS then 1.0 '+            //默认单位为 计量单位
       ' when B.UNIT_ID=C.SMALL_UNITS then cast(C.SMALLTO_CALC*1.00 as decimal(18,3)) '+  //默认单位为 小单位
       ' when B.UNIT_ID=C.BIG_UNITS then cast(C.BIGTO_CALC*1.00 as decimal(18,3)) '+      //默认单位为 大单位
       ' else 1.0 end )';
  result:=str;
end;
begin
  if FKpiIndexInfo.IdxType = '1' then
    CdsGoods.SQL.Text :=
    ' select A.GODS_ID,sum(A.CALC_AMOUNT) as CALC_AMOUNT,sum(A.CALC_AMOUNT/'+GetUnitTO_CALC+') as AMOUNT,sum(A.CALC_MONEY) as CALC_MONEY '+
    ' from VIW_SALESDATA A inner join MKT_KPI_GOODS B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID '+
    ' inner join VIW_GOODSINFO C on A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+
//    ' left join MKT_KPI_RESULT_LIST D on A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID and A.CLIENT_ID=D.CLIENT_ID and A.KPI'+
    ' where A.IS_PRESENT=0 and A.TENANT_ID=:TENANT_ID and A.CLIENT_ID=:CLIENT_ID and A.SALES_DATE >= :SALES_DATE1 '+
    ' and A.SALES_DATE <= :SALES_DATE2 and B.KPI_ID=:KPI_ID group by A.GODS_ID '
  else
    CdsGoods.SQL.Text :=
    ' select A.GODS_ID,sum(A.CALC_AMOUNT) as CALC_AMOUNT,sum(A.CALC_AMOUNT/'+GetUnitTO_CALC+') as AMOUNT,sum(A.CALC_MONEY) as CALC_MONEY '+
    ' from VIW_SALESDATA A inner join MKT_KPI_GOODS B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID '+
    ' inner join VIW_GOODSINFO C on A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+
//    ' left join MKT_KPI_RATIO D on A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID '+
    ' where A.IS_PRESENT=0 and A.TENANT_ID=:TENANT_ID and A.GUIDE_USER=:CLIENT_ID and A.SALES_DATE >= :SALES_DATE1 '+
    ' and A.SALES_DATE <= :SALES_DATE2 and B.KPI_ID=:KPI_ID group by A.GODS_ID ';

  CdsGoods.Params.ParamByName('TENANT_ID').AsInteger := FKpiIndexInfo.TenantId;
  CdsGoods.Params.ParamByName('CLIENT_ID').AsString := FKpiIndexInfo.ClientId;
  CdsGoods.Params.ParamByName('KPI_ID').AsString := FKpiIndexInfo.KpiId;

  if StartDate > EndDate then
  begin
     CdsGoods.Params.ParamByName('SALES_DATE1').AsInteger := FKpiIndexInfo.KpiYear*10000+StartDate;
     CdsGoods.Params.ParamByName('SALES_DATE2').AsInteger := (FKpiIndexInfo.KpiYear+1)*10000+EndDate;
  end
  else
  begin
     CdsGoods.Params.ParamByName('SALES_DATE1').AsInteger := FKpiIndexInfo.KpiYear*10000+StartDate;
     CdsGoods.Params.ParamByName('SALES_DATE2').AsInteger := FKpiIndexInfo.KpiYear*10000+EndDate;
  end;
  Factor.Open(CdsGoods);
  if CdsGoods.IsEmpty then
     Result := 0
  else
  begin
     CdsGoods.First;
     while not CdsGoods.Eof do
     begin
         if KpiData in [1,4] then
            Result := Result + CdsGoods.FieldByName('AMOUNT').AsFloat
         else
            Result := Result + CdsGoods.FieldByName('CALC_MONEY').AsFloat;
       CdsGoods.Next;
     end;
  end;
end;

function TClientRebate.KpiDataNum(Num: Real): Real;
begin
  if KpiTimes.FieldByName('KPI_DATA').AsString = '1' then
  begin
     if FKpiIndexInfo.PlanAmt = 0 then
        Result := 0
     else
        Result := Num/FKpiIndexInfo.PlanAmt;
  end
  else if KpiTimes.FieldByName('KPI_DATA').AsString = '2' then
  begin
     if FKpiIndexInfo.PlanMny = 0 then
        Result := 0
     else
        Result := Num/FKpiIndexInfo.PlanMny;
  end
  else
     Result := Num;
end;

procedure TClientRebate.LocateLevel(SumNum: Real);
var Id:String;
    Amt,Rete:Real;
begin
  Id := '';
  Amt := 0;
  Rete := 0;
  KpiLevel.SortedFields := 'LVL_AMT';
  KpiLevel.SortType := stAscending;
  KpiLevel.First;
  while not KpiLevel.Eof do
  begin
    if SumNum >= KpiLevel.FieldByName('LVL_AMT').AsFloat then
    begin
       Id := KpiLevel.FieldByName('LEVEL_ID').AsString;
       Amt := KpiLevel.FieldByName('LVL_AMT').AsFloat;
       Rete := KpiLevel.FieldByName('LOW_RATE').AsFloat;
    end;
    KpiLevel.Next;
  end;
  FKpiIndexInfo.LevelId := Id;
  FKpiIndexInfo.LevelAmt := Amt;
  FKpiIndexInfo.LevelLowRate := Rete;
end;

function TClientRebate.LocateTapPosition(CheckNum: Real;Brrow:boolean=false):real;
var
  CurRate,Rate,MaxAmt,UsingAmt:Real;
begin
  KpiSeqNo.Filtered := False;
  KpiSeqNo.Filter := ' LEVEL_ID='''+FKpiIndexInfo.LevelId+''' and TIMES_ID='''+KpiTimes.FieldByName('TIMES_ID').AsString+''' ';
  KpiSeqNo.Filtered := True;
  KpiSeqNo.SortedFields := 'KPI_AMT';
  KpiSeqNo.SortType := stAscending;
  result := CheckNum;
  FSeqNo.SeqNoId := '';
  FSeqNo.KpiAmt := 0;
  KpiSeqNo.First;
  while not KpiSeqNo.Eof do
  begin
    if KpiData in [1,2] then
       CurRate := KpiSeqNo.FieldByName('KPI_AMT').AsFloat/100
    else
       CurRate := KpiSeqNo.FieldByName('KPI_AMT').AsFloat;

    Rate := KpiDataNum(CheckNum);
    //if
    //(KpiSeqNo.FieldByName('LEVEL_ID').AsString = FKpiIndexInfo.LevelId) and
    //(KpiSeqNo.FieldByName('TIMES_ID').AsString = KpiTimes.FieldByName('TIMES_ID').AsString) and
    if (Rate >= CurRate) then
    begin
       FSeqNo.SeqNoId := KpiSeqNo.FieldByName('SEQNO_ID').AsString;
       FSeqNo.KpiAmt := KpiSeqNo.FieldByName('KPI_AMT').AsFloat;
    end
    else
    begin
       if Brrow then  //借量看看能否达标
          begin
            Rate := KpiDataNum(CheckNum+ContainerBrrw);
            if (Rate >= CurRate) then
            begin
               FSeqNo.SeqNoId := KpiSeqNo.FieldByName('SEQNO_ID').AsString;
               FSeqNo.KpiAmt := KpiSeqNo.FieldByName('KPI_AMT').AsFloat;
            end
          end;
    end;
    KpiSeqNo.Next;
  end;
  if Brrow then
  begin
    //处理借量容器剩余量
    if KpiData in [1,2] then //只有完成最高档位后的量才能用来借用。
       MaxAmt :=  FKpiIndexInfo.PlanAmt*KpiSeqNo.FieldByName('KPI_AMT').AsFloat/100
    else
       MaxAmt := KpiSeqNo.FieldByName('KPI_AMT').AsFloat;

    if KpiData in [1,2] then //只有完成最高档位后的量才能用来借用。
       UsingAmt :=  FKpiIndexInfo.PlanAmt*FSeqNo.KpiAmt/100
    else
       UsingAmt := FSeqNo.KpiAmt;
    if UsingAmt>CheckNum then result := UsingAmt;
    
    if UsingAmt>CheckNum then
       ContainerBrrw := ContainerBrrw-(UsingAmt-CheckNum);
    if CheckNum>MaxAmt then
       ContainerBrrw := ContainerBrrw+(CheckNum-MaxAmt);
  end;
end;

procedure TClientRebate.PromJudge(KpiRate: Real);
var GoodsId,UnitId:String;
    Ratio,PromNum:Real;
begin
  GoodsId := '';
  UnitId := '';
  Ratio := 0;
  CdsGoods.First;
  while not CdsGoods.Eof do
  begin
    if KpiTimes.FieldByName('RATIO_TYPE').AsString='1' then
       GoodsId:='#'
    else
       GoodsId:=CdsGoods.FieldByName('GODS_ID').AsString;
    if KpiRatio.Locate('SEQNO_ID;GODS_ID',
      VarArrayOf([KpiSeqNo.FieldByName('SEQNO_ID').AsString,GoodsId]),[]) then
    begin
      GoodsId := KpiRatio.FieldByName('GODS_ID').AsString;
      UnitId := '';
      Ratio := KpiRatio.FieldByName('KPI_RATIO').AsFloat;
    end
    else
    begin
      GoodsId := CdsGoods.FieldByName('GODS_ID').AsString;
      UnitId := '';
      Ratio := 0;
    end;

    KpiDetail.First;
    while not KpiDetail.Eof do
      begin
        if (KpiDetail.FieldByName('KPI_DATE1').AsInteger<=KpiTimes.FieldByName('KPI_DATE1').AsInteger)
           and
           (KpiDetail.FieldByName('KPI_DATE2').AsInteger>=KpiTimes.FieldByName('KPI_DATE2').AsInteger)
        then //促销时段内的区间
           begin
             if KpiDetail.FieldByName('KPI_RATIO').AsFloat<Ratio then
                begin
                  KpiDetail.Edit;
                  case KpiCalc of
                  1:begin
                      PromNum := CdsGoods.FieldByName('CALC_MONEY').AsFloat;
                      KpiDetail.FieldByName('KPI_MNY').AsFloat :=
                        (KpiDetail.FieldByName('FISH_MNY').AsFloat-PromNum)*KpiDetail.FieldByName('KPI_RATIO').AsFloat/100
                        +
                        PromNum*Ratio/100
                    end;
                  2:begin
                      PromNum := CdsGoods.FieldByName('CALC_AMOUNT').AsFloat;
                      KpiDetail.FieldByName('KPI_MNY').AsFloat :=
                        (CdsGoods.FieldByName('FISH_AMT').AsFloat-PromNum)*KpiDetail.FieldByName('KPI_RATIO').AsFloat
                        +
                        PromNum*Ratio
                    end;
                  3:begin
                      Raise Exception.Create('指定金额方式不支持促销时段。');
                    end;
                  end;
                end;
           end;
        KpiDetail.Next;
      end;
    CdsGoods.Next;
  end;
end;

procedure TClientRebate.ReachJudge(KpiRate,CheckNum:Real);
var GoodsId,UnitId:String;
    Ratio,FishCalcRate:Real;
begin
  GoodsId := '';
  UnitId := '';
  Ratio := 0;
  CdsGoods.First;
  while not CdsGoods.Eof do
  begin
    if KpiTimes.FieldByName('RATIO_TYPE').AsString='1' then
       GoodsId:='#'
    else
       GoodsId:=CdsGoods.FieldByName('GODS_ID').AsString;
    if KpiRatio.Locate('SEQNO_ID;GODS_ID',
      VarArrayOf([KpiSeqNo.FieldByName('SEQNO_ID').AsString,GoodsId]),[]) then
    begin
      GoodsId := KpiRatio.FieldByName('GODS_ID').AsString;
      UnitId := KpiRatio.FieldByName('UNIT_ID').AsString;
      Ratio := KpiRatio.FieldByName('KPI_RATIO').AsFloat;
    end
    else
    begin
      GoodsId := CdsGoods.FieldByName('GODS_ID').AsString;
      UnitId := '';
      if (CheckNum>=FKpiIndexInfo.PlanAmt) then
         Ratio := FKpiIndexInfo.LevelLowRate
      else
         Ratio := 0;
    end;

    if (Ratio<FKpiIndexInfo.LevelLowRate) and (CheckNum>=FKpiIndexInfo.PlanAmt) then Ratio := FKpiIndexInfo.LevelLowRate;

    if not KpiGoods.Locate('GODS_ID',CdsGoods.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('KpiGoods没找到商品');
    FishCalcRate := UnitToCalc(CdsGoods.FieldByName('GODS_ID').AsString,KpiGoods.FieldByName('UNIT_ID').AsString);
    if not KpiDetail.Locate('GODS_ID;TIMES_ID',VarArrayOf([CdsGoods.FieldByName('GODS_ID').AsString,KpiTimes.FieldByName('TIMES_ID').AsString]),[]) then
    begin
      KpiDetail.Append;
      KpiDetail.FieldByName('ROWS_ID').AsString := TSequence.NewId;
      KpiDetail.FieldByName('KPI_ID').AsString := FKpiIndexInfo.KpiId;
      KpiDetail.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      KpiDetail.FieldByName('CLIENT_ID').AsString := FKpiIndexInfo.ClientId;
      KpiDetail.FieldByName('KPI_YEAR').AsInteger := FKpiIndexInfo.KpiYear;
      KpiDetail.FieldByName('KPI_DATE1').AsInteger := KpiTimes.FieldByName('KPI_DATE1').AsInteger;
      KpiDetail.FieldByName('KPI_DATE2').AsInteger := KpiTimes.FieldByName('KPI_DATE2').AsInteger;
      KpiDetail.FieldByName('KPI_DATA').AsString := IntToStr(KpiData);
      KpiDetail.FieldByName('KPI_CALC').AsString := IntToStr(KpiCalc);
      KpiDetail.FieldByName('RATIO_TYPE').AsString := IntToStr(RatioType);
      KpiDetail.FieldByName('GODS_ID').AsString := CdsGoods.FieldByName('GODS_ID').AsString;
      KpiDetail.FieldByName('LVL_AMT').AsFloat := FKpiIndexInfo.LevelAmt;
      KpiDetail.FieldByName('KPI_RATE').AsFloat := KpiRate;
      KpiDetail.FieldByName('FISH_CALC_RATE').AsFloat := FishCalcRate;
      KpiDetail.FieldByName('FISH_AMT').AsFloat := CdsGoods.FieldByName('AMOUNT').AsFloat;//KpiDetail.FieldByName('FISH_CALC_RATE').AsFloat;
      KpiDetail.FieldByName('ADJS_AMT').AsFloat := 0;
      KpiDetail.FieldByName('FISH_MNY').AsFloat := CdsGoods.FieldByName('CALC_MONEY').AsFloat;
      KpiDetail.FieldByName('ADJS_MNY').AsFloat := 0;

      KpiDetail.FieldByName('KPI_RATIO').AsFloat := Ratio;
      if KpiCalc = 1 then
         KpiDetail.FieldByName('KPI_MNY').AsFloat := CdsGoods.FieldByName('CALC_MONEY').AsFloat*Ratio/100
      else if KpiCalc = 2 then
         KpiDetail.FieldByName('KPI_MNY').AsFloat := CdsGoods.FieldByName('CALC_AMOUNT').AsFloat*Ratio
      else if KpiCalc = 3 then
         KpiDetail.FieldByName('KPI_MNY').AsFloat := Ratio;

      CalculationRaito(CdsGoods.FieldbyName('GODS_ID').AsString,CdsGoods.FieldByName('AMOUNT').AsFloat);
      KpiDetail.Post;      GetTickCount
    end
    else
    begin
      KpiDetail.Edit;
      KpiDetail.FieldByName('KPI_DATE1').AsInteger := KpiTimes.FieldByName('KPI_DATE1').AsInteger;
      KpiDetail.FieldByName('KPI_DATE2').AsInteger := KpiTimes.FieldByName('KPI_DATE2').AsInteger;
      KpiDetail.FieldByName('KPI_DATA').AsString := IntToStr(KpiData);
      KpiDetail.FieldByName('KPI_CALC').AsString := IntToStr(KpiCalc);
      KpiDetail.FieldByName('RATIO_TYPE').AsString := IntToStr(RatioType);
      KpiDetail.FieldByName('LVL_AMT').AsFloat := FKpiIndexInfo.LevelAmt;
      KpiDetail.FieldByName('KPI_RATE').AsFloat := KpiRate;
      KpiDetail.FieldByName('FISH_AMT').AsFloat := CdsGoods.FieldByName('AMOUNT').AsFloat;
      KpiDetail.FieldByName('FISH_MNY').AsFloat := CdsGoods.FieldByName('CALC_MONEY').AsFloat;
      KpiDetail.FieldByName('FISH_CALC_RATE').AsFloat := FishCalcRate;
      KpiDetail.FieldByName('KPI_RATIO').AsFloat := Ratio;

      if KpiCalc = 1 then
         KpiDetail.FieldByName('KPI_MNY').AsFloat := (CdsGoods.FieldByName('CALC_MONEY').AsFloat)*Ratio/100
      else if KpiCalc = 2 then
         KpiDetail.FieldByName('KPI_MNY').AsFloat := (CdsGoods.FieldByName('CALC_AMOUNT').AsFloat)*Ratio
      else if KpiCalc = 3 then
         KpiDetail.FieldByName('KPI_MNY').AsFloat := Ratio;

      CalculationRaito(CdsGoods.FieldbyName('GODS_ID').AsString,CdsGoods.FieldByName('AMOUNT').AsFloat);
      KpiDetail.Post;
    end;

    CdsGoods.Next;
  end;
end;

procedure TClientRebate.SeasonCheck;
var CheckNum,ResultValue,CurKpiRate,AdjsAmt:Real;
    IsBorrow:Boolean;
begin
  LocateLevel(FKpiIndexInfo.PlanAmt);
  IsFlag := False;
  KpiTimes.First;
  while not KpiTimes.Eof do
  begin
    if KpiTimes.FieldByName('KPI_FLAG').AsString = '0' then
    begin
      KpiData := KpiTimes.FieldByName('KPI_DATA').AsInteger;
      KpiCalc := KpiTimes.FieldByName('KPI_CALC').AsInteger;
      RatioType := KpiTimes.FieldByName('RATIO_TYPE').AsInteger;

      CheckNum := GetSaleMoney(KpiTimes.FieldByName('KPI_DATE1').AsInteger,KpiTimes.FieldByName('KPI_DATE2').AsInteger);

      if (KpiTimes.FieldByName('USING_BRRW').AsString = '1') then IsBorrow := True else IsBorrow := False;
      CurKpiRate := LocateTapPosition(CheckNum,IsBorrow); //定位达标档位并获取相关参数
      ReachJudge(CurKpiRate,CheckNum);
    end;
    KpiTimes.Next;
  end;
end;

procedure TClientRebate.SetActiveRatio(const Value: TZQuery);
begin
  FActiveRatio := Value;
end;

procedure TClientRebate.SetKpiDetail(const Value: TZQuery);
begin
  FKpiDetail := Value;
end;

procedure TClientRebate.SetKpiGoods(const Value: TZQuery);
begin
  FKpiGoods := Value;
end;

procedure TClientRebate.SetKpiLevel(const Value: TZQuery);
begin
  FKpiLevel := Value;
end;

procedure TClientRebate.SetKpiRatio(const Value: TZQuery);
begin
  FKpiRatio := Value;
end;

procedure TClientRebate.SetKpiSeqNo(const Value: TZQuery);
begin
  FKpiSeqNo := Value;
end;

procedure TClientRebate.SetKpiTimes(const Value: TZQuery);
begin
  FKpiTimes := Value;
end;

function TClientRebate.UnitToCalc(GoodsId,UnitId: String): Real;
var rs:TZQuery;
begin
  Result := 1;
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if rs.Locate('GODS_ID',GoodsId,[]) then
  begin
    if UnitId=rs.FieldByName('CALC_UNITS').AsString then
       Result := 1
    else if UnitId=rs.FieldByName('BIG_UNITS').AsString then
       Result := rs.FieldByName('BIGTO_CALC').asFloat
    else if UnitId=rs.FieldByName('SMALL_UNITS').AsString then
       Result := rs.FieldByName('SMALLTO_CALC').asFloat
    else
       Result := 1;
  end
  else
  begin
     Raise Exception.Create('经营商品中没找到"'+rs.FieldbyName('GODS_NAME').AsString+'"');
  end;
end;

function TClientRebate.UseBrrw(CurAmt: Real; IsBrrw: Boolean): Real;
begin
  Result := CurAmt;

  if FSeqNo.KpiAmt <> 0 then
  begin
     if KpiData = 1 then
        ContainerBrrw := ContainerBrrw + CurAmt - FKpiIndexInfo.PlanAmt*FSeqNo.KpiAmt
     else if KpiData = 2 then
        ContainerBrrw := ContainerBrrw + CurAmt - FKpiIndexInfo.PlanMny*FSeqNo.KpiAmt
     else
        ContainerBrrw := ContainerBrrw + CurAmt - FSeqNo.KpiAmt;
     Result := CurAmt;
  end
  else
  begin
     if IsBrrw then
     begin
        Result := ContainerBrrw + CurAmt;
        if KpiData = 1 then
           ContainerBrrw := Result - FKpiIndexInfo.PlanAmt*FSeqNo.KpiAmt
        else if KpiData = 2 then
           ContainerBrrw := Result - FKpiIndexInfo.PlanMny*FSeqNo.KpiAmt
        else
           ContainerBrrw := Result - FSeqNo.KpiAmt;
           
        if ContainerBrrw < 0 then ContainerBrrw := 0;
     end
     else
        Result := CurAmt;
  end;
end;

procedure TClientRebate.YearCheck;
var CheckNum,ResultValue,CurKpiRate,AdjsAmt:Real;
    IsBorrow:Boolean;
begin
  LocateLevel(FKpiIndexInfo.PlanAmt);
  IsFlag := False;
  KpiTimes.First;
  while not KpiTimes.Eof do
  begin
    if KpiTimes.FieldByName('KPI_FLAG').AsString = '0' then
    begin
      KpiData := KpiTimes.FieldByName('KPI_DATA').AsInteger;
      KpiCalc := KpiTimes.FieldByName('KPI_CALC').AsInteger;
      RatioType := KpiTimes.FieldByName('RATIO_TYPE').AsInteger;

      CheckNum := GetSaleMoney(KpiTimes.FieldByName('KPI_DATE1').AsInteger,KpiTimes.FieldByName('KPI_DATE2').AsInteger);

      if (KpiTimes.FieldByName('USING_BRRW').AsString = '1') then IsBorrow := True else IsBorrow := False;
      CurKpiRate := LocateTapPosition(CheckNum,IsBorrow); //定位达标档位并获取相关参数
      ReachJudge(CurKpiRate,CheckNum);
    end;
    KpiTimes.Next;
  end;

  IsFlag := True;
  KpiTimes.First;
  while not KpiTimes.Eof do
  begin
    if KpiTimes.FieldByName('KPI_FLAG').AsString = '1' then
    begin
      KpiData := KpiTimes.FieldByName('KPI_DATA').AsInteger;
      KpiCalc := KpiTimes.FieldByName('KPI_CALC').AsInteger;
      RatioType := KpiTimes.FieldByName('RATIO_TYPE').AsInteger;
      CheckNum := GetSaleMoney(KpiTimes.FieldByName('KPI_DATE1').AsInteger,KpiTimes.FieldByName('KPI_DATE2').AsInteger);
      CurKpiRate := LocateTapPosition(CheckNum,false); //定位达标档位并获取相关参数

      PromJudge(CurKpiRate);
    end;
    KpiTimes.Next;
  end;
end;

end.
