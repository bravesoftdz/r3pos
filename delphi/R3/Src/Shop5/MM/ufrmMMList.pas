unit ufrmMMList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMMBasic, ImgList, RzTray, Menus, ExtCtrls, RzForms,ZBase,
  RzBckgnd, RzPanel, RzBmpBtn, StdCtrls, uMMUtil, uMMServer ,ShellApi,
  RzButton, ummFactory, RzGroupBar, RzTabs, ComCtrls, RzTreeVw, ZDataSet;
type
  TfrmMMList = class(TfrmMMBasic)
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    RzPanel6: TRzPanel;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    RzTreeView1: TRzTreeView;
    procedure FormCreate(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure RzButton2Click(Sender: TObject);
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure RzGroup1Items1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadFriends;
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  frmMMList: TfrmMMList;
implementation
{$R *.dfm}
uses ufrmMMMain,ummGlobal;

{ TfrmMMList }


procedure TfrmMMList.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      if not (csDesigning in frmMMMain.ComponentState) then
         WndParent:=frmMMMain.Handle; //关键一行，用SetParent都不行！！
    end;
end;

procedure TfrmMMList.FormCreate(Sender: TObject);
begin
  inherited;
  left := Screen.Width-width-1;
  top := (Screen.Height - Height) div 2 -1;
end;

procedure TfrmMMList.LoadFriends;
var
  g:TrzGroup;
  b:TrzGroupItem;
  i:integer;
  rs:TZQuery;
  us:TZQuery;
  Params:TftParamList;
begin
{  for i:=treeUsers.GroupCount -1 downto 0 do
    begin
      treeUsers.RemoveGroup(treeUsers.Groups[i]);
    end;
  rs := TZQuery.Create(nil);
  us := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    Params.ParambyName('TENANT_ID').asInteger := mmGlobal.TENANT_ID;
    mmGlobal.LocalFactory.Open(rs,'TmqqGrouping',Params);
    mmGlobal.LocalFactory.Open(us,'TmqqFriends',Params);
    rs.first;
    while not rs.eof do
      begin
         g := TrzGroup.Create(treeUsers);
         g.Caption := rs.FieldbyName('I_SHOW_NAME').AsString;
         g.CaptionColor := clWhite;
         g.Color := clWhite;
         g.DividerVisible := false;
         g.CaptionImageIndex := 0;
         treeUsers.AddGroup(g);
         us.Filtered := false;
         us.Filter := 'S_GROUP_ID='''+rs.FieldbyName('S_GROUP_ID').AsString+'''';
         us.Filtered := true;
         us.First;
         while not us.Eof do
           begin
             b := g.Items.Add;
             b.OnClick := nil;
             b.ImageIndex := 1;
             b.Caption := us.FieldbyName('U_SHOW_NAME').AsString;
             b.Data := nil;
             us.Next;
           end;
         rs.Next;
      end;
  finally
    Params.Free;
    us.Free;
    rs.Free;
  end;     }
end;

procedure TfrmMMList.RzButton1Click(Sender: TObject);
begin
  inherited;
  frmMMMain.WindowState := wsMaximized;
  frmMMMain.Show;
end;

procedure TfrmMMList.RzButton2Click(Sender: TObject);
begin
  inherited;
  mmFactory.ConnectTo;
end;

procedure TfrmMMList.RzGroup1Items0Click(Sender: TObject);
begin
//  inherited;

end;

procedure TfrmMMList.RzGroup1Items1Click(Sender: TObject);
begin
//  inherited;

end;

end.
