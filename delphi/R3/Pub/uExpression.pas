
unit uExpression;

interface

uses Classes, Dialogs, Sysutils, Math,db,Variants,Forms;

type
  TTokenType = (ttNone, ttNumeric, ttParenthesis, ttOperation, ttString,
    ttParamDelimitor, ttVariable,ttConst);
  TEvaluateOrder = (eoInternalFirst, eoEventFirst);
  TOnEvaluate = procedure(Sender: TObject; Eval: string; Args: array of Variant;
    ArgCount: Integer; var Value: Variant; var Done: Boolean) of object;
  TOnVariable = procedure(Sender: TObject; Variable: string; var Value: Variant;
    var Done: Boolean) of object;
  TOnConst = procedure(Sender: TObject; Variable: string;var Value: Variant;
    var Done: Boolean) of object;

  TExpToken = class
  private
    FText: string;
    FTokenType: TTokenType;
  public
    property Text: string read FText;
    property TokenType: TTokenType read FTokenType;
  end;

  TExpParser = class
  protected
    FExpression: string;
    FTokens: TList;
    FPos: Integer;
  private
    procedure Clear;
    function GetToken(Index: Integer): TExpToken;
    procedure SetExpression(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;

    function ReadFirstToken: TExpToken;
    function ReadNextToken: TExpToken;

    function TokenCount: Integer;
    property Tokens[Index: Integer]: TExpToken read GetToken;
    property TokenList: TList read FTokens;
    property Expression: string read FExpression write SetExpression;
  end;

  TExpNode = class
  protected
    FOwner: TObject;
    FParent: TExpNode;
    FChildren: TList;
    FTokens: TList;
    FLevel: Integer;
    FToken: TExpToken;
    FOnEvaluate: TOnEvaluate;
    FOnVariable: TOnVariable;
  private
    FOnConst: TOnConst;
    function GetToken(Index: Integer): TExpToken;
    function GetChildren(Index: Integer): TExpNode;
    function FindLSOTI: Integer;
    function ParseFunction: Boolean;
    procedure RemoveSorroundingParenthesis;
    procedure SplitToChildren(TokenIndex: Integer);
    function Evaluate: Variant;
    function Variable: Variant;
    function VarConst: Variant;
    property Children[Index: Integer]: TExpNode read GetChildren;
    function ParseVariable: Boolean;
  public
    constructor Create(AOwner: TObject; AParent: TExpNode; Tokens: TList);
    destructor Destroy; override;
    procedure Build;

    function TokenCount: Integer;
    function Calculate: Variant;
    property Tokens[Index: Integer]: TExpToken read GetToken;
    property Parent: TExpNode read FParent;
    property Level: Integer read FLevel;
    property OnEvaluate: TOnEvaluate read FOnEvaluate write FOnEvaluate;
    property OnVarible: TOnVariable read FOnVariable write FOnVariable;
    property OnConst: TOnConst read FOnConst write FOnConst;
  end;

  TFunction = class
  protected
    FIsParse:Boolean;
    FAsString, FName, FHead, FFunction: string;
    FOwner: TObject;
    FArgCount: Integer;
    FArgs: TStringList;
    FValues: array of Variant;
  private
    procedure SetAsString(const Value: string);
    procedure EvalArgs(Sender: TObject; Eval: string; Args: array of Variant;
      ArgCount: Integer; var Value: Variant);
  public
    constructor Create(AOwner: TObject);
    destructor Destroy; override;
    function Call(Values: array of Variant): Variant;
    property AsString: string read FAsString write SetAsString;
    property Name: string read FName;
    property ArgCount: Integer read FArgCount;
    property Args: TStringList read FArgs;
  end;

  TExpression = class(TComponent)
  protected
    FInfo, FText: string;
    FEvaluateOrder: TEvaluateOrder;
    FOnEvaluate: TOnEvaluate;
    FOnVariable: TOnVariable;
    FOnConst: TOnConst;
    FValue: Double;
    FFunctions: TStringList;
    FTree:TExpNode;
    FParser: TExpParser;
  private
    FDataSet: TDataSet;
    procedure Compile;
    function GetValue: Double;
    procedure SetInfo(Value: string);
    procedure Evaluate(Eval: string; Args: array of Variant; var Value: Variant);
    function FindFunction(FuncName: string): TFunction;
    procedure SetFunctions(Value: TStringList);
    procedure Variable(Eval: string; var Value: Variant);
    procedure VarConst(Eval: string; var Value: Variant);
    procedure HSEvaluate(Sender: TObject; Eval: String;
      Args: array of Variant; ArgCount: Integer; var Value: Variant;
      var Done: Boolean);
    procedure HSVariable(Sender: TObject; Variable: string; var Value: Variant;
    var Done: Boolean);
    procedure HSConst(Sender: TObject; Variable: string;var Value: Variant;
    var Done: Boolean);
    procedure SetDataSet(const Value: TDataSet);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Prepare;
    function  Result:Double;
    property Value: Double read GetValue;
  published
    property Text: string read FText write FText;
    property Info: string read FInfo write SetInfo;
    property Functions: TStringList read FFunctions write SetFunctions;
    property EvaluateOrder: TEvaluateOrder read FEvaluateOrder write
      FEvaluateOrder;
    property OnEvaluate: TOnEvaluate read FOnEvaluate write FOnEvaluate;
    property OnVariable: TOnVariable read FOnVariable write FOnVariable;
    property OnConst: TOnConst read FOnConst write FOnConst;
    property DataSet:TDataSet read FDataSet write SetDataSet;
  end;

//定义函数解释算法

function GetExpressionValue(Text:String;DataSet:TDataSet):Real;

var HSExpression:TExpression;
implementation

const
  // 支持的操作符
  STR_OPERATION = '+-*/^!';
  // 函数参数分隔符
  STR_PARAMDELIMITOR = ',';
  // 变量名字符
  STR_STRING: array[0..1] of string =
  ('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_',
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_$#@0123456789');

function GetExpressionValue(Text:String;DataSet:TDataSet):Real;
begin
 HSExpression.DataSet := DataSet;
 try
    if Trim(Text)='' then
      Result :=0
    else
    begin
      HSExpression.Text := Trim(Text);
      Result := HSExpression.Value;
    end;
 except
    result := 0;
    Raise;
 end;
end;

function OperParamateres(const Oper: string): Integer;
begin
  if Pos(Oper, '+-*/^') > 0 then
    Result := 2
  else if Oper = '!' then
    Result := 1
  else
    Result := 0;
end;

constructor TExpParser.Create;
begin
  inherited Create;
  FTokens := TList.Create;
end;

destructor TExpParser.Destroy;
begin
  Clear;
  FTokens.Free;
  inherited;
end;

procedure TExpParser.Clear;
begin
  while FTokens.Count > 0 do
  begin
    TExpToken(FTokens[0]).Free;
    FTokens.Delete(0);
  end;
end;

procedure TExpParser.SetExpression(const Value: string);
begin
  FExpression := Trim(Value);
end;

function TExpParser.GetToken(Index: Integer): TExpToken;
begin
  Result := TExpToken(FTokens[Index]);
end;

function TExpParser.ReadFirstToken: TExpToken;
begin
  Clear;
  FPos := 1;
  Result := ReadNextToken;
end;

function GetTokenType(S: string; First: Boolean): TTokenType;
var
  Value: Double;
  P, Error: Integer;
begin
  if (S = '(') or (S = ')') then
    Result := ttParenthesis
  else if S = STR_PARAMDELIMITOR then
    Result := ttParamDelimitor
  else if (S = '[') or (S = ']') then
    Result := ttVariable
  else if (S = '''') or (S = '''') then
    Result := ttConst
  else if Pos(S, STR_OPERATION) > 0 then
    Result := ttOperation
  else
  begin
    Val(S, Value, Error);
    if Error = 0 then
      Result := ttNumeric
    else
    begin
      if First then
        P := Pos(S, STR_STRING[0])
      else
        P := Pos(S, STR_STRING[1]);

      if P > 0 then
        Result := ttString
      else
        Result := ttNone;
    end;
  end;
end;

function TExpParser.ReadNextToken: TExpToken;
var
  Part, Ch: string;
  FirstType, NextType: TTokenType;
  Sci: Boolean;
begin
  Result := nil;
  if FPos > Length(FExpression) then
    Exit;
  Sci := False;

  Part := '';
  repeat
    Ch := FExpression[FPos];
    Inc(FPos);
  until (Ch <> ' ') or (FPos > Length(FExpression));
  if FPos - 1 > Length(FExpression) then
    Exit;

  FirstType := GetTokenType(Ch, True);
  if FirstType = ttNone then
  begin
    raise
      Exception.CreateFmt('解码错误: 跳过字符 "%s" 在 %d.',
      [Ch, FPos - 1]);
    Exit;
  end;

  if FirstType in [ttParenthesis, ttOperation] then
  begin
    Result := TExpToken.Create;
    with Result do
    begin
      FText := Ch;
      FTokenType := FirstType;
    end;
    FTokens.Add(Result);
    Exit;
  end;

  if (FirstType <> ttVariable) and (FirstType <> ttConst) then    //对[],''进行解码
    Part := Ch;
  repeat
    if FPos <= Length(FExpression) then
      Ch := FExpression[FPos]
    else
      Ch := #0;
    NextType := GetTokenType(Ch, False);

    if (NextType = FirstType) and (FirstType <> ttVariable) and (FirstType <> ttConst) or
       ((FirstType = ttVariable) and (NextType <> ttVariable)) or ((FirstType = ttConst) and (NextType <> ttConst)) or
      ((FirstType = ttString) and (NextType = ttNumeric)) or
      ((FirstType = ttNumeric) and (NextType = ttString) and (Ch = 'E') and
      (Sci = False)) or
      ((FirstType = ttNumeric) and (NextType = ttOperation) and (Ch = '-') and
      (Sci = True)) then
    begin
      Part := Part + Ch;
      if (FirstType = ttNumeric) and (NextType = ttString) and (Ch = 'E') then
        Sci := True;
    end
    else
    begin
      if (FirstType = ttVariable) and (NextType = ttVariable) or (FirstType = ttConst) and (NextType = ttConst) then
        Inc(FPos);
      Result := TExpToken.Create;
      with Result do
      begin
        FText := Part;
        FTokenType := FirstType;
      end;
      FTokens.Add(Result);
      Exit;
    end;
    Inc(FPos);
  until FPos > Length(FExpression);

  Result := TExpToken.Create;
  with Result do
  begin
    FText := Part;
    FTokenType := FirstType;
  end;
  FTokens.Add(Result);
end;

function TExpParser.TokenCount: Integer;
begin
  Result := FTokens.Count;
end;

constructor TExpNode.Create(AOwner: TObject; AParent: TExpNode; Tokens: TList);
var
  I: Integer;
begin
  inherited Create;

  FOwner := AOwner;
  FParent := AParent;
  if FParent = nil then
    FLevel := 0
  else
    FLevel := FParent.Level + 1;

  FTokens := TList.Create;
  I := 0;
  while I < Tokens.Count do
  begin
    FTokens.Add(Tokens[I]);
    Inc(I);
  end;

  FChildren := TList.Create;

  if Tokens.Count = 1 then
    FToken := Tokens[0];
end;

destructor TExpNode.Destroy;
var
  Child: TExpNode;
  i:Integer;
begin
  if Assigned(FChildren) then
  begin
    while FChildren.Count > 0 do
    begin
      Child := Children[FChildren.Count - 1];
      FreeAndNil(Child);
      FChildren.Delete(FChildren.Count - 1);
    end;

    FreeAndNil(FChildren);
  end;
  FTokens.Free;

  inherited;
end;

procedure TExpNode.RemoveSorroundingParenthesis;
var
  First, Last, Lvl, I: Integer;
  Sorrounding: Boolean;
begin
  First := 0;
  Last := TokenCount - 1;
  while Last > First do
  begin
    if (Tokens[First].TokenType = ttParenthesis) and
      (Tokens[Last].TokenType = ttParenthesis) and
      (Tokens[First].Text = '(') and (Tokens[Last].Text = ')') then
    begin

      Lvl := 0;
      I := 0;
      Sorrounding := True;
      repeat
        if (Tokens[I].TokenType = ttParenthesis) and (Tokens[I].Text = '(') then
          Inc(Lvl)
        else if (Tokens[I].TokenType = ttParenthesis) and (Tokens[I].Text = ')')
          then
          Dec(Lvl);

        if (Lvl = 0) and (I < TokenCount - 1) then
        begin
          Sorrounding := False;
          Break;
        end;

        Inc(I);
      until I = TokenCount;

      if Sorrounding then
      begin
        FTokens.Delete(Last);
        FTokens.Delete(First);
      end
      else
        Exit;
    end
    else
      Exit;

    First := 0;
    Last := TokenCount - 1;
  end;
end;

procedure TExpNode.Build;
var
  LSOTI: Integer;
begin
  if TokenCount < 2 then
    Exit;
  RemoveSorroundingParenthesis;
  if TokenCount < 2 then
    Exit;

  LSOTI := FindLSOTI;
  if LSOTI < 0 then
  begin
    if ParseFunction then
      Exit
    else if ParseVariable then
      Exit;
    raise Exception.Create('编绎错误: 语法错误.');
    Exit;
  end;
  SplitToChildren(LSOTI);
end;

function TExpNode.ParseFunction: Boolean;
var
  Func: Boolean;
  I, Delimitor, DelimitorLevel: Integer;
  FChild: TExpNode;
  FList: TList;
begin
  Result := False;
  if TokenCount < 4 then
    Exit;

  Func := (Tokens[0].TokenType = ttString) and
    (Tokens[1].TokenType = ttParenthesis) and
    (Tokens[TokenCount - 1].TokenType = ttParenthesis);

  if not Func then
    Exit;

  FToken := Tokens[0];
  with FTokens do
  begin
    Delete(TokenCount - 1);
    Delete(1);
  end;

  FList := TList.Create;
  try
    while TokenCount > 1 do
    begin
      Delimitor := -1;
      DelimitorLevel := 0;
      for I := 1 to TokenCount - 1 do
      begin
        if (Tokens[I].TokenType = ttParenthesis) and (Tokens[I].Text = '(') then
          Inc(DelimitorLevel)
        else if (Tokens[I].TokenType = ttParenthesis) and (Tokens[I].Text = ')')
          then
          Dec(DelimitorLevel)
        else if (Tokens[I].TokenType = ttParamDelimitor) and (DelimitorLevel = 0)
          then
        begin
          Delimitor := I - 1;
          FTokens.Delete(I);
          Break;
        end;

        if DelimitorLevel < 0 then
        begin
          raise Exception.Create('函数解释数据.');
          Exit;
        end;
      end;

      if Delimitor = -1 then
        Delimitor := TokenCount - 1;
      for I := 1 to Delimitor do
      begin
        FList.Add(Tokens[1]);
        FTokens.Delete(1);
      end;
      FChild := TExpNode.Create(FOwner, Self, FList);
      FList.Clear;
      FChild.Build;
      FChildren.Add(FChild);
    end;
  finally
    FList.Free;
  end;
  Result := True;
end;

procedure TExpNode.SplitToChildren(TokenIndex: Integer);
var
  Left, Right: TList;
  I: Integer;
  FChild: TExpNode;
begin
  Left := TList.Create;
  Right := TList.Create;

  try
    if TokenIndex < TokenCount - 1 then
      for I := TokenCount - 1 downto TokenIndex + 1 do
      begin
        Right.Insert(0, FTokens[I]);
        FTokens.Delete(I);
      end;

    if Right.Count > 0 then
    begin
      FChild := TExpNode.Create(FOwner, Self, Right);
      FChildren.Insert(0, FChild);
      FChild.Build;
    end;

    if TokenIndex > 0 then
      for I := TokenIndex - 1 downto 0 do
      begin
        Left.Insert(0, FTokens[I]);
        FTokens.Delete(I);
      end;

    FChild := TExpNode.Create(FOwner, Self, Left);
    FChildren.Insert(0, FChild);
    FChild.Build;
  finally
    FToken := Tokens[0];
    Left.Free;
    Right.Free;
  end;
end;

function TExpNode.GetChildren(Index: Integer): TExpNode;
begin
  Result := TExpNode(FChildren[Index]);
end;

function TExpNode.ParseVariable: Boolean;
begin
  Result := False;
  if Tokens[0].TokenType = ttVariable then
    Result := True;
  if Tokens[0].TokenType = ttConst then
    Result := True;
end;

function TExpNode.FindLSOTI: Integer;
var
  Lvl, I, LSOTI, NewOperPriority, OperPriority: Integer;
begin
  Lvl := 0;
  I := 0;
  LSOTI := -1;
  OperPriority := 9;

  repeat
    if Tokens[I].TokenType = ttParenthesis then
    begin
      if Tokens[I].Text = '(' then
        Inc(Lvl)
      else if Tokens[I].Text = ')' then
        Dec(Lvl);

      if Lvl < 0 then
      begin
        raise Exception.Create('编绎错误: 括号不配(;).');
        Exit;
      end;
    end;

    if (Tokens[I].TokenType = ttOperation) and (Lvl = 0) then
    begin
      NewOperPriority := Pos(Tokens[I].Text, STR_OPERATION);
      if NewOperPriority <= OperPriority then
      begin
        OperPriority := NewOperPriority;
        LSOTI := I;
      end;
    end;

    Inc(I);
  until I >= TokenCount;

  Result := LSOTI;
end;

function Exl(Value: Integer): Double;
begin
  if Value <= 1 then
    Result := Value
  else
    Result := Value * Exl(Value - 1);
end;

function TExpNode.Evaluate: Variant;
var
  Args: array of Variant;
  Count, I: Integer;
  Done: Boolean;
begin
  Result := 0;
  if FToken.TokenType = ttString then
  begin
    Count := FChildren.Count;
    SetLength(Args, Count);
    for I := 0 to Count - 1 do
      Args[I] := Children[I].Calculate;

    if Assigned(FOnEvaluate) then
      FOnEvaluate(Self, FToken.Text, Args, High(Args) + 1, Result, Done)
    else if FOwner is TExpression then
      TExpression(FOwner).Evaluate(FToken.Text, Args, Result)
    else if FOwner is TFunction then
      TFunction(FOwner).EvalArgs(Self, FToken.Text, Args, High(Args) + 1,
        Result);
  end;
end;

function TExpNode.Variable: Variant;
var
  Done: Boolean;
begin
  Result := 0;
  if FToken.TokenType = ttVariable then
  begin

    if Assigned(FOnVariable) then
      FOnVariable(Self, FToken.Text, Result, Done);
    if FOwner is TExpression then
      TExpression(FOwner).Variable(FToken.Text, Result);
  end;

end;

function TExpNode.Calculate: Variant;
var
  Error: Integer;
  DivX, DivY,TmpNumber: Double;
begin
  Result := 0;
  if (FToken = nil) or (TokenCount = 0) then
    Exit;

  if TokenCount = 1 then
  begin
    if FToken.TokenType = ttNumeric then
    begin
      Val(FToken.Text, TmpNumber, Error);
      Result := TmpNumber;
    end
    else if FToken.TokenType = ttString then
    begin
      Result := Evaluate;
    end
    else if (FToken.TokenType = ttVariable) then
    begin
      Result := Variable;
    end
    else if (FToken.TokenType = ttConst) then
    begin
      Result := VarConst;
    end
    else if FToken.TokenType = ttOperation then
    begin
      if FChildren.Count <> OperParamateres(FToken.Text) then
      begin
        raise Exception.Create('计算错误: 语法树有误.');
        Exit;
      end;
      if FToken.Text = '+' then
        Result := Children[0].Calculate + Children[1].Calculate
      else if FToken.Text = '-' then
        Result := Children[0].Calculate - Children[1].Calculate
      else if FToken.Text = '*' then
        Result := Children[0].Calculate * Children[1].Calculate
      else if FToken.Text = '/' then
      begin
        DivX := Children[0].Calculate;
        DivY := Children[1].Calculate;
        if DivY <> 0 then
          Result := DivX / DivY
        else
        begin
          result := null;
          //raise
          //  Exception.CreateFmt('计算错误: "%f / %f" 零除错误.',
          //  [DivX, DivY]);
          Exit;
        end;
      end
      else if FToken.Text = '^' then
        Result := Power(Children[0].Calculate, Children[1].Calculate)
      else if FToken.Text = '!' then
        Result := Exl(Round(Children[0].Calculate));
    end;
  end;
end;

function TExpNode.GetToken(Index: Integer): TExpToken;
begin
  Result := TExpToken(FTokens[Index]);
end;

function TExpNode.TokenCount: Integer;
begin
  Result := FTokens.Count;
end;

constructor TFunction.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  FAsString := '';
  FName := '';
  FArgCount := 0;
  FArgs := TStringList.Create;
end;

destructor TFunction.Destroy;
begin
  FArgs.Free;
  inherited;
end;

function TFunction.Call(Values: array of Variant): Variant;
var
  Token: TExpToken;
  Tree: TExpNode;
  Parser: TExpParser;
  I: Integer;
begin
  SetLength(FValues, High(Values) + 1);
  for I := 0 to High(Values) do
    FValues[I] := Values[I];

  Parser := TExpParser.Create;
  try
    Parser.Expression := FFunction;
    Token := Parser.ReadFirstToken;
    while Token <> nil do
      Token := Parser.ReadNextToken;

    Tree := TExpNode.Create(Self, nil, Parser.TokenList);
    try
      with Tree do
      begin
        Build;
        Result := Calculate;
      end;
    finally
      Tree.Free;
    end;
  finally
    Parser.Free;
  end;
end;

procedure TFunction.EvalArgs(Sender: TObject; Eval: string; Args: array of
  Variant; ArgCount: Integer; var Value: Variant);
var
  I: Integer;
begin
  for I := 0 to FArgs.Count - 1 do
    if UpperCase(FArgs[I]) = UpperCase(Eval) then
    begin
      Value := FValues[I];
      Exit;
    end;

  if FOwner is TExpression then
    TExpression(FOwner).Evaluate(Eval, Args, Value);
end;

procedure TFunction.SetAsString(const Value: string);
var
  Head: string;
  HeadPos: Integer;
  Parser: TExpParser;
  Token: TExpToken;
  ExpectParenthesis, ExpectDelimitor: Boolean;
begin
  FArgs.Clear;
  FArgCount := 0;
  FAsString := Value;
  FHead := '';
  FFunction := '';
  FName := '';

  HeadPos := Pos('=', FAsString);
  if HeadPos = 0 then
    Exit;
  Head := Copy(FAsString, 1, HeadPos - 1);
  FFunction := FAsString;
  Delete(FFunction, 1, HeadPos);
  Parser := TExpParser.Create;
  try
    Parser.Expression := Head;
    Token := Parser.ReadFirstToken;
    if (Token = nil) or (Token.TokenType <> ttString) then
    begin
      raise Exception.CreateFmt('函数 "%s" 无效.', [FAsString]);
      Exit;
    end;
    FName := Token.Text;

    Token := Parser.ReadNextToken;
    if Token = nil then
      Exit;
    if Token.TokenType = ttParenthesis then
    begin
      if Token.Text = '(' then
        ExpectParenthesis := True
      else
      begin
        raise Exception.CreateFmt('函数头 "%s" 无效.', [Head]);
        Exit;
      end;
    end
    else
      ExpectParenthesis := False;

    ExpectDelimitor := False;
    while Token <> nil do
    begin
      Token := Parser.ReadNextToken;
      if Token <> nil then
      begin
        if Token.TokenType = ttParenthesis then
        begin
          if ExpectParenthesis and (Token.Text = ')') then
            Exit
          else
          begin
            raise Exception.CreateFmt('函数头 "%s" 无效.',
              [Head]);
            Exit;
          end;
        end;

        if ExpectDelimitor then
        begin
          if (Token.TokenType <> ttParamDelimitor) and (Token.TokenType <>
            ttParenthesis) then
          begin
            raise
              Exception.Create('函数解释错误: 参数分隔符只能是 "," .');
            Exit;
          end;
          ExpectDelimitor := False;
          Continue;
        end;

        if Token.TokenType = ttString then
        begin
          FArgs.Add(Token.Text);
          FArgCount := FArgs.Count;
          ExpectDelimitor := True;
        end;
      end;
    end;
    if ExpectParenthesis then
      raise Exception.CreateFmt('函数名 "%s" 无效.', [Head]);
  finally
    Parser.Free;
  end;
end;

constructor TExpression.Create;
begin
  inherited;
  FText := '';
  FInfo := '海晟报表公式解码器。';
  FFunctions := TStringList.Create;
  FOnEvaluate := HSEvaluate;
  FOnVariable := HSVariable;
  FOnConst := HSConst;
end;

destructor TExpression.Destroy;
begin
  FFunctions.Free;
  if FTree<>nil then FreeAndNil(FTree);
  if FParser<>nil then FreeAndNil(FParser);
  inherited;
end;

procedure TExpression.Compile;
var
  Token: TExpToken;
  Tree: TExpNode;
  Parser: TExpParser;
begin
  Parser := TExpParser.Create;
  try
    Parser.Expression := FText;
    Token := Parser.ReadFirstToken;
    while Token <> nil do
      Token := Parser.ReadNextToken;

    Tree := TExpNode.Create(Self, nil, Parser.TokenList);
    try
      with Tree do
      begin
        Build;
        FValue := Calculate;
      end;
    finally
      Tree.Free;
    end;
  finally
    Parser.Free;
  end;
end;

function TExpression.FindFunction(FuncName: string): TFunction;
var
  F: TFunction;
  I: Integer;
begin
  Result := nil;
  for I := 0 to FFunctions.Count - 1 do
    if Trim(FFunctions[I]) <> '' then
    begin
      F := TFunction.Create(Self);
      F.AsString := FFunctions[I];
      if UpperCase(F.Name) = UpperCase(FuncName) then
      begin
        Result := F;
        Exit;
      end;
      F.Free;
    end;
end;

procedure TExpression.SetInfo(Value: string);
begin
  //
end;

procedure TExpression.Evaluate(Eval: string; Args: array of Variant; var
  Value: Variant);
var
  Func: TFunction;
  Done: Boolean;
begin
  Done := False;
  if (EvaluateOrder = eoEventFirst) and Assigned(FOnEvaluate) then
  begin
    FOnEvaluate(Self, Eval, Args, High(Args) + 1, Value, Done);
    if Done then
      Exit;
  end
  else
    Value := 0;

  Func := FindFunction(Eval);
  if Func <> nil then
  begin
    Value := Func.Call(Args);
    Func.Free;
    Exit;
  end;

  if (EvaluateOrder = eoInternalFirst) and Assigned(FOnEvaluate) then
    FOnEvaluate(Self, Eval, Args, High(Args) + 1, Value, Done)
  else
    Value := 0;
end;

procedure TExpression.Variable(Eval: string; var Value: Variant);
var
  Done: Boolean;
begin
  Done := False;
  if Assigned(FOnVariable) then
  begin
    FOnVariable(Self, Eval, Value, Done);
    if Done then
      Exit;
  end
  else
    Value := 0;
end;

function TExpression.GetValue: Double;
begin
  Compile;
  Result := FValue;
end;

procedure TExpression.SetFunctions(Value: TStringList);
begin
  FFunctions.Assign(Value);
end;

procedure TExpression.HSEvaluate(Sender: TObject; Eval: String;
  Args: array of Variant; ArgCount: Integer; var Value: Variant;
  var Done: Boolean);
var
  I: Integer;
begin
  Done := True;
  if UpperCase(Eval) = 'PI' then Value := Pi else
  if UpperCase(Eval) = 'ADD' then begin
    for I := 0 to ArgCount - 1 do
      Value := Value + Args[I];
  end else
  if UpperCase(Eval) = 'SIGN' then begin
      if ArgCount<>1 then
        Raise Exception.Create('SIGN数据所带的参数不正确');
      Value := Sign(Args[0]);
  end else
  if UpperCase(Eval) = 'IF' then begin
      if ArgCount<>3 then
        Raise Exception.Create('IF数据所带的参数不正确');
      if Args[0]>0 then
        Value := Args[1]
      else
        Value := Args[2];
  end else
  if UpperCase(Eval) = 'EQUAL' then begin
      if ArgCount<>2 then
        Raise Exception.Create('EQUAL数据所带的参数不正确');
      if VarSameValue(Args[0],Args[1]) then
        Value := 1
      else
        Value := 0;
  end else
  if UpperCase(Eval) = 'INCLUDE' then begin
      if ArgCount<>3 then
        Raise Exception.Create('INCLUDE数据所带的参数不正确');
      if (VarCompareValue(Args[0],Args[1]) In [vrGreaterThan,vrEqual])
           and
         (VarCompareValue(Args[0],Args[2]) In [vrLessThan,vrEqual])
      then
        Value := 1
      else
        Value := 0;
  end else
  if UpperCase(Eval) = 'DECODE' then begin
      if (ArgCount<3) OR ((ArgCount Mod 2)=0) then
        Raise Exception.Create('DECODE数据所带的参数不正确');
      for i:=1 to ArgCount-2 do
       begin
        if (i Mod 2) <> 0 then Continue;
        if VarSameValue(Args[0],Args[i]) then
           begin
             Value := Args[i+1];
             Break;
           end
        else
           Value := 0;
       end;
  end else              
  Done := False;
end;

procedure TExpression.SetDataSet(const Value: TDataSet);
begin
  FDataSet := Value;
end;

procedure TExpression.HSVariable(Sender: TObject; Variable: string;
  var Value: Variant; var Done: Boolean);
var Field:Integer;
begin
   if DataSet=nil Then
     begin
        Value := '1';
        Done := True;
        Exit;
     end;

   Field:=StrtoInt(Variable);

   if Field>=DataSet.FieldCount then
     Raise Exception.Create(Variable+'字段没找到，表达式错误');

   Done := True;
   Case DataSet.Fields[Field].DataType of
    ftSmallint, ftInteger, ftWord,ftFloat, ftCurrency, ftBCD:
       Value := DataSet.Fields[Field].asFloat;
    ftString,ftMemo,ftFmtMemo,ftWideString:Value := DataSet.Fields[Field].AsString;
    else
      Done := false;
   End;

end;

procedure TExpression.HSConst(Sender: TObject; Variable: string;
  var Value: Variant; var Done: Boolean);
begin
  Value := Variable;
  Done := True;
end;

procedure TExpression.VarConst(Eval: string; var Value: Variant);
var
  Done: Boolean;
begin
  Done := False;
  if Assigned(FOnConst) then
  begin
    FOnConst(Self, Eval, Value, Done);
    if Done then
      Exit;
  end
  else
    Value := 0;
end;

function TExpNode.VarConst: Variant;
var Done:Boolean;
begin
  Done := False;
  if FToken.TokenType = ttConst then
  begin

    if Assigned(FOnConst) then
      FOnConst(Self, FToken.Text, Result, Done);
    if FOwner is TExpression then
      TExpression(FOwner).VarConst(FToken.Text, Result);
  end;

end;

procedure TExpression.Prepare;
var
  Token: TExpToken;
begin
  if FParser<>nil then FParser.Free;
  FParser := TExpParser.Create;
  FParser.Expression := FText;
  Token := FParser.ReadFirstToken;
  while Token <> nil do
    Token := FParser.ReadNextToken;
  if FTree<> nil then FTree.Free;
  FTree := TExpNode.Create(Self, nil, FParser.TokenList);
  with FTree do
  begin
    Build;
  end;
end;

function TExpression.Result: Double;
begin
  if FTree= nil then
     Raise Exception.Create('表达式没用编绎不能执行此函数。');
  Result := 0;
  Result := FTree.Calculate;
end;

initialization

  HSExpression := TExpression.Create(nil);
finalization

  HSExpression.Free;

end.




