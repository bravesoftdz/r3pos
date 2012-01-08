unit uKpiCalculate;

interface
uses
  Windows, Messages, SysUtils, Classes, InvokeRegistry, Types, ZBase, Variants,
  ObjCommon, ZDataset, DateUtils;

type
  TKpiInfo=record
    TenantId:Integer;  //��ҵID
    KpiYear:Integer;   //���
    KpiId:String;      //ָ��ID
    ClientId:String;   //������ID
    IdxType:String;    //ָ������
    KpiType:String;    //��������
    KpiData:String;    //���˱�׼
    KpiCalc:String;    //�����׼
    KpiOptn:String;    //�Ƿ����ý���
    KpiAgio:Real;      //��׼ϵ��
    PlanAmt:Real;      //�ƻ�����
    PlanMny:Real;      //�ƻ����
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
    FshVle:Real;
    KpiMny:Real;
  end;
  //PKpiInfo=^TKpiInfo;
  PKpiIndex=^TKpiIndex;
  TKpiCalculate=class
  private
    FDataSet_Kpi: TZQuery;
    FList:TList;
    Type_Brrw:Boolean;//�йؿ���ȡ���������ÿ����λ�ıȽ�ֵ
    LV_MNY:Real; //��ĳ��ʱ����ڵ�������(���۶�/ë��)
    ContainerBrrw:Real; //����ֵ����
    ProNum:Real;//�۽���
    FKpiSite:TKpiSite;//��¼���˱�׼��λ����
    function GetKpiMny(LV:String):Real;
    function GetCurSeq(LV:String):Integer;
    procedure SetDataSet_Kpi(const Value: TZQuery);

    procedure DateCalculate(var StartDate,EndDate:Integer);//���ڼ���
    function ReachJudge(CurAmt,CurPrarm,Param1,Param2,CurAgio:Real):Real;   //�жϴ��������ó����˽��ֵ
    function UseBrrw(CurAmt,CurPrarm,Param1,Param2:Real;IsBrrw:Boolean):Real;   //�йؽ���
    function KpiDataNum(Num:Real):Real;     //���ض�Ӧ�������͵Ĳ���ֵ(��������ë��)
  public
    FKpiInfo:TKpiInfo;

    constructor Create;
    destructor Destroy; override;
    procedure BeginCalculate;     //��ʼ����

    function GetLvFshVle(KpiLv:String;SeqNo:Integer):Real;
    function FindKipIndex(LV:String;SeqNo:Integer):PKpiIndex;

    procedure AddKpiIndex(KpiIndex:PKpiIndex);
    procedure Clear;
    property KpiMny[LV:String]:Real read GetKpiMny;    //���ص�ǰʱ��εĿ��˽��
    property CurSeq[LV:String]:Integer read GetCurSeq;  //���ص�ǰʱ��ε��Ѿ����ĵ�λ���
    property DataSet_Kpi:TZQuery read FDataSet_Kpi write SetDataSet_Kpi;
  end;

