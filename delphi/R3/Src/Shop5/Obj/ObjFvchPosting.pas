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
  TFvchPostForInspur_OLD=class(TZProcFactory)
  private
    FDBLink:string;   //账套DBLink
    FVCH_BH:string;   //凭证字编号
    FVCH_NAME:string; //凭证字
    FVCH_DATE:string; //凭证日期
    FPZZNUM:integer;  //凭证字序号
    FPZNM:integer;     //凭证内码
    FPZFLNM:integer;   //凭证分录内码
    FvchOrder:TZQuery;  //主表数据集
    FvchData:TZQuery;   //分录数据集
    FvchDetail:TZQuery; //辅助数据集
    //打开取数据
    function OpenFvchData(AGlobal:IdbHelp;Params:TftParamList):Boolean;
    //复制凭证主表
    function DoCopyFvchOrder(AGlobal:IdbHelp;Params:TftParamList): Boolean;
    //复制凭证分录
    function DoCopyFvchData(AGlobal:IdbHelp;Params:TftParamList): Boolean;
    //复制凭证分录明细
    function DoCopyFvchDetail(AGlobal:IdbHelp;Params:TftParamList): Boolean;
    //更新原单据状态和单据号
    function UpdateOldOrderAndBM(AGlobal:IdbHelp;Params:TftParamList): Boolean;
  public
    constructor Create(AGlobal:IdbHelp;Params:TftParamList);override;
    destructor Destroy;override;
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

  
implementation
 

{ TFvchAudit }

function TFvchPostForInspur_OLD.DoCopyFvchOrder(AGlobal:IdbHelp;Params:TftParamList): Boolean;
var
  SQL: string;
  iRet: integer;
