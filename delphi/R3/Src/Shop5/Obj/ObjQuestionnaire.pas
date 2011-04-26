unit ObjQuestionnaire;

interface
uses Dialogs,SysUtils,zBase,Classes,DB,ZIntf,ZDataset,ObjCommon;

type
  TQuestion=class(TZFactory)
  public
    procedure InitClass; override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TQuestionItem=class(TZFactory)
  public
    procedure InitClass; override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  
  TInvest=class(TZFactory)
  public
    procedure InitClass; override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TInvestData=class(TZFactory)
  public
    procedure InitClass; override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  
implementation

{ TQuestionItem }

function TQuestionItem.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TQuestionItem.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TQuestionItem.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TQuestionItem.InitClass;
var
  Str: string;
begin
  inherited;
   SelectSQL.Text :=  
   'select jc.*,c.CODE_NAME as QUESTION_ITEM_TYPE_TEXT from ( '+
   'select a.TENANT_ID,a.QUESTION_ID,a.QUESTION_ITEM_ID,a.SEQ_NO,a.QUESTION_ITEM_TYPE,a.QUESTION_INFO,a.QUESTION_OPTIONS,a.COMM_ID '+
   'from MSC_QUESTION_ITEM a left join MSC_QUESTION b on a.TENANT_ID=b.TENANT_ID and a.QUESTION_ID=b.QUESTION_ID '+
   'where a.TENANT_ID=:TENANT_ID and a.QUESTION_ID=:QUESTION_ID ) '+
   'jc left join (select CODE_ID,CODE_NAME,TYPE_CODE from PUB_PARAMS where TYPE_CODE=''QUESTION_ITEM_TYPE'') c on jc.QUESTION_ITEM_TYPE=c.CODE_ID ';

  IsSQLUpdate := True;
  Str :=
  'insert into MSC_QUESTION_ITEM(TENANT_ID,QUESTION_ID,QUESTION_ITEM_ID,SEQ_NO,QUESTION_ITEM_TYPE,QUESTION_INFO,QUESTION_OPTIONS,COMM_ID) '+
  'VALUES(:TENANT_ID,:QUESTION_ID,:QUESTION_ITEM_ID,:SEQ_NO,:QUESTION_ITEM_TYPE,:QUESTION_INFO,:QUESTION_OPTIONS,:COMM_ID)';
  InsertSQL.Text := Str;
  Str :=
  'update MSC_QUESTION_ITEM set SEQ_NO=:SEQ_NO,QUESTION_ITEM_TYPE=:QUESTION_ITEM_TYPE,QUESTION_INFO=:QUESTION_INFO,QUESTION_OPTIONS=:QUESTION_OPTIONS,COMM_ID=:COMM_ID '+
  ' where TENANT_ID=:OLD_TENANT_ID and QUESTION_ID=:OLD_QUESTION_ID and QUESTION_ITEM_ID=:OLD_QUESTION_ITEM_ID';
  UpdateSQL.Text := Str;

end;

{ TQuestion }

function TQuestion.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TQuestion.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TQuestion.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TQuestion.InitClass;
var
  Str: string;
begin
  inherited;
   SelectSQL.Text :=  //
   'select TENANT_ID,QUESTION_ID,QUESTION_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,QUESTION_SOURCE,ISSUE_USER,QUESTION_TITLE,ANSWER_FLAG,'+
   'QUESTION_ITEM_AMT,REMARK,END_DATE,COMM_ID from MSC_QUESTION where TENANT_ID=:TENANT_ID and QUESTION_ID=:QUESTION_ID';

  IsSQLUpdate := True;
  Str :=
  'insert into MSC_QUESTION(TENANT_ID,QUESTION_ID,QUESTION_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,QUESTION_SOURCE,ISSUE_USER,QUESTION_TITLE,'+
  'ANSWER_FLAG,QUESTION_ITEM_AMT,REMARK,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
  'VALUES(:TENANT_ID,:QUESTION_ID,:QUESTION_CLASS,:ISSUE_DATE,:ISSUE_TENANT_ID,:QUESTION_SOURCE,:ISSUE_USER,:QUESTION_TITLE,:ANSWER_FLAG,'+
  ':QUESTION_ITEM_AMT,:REMARK,:END_DATE,:COMM_ID,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str :=
  'update MSC_QUESTION set QUESTION_CLASS=:QUESTION_CLASS,ISSUE_DATE=:ISSUE_DATE,ISSUE_TENANT_ID=:ISSUE_TENANT_ID,QUESTION_SOURCE=:QUESTION_SOURCE,'+
  'ISSUE_USER=:ISSUE_USER,QUESTION_TITLE=:QUESTION_TITLE,ANSWER_FLAG=:ANSWER_FLAG,QUESTION_ITEM_AMT=:QUESTION_ITEM_AMT,REMARK=:REMARK,END_DATE=:END_DATE,'+
  'COMM_ID=:COMM_ID,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and QUESTION_ID=:OLD_QUESTION_ID ';
  UpdateSQL.Text := Str;
  
  Str := 'update MSC_QUESTION set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and QUESTION_ID=:OLD_QUESTION_ID ';
  DeleteSQL.Text := Str;
  
