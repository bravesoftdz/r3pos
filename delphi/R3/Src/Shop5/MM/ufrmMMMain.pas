unit ufrmMMMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMMBasic, ImgList, RzTray, Menus, ExtCtrls, RzForms,
  RzBckgnd, RzPanel;

type
  TfrmMMMain = class(TfrmMMBasic)
    RzTrayIcon1: TRzTrayIcon;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMMMain: TfrmMMMain;

implementation

{$R *.dfm}

end.