begin
  result:=False;
  //复制主表记录
  SQL:=
    'insert into '+FDBLink+'ZWPZK '+
        '(ZWPZK_PZNM'+   //凭证内码
        ',ZWPZK_KJND'+   //会计年度
        ',ZWPZK_KJQJ'+   //会计期间
        ',ZWPZK_PZRQ'+   //会计日期
        ',ZWPZK_PZBH'+   //凭证编码（8字节）
        ',ZWPZK_LXBH'+   //凭证类型
        ',ZWPZK_FJZS'+   //附件数
        ',ZWPZK_ZDR)'+   //制单人
    ' values '+
        '('''+IntToStr(FPZNM)+''''+
        ','''+Copy(FVCH_DATE,1,4)+''''+
        ','''+Copy(FVCH_DATE,5,2)+''''+
        ','''+FVCH_DATE+''''+
        ','''+FVCH_NAME+''''+
        ','''+FVCH_BH+''''+
        ','+IntToStr(FvchOrder.FieldByName('FVCH_ATTACH').AsInteger)+
        ','''+FvchOrder.FieldByName('SUBJECT_NO').AsString+''')';
  iRet:=AGlobal.ExecSQL(SQL);
  result:=(iRet=1);
end;

function TFvchPostForInspur_OLD.DoCopyFvchData(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  SQL: string;
  RecNo,iRet: integer;
begin
  result:=False;
  iRet:=0;
  if not FvchData.Active then Exit;
  FvchData.First;
  while not FvchData.Eof do
  begin
    RecNo:=FvchData.RecNo;
    SQL:=
      'insert into '+FDBLink+'ZWPZFL '+
          '(ZWPZFL_PZNM'+   //凭证内码
          ',ZWPZFL_FLNM'+   //分录内码
          ',ZWPZFL_FLBH'+   //分录编号 （4位系统编号）
          ',ZWPZFL_KMBH'+   //科目编号 （必须与帐务处理中的科目保持一致）
          ',ZWPZFL_ZY'+     //摘要
          ',ZWPZFL_JE'+     //金额
          ',ZWPZFL_SL'+     //数量
          ',ZWPZFL_DJ'+     //单价
          ',ZWPZFL_JZFX'+   //记账方向'1':借方，'2':贷方
          ',ZWPZFL_YWRQ)'+  //业务日期
      ' values '+
          '('''+IntToStr(FPZNM)+''''+
          ','''+IntToStr(FPZFLNM)+''''+
          ','''+FormatFloat('0000',RecNo)+''''+
          ','''+FvchData.FieldByName('SUBJECT_NO').AsString+''''+
          ','''+FvchData.FieldByName('SUMMARY').AsString+''''+
          ','''+FloatToStr(FvchData.FieldByName('AMONEY').AsFloat)+''''+
          ','''+FloatToStr(FvchData.FieldByName('AMOUNT').AsFloat)+''''+
          ','''+FloatToStr(FvchData.FieldByName('APRICE').AsFloat)+''''+
          ','''+FvchData.FieldByName('SUBJECT_TYPE').AsString+''''+
          ','''+IntToStr(FvchData.FieldByName('OPER_DATE').AsInteger)+''''+
          ')';
    //执行插入分录SQL
    AGlobal.ExecSQL(SQL);
    FvchData.Next;
    Inc(iRet);
  end;
  result:=(RecNo=iRet);
end;

function TFvchPostForInspur_OLD.DoCopyFvchDetail(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  SQL: string;
  RecNo,iRet: integer;
begin
  result:=False;
  iRet:=0;
  if not FvchDetail.Active then Exit;
  FvchDetail.First;
  while not FvchDetail.Eof do
  begin
    RecNo:=FvchDetail.RecNo;
    SQL:=
      'insert into '+FDBLink+'ZWFZYS '+
          '(ZWFZYS_PZNM'+   //凭证内码
          ',ZWFZYS_FLNM'+   //分录内码
          ',ZWFZYS_YSBH'+   //辅助编号
          ',ZWPZFL_KMBH'+   //科目编号 （必须与帐务处理中的科目保持一致）
          ',ZWFZYS_BMBH'+   //部门编号
          ',ZWFZYS_DWBH'+   //往来单位编号
          ',ZWFZYS_ZGBH'+   //人员编码
          ',ZWFZYS_XM01'+   //项目01
          ',ZWFZYS_XM02'+   //项目02
          ',ZWFZYS_XM03'+   //项目03
          ',ZWFZYS_XM04'+   //项目04
          ',ZWFZYS_XM05'+   //项目05                              
          ',ZWPZFL_JZFX'+   //记账方向'1':借方，'2':贷方
          ',ZWFZYS_SL'+     //数量
          ',ZWFZYS_DJ'+     //单价
          ',ZWFZYS_JE'+     //金额
          ',ZWFZYS_YWRQ)'+   //业务日期
      ' values '+
          '('''+IntToStr(FPZNM)+''''+
          ','''+IntToStr(FPZFLNM)+''''+
          ','''+FormatFloat('0000',RecNo)+''''+
          ','''+FvchDetail.FieldByName('SUBJECT_NO').AsString+''''+
          ','''+FvchDetail.FieldByName('SUBJ_DEPT_ID').AsString+''''+
          ','''+FvchDetail.FieldByName('SUBJ_CLIENT_ID').AsString+''''+
          ','''+FvchDetail.FieldByName('SUBJ_USER_ID').AsString+''''+
          ','''+FvchDetail.FieldByName('SUBJ_OTHR1_ID').AsString+''''+
          ','''+FvchDetail.FieldByName('SUBJ_OTHR2_ID').AsString+''''+          
          ','''+FvchDetail.FieldByName('SUBJ_OTHR3_ID').AsString+''''+
          ','''+FvchDetail.FieldByName('SUBJ_OTHR4_ID').AsString+''''+
          ','''+FvchDetail.FieldByName('SUBJ_OTHR5_ID').AsString+''''+                       
          ','''+FvchDetail.FieldByName('SUBJECT_TYPE').AsString+''''+
          ','''+FloatToStr(FvchDetail.FieldByName('AMOUNT').AsFloat)+''''+
          ','''+FloatToStr(FvchDetail.FieldByName('APRICE').AsFloat)+''''+
          ','''+FloatToStr(FvchDetail.FieldByName('AMONEY').AsFloat)+''''+
          ','''+IntToStr(FvchDetail.FieldByName('OPER_DATE').AsInteger)+''''+
          ')';    
    //执行插入分录SQL
    AGlobal.ExecSQL(SQL);
    FvchDetail.Next;
    Inc(iRet);
  end;
  result:=(RecNo=iRet);
end;

function TFvchPostForInspur_OLD.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  SaveTrans: Boolean;
begin
  //打开所有相应数
  try
    if not OpenFvchData(AGlobal,Params) then Exit;
  except
    on E:Exception do
    begin
      Msg := E.Message;
    end;
  end;
  //开始更新数据
  SaveTrans := AGlobal.InTransaction;
  if not SaveTrans then AGlobal.BeginTrans;
  try
    //111、复制凭证主表
    DoCopyFvchOrder(AGlobal,Params);
    //222、复制凭证分录表
    DoCopyFvchData(AGlobal,Params);
    //333、复制凭证明细表
    DoCopyFvchDetail(AGlobal,Params);
    //444、更新单据内码等
    UpdateOldOrderAndBM(AGlobal,Params);

    AGlobal.CommitTrans; 
  except
    on E:Exception do
    begin
      Msg := E.Message;
      AGlobal.RollBackTrans;
    end;
  end;
end;

constructor TFvchPostForInspur_OLD.Create(AGlobal: IdbHelp; Params: TftParamList);
begin
  inherited;
  FDBLink:='CWSER.cwbase1.lc0019999.';
  FvchOrder:=TZQuery.Create(nil);  //主表数据集
  FvchData:=TZQuery.Create(nil);   //分录数据集
  FvchDetail:=TZQuery.Create(nil); //辅助数据集
end;

destructor TFvchPostForInspur_OLD.Destroy;
begin
  FvchOrder.Free;
  FvchData.Free;
  FvchDetail.Free;
  inherited;
end;

function TFvchPostForInspur_OLD.OpenFvchData(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  Rs: TZQuery;
  FVCH_ID,ZXTab: string;
begin
  result:=False;
  FPZNM:=0; //凭证内码
  FPZFLNM:=0; //凭证分录内码
  Rs:=TZQuery.Create(nil);
  try
    //取数据(FvchOrder)FvchData,FvchDetail)
    FvchOrder.Close;
    FvchOrder.SQL.Text:=ParseSQL(AGlobal.iDbType,
      'select a.*,c.SUBJECT_NO from ACC_FVCHORDER a left outer join CA_USERS c on a.TENANT_ID=c.TENANT_ID and a.CREA_USER=c.USER_ID '+
      ' where a.TENANT_ID=:TENANT_ID and FVCH_ID=:FVCH_ID and FVCH_FLAG<>''3'' and isnull(FVCH_IMPORT_ID,'''')='''' ');
    FvchOrder.Params.ParamByName('TENANT_ID').AsInteger:=Params.ParamByName('TENANT_ID').AsInteger;
    FvchOrder.Params.ParamByName('FVCH_ID').AsString:=Params.ParamByName('FVCH_ID').AsString;
    AGlobal.Open(FvchOrder);
    if FvchOrder.RecordCount=1 then
    begin
      FVCH_ID:=FvchOrder.FieldByName('FVCH_ID').AsString;
      FVCH_DATE:=FvchOrder.FieldByName('FVCH_DATE').AsString;
      FVCH_NAME:=FvchOrder.FieldByName('FVCH_NAME').AsString;
      //取凭证内码、分录内码
      Rs.Close;
      Rs.SQL.Text:='select LSNBBM_NMBH,LSNBBM_DQNM from '+FDBLink+'LSNBBM where LSNBBM_XTBH=''ZW'' and LSNBBM_NMBH in (''ZWPZNM'',''ZWFLNM'')';
      AGlobal.Open(Rs);
      if Rs.Active then
      begin
        if Rs.Locate('LSNBBM_NMBH','ZWPZNM',[]) then
          FPZNM:=StrToIntDef(Rs.FieldByName('LSNBBM_DQNM').AsString,0);
        if Rs.Locate('LSNBBM_NMBH','ZWFLNM',[]) then
          FPZFLNM:=StrToIntDef(Rs.FieldByName('LSNBBM_DQNM').AsString,0);
      end else
        Raise Exception.Create('    取凭证内码出错...    ');

      //取凭证字编号   
      Rs.Close;
      Rs.SQL.Text:='select ZWPZLX_LXBH from '+FDBLink+'ZWPZLX where ZWPZLX_PZZ='''+FVCH_NAME+''' ';
      AGlobal.Open(Rs);
      if (Rs.Active) and (Rs.RecordCount=1) then
        FVCH_BH:=trim(Rs.FieldByName('ZWPZLX_LXBH').AsString) 
      else
      begin
        if Rs.RecordCount>1 then Raise Exception.Create('  存在重复凭证类型...  ');
        if Rs.RecordCount=0 then Raise Exception.Create('  凭证字〖'+FVCH_NAME+'〗的编号不存在...  '); 
      end;

      //取凭证编号[传入凭证字]
      Rs.Close;
      Rs.SQL.Text:='select ZWPZBH_PZBH from '+FDBLink+'ZWPZBH where ZWPZBH_KJND='''+copy(FVCH_DATE,1,4)+''' and ZWPZBH_KJQJ='''+copy(FVCH_DATE,5,2)+''' and ZWPZBH_PZZ='''+FVCH_NAME+''' ';
      AGlobal.Open(Rs);
      if (Rs.Active) and (Rs.RecordCount=1) then
      begin
        FPZZNUM:=StrToIntDef(Rs.FieldByName('ZWPZBH_PZBH').AsString,0);
        FVCH_NAME:=FVCH_NAME+FormatFloat('0000',FPZZNUM);
      end else
      begin
        if Rs.RecordCount>1 then Raise Exception.Create('  存在重复凭证字...  ');
        if Rs.RecordCount=0 then Raise Exception.Create('  凭证字〖'+FVCH_NAME+'〗不存在...  '); 
      end;

      //取分录数据(FvchData)
      FvchData.Close;
      FvchData.SQL.Text:='select * from ACC_FVCHDATA where TENANT_ID=:TENANT_ID and FVCH_ID=:FVCH_ID order by SUBJECT_TYPE,SEQNO';
      FvchData.Params.ParamByName('TENANT_ID').AsInteger:=Params.ParamByName('TENANT_ID').AsInteger;
      FvchData.Params.ParamByName('FVCH_ID').AsString:=Params.ParamByName('FVCH_ID').AsString;
      AGlobal.Open(FvchData);

      //取数据(FvchDetail)
      ZXTab:='select CODE_ID,CODE_SPELL as SUBJ_OTHR_ID from PUB_CODE_INFO where TENANT_ID='+IntToStr(Params.ParamByName('TENANT_ID').AsInteger)+' and CODE_TYPE=''20'' ';
      FvchDetail.Close;
      FvchDetail.SQL.Text:=ParseSQL(AGlobal.iDbType,
        'select a.*'+
        ',b.SUBJECT_NO'+                      //科目
        ',c.SUBJECT_NO as SUBJ_USER_ID'+      //人员ID
        ',d.SUBJECT_NO as SUBJ_DEPT_ID'+      //部门ID
        ',e.SUBJECT_NO as SUBJ_SHOP_ID'+      //门店ID
        ',f.SUBJECT_NO as SUBJ_CLIENT_ID'+    //往来单位
        ',g.SUBJ_OTHR_ID as SUBJ_OTHR1_ID'+   //专项1
        ',h.SUBJ_OTHR_ID as SUBJ_OTHR2_ID'+   //专项2
        ',i.SUBJ_OTHR_ID as SUBJ_OTHR3_ID'+   //专项3
        ',j.SUBJ_OTHR_ID as SUBJ_OTHR4_ID'+   //专项4
        ',k.SUBJ_OTHR_ID as SUBJ_OTHR5_ID '+  //专项5
        ' from ACC_FVCHDETAIL a '+
        ' left outer join ACC_FVCHDATA b on a.TENANT_ID=b.TENANT_ID and a.FVCH_ID=b.FVCH_ID and a.FVCH_DID=b.FVCH_DID '+
        ' left outer join CA_USERS c on a.TENANT_ID=c.TENANT_ID and a.SUBJ_USER=c.USER_ID '+
        ' left outer join CA_DEPT_INFO d on a.TENANT_ID=c.TENANT_ID and a.SUBJ_DEPT=d.DEPT_ID '+
        ' left outer join CA_SHOP_INFO e on a.TENANT_ID=e.TENANT_ID and a.SUBJ_SHOP=e.SHOP_ID '+
        ' left outer join VIW_CLIENTINFO f on a.TENANT_ID=f.TENANT_ID and a.SUBJ_CLIENT=f.CLIENT_ID '+
        ' left outer join ('+ZXTab+') g on a.TENANT_ID=g.TENANT_ID and a.SUBJ_OTHR1=g.CODE_ID '+
        ' left outer join ('+ZXTab+') h on a.TENANT_ID=h.TENANT_ID and a.SUBJ_OTHR2=h.CODE_ID '+
        ' left outer join ('+ZXTab+') i on a.TENANT_ID=i.TENANT_ID and a.SUBJ_OTHR3=i.CODE_ID '+
        ' left outer join ('+ZXTab+') j on a.TENANT_ID=j.TENANT_ID and a.SUBJ_OTHR4=j.CODE_ID '+
        ' left outer join ('+ZXTab+') k on a.TENANT_ID=k.TENANT_ID and a.SUBJ_OTHR5=k.CODE_ID '+
        ' where TENANT_ID=:TENANT_ID and FVCH_ID=:FVCH_ID'
        );
      FvchDetail.Params.ParamByName('TENANT_ID').AsInteger:=Params.ParamByName('TENANT_ID').AsInteger;
      FvchDetail.Params.ParamByName('FVCH_ID').AsString:=Params.ParamByName('FVCH_ID').AsString;
      AGlobal.Open(FvchDetail);
      result:=FvchDetail.Active;
    end else
    begin
      if FvchOrder.RecordCount>1 then
        Raise Exception.Create('  存在重复凭证单号...  ');
      if FvchOrder.RecordCount=0 then
        Raise Exception.Create('  没有找到对应凭证单号...  ');
    end;
  finally
    Rs.Free;
  end;
end;

function TFvchPostForInspur_OLD.UpdateOldOrderAndBM(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  UpSQL: string;
begin               
  //更新
  UpSQL:=
    'update ACC_FVCHORDER set FVCH_FLAG=''2'',FVCH_IMPORT_ID='''+IntToStr(FPZNM)+''' '+
    ' where TENANT_ID='+IntToStr(Params.ParamByName('TENANT_ID').AsInteger)+' and FVCH_ID='''+Params.ParamByName('FVCH_ID').AsString+''' ';
  AGlobal.ExecSQL(UpSQL);
  
  //更新凭证分录内码:
  UpSQL:='update '+FDBLink+'LSNBBM set LSNBBM_DQNM='''+IntToStr(FPZNM)+''' where LSNBBM_XTBH=''ZW'' and LSNBBM_NMBH=''ZWPZNM'' ';
  AGlobal.ExecSQL(UpSQL);
  //更新凭证分录内码:
  UpSQL:='update '+FDBLink+'LSNBBM set LSNBBM_DQNM='''+IntToStr(FPZFLNM)+''' where LSNBBM_XTBH=''ZW'' and LSNBBM_NMBH=''ZWFLNM'' ';
  AGlobal.ExecSQL(UpSQL);
  //更新凭证字编码:
  UpSQL:=
   'update '+FDBLink+'ZWPZBH set ZWPZBH_PZBH='''+IntToStr(FPZZNUM)+''' '+
   ' where ZWPZBH_KJND='''+copy(FVCH_DATE,1,4)+''' and ZWPZBH_KJQJ='''+copy(FVCH_DATE,5,2)+''' and ZWPZBH_PZZ='''+FVCH_NAME+''' ';
  AGlobal.ExecSQL(UpSQL);
end;

initialization
  RegisterClass(TFvchPostForInspur);

finalization
  UnRegisterClass(TFvchPostForInspur);

end.
