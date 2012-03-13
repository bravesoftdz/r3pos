unit uUIFactory;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes,DB, Graphics, Controls, Forms,
  Dialogs,ZdbFactory,uGlobal, Menus, ActnList, cxControls, cxSpinEdit, RzSplit,RzTabs,
  cxContainer, cxEdit, cxTextEdit,ExtCtrls, cxMemo,DbGridEh,cxDropDownEdit,ZBase,FR_Class,
  ComCtrls,RzTreeVw, StdCtrls, RzButton, RzPanel, ShellApi, cxCalendar,DBGrids,cxCheckBox,
  cxMaskEdit,cxButtonEdit,zrComboBoxList,ZLogFile, RzBmpBtn,IniFiles,RzLabel;
type
  TUIFactory=class
  private
    F:TIniFile;
  public
    constructor Create;
    destructor Destroy; override;

    procedure InitForm(Form:TWinControl);
  end;
var
  UIFactory:TUIFactory;
implementation

{ TUIFactory }

constructor TUIFactory.Create;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'ui.cfg');
end;

destructor TUIFactory.Destroy;
begin
  F.Free;
  inherited;
end;

procedure TUIFactory.InitForm(Form:TWinControl);
var
  i,c:integer;
  Control:TControl;
begin
  for i:=0 to Form.ComponentCount -1 do
     begin
       if not F.SectionExists(Form.Name) then continue;
       if Form is TForm then TForm(Form).Caption := F.ReadString(Form.Name,'caption',TForm(Form).Caption); 
       if Form.Components[i] is TActionList then
          begin
            with TActionList(Form.Components[i]) do
               begin
                 for c:= ActionCount -1 downto 0 do
                 begin
                   TAction(Actions[c]).Visible := F.ReadBool(Form.Name,Name+'.'+Actions[c].Name+'_visible',TAction(Actions[c]).Visible);
                   TAction(Actions[c]).Caption := F.ReadString(Form.Name,Name+'.'+Actions[c].Name+'_caption',TAction(Actions[c]).Caption);
                 end;
               end;
            continue;
          end;
       if Form.Components[i] is TControl then
          begin
            Control := TControl(Form.Components[i]);
            Control.Top := F.ReadInteger(Form.Name,Control.Name+'_top',Control.Top);
            Control.Left := F.ReadInteger(Form.Name,Control.Name+'_left',Control.Left);
            Control.Height := F.ReadInteger(Form.Name,Control.Name+'_height',Control.Height);
            Control.Width := F.ReadInteger(Form.Name,Control.Name+'_width',Control.Width);
            Control.Visible := F.ReadBool(Form.Name,Control.Name+'_visible',Control.Visible);
          end
       else
          Continue;
       if Control is TDBGridEh then
          begin
            with TDBGridEh(Control) do
            begin
              Columns.BeginUpdate;
              try
                for c:= Columns.Count -1 downto 0 do
                begin
                  if not F.ReadBool(Form.Name,Control.Name+'.'+Columns[c].FieldName+'_visible',true) then
                     Columns.Delete(c)
                  else
                     Columns[c].Title.Caption := F.ReadString(Form.Name,Control.Name+'.'+Columns[c].FieldName+'_name',Columns[c].Title.Caption);
                end;
              finally
                Columns.EndUpdate;
              end;
            end;
          end;
       if Control is TLabel then
          begin
            TLabel(Control).Caption := F.ReadString(Form.Name,Control.Name+'_caption',TLabel(Control).Caption);
          end;
       if Control is TRzLabel then
          begin
            TRzLabel(Control).Caption := F.ReadString(Form.Name,Control.Name+'_caption',TRzLabel(Control).Caption);
          end;
       if Control is TRzPageControl then
          begin
            with TRzPageControl(Control) do
            begin
              for c:= PageCount -1 downto 0 do
              begin
                Pages[c].TabVisible := F.ReadBool(Form.Name,Control.Name+'.'+Pages[c].Name+'_tabVisible',true);
                Pages[c].Caption := F.ReadString(Form.Name,Control.Name+'.'+Pages[c].Name+'_caption',Pages[c].Caption);
              end;
            end;
          end;
     end;
end;

initialization
  UIFactory := TUIFactory.Create;
finalization
  UIFactory.Free;
end.
