unit uTreeUtil;

interface
uses
  Windows, Messages, SysUtils,ComCtrls,RzTreeVw,DB,ObjBase,Classes;
Const
 MaxLevelTree=10;

//跟据父子关系建树
Procedure CreateParantTree(DataSet:TDataSet;ATree:TRzTreeView;
  KeyField:string=''; //关键字段  默认0号字段
  ListField:string=''; //显示字段  默认1号字段
  ParantField:String=''; //父级字段 默认2号字段
  ImageIndex:Integer=0;
  SelectIndex:Integer=0;
  SortField:string=''
  );overload;

//跟据LEVELID代码建树；要求DATASET中的记录必须按LEVEL字段排序。
Procedure CreateLevelTree(DataSet:TDataSet;ATree:TRzTreeView;
  ATreeFormat:String='333333333'; //指LEVELID的格式
  KeyField:string=''; //关键字段  默认0号字段
  ListField:string=''; //显示字段  默认1号字段
  LevelField:String=''; //LEVELID字段名 默认2号字段
  ImageIndex:Integer=0;
  SelectIndex:Integer=0;
  SortField:string='';
  RootNode:TTreeNode=nil
  );overload;
//清除树结点及其所指向的TObject对象
procedure ClearTree(ATree:TRzTreeView;RootNode:TTreeNode=nil);overload;

//跟据父子关系建树
Procedure CreateParantTree(DataSet:TDataSet;ATree:TRzCheckTree;
  KeyField:string=''; //关键字段  默认0号字段
  ListField:string=''; //显示字段  默认1号字段
  ParantField:String=''; //父级字段 默认2号字段
  ImageIndex:Integer=0;
  SelectIndex:Integer=0;
  SortField:string=''
  );overload;

//跟据LEVELID代码建树；要求DATASET中的记录必须按LEVEL字段排序。
Procedure CreateLevelTree(DataSet:TDataSet;ATree:TRzCheckTree;
  ATreeFormat:String='333333333'; //指LEVELID的格式
  KeyField:string=''; //关键字段  默认0号字段
  ListField:string=''; //显示字段  默认1号字段
  LevelField:String=''; //LEVELID字段名 默认2号字段
  ImageIndex:Integer=0;
  SelectIndex:Integer=0;
  SortField:string='';
  RootNode:TTreeNode=nil
  );overload;
//清除树结点及其所指向的TObject对象
procedure ClearTree(ATree:TRzCheckTree;RootNode:TTreeNode=nil);overload;
//清加根结点
procedure AddRoot(ATree:TRzTreeView;RootName:string);
type
TrzTreeCompare=class
  private
    FOrderNoField: string;
    procedure SetOrderNoField(const Value: string);
public
  constructor Create(SortField:String);

  procedure rzTreeCompare(Sender: TObject; Node1,
    Node2: TTreeNode; Data: Integer; var Compare: Integer);
  property OrderNoField:string read FOrderNoField write SetOrderNoField;
end;
implementation
procedure AddRoot(ATree:TRzTreeView;RootName:string);
var P,Root:TTreeNode;
begin
  Root := ATree.Items.Add(nil,RootName);
  P := Root.getPrevSibling;
  while P <> nil do
  begin
    P.MoveTo(Root, naAddChildFirst);
    P := Root.getPrevSibling;
  end;
  Root.Selected := true;
end;
//根据代码返加树结点级别;
Function GetNodeLevel(LevelID:String;ATreeFormat:String):Integer;
Var nLen,i:Integer;
    TmpLen:Integer;
Begin
 nLen := Length(LevelID);
 TmpLen:=0;
 For i:=1 to Length(ATreeFormat) Do
   Begin
     TmpLen:=TmpLen+StrtoInt(ATreeFormat[i]);
     if TmpLen>=nLen Then
       Begin
         Result := i;
         Exit;
       End;
   End;
 Result := 1;
End;

procedure ClearTree(ATree:TRzTreeView;RootNode:TTreeNode=nil);
var
  i:Integer;
  Node:TTreeNode;
begin
 if RootNode=nil then
 begin
   for i:=0 to ATree.Items.Count-1 do
     begin
     if (ATree.Items[I].Data <> Nil) then
        begin
          TObject(ATree.Items[I].Data).free;
          ATree.Items[I].Data := nil;
        end;
     end;
   ATree.Items.Clear;
 end
 else
 begin
   Node := RootNode.getFirstChild;
   while Node<>nil do
      begin
        ClearTree(ATree,Node);
        Node := RootNode.getFirstChild;
      end;
   TObject(RootNode.Data).free;
   RootNode.Data := nil;
   ATree.Items.Delete(RootNode); 
 end;
