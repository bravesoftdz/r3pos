unit ufrmMMList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMMBasic, ImgList, RzTray, Menus, ExtCtrls, RzForms,ZBase,
  RzBckgnd, RzPanel, RzBmpBtn, StdCtrls, uMMUtil, uMMServer ,ShellApi,
  RzButton, ummFactory, RzGroupBar, RzTabs, ComCtrls, RzTreeVw, ZDataSet;
type
  TfrmMMList = class(TfrmMMBasic)
    FlagImage: TImageList;
    PopupMenu1: TPopupMenu;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    RzPanel6: TRzPanel;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    rzUsers: TRzTreeView;
    StateImage: TImageList;
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
uses ufrmMMMain,ummGlobal,uTreeUtil;

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
  g,b:TTreeNode;
  i:integer;
  rs:TZQuery;
  us:TZQuery;
  Params:TftParamList;
begin
  ClearTree(rzUsers);
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
         g := rzUsers.Items.Add(nil,rs.FieldbyName('I_SHOW_NAME').AsString);
         g.StateIndex := 0;
         us.Filtered := false;
         us.Filter := 'S_GROUP_ID='''+rs.FieldbyName('S_GROUP_ID').AsString+'''';
         us.Filtered := true;
         us.First;
         while not us.Eof do
           begin
             b := rzUsers.Items.AddChild(g,rs.FieldbyName('U_SHOW_NAME').AsString);
             b.ImageIndex := 1;
             us.Next;
           end;
         rs.Next;
      end;
  finally
    Params.Free;
    us.Free;
    rs.Free;
  end;    
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
