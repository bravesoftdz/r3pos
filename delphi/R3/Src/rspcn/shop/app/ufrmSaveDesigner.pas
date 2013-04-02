unit ufrmSaveDesigner;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzPanel, RzBmpBtn, RzForms, jpeg, ExtCtrls,
  Grids, RzGrids, FR_Class, IniFiles, ZDataSet, DB, StdCtrls, RzLabel;

type
  TfrmSaveDesigner = class(TfrmWebDialog)
    RzPanel2: TRzPanel;
    frfGrid: TRzStringGrid;
    RzLabel26: TRzLabel;
    RzPanel4: TRzPanel;
    btnOK: TRzBmpButton;
    btnCancel: TRzBmpButton;
    btnSave: TRzBmpButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure frfGridDblClick(Sender: TObject);
  private
    Flag:integer;
    SaveType:integer; //0:��Ϊģ�� 1:��Ϊ��ʽ
    FfrfFileName: string;
    MyfrReport:TfrReport;
    procedure SetfrfFileName(const Value: string);
  public
    procedure Load;
    property frfFileName:string read FfrfFileName write SetfrfFileName;
    class function ShowDialog(Owner:TForm;fname:string;frReport:TfrReport):integer;
    class function SaveDialog(Owner:TForm;fname:string;frReport:TfrReport):integer;
  end;

implementation

uses uTokenFactory,udataFactory,udllDsUtil;

{$R *.dfm}

class function TfrmSaveDesigner.ShowDialog(Owner:TForm;fname:string;frReport:TfrReport): integer;
begin
  with TfrmSaveDesigner.Create(Owner) do
    begin
      try
        Flag := 0;
        btnSave.Visible := false;
        RzLabel26.Caption := '��ʽѡ��';
        frfFileName := fname;
        MyfrReport := frReport;
        Load;
        if ShowModal=MROK then
           result := frfGrid.Selection.Top
        else
           result := -1;
      finally
        Free;
      end;
    end;
end;

class function TfrmSaveDesigner.SaveDialog(Owner:TForm;fname:string;frReport:TfrReport): integer;
begin
  with TfrmSaveDesigner.Create(Owner) do
    begin
      try
        Flag := 1;
        RzLabel26.Caption := '���������';
        frfFileName := fname;
        MyfrReport := frReport;
        btnSave.Visible := (frReport <> nil);
        Load;
        if ShowModal = MROK then
           if SaveType = 0 then
              result := -1
           else
              result := frfGrid.Selection.Top
        else
           result := -1;
      finally
        Free;
      end;
    end;
end;

procedure TfrmSaveDesigner.SetfrfFileName(const Value: string);
begin
  FfrfFileName := Value;
end;

procedure TfrmSaveDesigner.Load;
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'frf\frfFile.cfg');
  try
  frfGrid.Cells[0,0] := 'Ĭ�ϱ���';
  if not FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frfFileName+'1.frf') then
     frfGrid.Cells[0,1] := '�Զ���һ(����)'
  else
     frfGrid.Cells[0,1] := F.ReadString('s1_'+frfFileName,'name','�Զ���һ');
  if not FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frfFileName+'2.frf') then
     frfGrid.Cells[0,2] := '�Զ����(����)'
  else
     frfGrid.Cells[0,2] := F.ReadString('s2_'+frfFileName,'name','�Զ����');
  if not FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frfFileName+'3.frf') then
     frfGrid.Cells[0,3] := '�Զ�����(����)'
  else
     frfGrid.Cells[0,3] := F.ReadString('s3_'+frfFileName,'name','�Զ�����');
  if not FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frfFileName+'4.frf') then
     frfGrid.Cells[0,4] := '�Զ�����(����)'
  else
     frfGrid.Cells[0,4] := F.ReadString('s4_'+frfFileName,'name','�Զ�����');
  if not FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frfFileName+'5.frf') then
     frfGrid.Cells[0,5] := '�Զ�����(����)'
  else
     frfGrid.Cells[0,5] := F.ReadString('s5_'+frfFileName,'name','�Զ�����');
  finally
    F.Free;
  end;
end;

procedure TfrmSaveDesigner.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmSaveDesigner.btnOKClick(Sender: TObject);
var
  F:TIniFile;
  s:string;
begin
  if Flag = 1 then
  begin
    if frfGrid.Selection.Top > 1 then
       begin
         s := frfGrid.Cells[0,frfGrid.Selection.Top];
         if InputQuery('��ӡ����...','�����뵥�ݱ�������:',s) then
            begin
               frfGrid.Cells[0,frfGrid.Selection.Top] := s;
            end;
       end;
    F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'frf\frfFile.cfg');
    try
      if (pos('�Զ���',frfGrid.Cells[0,1])=0) then
         F.WriteString('s1_'+frfFileName,'name',frfGrid.Cells[0,1]);
      if (pos('�Զ���',frfGrid.Cells[0,2])=0) then
         F.WriteString('s2_'+frfFileName,'name',frfGrid.Cells[0,2]);
      if (pos('�Զ���',frfGrid.Cells[0,3])=0) then
         F.WriteString('s3_'+frfFileName,'name',frfGrid.Cells[0,3]);
      if (pos('�Զ���',frfGrid.Cells[0,4])=0) then
         F.WriteString('s4_'+frfFileName,'name',frfGrid.Cells[0,4]);
      if (pos('�Զ���',frfGrid.Cells[0,5])=0) then
         F.WriteString('s5_'+frfFileName,'name',frfGrid.Cells[0,5]);
    finally
      F.Free;
    end;
  end;
  SaveType := 1;
  ModalResult := MROK;
end;

procedure TfrmSaveDesigner.btnSaveClick(Sender: TObject);
var
  s:string;
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
     if InputQuery('ģ�����','������ģ�����ƣ�',s) then
     begin
       rs.Close;
       rs.SQL.Text := 'select * from SYS_FASTFILE where TENANT_ID='+token.tenantId+' and frfFileName like '''+frfFileName+'%'' and frfFileTitle='''+s+'''';
       dataFactory.MoveToRemote;
       try
         dataFactory.Open(rs);
       finally
         dataFactory.MoveToDefault;
       end;
       if rs.IsEmpty then
          begin
            rs.Append;
            rs.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
            dataFactory.MoveToRemote;
            try
              rs.FieldByName('frfFileName').AsString := TSequence.GetMaxID(frfFileName,'frfFileName','SYS_FASTFILE','0000','TENANT_ID='+token.tenantId);
            finally
              dataFactory.MoveToDefault;
            end;
          end
       else
          rs.Edit;
       rs.FieldByName('frfFileTitle').AsString := s;
       rs.FieldByName('frfDefault').AsInteger := 0;
       MyfrReport.SaveToBlobField(TBlobField(rs.FieldByName('frfBlob')));
       rs.Post;
       dataFactory.MoveToRemote;
       try
         dataFactory.UpdateBatch(rs,'TSysFastFileV60');
       finally
         dataFactory.MoveToDefault;
       end;
       MessageBox(Handle,'����ģ��ɹ�..','������ʾ..',MB_OK+MB_ICONINFORMATION);
     end;
  finally
    rs.Free;
  end;
  SaveType := 0;
  ModalResult := MROK;
end;

procedure TfrmSaveDesigner.frfGridDblClick(Sender: TObject);
begin
  inherited;
  btnOK.Click;
end;

end.
