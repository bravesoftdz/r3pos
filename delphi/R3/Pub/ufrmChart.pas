unit ufrmChart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ComCtrls, ToolWin, ImgList,
  TeeProcs, TeEngine, Chart, ExtCtrls;

type
  TfrmChart = class(TfrmBasic)
    F1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    E1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    F2: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    H1: TMenuItem;
    N13: TMenuItem;
    CoolBar1: TCoolBar;
    ToolBar2: TToolBar;
    ToolButton3: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton16: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton13: TToolButton;
    ToolButton9: TToolButton;
    ToolButton12: TToolButton;
    Image: TImageList;
    Panel1: TPanel;
    Chart1: TChart;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChart: TfrmChart;

implementation

{$R *.dfm}

end.