end;
procedure ClearTree(ATree:TRzCheckTree;RootNode:TTreeNode=nil);
var
  i:Integer;
  Node:TTreeNode;
begin
 if RootNode=nil then
 begin
   for i:=0 to ATree.Items.Count-1 do
     begin
     if (ATree.Items[I].Data <> Nil) then
        begin
          TObject(ATree.Items[I].Data).free;
          ATree.Items[I].Data := nil;
        end;
     end;
   ATree.Items.Clear;
 end
 else
 begin
   Node := RootNode.getFirstChild;
   while Node<>nil do
      begin
        ClearTree(ATree,Node);
        Node := RootNode.getFirstChild;
      end;
   TObject(RootNode.Data).free;
   RootNode.Data := nil;
   ATree.Items.Delete(RootNode); 
 end;
end;
Procedure CreateLevelTree(DataSet:TDataSet;ATree:TRzTreeView;
  ATreeFormat:String='333333333';
  KeyField:string='';ListField:string='';LevelField:String='';
  ImageIndex:Integer=0;
  SelectIndex:Integer=0;
  SortField:string='';
  RootNode:TTreeNode=nil
);

Var Node:Array[1..MaxLevelTree] Of TTreeNode;
    Level:Integer;
    AObj:TRecord_;
    ALevelField:Integer;
    Compare:TrzTreeCompare;
begin
 if KeyField<>'' then
    DataSet.FieldByName(KeyField).Index :=0;
 if ListField<>'' then
    DataSet.FieldByName(ListField).Index :=1;
 if (LevelField<>'') and (LevelField<>KeyField) then
    begin
      DataSet.FieldByName(LevelField).Index :=2;
      ALevelField := 2;
    end
    else
      ALevelField := 0;
 Level:=0;
 if RootNode<>nil then
    ClearTree(ATree);
 with ATree,DataSet Do
  begin
   First;
   while Not Eof Do
    begin
      AObj := TRecord_.Create(DataSet);
      AObj.ReadFromDataSet(DataSet);
      Level:=GetNodeLevel(Fields[ALevelField].asString,ATreeFormat);
      if Level>MaxLevelTree then
         Raise Exception.Create('级别溢出，树状最大级别支持10级。');
      if Level<=1 then
         Node[Level]:=Items.AddChildObject(RootNode,Trim(Fields[1].AsString),AObj) Else
      Node[Level]:=Items.AddChildObject(Node[Level-1],Trim(Fields[1].AsString),AObj);
      Node[Level].ImageIndex :=ImageIndex;
      Node[Level].SelectedIndex :=SelectIndex;
      Next;
    end;//End While
  end;
  if SortField<>'' then
     begin
        Compare:=TrzTreeCompare.Create(SortField);
        try
          ATree.OnCompare := Compare.rzTreeCompare;
          ATree.AlphaSort;
        finally
          Compare.Free;
        end;
    end;
end;

Procedure CreateLevelTree(DataSet:TDataSet;ATree:TRzCheckTree;
  ATreeFormat:String='333333333';
  KeyField:string='';ListField:string='';LevelField:String='';
  ImageIndex:Integer=0;
  SelectIndex:Integer=0;
  SortField:string='';
  RootNode:TTreeNode=nil
  );

Var Node:Array[1..MaxLevelTree] Of TTreeNode;
    Level:Integer;
    AObj:TRecord_;
    ALevelField:Integer;
    Compare:TrzTreeCompare;
begin
 if KeyField<>'' then
    DataSet.FieldByName(KeyField).Index :=0;
 if ListField<>'' then
    DataSet.FieldByName(ListField).Index :=1;
 if (LevelField<>'') and (LevelField<>KeyField) then
    begin
      DataSet.FieldByName(LevelField).Index :=2;
      ALevelField := 2;
    end
    else
      ALevelField := 0;

 Level:=0;
 if RootNode<>nil then
    ClearTree(ATree);
 with ATree,DataSet Do
  begin
   First;
   while Not Eof Do
    begin
      AObj := TRecord_.Create(DataSet);
      AObj.ReadFromDataSet(DataSet);
      Level:=GetNodeLevel(Fields[ALevelField].asString,ATreeFormat);
      if Level>MaxLevelTree then
         Raise Exception.Create('级别溢出，树状最大级别支持10级。');
      if Level<=1 then
      Node[Level]:=Items.AddChildObject(RootNode,Trim(Fields[1].AsString),AObj) Else
      Node[Level]:=Items.AddChildObject(Node[Level-1],Trim(Fields[1].AsString),AObj);
      Node[Level].ImageIndex :=ImageIndex;
      Node[Level].SelectedIndex :=SelectIndex;
      Next;
    end;//End While
  end;
  if SortField<>'' then
     begin
        Compare:=TrzTreeCompare.Create(SortField);
        try
          ATree.OnCompare := Compare.rzTreeCompare;
          ATree.AlphaSort;
        finally
          Compare.Free;
        end;
    end;
