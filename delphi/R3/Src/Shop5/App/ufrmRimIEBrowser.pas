unit ufrmRimIEBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmIEWebForm, ImgList, ActnList, Menus, RzTabs, OleCtrls,
  SHDocVw, ExtCtrls, RzPanel;

type
  TfrmRimIEBrowser = class(TfrmIEWebForm)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ReadParam;
    function EncodeChk:string;

    function OpenUrl(url:string):boolean;
  end;
var
  Rim_Url:string;
  Rim_ComId:string;
  Rim_CustId:string;
implementation
uses IniFiles;
{$R *.dfm}

{ TfrmRimIEBrowser }

function TfrmRimIEBrowser.EncodeChk: string;
begin
  result := 'comId='+Rim_ComId+'&custId='+Rim_CustId;
end;

function TfrmRimIEBrowser.OpenUrl(url: string):boolean;
var p:string;
begin
  FormStyle := fsMDIChild;
  WindowState := wsMaximized;
  BringToFront;
  ReadParam;
  if pos('?',url)=0 then p := '?' else p := '&';
  result := inherited Open(Rim_Url+url+p+EncodeChk);
end;

procedure TfrmRimIEBrowser.ReadParam;
var
  F:TIniFile;
  List:TStringList;
begin
  if Rim_ComId<>'' then Exit;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  List := TStringList.Create;
  try
    Rim_Url := f.ReadString('H_'+f.ReadString('db','srvrId','default'),'srvrPath','');
    if Rim_Url='' then Rim_Url := 'http://220.173.61.110:9080/rimweb/'
       else
       begin
         List.CommaText := Rim_Url;
         Rim_Url := List.Values['rim'];
         if Rim_Url<>'' then
           begin
             if Rim_Url[Length(Rim_Url)]<>'/' then Rim_Url := Rim_Url+'/';
           end;
       end;
  finally
    List.free;
    F.Free;
  end;
  Rim_ComId := 'LZ0000000000001';
  Rim_CustId := 'GX00000004392';
end;

end.
