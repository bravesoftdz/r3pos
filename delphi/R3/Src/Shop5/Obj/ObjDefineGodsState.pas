unit ObjDefineGodsState;

interface
uses
  SysUtils, zBase, Classes, ZIntf, ObjCommon, ZDataset, DB;

type
  {==自定义商品指标==}
  TDefineStateInfo=class(TZFactory)
  public
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;     

implementation

{ TDefineStateInfo }

function TDefineStateInfo.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
  UseFlag: integer;
begin
  //判断是否有启用
  UseFlag:=FieldByName('USEFLAG').AsInteger;
  case UseFlag of
   0:  //禁用
    AGlobal.ExecSQL('delete from PUB_CODE_INFO where CODE_TYPE=''16'' and TENANT_ID=:OLD_TENANT_ID and CODE_ID=:OLD_CODE_ID',self);
   1:  //启用
    begin
      //先更新：
      str:='update PUB_CODE_INFO set CODE_NAME=:CODE_NAME,CODE_SPELL=:CODE_SPELL,SEQ_NO=:SEQ_NO,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:TENANT_ID and CODE_TYPE=''16'' and CODE_ID=:OLD_CODE_ID ';
      if AGlobal.ExecSQL(Str,self)=0 then  //没有更新到记录则新增加
      begin
        str:='insert into PUB_CODE_INFO(TENANT_ID,CODE_ID,CODE_TYPE,CODE_NAME,CODE_SPELL,SEQ_NO,COMM,TIME_STAMP) values (:TENANT_ID,:CODE_ID,''16'',:CODE_NAME,:CODE_SPELL,:SEQ_NO,''00'','+GetTimeStamp(iDbType)+')';
        AGlobal.ExecSQL(Str,self);
      end;
    end;
  end;
end;

procedure TDefineStateInfo.InitClass;
var
  Str: string;
begin
  inherited;

{
  Str:='select TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,USEFLAG,SEQ_NO from '+
       '(select j.CODE_ID,(case when SEQ_NO>0 then SEQ_NO else 40 end)as SEQ_NO,b.TENANT_ID,'+
        '(case when b.CODE_NAME is null then j.CODE_NAME else b.CODE_NAME end) as CODE_NAME,b.CODE_SPELL,'+
        '(case when cast(j.CODE_ID as int)<9 then 1 else (case when b.CODE_NAME is null then 0 else 1 end) end) as USEFLAG '+
       ' from PUB_PARAMS j '+
       ' left outer join (select CODE_ID,CODE_NAME,CODE_SPELL,TENANT_ID,SEQ_NO from PUB_CODE_INFO where TENANT_ID=:TENANT_ID and CODE_TYPE=''16'') b '+
       ' on j.CODE_ID=b.CODE_ID '+
       ' where j.CODE_ID not in (''1'',''3'',''7'',''8'') and j.TYPE_CODE=''SORT_TYPE'')g order by SEQ_NO,cast(CODE_ID as int)';
}

  Str:=
    'select * from '+
    '(select TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,USEFLAG,'+
    ' (case when SEQ_NO>0 then SEQ_NO else cast(CODE_ID as int)+20 end)as SEQ_NO from  '+
    ' (select b.TENANT_ID,j.CODE_ID,'+
    '  (case when b.CODE_NAME is null then j.CODE_NAME else b.CODE_NAME end) as CODE_NAME,'+  //代码名称
    '  (case when (b.CODE_NAME is not null) or (cast(j.CODE_ID as int)<9) then 1 else 0 end) as USEFLAG,'+                        //启用标记
    '  (case when b.SEQ_NO is null then 0 else b.SEQ_NO end) as SEQ_NO,b.CODE_SPELL from PUB_PARAMS j '+    //排序号
    '  left outer join '+
    '  (select TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO from PUB_CODE_INFO where TENANT_ID=:TENANT_ID and CODE_TYPE=''16'') b '+
    '   on j.CODE_ID=b.CODE_ID '+
    '  where j.CODE_ID not in (''1'',''3'',''7'',''8'') and j.TYPE_CODE=''SORT_TYPE'')tmp'+
    ' )temp '+
    ' order by SEQ_NO';

   // ' order by SEQ_NO,cast(CODE_ID+10 as int) ';
  SelectSQL.Text:=Str;
end;

initialization
  RegisterClass(TDefineStateInfo);
  
finalization
  UnRegisterClass(TDefineStateInfo);

end.