implementation
uses uShopGlobal,uGlobal, DB;


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
begin
  Result := 0;
  if StrToInt(FKpiInfo.KpiCalc) in [1,2,3] then
  begin
     if CurPrarm >= Param2 then
        Result := CurAmt * CurAgio/100;
  end
  else if StrToInt(FKpiInfo.KpiCalc) in [4,5,6] then
  begin
     if (CurPrarm >= Param2) and (Param1 = Param2 ) then
     begin
        if FKpiInfo.KpiData = '1' then
        begin
           Result := FKpiInfo.PlanAmt*Param2*CurAgio/10000;
           ProNum := CurAmt*CurAgio/100;
        end
        else if FKpiInfo.KpiData = '2' then
        begin
           Result := FKpiInfo.PlanMny*Param2*CurAgio/10000;
           ProNum := CurAmt*CurAgio/100;
        end
        else if FKpiInfo.KpiData = '3' then
        begin
           //Result := FKpiInfo.PlanMny*Param2*CurAgio;
           //ProNum := CurAmt*CurAgio;
           //ë��ĿǰΪ ��
           Result := 0;
           ProNum := 0;
        end
        else if FKpiInfo.KpiData = '4' then
        begin
           Result := Param2*CurAgio/10000;
           ProNum := CurAmt*CurAgio/100;
        end
        else if FKpiInfo.KpiData = '5' then
        begin
           Result := Param2*CurAgio/10000;
           ProNum := CurAmt*CurAgio/100;
        end
        else if FKpiInfo.KpiData = '6' then
        begin
           //Result := Param2*CurAgio;
           //ProNum := CurAmt*CurAgio;
           //ë��ĿǰΪ ��
           Result := 0;
           ProNum := 0;
        end;
     end
     else if (CurPrarm >= Param2) and (Param2 > Param1) then
     begin
        if FKpiInfo.KpiData = '1' then
        begin
           Result := FKpiInfo.PlanAmt*(Param2-Param1)*CurAgio/10000;
           ProNum := (CurAmt-FKpiInfo.PlanAmt*Param1)*CurAgio/100;
        end
        else if FKpiInfo.KpiData = '2' then
        begin
           Result := FKpiInfo.PlanAmt*(Param2-Param1)*CurAgio/10000;
           ProNum := (CurAmt-FKpiInfo.PlanAmt*Param1)*CurAgio/100;
        end
        else if FKpiInfo.KpiData = '3' then
        begin
           //Result := (FKpiInfo.PlanAmt*Param2-FKpiInfo.PlanAmt*Param1)*CurAgio;
           //ProNum := (CurAmt-FKpiInfo.PlanAmt*Param1)*CurAgio;
           //ë��ĿǰΪ ��
           Result := 0;
           ProNum := 0;
        end
        else if FKpiInfo.KpiData = '4' then
        begin
           Result := (Param2-Param1)*CurAgio/100;
           ProNum := (CurAmt-Param1)*CurAgio/100;
        end
        else if FKpiInfo.KpiData = '5' then
        begin
           Result := (Param2-Param1)*CurAgio/100;
           ProNum := (CurAmt-Param1)*CurAgio/100;
        end
        else if FKpiInfo.KpiData = '6' then
        begin
           //Result := (Param2-Param1)*CurAgio;
           //ProNum := (CurAmt-Param1)*CurAgio;
           //ë��ĿǰΪ ��
           Result := 0;
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
var rs:TZQuery;
    IsAdd,IsBrrw:Boolean;
    Kpi_Index:PKpiIndex;
//��ǰʱ����ڵĴ��������ǰ���˽������ǰ�����/���������һָ������/���������ǰָ������/�����,��ǰ�ۿ�ϵ��
    CurAmount,CurMny,CurRate_Amt,LastParam,CurParam,CurAgio:Real;
    // ��������
    CalculateAmt:Real;
