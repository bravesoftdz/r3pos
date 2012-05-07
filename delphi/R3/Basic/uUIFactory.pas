unit uUIFactory;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes,DB, Graphics, Controls, Forms,
  Dialogs,ZdbFactory,uGlobal, Menus, ActnList, cxControls, cxSpinEdit, RzSplit,RzTabs,
  cxContainer, cxEdit, cxTextEdit,ExtCtrls, cxMemo,DbGridEh,cxDropDownEdit,ZBase,FR_Class,
  ComCtrls,RzTreeVw, StdCtrls, RzButton, RzPanel, ShellApi, cxCalendar,DBGrids,cxCheckBox,
  cxMaskEdit,cxButtonEdit,zrComboBoxList,ZLogFile, RzBmpBtn,IniFiles,RzLabel,RzStatus,RzGrids;
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
  i,c,d:integer;
  Control:TControl;
begin
  for i:=0 to Form.ComponentCount -1 do
     begin
       if not F.SectionExists(Form.Name) then continue;

       if Form is TForm then
          begin
            TForm(Form).Caption := F.ReadString(Form.Name,'caption',TForm(Form).Caption);
            if F.ReadString(Form.Name,'color','') <> ''  then
              TForm(Form).Color := TColor(F.ReadInteger(Form.Name,'color', 0));
          end;
          
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
            Control.Enabled := F.ReadBool(Form.Name,Control.Name+'_enabled',Control.Enabled);
          end
       else
          Continue;

       if Control is TDBGridEh then
          begin
            with TDBGridEh(Control) do
            begin
              if F.ReadString(Form.Name,Control.Name+'_color','') <> '' then
                Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_color', 0));

              if F.ReadString(Form.Name,Control.Name+'_fixedcolor','') <> '' then
                FixedColor := TColor(F.ReadInteger(Form.Name,Control.Name+'_fixedcolor', 0));
              if F.ReadString(Form.Name,Control.Name+'_titlefontcolor','') <> '' then
                TitleFont.Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_titlefontcolor', 0));

              if F.ReadString(Form.Name,Control.Name+'_footercolor','') <> '' then
                FooterColor := TColor(F.ReadInteger(Form.Name,Control.Name+'_footercolor', 0));
              if F.ReadString(Form.Name,Control.Name+'_footerfontcolor','') <> '' then
                FooterFont.Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_footerfontcolor', 0));

              Columns.BeginUpdate;
              try
                for c:= Columns.Count -1 downto 0 do
                begin
                  if F.ReadString(Form.Name,Control.Name+'.'+Columns[c].FieldName+'_color','') <> '' then
                     Columns[c].Color := TColor(F.ReadInteger(Form.Name,Control.Name+'.'+Columns[c].FieldName+'_color', 0));
                  if F.ReadString(Form.Name,Control.Name+'.'+Columns[c].FieldName+'_titlecolor','') <> '' then
                     Columns[c].Title.Color := TColor(F.ReadInteger(Form.Name,Control.Name+'.'+Columns[c].FieldName+'_titlecolor', 0));
                  if F.ReadString(Form.Name,Control.Name+'.'+Columns[c].FieldName+'_fontcolor','') <> '' then
                     Columns[c].Font.Color := TColor(F.ReadInteger(Form.Name,Control.Name+'.'+Columns[c].FieldName+'_fontcolor', 0));

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

       if Control is TPanel then
          begin
            if F.ReadString(Form.Name,Control.Name+'_color','') <> '' then
              TPanel(Control).Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_color', 0));
            if F.ReadString(Form.Name,Control.Name+'_fontcolor','') <> '' then
              TPanel(Control).Font.Color:= TColor(F.ReadInteger(Form.Name,Control.Name+'_fontcolor', 0));
          end;

       if Control is TLabel then
          begin
            TLabel(Control).Caption := F.ReadString(Form.Name,Control.Name+'_caption',TLabel(Control).Caption);
            if F.ReadString(Form.Name,Control.Name+'_color','') <> '' then
              TLabel(Control).Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_color', 0));
            if F.ReadString(Form.Name,Control.Name+'_fontcolor','') <> '' then
              TLabel(Control).Font.Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_fontcolor', 0));
          end;

       if Control is TGroupBox then
          begin
            if F.ReadString(Form.Name,Control.Name+'_color','') <> '' then
              TGroupBox(Control).Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_color', 0));
            if F.ReadString(Form.Name,Control.Name+'_fontcolor','') <> '' then
              TGroupBox(Control).Font.Color:= TColor(F.ReadInteger(Form.Name,Control.Name+'_fontcolor', 0));
          end;

       if Control is TRzLabel then
          begin
            TRzLabel(Control).Caption := F.ReadString(Form.Name,Control.Name+'_caption',TRzLabel(Control).Caption);
            if F.ReadString(Form.Name,Control.Name+'_color','') <> '' then
              TRzLabel(Control).Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_color', 0));
            if F.ReadString(Form.Name,Control.Name+'_fontcolor','') <> '' then
              TRzLabel(Control).Font.Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_fontcolor', 0));
          end;

       if Control is TRzPageControl then
          begin
            with TRzPageControl(Control) do
            begin
              for c:= PageCount -1 downto 0 do
              begin
                Pages[c].TabVisible := F.ReadBool(Form.Name,Control.Name+'.'+Pages[c].Name+'_tabVisible',true);
                Pages[c].Caption := F.ReadString(Form.Name,Control.Name+'.'+Pages[c].Name+'_caption',Pages[c].Caption);

                if F.ReadString(Form.Name,Control.Name+'.'+Pages[c].Name+'_color','') <> '' then
                  Pages[c].Color := TColor(F.ReadInteger(Form.Name,Control.Name+'.'+Pages[c].Name+'_color', 0));
                if F.ReadString(Form.Name,Control.Name+'.'+Pages[c].Name+'_fontcolor','') <> '' then
                  Pages[c].Font.Color := TColor(F.ReadInteger(Form.Name,Control.Name+'.'+Pages[c].Name+'_fontcolor', 0));
              end;
            end;
          end;

       if Control is TRzGroupBox then
          begin
            if F.ReadString(Form.Name,Control.Name+'_color','') <> '' then
              TRzGroupBox(Control).Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_color', 0));
            if F.ReadString(Form.Name,Control.Name+'_fontcolor','') <> '' then
              TRzGroupBox(Control).Font.Color:= TColor(F.ReadInteger(Form.Name,Control.Name+'_fontcolor', 0));
          end;

       if Control is TRzPanel then
          begin
            if F.ReadString(Form.Name,Control.Name+'_color','') <> '' then
              TRzPanel(Control).Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_color', 0));
            if F.ReadString(Form.Name,Control.Name+'_fontcolor','') <> '' then
              TRzPanel(Control).Font.Color:= TColor(F.ReadInteger(Form.Name,Control.Name+'_fontcolor', 0));
            if F.ReadString(Form.Name,Control.Name+'_bordercolor','') <> '' then
              TRzPanel(Control).BorderColor:= TColor(F.ReadInteger(Form.Name,Control.Name+'_bordercolor', 0));
          end;

       if Control is TRzStatusPane then
          begin
            if F.ReadString(Form.Name,Control.Name+'_color','') <> '' then
              TRzStatusPane(Control).Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_color', 0));
            if F.ReadString(Form.Name,Control.Name+'_fontcolor','') <> '' then
              TRzStatusPane(Control).Font.Color:= TColor(F.ReadInteger(Form.Name,Control.Name+'_fontcolor', 0));
          end;

       if Control is TRzClockStatus then
          begin
            if F.ReadString(Form.Name,Control.Name+'_color','') <> '' then
              TRzClockStatus(Control).Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_color', 0));
            if F.ReadString(Form.Name,Control.Name+'_fontcolor','') <> '' then
              TRzClockStatus(Control).Font.Color:= TColor(F.ReadInteger(Form.Name,Control.Name+'_fontcolor', 0));
          end;

       if Control is TcxTextEdit then
          begin
            if F.ReadString(Form.Name,Control.Name+'_color','') <> '' then
              TcxTextEdit(Control).Style.Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_color', 0));
            if F.ReadString(Form.Name,Control.Name+'_fontcolor','') <> '' then
              TcxTextEdit(Control).Style.Font.Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_fontcolor', 0));
          end;

       if Control is TRzStringGrid then
          begin
            if F.ReadString(Form.Name,Control.Name+'_color','') <> '' then
              TRzStringGrid(Control).Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_color', 0));
            if F.ReadString(Form.Name,Control.Name+'_fontcolor','') <> '' then
              TRzStringGrid(Control).Font.Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_fontcolor', 0));
          end;

       if Control is TCheckBox then
          begin
            if F.ReadString(Form.Name,Control.Name+'_color','') <> '' then
              TCheckBox(Control).Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_color', 0));
            if F.ReadString(Form.Name,Control.Name+'_fontcolor','') <> '' then
              TCheckBox(Control).Font.Color := TColor(F.ReadInteger(Form.Name,Control.Name+'_fontcolor', 0));
          end;
     end;
end;

initialization
  UIFactory := TUIFactory.Create;
finalization
  UIFactory.Free;
end.