end;

Procedure CreateParantTree(DataSet:TDataSet;ATree:TRzCheckTree;
  KeyField:string=''; //关键字段  默认0号字段
  ListField:string=''; //显示字段  默认1号字段
  ParantField:String='';
  ImageIndex:Integer=0;
  SelectIndex:Integer=0;
  SortField:string=''
);//父级字段 默认2号字段
var AObj:TRecord_;
    i:integer;
    FList:TList;
    Node:TTreeNode;
  function CompareString(Item1, Item2: Pointer): Integer;
    var A1,A2,P1,P2:String;
    begin
      A1 := TRecord_(Item1).Fields[0].asString;
      A2 := TRecord_(Item2).Fields[0].asString;
      P1 := TRecord_(Item1).Fields[2].asString;
      P2 := TRecord_(Item2).Fields[2].asString;
      if (P1='') and (P2<>'') then
         Result := -1
      else
      if (P1<>'') and (P2='') then
         Result := 1
      else
      if A1=P2 then
         Result := -1
      else
      if A2=P1 then
         Result := 1
      else
      if A1>A2 then
         Result := 1
      else
      if A1<A2 then
         Result := -1
      else
         Result := 0;
    end;
  function  FindParantNode(ATree:TRzCheckTree;AKeyID:String):TTreeNode;
    var i:Integer;
    begin
      Result := nil;
      if AKeyID='' then Exit;
      for i:=0 to ATree.Items.Count -1 do
        begin
          if ATree.Items[i].Data=nil then Continue;
          if TRecord_(ATree.Items[i].Data).Fields[0].AsString=AKeyID then
             begin
                Result := ATree.Items[i];
                exit;
             end;
        end;
    end;
  function  HasParant(AKeyID:String):Boolean;
    begin
      if AKeyID='' then
         begin
            Result := False;
            Exit;
         end;
      result := DataSet.Locate(DataSet.Fields[0].FieldName,AKeyID,[]);
    end;
var tmpNode:TTreeNode;
    Compare:TrzTreeCompare;
begin
 if KeyField<>'' then
    DataSet.FieldByName(KeyField).Index :=0;
 if ListField<>'' then
    DataSet.FieldByName(ListField).Index :=1;
 if ParantField<>'' then
    DataSet.FieldByName(ParantField).Index :=2;
  ClearTree(ATree);
  FList := TList.Create;
  try
  DataSet.First;
  while not DataSet.Eof do
    begin
      AObj := TRecord_.Create(DataSet);
      AObj.ReadFromDataSet(DataSet);
      FList.Add(AObj);
      DataSet.Next;
    end;
 // FList.Sort(@CompareString);
  Node := nil;
    i := 0;
    while i<=(FList.Count -1) do
      begin
        if not((Node<>nil) and (TRecord_(Node.Data).Fields[0].AsString=TRecord_(FList.Items[i]).Fields[2].AsString)) then
           Node := FindParantNode(ATree,TRecord_(FList.Items[i]).Fields[2].AsString);
        if (Node=nil) and HasParant(TRecord_(FList.Items[i]).Fields[2].AsString) then
           begin
             FList.Add(FList.Items[i]);
             inc(i);
             Continue;
           end;
        tmpNode := ATree.Items.AddChildObject(Node,Trim(TRecord_(FList.Items[i]).Fields[1].AsString),FList.Items[i]);
        tmpNode.ImageIndex := ImageIndex;
        tmpNode.SelectedIndex := SelectIndex;
        inc(i);
      end;
  finally
    FList.Free;
  end;
  if SortField<>'' then
     begin
        Compare:=TrzTreeCompare.Create(SortField);
        try
          ATree.OnCompare := Compare.rzTreeCompare;
          ATree.AlphaSort;
        finally
          Compare.Free;
        end;
    end;