begin
  if FDataSet_Kpi.IsEmpty then Exit;

  IsAdd := False;
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select sum(CALC_AMOUNT) as CALC_AMOUNT,sum(CALC_MONEY) as CALC_MONEY from VIW_SALESDATA where TENANT_ID=:TENANT_ID and CLIENT_ID=:CLIENT_ID '+
    ' and GODS_ID in (select GODS_ID from MKT_KPI_GOODS where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID) and SALES_DATE >= :SALES_DATE1 and SALES_DATE <= :SALES_DATE2 ';
    rs.Params.ParamByName('TENANT_ID').AsInteger := FKpiInfo.TenantId;
    rs.Params.ParamByName('CLIENT_ID').AsString := FKpiInfo.ClientId;
    rs.Params.ParamByName('KPI_ID').AsString := FKpiInfo.KpiId;

    FDataSet_Kpi.First;
    while not FDataSet_Kpi.Eof do
    begin
      //      �Ӵ˴���ʼ�����ڡ�
      if FKpiInfo.KpiType = '3' then
      begin
         if (FDataSet_Kpi.FieldByName('SEQNO').AsInteger = 1) then
         begin
             if StrToInt(FKpiInfo.KpiData) in [1,2,3] then
             begin
                CurParam := FDataSet_Kpi.FieldByName('KPI_RATE').AsFloat;
                LastParam := FDataSet_Kpi.FieldByName('KPI_RATE').AsFloat;
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
                LastParam := FDataSet_Kpi.FieldByName('KPI_RATE').AsFloat;
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
              rs.Params.ParamByName('SALES_DATE1').AsInteger := (FKpiInfo.KpiYear+1)*10000+FDataSet_Kpi.FieldByName('KPI_DATE1').AsInteger;
              rs.Params.ParamByName('SALES_DATE2').AsInteger := (FKpiInfo.KpiYear)*10000+FDataSet_Kpi.FieldByName('KPI_DATE2').AsInteger;
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
             CurParam := FDataSet_Kpi.FieldByName('KPI_RATE').AsFloat;
             LastParam := FDataSet_Kpi.FieldByName('KPI_RATE').AsFloat;
          end
          else
          begin
             CurParam := FDataSet_Kpi.FieldByName('KPI_AMT').AsFloat;
             LastParam := FDataSet_Kpi.FieldByName('KPI_AMT').AsFloat;
          end;
          IsAdd := True;
          if FDataSet_Kpi.FieldByName('KPI_DATE1').AsInteger > FDataSet_Kpi.FieldByName('KPI_DATE2').AsInteger then
             begin
               rs.Params.ParamByName('SALES_DATE1').AsInteger := (FKpiInfo.KpiYear+1)*10000+FDataSet_Kpi.FieldByName('KPI_DATE1').AsInteger;
               rs.Params.ParamByName('SALES_DATE2').AsInteger := (FKpiInfo.KpiYear)*10000+FDataSet_Kpi.FieldByName('KPI_DATE2').AsInteger;
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
             CurParam := FDataSet_Kpi.FieldByName('KPI_RATE').AsFloat
          else
             CurParam := FDataSet_Kpi.FieldByName('KPI_AMT').AsFloat;
        end;
        CurAgio := FDataSet_Kpi.FieldByName('KPI_AGIO').AsFloat;

      end;
      // �Ӵ˴����������ڶε��ж�

      FKpiSite.LastLv := FKpiSite.ThisLv;
      FKpiSite.LastSeqNo := FKpiSite.ThisSeqNo;
      FKpiSite.ThisLv := FDataSet_Kpi.FieldByName('KPI_LV').AsString;
      FKpiSite.ThisSeqNo := FDataSet_Kpi.FieldByName('SEQNO').AsInteger;

      if IsAdd then       //��ĳһʱ����е�������/���۶�/ë��
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

         IsAdd := False;
      end;
      
      if FDataSet_Kpi.FieldByName('KPI_LV').AsString = '1' then
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
      //���ݿ��˱�׼ �ó���ǰʱ��� �Ƿ����ϵ��
      CurRate_Amt := KpiDataNum(CurAmount);  
      //�˴��ж��Ƿ�ӽ���ֵ
      CurAmount := UseBrrw(CurAmount,CurRate_Amt,LastParam,CurParam,FDataSet_Kpi.FieldByName('USING_BRRW').AsBoolean);
      //�ó���ǰ��λ�Ŀ��˽��
      CurMny := ReachJudge(CalculateAmt,CurRate_Amt,LastParam,CurParam,CurAgio);

      New(Kpi_Index);
      Kpi_Index.LV := FDataSet_Kpi.FieldByName('KPI_LV').AsString;
      Kpi_Index.SEQNO := FDataSet_Kpi.FieldByName('SEQNO').AsInteger;
      Kpi_Index.FshVle := CurAmount;
      Kpi_Index.KpiMny := CurMny;
      AddKpiIndex(Kpi_Index);
      //�й��۽����㣬���¸�ֵ
      if (StrToInt(FKpiInfo.KpiCalc) in [4,5,6]) and ((CurMny = 0) or ((CurMny<>0) and (FKpiSite.LastLv<>FKpiSite.ThisLv))) then
      begin
         if FindKipIndex(FKpiSite.LastLv,FKpiSite.LastSeqNo) <> nil then
            FindKipIndex(FKpiSite.LastLv,FKpiSite.LastSeqNo).KpiMny := ProNum;
      end;

      FDataSet_Kpi.Next;
    end;
  finally
    rs.Free;
  end;
end;

function TKpiCalculate.KpiDataNum(Num:Real): Real;
begin
  if FKpiInfo.KpiData = '1' then
     Result := Num/FKpiInfo.PlanAmt*100
  else if FKpiInfo.KpiData = '2' then
     Result := Num/FKpiInfo.PlanMny*100
  else if FKpiInfo.KpiData = '3' then
     Result := Num/FKpiInfo.PlanMny*100
  else
     Result := Num;