end;

{ TInvest }

function TInvest.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TInvest.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TInvest.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TInvest.InitClass;
var
  Str: string;
begin
  inherited;
   SelectSQL.Text :=  
   'select TENANT_ID,QUESTION_ID,SHOP_ID,ANSWER_DATE,ANSWER_USER,ANSWER_USE_TIME,QUESTION_FEEDBACK_STATUS,QUESTION_ANSWER_STATUS,COMM_ID '+
   'from MSC_INVEST_LIST where TENANT_ID=:TENANT_ID and QUESTION_ID=:QUESTION_ID and SHOP_ID=:SHOP_ID';

  IsSQLUpdate := True;
  Str :=
  'insert into MSC_INVEST_LIST(TENANT_ID,QUESTION_ID,SHOP_ID,ANSWER_DATE,ANSWER_USER,ANSWER_USE_TIME,QUESTION_FEEDBACK_STATUS,QUESTION_ANSWER_STATUS,COMM_ID,COMM,TIME_STAMP) '+
  'VALUES(:TENANT_ID,:QUESTION_ID,:SHOP_ID,:ANSWER_DATE,:ANSWER_USER,:ANSWER_USE_TIME,:QUESTION_FEEDBACK_STATUS,:QUESTION_ANSWER_STATUS,:COMM_ID,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str :=
  'update MSC_INVEST_LIST set ANSWER_DATE=:ANSWER_DATE,ANSWER_USER=:ANSWER_USER,ANSWER_USE_TIME=:ANSWER_USE_TIME,QUESTION_FEEDBACK_STATUS=:QUESTION_FEEDBACK_STATUS,QUESTION_ANSWER_STATUS=:QUESTION_ANSWER_STATUS,COMM_ID=:COMM_ID,'+
  'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and QUESTION_ID=:OLD_QUESTION_ID and SHOP_ID=:OLD_SHOP_ID ';
  UpdateSQL.Text := Str;
  
end;

{ TInvestData }

function TInvestData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TInvestData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TInvestData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TInvestData.InitClass;
var
  Str: string;
begin
  inherited;
   SelectSQL.Text :=  
   'select a.ROWS_ID,a.TENANT_ID,a.SHOP_ID,a.QUESTION_ID,a.QUESTION_ITEM_ID,a.ANSWER_VALUE from MSC_INVEST_ANSWER a left join MSC_INVEST_LIST b '+
   'on a.TENANT_ID=b.TENANT_ID and a.QUESTION_ID=b.QUESTION_ID where a.TENANT_ID=:TENANT_ID and a.QUESTION_ID=:QUESTION_ID and SHOP_ID=:SHOP_ID ';

  IsSQLUpdate := True;
  Str :=
  'insert into MSC_INVEST_ANSWER(ROWS_ID,TENANT_ID,SHOP_ID,QUESTION_ID,QUESTION_ITEM_ID,ANSWER_VALUE,COMM,TIME_STAMP ) '+
  'VALUES(:ROWS_ID,:TENANT_ID,:SHOP_ID,:QUESTION_ID,:QUESTION_ITEM_ID,:ANSWER_VALUE,''00'','+GetTimeStamp(iDbType)+' )';
  InsertSQL.Text := Str;

  Str :=
  'update MSC_INVEST_ANSWER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,QUESTION_ID=:QUESTION_ID,QUESTION_ITEM_ID=:QUESTION_ITEM_ID,ANSWER_VALUE=:ANSWER_VALUE,'+
  'COMM='+GetCommStr(iDbType)+
  ',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID ';
  UpdateSQL.Text := Str;

  Str := 'update MSC_INVEST_ANSWER set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID ';
  DeleteSQL.Text := Str;
  
end;

initialization
  RegisterClass(TQuestion);
  RegisterClass(TQuestionItem);
  RegisterClass(TInvest);
  RegisterClass(TInvestData);
finalization
  UnRegisterClass(TQuestion);
  UnRegisterClass(TQuestionItem);
  UnRegisterClass(TInvest);
  UnRegisterClass(TInvestData);

end.