end;
Procedure CreateParantTree(DataSet:TDataSet;ATree:TRzTreeView;
  KeyField:string=''; //关键字段  默认0号字段
  ListField:string=''; //显示字段  默认1号字段
  ParantField:String='';
  ImageIndex:Integer=0;
  SelectIndex:Integer=0;
  SortField:string=''
);//父级字段 默认2号字段
var AObj:TRecord_;
    i:integer;
    FList:TList;
    Node:TTreeNode;
  function CompareString(Item1, Item2: Pointer): Integer;
    var A1,A2,P1,P2:String;
    begin
      A1 := TRecord_(Item1).Fields[0].asString;
      A2 := TRecord_(Item2).Fields[0].asString;
      P1 := TRecord_(Item1).Fields[2].asString;
      P2 := TRecord_(Item2).Fields[2].asString;
      if (P1='') and (P2<>'') then
         Result := -1
      else
      if (P1<>'') and (P2='') then
         Result := 1
      else
      if A1=P2 then
         Result := -1
      else
      if A2=P1 then
         Result := 1
      else
      if A1>A2 then
         Result := 1
      else
      if A1<A2 then
         Result := -1
      else
         Result := 0;
    end;
  function  FindParantNode(ATree:TRzTreeView;AKeyID:String):TTreeNode;
    var i:Integer;
    begin
      Result := nil;
      if AKeyID='' then Exit;

      for i:=0 to ATree.Items.Count -1 do
        begin
          if ATree.Items[i].Data=nil then Continue;
          if TRecord_(ATree.Items[i].Data).Fields[0].AsString=AKeyID then
             begin
                Result := ATree.Items[i];
                exit;
             end;
        end;
    end;
  function  HasParant(AKeyID:String):Boolean;
    begin
      if AKeyID='' then
         begin
            Result := False;
            Exit;
         end;
      result := DataSet.Locate(DataSet.Fields[0].FieldName,AKeyID,[]);
    end;
var tmpNode:TTreeNode;
    Compare:TrzTreeCompare;
begin
 if KeyField<>'' then
    DataSet.FieldByName(KeyField).Index :=0;
 if ListField<>'' then
    DataSet.FieldByName(ListField).Index :=1;
 if ParantField<>'' then
    DataSet.FieldByName(ParantField).Index :=2;
  ClearTree(ATree);
  FList := TList.Create;
  try
  DataSet.First;
  while not DataSet.Eof do
    begin
      AObj := TRecord_.Create(DataSet);
      AObj.ReadFromDataSet(DataSet);
      FList.Add(AObj);
      DataSet.Next;
    end;
  //FList.Sort(@CompareString);
  Node := nil;
    i := 0;
    while i<=(FList.Count -1) do
      begin
        if not((Node<>nil) and (TRecord_(Node.Data).Fields[0].AsString=TRecord_(FList.Items[i]).Fields[2].AsString)) then
           Node := FindParantNode(ATree,TRecord_(FList.Items[i]).Fields[2].AsString);
        if (Node=nil) and HasParant(TRecord_(FList.Items[i]).Fields[2].AsString) then
           begin
             FList.Add(FList.Items[i]);
             inc(i);
             Continue;
           end;
        tmpNode := ATree.Items.AddChildObject(Node,Trim(TRecord_(FList.Items[i]).Fields[1].AsString),FList.Items[i]);
        tmpNode.ImageIndex := ImageIndex;
        tmpNode.SelectedIndex := SelectIndex;
        inc(i);
      end;
  finally
    FList.Free;
  end;
  if SortField<>'' then
     begin
        Compare:=TrzTreeCompare.Create(SortField);
        try
          ATree.OnCompare := Compare.rzTreeCompare;
          ATree.AlphaSort;
        finally
          Compare.Free;
        end;
    end;
end;
{ TrzTreeCompare }

constructor TrzTreeCompare.Create(SortField: String);
begin
  inherited Create;
  OrderNoField := SortField;
end;

procedure TrzTreeCompare.rzTreeCompare(Sender: TObject; Node1,
  Node2: TTreeNode; Data: Integer; var Compare: Integer);
begin
 Compare := 0;
 case TRecord_(Node1.Data).FieldByName(FOrderNoField).DataType of
  ftString,ftFixedChar, ftWideString:
    begin
      if TRecord_(Node1.Data).FieldByName(FOrderNoField).AsString > TRecord_(Node2.Data).FieldByName(FOrderNoField).AsString then
         Compare := 1
      else
      if TRecord_(Node1.Data).FieldByName(FOrderNoField).AsString < TRecord_(Node2.Data).FieldByName(FOrderNoField).AsString then
         Compare := -1
      else
         Compare := 0
    end ;
  ftSmallint, ftInteger, ftWord,ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime,ftLargeint,ftAutoInc:
    begin
      if TRecord_(Node1.Data).FieldByName(FOrderNoField).asInteger > TRecord_(Node2.Data).FieldByName(FOrderNoField).asInteger then
         Compare := 1
      else
      if TRecord_(Node1.Data).FieldByName(FOrderNoField).asInteger < TRecord_(Node2.Data).FieldByName(FOrderNoField).asInteger then
         Compare := -1
      else
         Compare := 0
    end;
  else
    Raise Exception.Create('不支持的排序字段类型。'); 
 end;
end;

procedure TrzTreeCompare.SetOrderNoField(const Value: string);
begin
  FOrderNoField := Value;
end;

end.
