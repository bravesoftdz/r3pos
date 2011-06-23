unit udmR3Icon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, udmIcon, ImgList;

type
  TdmR3Icon = class(TdmIcon)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetResBitbmp(id:string):TBitmap;
  end;

var
  dmR3Icon: TdmR3Icon;

implementation

{$R *.dfm}

{ TdmR3Icon }

function TdmR3Icon.GetResBitbmp(id: string): TBitmap;
begin
  result := TBitmap.Create;
  HsResOpr.GetDllBmpRes(result,id,ExtractFilePath(ParamStr(0))+'Pic32.dll');
end;

procedure TdmR3Icon.DataModuleCreate(Sender: TObject);
begin
  inherited;
  dmIcon := dmR3Icon;
end;

end.
