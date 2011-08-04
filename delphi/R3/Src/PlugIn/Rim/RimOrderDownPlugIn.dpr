{
  Create Date: 2011.04.11 Pm
  说明:
    1、插件ID: 是对于实现某个功能插件编号;
 }


library RimOrderDownPlugIn;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  DB,
  zDataSet,
  SysUtils,
  Variants,
  Classes,
  zBase,
  uBaseSyncFactory in '..\Pub\uBaseSyncFactory.pas',
  uRimSyncFactory in 'uRimSyncFactory.pas',
  uOrderDownFactory in 'uOrderDownFactory.pas';

{$R *.res}
       
//RSP装载插件时调用，传插件可访问的服务接口
function SetParams(PlugIn: IPlugIn):integer; stdcall;
begin
  GPlugIn := PlugIn;
end;

//插件中执行的所有操作都必须带 try except end 如果出错时，由此方法返回错信息
function GetLastError:Pchar; stdcall;
begin
  result := Pchar(GLastError);
end;

//返回当前插件说明
function GetPlugInDisplayName:Pchar; stdcall;
begin
  result := 'RSP下载RIM系统卷烟订货单';
end;

//返回RIM下载订单（到货确认）的插件
function GetPlugInId:Integer; stdcall;
begin
  result := 1002;
end;

//RSP调用插件时执行此方法
function DoExecute(Params:Pchar; var Data:oleVariant;dbResoler:integer):Integer; stdcall;
var
  OrderFactory: TOrderDownSyncFactory;
begin
  result:=-1;
  GLastError:='';
  try
    try
      OrderFactory:=TOrderDownSyncFactory.Create;
      OrderFactory.dbResoler := dbResoler;
      OrderFactory.CallSyncData(GPlugIn,StrPas(Params));
      if not  OrderFactory.HasError then
        result:=0
      else
        GLastError:=OrderFactory.ErrorMsg;
    finally
      OrderFactory.Free;
    end;
  except
    on E:Exception do
    begin
      if GLastError='' then
        GLastError := E.Message;
      result := 2001;
    end;
  end;
end;

//RSP调用插件自定义的管理界面,没有时直接返回0
function ShowPlugin:Integer; stdcall;
begin
  try
    //开始显示主界面窗体
    result := 0;
  except
    on E:Exception do
      begin
        GLastError := E.Message;
        result := 2002;
      end;
  end;
end;

exports
  SetParams,GetLastError,GetPlugInDisplayName,GetPlugInId,DoExecute,ShowPlugin;
begin

end.
