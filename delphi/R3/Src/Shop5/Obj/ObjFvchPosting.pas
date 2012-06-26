//凭证过账
//1、插入到第三方数据库;
//2、导出凭证字段(可选字段);
//3、ACC_FVCHORDER,ACC_FVCHDATA、ACC_FVCHDetail三表;

unit ObjFvchPosting;

interface

uses
  Dialogs,SysUtils,zBase,Classes,DB,ZIntf,ZDataset,ObjCommon;

type
  //凭证过账（审核）
  TFvchPosting=class(TZProcFactory)
  private
    //判断是否重复
    function CheckDataExists(AGlobal:IdbHelp;const Str:string):Boolean;
    //过账前判断是否不完整
    function DoCheckFvchPosting(AGlobal:IdbHelp;Params:TftParamList):Boolean;
    //不同对接系统过账
    //浪潮通软
    function DoFvchPostForInspur(AGlobal:IdbHelp;Params:TftParamList):Boolean;
    //用友财务
    function DoFvchPostForYonYou(AGlobal:IdbHelp;Params:TftParamList):Boolean;
    //金碟财务
    function DoFvchPostForKingDee(AGlobal:IdbHelp;Params:TftParamList):Boolean;
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;


implementation
 

{ TFvchPosting }

function TFvchPosting.CheckDataExists(AGlobal:IdbHelp;const Str:string):Boolean;
var
  Rs: TZQuery;
begin
  result:=False;
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:=ParseSQL(AGlobal.iDbType,Str);
    AGlobal.Open(Rs);
    if (Rs.Active) then
    begin
      if Rs.FindField('RESUM')<>nil then //汇总字段
        result:=(Rs.FieldByName('RESUM').AsInteger>0)
      else
        result:=(trim(Rs.Fields[0].AsString)<>'');  //判断字段值是否为空
     end;
  finally
    Rs.Free;
  end;
end;

function TFvchPosting.DoCheckFvchPosting(AGlobal:IdbHelp;Params:TftParamList): Boolean;
var
  Ten_ID: integer;
  Fvch_ID: string;
  Str,ZxTab,ReStr,UserID,CurValue: string;
  Rs: TZQuery;