end;

function TKpiCalculate.UseBrrw(CurAmt,CurPrarm,Param1,Param2:Real;IsBrrw:Boolean):Real;
begin
  if FKpiInfo.KpiType = '3' then
  begin
     if CurPrarm < Param2 then
     begin
        if IsBrrw then
        begin
           Result := CurAmt + ContainerBrrw;
           if FKpiInfo.KpiData = '1' then
              ContainerBrrw := Result - FKpiInfo.PlanAmt*Param2
           else if FKpiInfo.KpiData = '2' then
              ContainerBrrw := Result - FKpiInfo.PlanMny*Param2
           else if FKpiInfo.KpiData = '3' then
              ContainerBrrw := Result - FKpiInfo.PlanMny*Param2
           else 
              ContainerBrrw := Result - Param2;

           if ContainerBrrw < 0 then ContainerBrrw := 0;

        end;
     end
     else
     begin
       if FKpiInfo.KpiData = '1' then
          ContainerBrrw := CurAmt - FKpiInfo.PlanAmt*Param2/100
       else if FKpiInfo.KpiData = '2' then
          ContainerBrrw := CurAmt - FKpiInfo.PlanMny*Param2/100
       else if FKpiInfo.KpiData = '3' then
          ContainerBrrw := CurAmt - FKpiInfo.PlanMny*Param2/100
       else
          ContainerBrrw := CurAmt - Param2;
       Result := CurAmt;
     end;
  end
  else
  begin
     if (FKpiSite.LastLv <> FKpiSite.ThisLv) and Type_Brrw then
     begin
       if FKpiInfo.KpiData = '1' then
          ContainerBrrw := ContainerBrrw + FKpiSite.LastAmt - FKpiInfo.PlanAmt*FKpiSite.LastParam
       else if FKpiInfo.KpiData = '2' then
          ContainerBrrw := ContainerBrrw + FKpiSite.LastAmt - FKpiInfo.PlanMny*FKpiSite.LastParam
       else if FKpiInfo.KpiData = '3' then
          ContainerBrrw := ContainerBrrw + FKpiSite.LastAmt - FKpiInfo.PlanMny*FKpiSite.LastParam
       else
          ContainerBrrw := ContainerBrrw + FKpiSite.LastAmt - FKpiSite.LastParam;
     end;

     if CurPrarm < Param2 then
     begin
        if IsBrrw then
        begin
           Result := CurAmt + ContainerBrrw;
           if FKpiInfo.KpiData = '1' then
              ContainerBrrw := Result - FKpiInfo.PlanAmt*Param2
           else if FKpiInfo.KpiData = '2' then
              ContainerBrrw := Result - FKpiInfo.PlanMny*Param2
           else if FKpiInfo.KpiData = '3' then
              ContainerBrrw := Result - FKpiInfo.PlanMny*Param2
           else
              ContainerBrrw := Result - Param2;

           if ContainerBrrw < 0 then ContainerBrrw := 0;
        end;
        Type_Brrw := False;
     end
     else
     begin
       if FKpiInfo.KpiData = '1' then
          ContainerBrrw := CurAmt - FKpiInfo.PlanAmt*Param2
       else if FKpiInfo.KpiData = '2' then
          ContainerBrrw := CurAmt - FKpiInfo.PlanMny*Param2
       else if FKpiInfo.KpiData = '3' then
          ContainerBrrw := CurAmt - FKpiInfo.PlanMny*Param2
       else
          ContainerBrrw := CurAmt - Param2;
       Result := CurAmt;
       Type_Brrw := True;
     end;
  end;

end;

procedure TKpiCalculate.DateCalculate(var StartDate,EndDate:Integer);
begin

end;

function TKpiCalculate.GetCurSeq(LV: String): Integer;
var i,Seq:Integer;
    Mny:Real;
begin
  Seq := 0;
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
             Mny := PKpiIndex(FList[i]).KpiMny;
             Seq := PKpiIndex(FList[i]).SEQNO;
          end;
    end;
  end;
  Result := Seq;
end;

end.
