unit ufrmMMFindBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ExtCtrls, RzPanel, ComCtrls,
  RzListVw, ImgList, ZDataSet, RzBmpBtn, RzTreeVw;

type
  PMMToolBox=^TMMToolBox;
  TMMToolBox=record
    Action:TAction;
    mid:string;
  end;

  TfrmMMFindBox = class(TfrmBasic)
    RzPanel2: TRzPanel;
    ImageList1: TImageList;
    rzList: TRzTreeView;
    procedure FormDeactivate(Sender: TObject);
    procedure RzListClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FLocked: boolean;
    { Private declarations }
    procedure LoadFilter(filterText:string);
    procedure SetLocked(const Value: boolean);
  public
    { Public declarations }
    procedure Clear;
    function Popup(Owner:TWinControl;filterText:string):boolean;
    property Locked:boolean read FLocked write SetLocked;
  end;

implementation
uses ufrmMMList, ufrmMMMain, ummFactory;
{$R *.dfm}

{ TfrmMMToolBox }

function TfrmMMFindBox.Popup(Owner:TWinControl;filterText:string): boolean;
procedure AdjustDropDownForm(AControl : TControl; HostControl: TControl);
var
   WorkArea: TRect;
   HostP, PDelpta: TPoint;
begin                          //设置下拉窗口位置。
{$IFDEF CIL}
   SystemParametersInfo(SPI_GETWORKAREA,0,WorkArea,0);
{$ELSE}
   SystemParametersInfo(SPI_GETWORKAREA,0,@WorkArea,0);
{$ENDIF}
   HostP := HostControl.ClientToScreen(Point(-3,-3));
   PDelpta := AControl.ClientToScreen(Point(0,0));
   if AControl.Left<> HostP.x+1 then
      AControl.Left := HostP.x+1;
   if AControl.Top<> HostP.y + HostControl.Height then
      AControl.Top := HostP.y + HostControl.Height;
   if (AControl.Width > WorkArea.Right - WorkArea.Left) then
     if (AControl.Width <> (WorkArea.Right - WorkArea.Left)) then
        AControl.Width := WorkArea.Right - WorkArea.Left;
   if (AControl.Left + AControl.Width > WorkArea.Right) then
     if (AControl.Left <> (WorkArea.Right - AControl.Width)) then
        AControl.Left := WorkArea.Right - AControl.Width;
   if (AControl.Left < WorkArea.Left) then
     if (AControl.Left <> WorkArea.Left) then
        AControl.Left := WorkArea.Left;
   if (AControl.Top + AControl.Height > WorkArea.Bottom) then
   begin
     if (HostP.y - WorkArea.Top > WorkArea.Bottom - HostP.y - HostControl.Height)  then
       if AControl.Top <> (HostP.y - AControl.Height) then
          AControl.Top := HostP.y - AControl.Height;
   end;
   if (AControl.Top < WorkArea.Top) then
   begin
     if AControl.Height <> (AControl.Height - (WorkArea.Top - AControl.Top)) then
        AControl.Height := AControl.Height - (WorkArea.Top - AControl.Top);
     if AControl.Top <> WorkArea.Top then
        AControl.Top := WorkArea.Top;
   end;
   if (AControl.Top + AControl.Height > WorkArea.Bottom) then
   begin
     if AControl.Height <> (WorkArea.Bottom - AControl.Top) then
        AControl.Height := WorkArea.Bottom - AControl.Top;
   end;

end;
begin
  width := Owner.Width;
  Loadfilter(filterText);
  AdjustDropDownForm(self,Owner);
  Show;
end;

procedure TfrmMMFindBox.FormDeactivate(Sender: TObject);
begin
  inherited;
  if not Locked then Close;
end;

procedure TfrmMMFindBox.Loadfilter(filterText:string);
var
  i:integer;
  mmUserInfo:PmmUserInfo;
  TreeNode:TTreeNode;
begin
  Clear;
  for i:=frmMMList.rzUsers.Items.Count -1 downto 0 do
    begin
      if frmMMList.rzUsers.Items[i].Data=nil then continue;
      mmUserInfo := PmmUserInfo(frmMMList.rzUsers.Items[i].Data);
      if (pos(filterText,mmUserInfo^.uid)>0)
         or
         (pos(filterText,mmUserInfo^.PlayerFava.nickName)>0)
      then
         begin
           TreeNode := rzList.Items.Add(nil,frmMMList.rzUsers.Items[i].Text);
           TreeNode.ImageIndex := frmMMList.rzUsers.Items[i].ImageIndex;
           TreeNode.SelectedIndex := frmMMList.rzUsers.Items[i].SelectedIndex;
           TreeNode.Data := frmMMList.rzUsers.Items[i].Data;
         end;
    end;
end;

procedure TfrmMMFindBox.RzListClick(Sender: TObject);
begin
  inherited;
  close;
  if rzList.Selected<>nil then
     begin
       frmMMList.OpenDialog(PmmUserInfo(rzList.Selected.Data)^.uid)
     end;
end;

procedure TfrmMMFindBox.Clear;
begin
  rzList.Items.Clear;
end;

procedure TfrmMMFindBox.FormDestroy(Sender: TObject);
begin
  inherited;
  Clear;
end;

procedure TfrmMMFindBox.SetLocked(const Value: boolean);
begin
  FLocked := Value;
end;

end.
