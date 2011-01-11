unit uXDictFactory;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;
type
  TXDictFactory=class
  private
    // flag 类型说明
    // 1:消息框提示数据字黄
    // 2:界面Label数据字黄
    function GetString(Ident:string;flag:integer;Default:string):string;
  public
    function GetMsgString(Ident:string;Default:string):string;
    function GetMsgStringFmt(Ident:string;Default:string;Args: array of const):string;
    function GetResString(Ident:string;version:integer;Default:string):string;
    //装载数据字典
    procedure LoadRes;
  end;
var
  XDictFactory:TXDictFactory;
implementation

{ TXDictFactory }

function TXDictFactory.GetMsgString(Ident: string;Default:string): string;
begin
  result := GetString(Ident,1,Default);
end;

function TXDictFactory.GetMsgStringFmt(Ident, Default: string;
  Args: array of const): string;
begin
  result := format(GetMsgString(Ident,Default),Args);
end;

function TXDictFactory.GetResString(Ident: string; version: integer;
  Default:string): string;
begin
  if Ident='PROPERTY_01' then
     begin
       case version of
       1:result := '尺码';
       2:result := '规格';
       3:result := '规格';
       4:result := '规格';
       end;
     end
  else
     result := Default;
end;

function TXDictFactory.GetString(Ident: string; flag: integer ;Default:string): string;
begin
  result := Default;
end;

procedure TXDictFactory.LoadRes;
begin

end;

initialization
  XDictFactory := TXDictFactory.Create;
finalization
  XDictFactory.Free;
end.