begin
  result:=False;
  Ten_ID:=Params.ParamByName('TENANT_ID').AsInteger;
  Fvch_ID:=Params.ParamByName('FVCH_ID').AsString;
  //判断是否过账
  Str:='select count(*) as RESUM from ACC_FVCHORDER '+
       ' where TENANT_ID='+IntToStr(Ten_ID)+' and FVCH_ID='''+Fvch_ID+''' and FVCH_FLAG=''2'' and (isnull(FVCH_IMPORT_ID,'''')<>'''') ';
  if CheckDataExists(AGlobal,Str) then
  begin
    Msg:='     当前凭证已过账，不能重复过账！   ';
    Exit;
  end;

  try
    Rs:=TZQuery.Create(nil);
    //判断单据的人员是否维护财务系统内码
    Str:='select a.CREA_USER as CREA_USER,c.SUBJECT_NO as SUBJECT_NO from ACC_FVCHORDER a '+
         ' left outer join CA_USERS c on a.TENANT_ID=c.TENANT_ID and a.CREA_USER=c.USER_ID '+
         ' where a.TENANT_ID='+IntToStr(Ten_ID)+' and a.FVCH_ID='''+Fvch_ID+''' ';
    Rs.Close;
    Rs.SQL.Text:=ParseSQL(AGlobal.iDbType,Str);
    AGlobal.Open(Rs);
    if (Rs.Active) and (Trim(Rs.FieldByName('CREA_USER').AsString)<>'') then
    begin
      UserID:=Trim(UpperCase(Rs.FieldByName('CREA_USER').AsString));
      if (UserID='ADMIN') or (UserID='SYSTEM') then 
      begin
        Rs.Close;
        Rs.SQL.Text:='select DEFINE,VALUE from SYS_DEFINE where TENANT_ID='+IntToStr(Ten_ID)+' and DEFINE in (''ADMIN_SUBJECT_NO'',''SYSTEM_SUBJECT_NO'') ';
        AGlobal.Open(Rs);
        if UserID='ADMIN' then
        begin
          if Rs.Locate('DEFINE','ADMIN_SUBJECT_NO',[]) then
          begin
            if trim(Rs.FieldByName('VALUE').AsString) = '' then
            begin
              Msg:='   当前凭证制单人(超级管理员admin)没有设置财务系统的对应内码，请先设置人员辅助内码！   ';
              Exit;
            end;
          end;
        end else
        if UserID='SYSTEM' then
        begin
          if Rs.Locate('DEFINE','SYSTEM_SUBJECT_NO',[]) then
          begin
            if trim(Rs.FieldByName('VALUE').AsString) = '' then
            begin
              Msg:='   当前凭证制单人(超级管理员system)没有设置财务系统的对应内码，请先设置人员辅助内码！  ';
              Exit;
            end;
          end;
        end;
      end else
      begin
        if Trim(Rs.FieldByName('SUBJECT_NO').AsString)<>'' then
        begin
          Msg:='   当前凭证制单人没有设置财务系统的对应内码，请先设置人员辅助内码！   ';
          Exit;
        end;
      end;
    end;

    //分录明细
    ZxTab:='select CODE_ID,CODE_SPELL as SUBJ_OTHR_ID,CODE_NAME from PUB_CODE_INFO where TENANT_ID='+IntToStr(Ten_ID)+' and CODE_TYPE=''20'' ';
    Str:=
      'select '+
        ' a.SUBJ_USER,c.SUBJECT_NO as SUBJ_USER_ID,USER_NAME'+        //人员ID
        ',a.SUBJ_DEPT,d.SUBJECT_NO as SUBJ_DEPT_ID,DEPT_NAME'+       //部门ID
        ',a.SUBJ_CLIENT,f.SUBJECT_NO as SUBJ_CLIENT_ID,CLIENT_ID'+   //往来单位
        ',a.SUBJ_OTHR1,g.SUBJ_OTHR_ID as SUBJ_OTHR1_ID,g.CODE_NAME as CODE_NAME1'+   //专项1
        ',a.SUBJ_OTHR2,h.SUBJ_OTHR_ID as SUBJ_OTHR2_ID,h.CODE_NAME as CODE_NAME2'+   //专项2
        ',a.SUBJ_OTHR3,i.SUBJ_OTHR_ID as SUBJ_OTHR3_ID,i.CODE_NAME as CODE_NAME3'+   //专项3
        ',a.SUBJ_OTHR4,j.SUBJ_OTHR_ID as SUBJ_OTHR4_ID,j.CODE_NAME as CODE_NAME4'+   //专项4
        ',a.SUBJ_OTHR5,k.SUBJ_OTHR_ID as SUBJ_OTHR5_ID,k.CODE_NAME as CODE_NAME5 '+  //专项5
      ' from ACC_FVCHDETAIL a '+
      ' left outer join CA_USERS c on a.TENANT_ID=c.TENANT_ID and a.SUBJ_USER=c.USER_ID '+
      ' left outer join CA_DEPT_INFO d on a.TENANT_ID=c.TENANT_ID and a.SUBJ_DEPT=d.DEPT_ID '+
      ' left outer join PUB_CLIENTINFO f on a.TENANT_ID=f.TENANT_ID and a.SUBJ_CLIENT=f.CLIENT_ID '+
      ' left outer join ('+ZxTab+') g on a.SUBJ_OTHR1=g.CODE_ID '+
      ' left outer join ('+ZxTab+') h on a.SUBJ_OTHR2=h.CODE_ID '+
      ' left outer join ('+ZxTab+') i on a.SUBJ_OTHR3=i.CODE_ID '+
      ' left outer join ('+ZxTab+') j on a.SUBJ_OTHR4=j.CODE_ID '+
      ' left outer join ('+ZxTab+') k on a.SUBJ_OTHR5=k.CODE_ID '+
      ' where a.TENANT_ID='+IntToStr(Ten_ID)+' and a.FVCH_ID='''+Fvch_ID+''' ';
    Rs.Close;
    Rs.SQL.Text:=ParseSQL(AGlobal.iDbType,Str);
    AGlobal.Open(Rs);
    if Rs.Active then
    begin
      ReStr:='';
      Rs.First;
      while not Rs.Eof do
      begin
        if (trim(Rs.FieldByName('SUBJ_USER').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_USER_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('USER_NAME').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   人员（'+CurValue+'）没有维护财务系统人员编码;';
        end;
        if (trim(Rs.FieldByName('SUBJ_DEPT').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_DEPT_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('DEPT_NAME').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   部门（'+CurValue+'）没有维护财务系统部门编码;';
        end;
        if (trim(Rs.FieldByName('SUBJ_CLIENT').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_CLIENT_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('DEPT_NAME').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   往来单位（'+CurValue+'）没有维护财务系统往来单位编码;';
        end;
        if (trim(Rs.FieldByName('SUBJ_OTHR1').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_OTHR1_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('CODE_NAME1').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   专项（'+CurValue+'）没有维护财务系统编码;';
        end;
        if (trim(Rs.FieldByName('SUBJ_OTHR2').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_OTHR2_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('CODE_NAME2').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   专项（'+CurValue+'）没有维护财务系统编码;';
        end;
        if (trim(Rs.FieldByName('SUBJ_OTHR3').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_OTHR3_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('CODE_NAME3').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   专项（'+CurValue+'）没有维护财务系统编码;';
        end;
        if (trim(Rs.FieldByName('SUBJ_OTHR4').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_OTHR4_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('CODE_NAME4').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   专项（'+CurValue+'）没有维护财务系统编码;';
        end;
        if (trim(Rs.FieldByName('SUBJ_OTHR5').AsString)<>'') and (trim(Rs.FieldByName('SUBJ_OTHR5_ID').AsString)='') then
        begin
          CurValue:=trim(Rs.FieldByName('CODE_NAME5').AsString);
          if Pos(CurValue,ReStr)<=0 then
            ReStr:=ReStr+#13+'   专项（'+CurValue+'）没有维护财务系统编码;';
        end;
        Rs.Next;
      end;
    end;
    if trim(ReStr)<>'' then
    begin
      Msg:=ReStr;
      Exit;
    end;
  finally
    Rs.Free;
  end;
  result:=true;
end;

function TFvchPosting.DoFvchPostForInspur(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  Ten_ID: integer;
  Fvch_ID: string;
  Str: string;
  Rs: TZQuery;
begin
  result:=False;
  Ten_ID:=Params.ParamByName('TENANT_ID').AsInteger;
  Fvch_ID:=Params.ParamByName('FVCH_ID').AsString;
  try
    //判断是否过账
    Str:='select count(*) as RESUM from ACC_FVCHORDER '+
         ' where TENANT_ID='+IntToStr(Ten_ID)+' and FVCH_ID='''+Fvch_ID+''' and FVCH_FLAG=''2'' and (isnull(FVCH_IMPORT_ID,'''')<>'''') ';
    if CheckDataExists(AGlobal,Str) then
    begin
      Msg:='     当前凭证已过账，不能重复过账！   ';
      Exit;
    end;
    //判断单据是否已过账
    Rs:=TZQuery.Create(nil);
    //开始执行过账...
    Rs.Close;
    Rs.SQL.Text:='exec dt_AccPosting '+IntToStr(Ten_ID)+','''+Fvch_ID+''' ';
    AGlobal.Open(Rs);
    if (not Rs.IsEmpty) and (Rs.Fields[0].AsInteger>0) then
      Msg:='  凭证过账成功！ '
    else
      Msg:='  凭证过账失败！ ';
    result:=(not Rs.IsEmpty);
  finally
    Rs.Free;
  end;
end;

function TFvchPosting.DoFvchPostForKingDee(AGlobal: IdbHelp; Params: TftParamList): Boolean;
begin

end;

function TFvchPosting.DoFvchPostForYonYou(AGlobal: IdbHelp; Params: TftParamList): Boolean;
begin

end;

{==财务系统索引:1浪潮通软ERP-PS财务系统; 2:用友财务系统;3:金碟财务系统==}
function TFvchPosting.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  CW_IDX: integer; //财务系统索引
  Rs:TZQuery;
begin
  result:=False;
  //过帐前判断
  if not DoCheckFvchPosting(AGlobal,Params) then Exit;

  //调用过账
  CW_IDX:=Params.ParamByName('CW_IDX').AsInteger;
  case CW_IDX of
   1: result:=DoFvchPostForInspur(AGlobal,Params);
   2: result:=DoFvchPostForYonYou(AGlobal,Params);
   3: result:=DoFvchPostForKingDee(AGlobal,Params);
  end;
end;

initialization
  RegisterClass(TFvchPosting);

finalization
  UnRegisterClass(TFvchPosting);

end.
