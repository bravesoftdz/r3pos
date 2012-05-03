unit ufrmMMToolBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ExtCtrls, RzPanel, ComCtrls,
  RzListVw, ImgList, ZDataSet, RzBmpBtn;

type
  PMMToolBox=^TMMToolBox;
  TMMToolBox=record
    Action:TAction;
    mid:string;
  end;

  TfrmMMToolBox = class(TfrmBasic)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    Image1: TImage;
    ImageList1: TImageList;
    RzList: TRzListView;
    toolClose: TRzBmpButton;
    procedure FormDeactivate(Sender: TObject);
    procedure RzListClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure toolCloseClick(Sender: TObject);
  private
    { Private declarations }
    procedure LoadModule(mid:string);
  public
    { Public declarations }
    procedure Clear;
    function Popup(Owner:TWinControl;mid:string):boolean;
  end;

implementation
uses ufrmMMMain,uShopGlobal,uRcFactory;
{$R *.dfm}

{ TfrmMMToolBox }

function TfrmMMToolBox.Popup(Owner:TWinControl;mid:string): boolean;
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
   HostP := HostControl.ClientToScreen(Point(HostControl.Width,-HostControl.Height - (Height - HostControl.Height) div 2));
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
var
  pData:PMMToolBox;
begin
  LoadModule(mid);
  AdjustDropDownForm(self,Owner);
  if rzList.Items.Count=0 then Raise Exception.Create('你没有操作此模块的权限...');
  if rzList.Items.Count = 1 then
     begin
       pData := PMMToolBox(rzList.Items[0].Data);
       pData.Action.OnExecute(TObject(pData));
     end
  else
     Show;
end;

procedure TfrmMMToolBox.FormDeactivate(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMMToolBox.LoadModule(mid:string);
var
  rs:TZQuery;
  ListItem:TListItem;
  lvid:string;
  Action:TAction;
  pData:PMMToolBox;
  bitmap:TBitMap;
begin
  Clear;
  rs := frmMMMain.CA_MODULE;
  if not rs.Locate('MODU_ID',mid,[]) then Exit;
  lvid := rs.FieldbyName('LEVEL_ID').AsString;
  rs.First;
  while not rs.Eof do
    begin
      if (copy(rs.FieldbyName('LEVEL_ID').AsString,1,length(lvid))=lvid)
         and
         (length(rs.FieldbyName('LEVEL_ID').AsString)>length(lvid))
      then
         begin
           Action := frmMMMain.FindAction(rs.FieldbyName('ACTION_NAME').AsString);
           if Assigned(Action) and Action.Enabled and ShopGlobal.GetChkRight(rs.FieldbyName('MODU_ID').AsString) then
              begin
                 ListItem := rzList.Items.Add;
                 ListItem.Caption := rs.FieldbyName('MODU_NAME').AsString;
                 bitmap := rcFactory.GetBitMap(rs.FieldbyName('MODU_NAME').AsString);
                 if bitmap <> nil then
                    begin
                      try
                        bitmap.Transparent := true;
                        ListItem.ImageIndex := ImageList1.Add(bitmap, nil);
                      except
                        ListItem.ImageIndex := 0;
                      end;
                      bitmap.Free;
                    end
                 else
                    ListItem.ImageIndex := 0;
                 new(pData);
                 pData^.Action := Action;
                 pData^.mid := rs.FieldbyName('MODU_ID').AsString;
                 ListItem.Data := pData;
              end;
         end;
      rs.Next;
    end;
  width := rzList.Items.Count*90+ 24;
  toolClose.left := RzPanel3.width - 17;
end;

procedure TfrmMMToolBox.RzListClick(Sender: TObject);
var
  pData:PMMToolBox;
begin
  inherited;
  close;
  if rzList.Selected<>nil then
     begin
       pData := PMMToolBox(rzList.Selected.Data);
       pData.Action.OnExecute(TObject(pData));
     end;
end;

procedure TfrmMMToolBox.Clear;
var
  i:integer;
begin
  for i:=0 to RzList.Items.Count -1 do
    begin
      Dispose(RzList.Items[i].Data);
    end;
  rzList.Items.Clear;

  for i:=2 to ImageList1.Count -1 do
    begin
      ImageList1.Delete(i);
    end;
end;

procedure TfrmMMToolBox.FormDestroy(Sender: TObject);
begin
  inherited;
  Clear;
end;

procedure TfrmMMToolBox.toolCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
