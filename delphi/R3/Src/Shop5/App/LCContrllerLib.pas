unit LCContrllerLib;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 2011/6/21 21:23:43 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Windows\system32\LCContrller.dll (1)
// LIBID: {C793E85D-7033-4E8A-8160-3E1C2CBC6F65}
// LCID: 0
// Helpfile: 
// HelpString: LCContrller 1.0 ¿‡–Õø‚
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  LCContrllerLibMajorVersion = 1;
  LCContrllerLibMinorVersion = 0;

  LIBID_LCContrllerLib: TGUID = '{C793E85D-7033-4E8A-8160-3E1C2CBC6F65}';

  DIID__ILCObjectEvents: TGUID = '{4B66A8CA-57F6-415E-9FD1-4877C7C3F070}';
  IID_ILCObject: TGUID = '{024DB0C4-25F6-445E-B761-504A9CC5F7D5}';
  CLASS_LCObject: TGUID = '{08120055-CD5F-41A5-B80A-6AC7DD4F4BC2}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _ILCObjectEvents = dispinterface;
  ILCObject = interface;
  ILCObjectDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  LCObject = ILCObject;


// *********************************************************************//
// DispIntf:  _ILCObjectEvents
// Flags:     (4096) Dispatchable
// GUID:      {4B66A8CA-57F6-415E-9FD1-4877C7C3F070}
// *********************************************************************//
  _ILCObjectEvents = dispinterface
    ['{4B66A8CA-57F6-415E-9FD1-4877C7C3F070}']
    procedure FuncCall(const szMethodName: WideString; const szPara: WideString); dispid 1;
    procedure FuncCall2(const szMethodName: WideString; const szPara1: WideString; 
                        const szPara2: WideString); dispid 2;
    procedure FuncCall3(const szMethodName: WideString; const szPara1: WideString; 
                        const szPara2: WideString; const szPara3: WideString); dispid 3;
    procedure ErrorHappened(errCode: LongWord); dispid 4;
  end;

// *********************************************************************//
// Interface: ILCObject
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {024DB0C4-25F6-445E-B761-504A9CC5F7D5}
// *********************************************************************//
  ILCObject = interface(IDispatch)
    ['{024DB0C4-25F6-445E-B761-504A9CC5F7D5}']
    function Connect(const szLocConnName: WideString): LongWord; safecall;
    procedure Close; safecall;
    function Send(const szLocConnName: WideString; const szMethodName: WideString; 
                  const szPara: WideString): LongWord; safecall;
    function Send2(const bstrLocConnName: WideString; const bstrMethodName: WideString; 
                   const bstrPara1: WideString; const bstrPara2: WideString): LongWord; safecall;
    function Send3(const bstrLocConnName: WideString; const bstrMethodName: WideString; 
                   const bstrPara1: WideString; const bstrPara2: WideString; 
                   const bstrPara3: WideString): LongWord; safecall;
    procedure Test1(saParas: PSafeArray); safecall;
  end;

// *********************************************************************//
// DispIntf:  ILCObjectDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {024DB0C4-25F6-445E-B761-504A9CC5F7D5}
// *********************************************************************//
  ILCObjectDisp = dispinterface
    ['{024DB0C4-25F6-445E-B761-504A9CC5F7D5}']
    function Connect(const szLocConnName: WideString): LongWord; dispid 1;
    procedure Close; dispid 2;
    function Send(const szLocConnName: WideString; const szMethodName: WideString; 
                  const szPara: WideString): LongWord; dispid 3;
    function Send2(const bstrLocConnName: WideString; const bstrMethodName: WideString; 
                   const bstrPara1: WideString; const bstrPara2: WideString): LongWord; dispid 4;
    function Send3(const bstrLocConnName: WideString; const bstrMethodName: WideString; 
                   const bstrPara1: WideString; const bstrPara2: WideString; 
                   const bstrPara3: WideString): LongWord; dispid 5;
    procedure Test1(saParas: {??PSafeArray}OleVariant); dispid 6;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TLCObject
// Help String      : LCObject Class
// Default Interface: ILCObject
// Def. Intf. DISP? : No
// Event   Interface: _ILCObjectEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TLCObjectFuncCall = procedure(ASender: TObject; const szMethodName: WideString; 
                                                  const szPara: WideString) of object;
  TLCObjectFuncCall2 = procedure(ASender: TObject; const szMethodName: WideString; 
                                                   const szPara1: WideString; 
                                                   const szPara2: WideString) of object;
  TLCObjectFuncCall3 = procedure(ASender: TObject; const szMethodName: WideString; 
                                                   const szPara1: WideString; 
                                                   const szPara2: WideString; 
                                                   const szPara3: WideString) of object;
  TLCObjectErrorHappened = procedure(ASender: TObject; errCode: LongWord) of object;

  TLCObject = class(TOleControl)
  private
    FOnFuncCall: TLCObjectFuncCall;
    FOnFuncCall2: TLCObjectFuncCall2;
    FOnFuncCall3: TLCObjectFuncCall3;
    FOnErrorHappened: TLCObjectErrorHappened;
    FIntf: ILCObject;
    function  GetControlInterface: ILCObject;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function Connect(const szLocConnName: WideString): LongWord;
    procedure Close;
    function Send(const szLocConnName: WideString; const szMethodName: WideString; 
                  const szPara: WideString): LongWord;
    function Send2(const bstrLocConnName: WideString; const bstrMethodName: WideString; 
                   const bstrPara1: WideString; const bstrPara2: WideString): LongWord;
    function Send3(const bstrLocConnName: WideString; const bstrMethodName: WideString; 
                   const bstrPara1: WideString; const bstrPara2: WideString; 
                   const bstrPara3: WideString): LongWord;
    procedure Test1(saParas: PSafeArray);
    property  ControlInterface: ILCObject read GetControlInterface;
    property  DefaultInterface: ILCObject read GetControlInterface;
  published
    property Anchors;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property OnFuncCall: TLCObjectFuncCall read FOnFuncCall write FOnFuncCall;
    property OnFuncCall2: TLCObjectFuncCall2 read FOnFuncCall2 write FOnFuncCall2;
    property OnFuncCall3: TLCObjectFuncCall3 read FOnFuncCall3 write FOnFuncCall3;
    property OnErrorHappened: TLCObjectErrorHappened read FOnErrorHappened write FOnErrorHappened;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TLCObject.InitControlData;
const
  CEventDispIDs: array [0..3] of DWORD = (
    $00000001, $00000002, $00000003, $00000004);
  CControlData: TControlData2 = (
    ClassID: '{08120055-CD5F-41A5-B80A-6AC7DD4F4BC2}';
    EventIID: '{4B66A8CA-57F6-415E-9FD1-4877C7C3F070}';
    EventCount: 4;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$80004002*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnFuncCall) - Cardinal(Self);
end;

procedure TLCObject.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as ILCObject;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TLCObject.GetControlInterface: ILCObject;
begin
  CreateControl;
  Result := FIntf;
end;

function TLCObject.Connect(const szLocConnName: WideString): LongWord;
begin
  Result := DefaultInterface.Connect(szLocConnName);
end;

procedure TLCObject.Close;
begin
  DefaultInterface.Close;
end;

function TLCObject.Send(const szLocConnName: WideString; const szMethodName: WideString; 
                        const szPara: WideString): LongWord;
begin
  Result := DefaultInterface.Send(szLocConnName, szMethodName, szPara);
end;

function TLCObject.Send2(const bstrLocConnName: WideString; const bstrMethodName: WideString; 
                         const bstrPara1: WideString; const bstrPara2: WideString): LongWord;
begin
  Result := DefaultInterface.Send2(bstrLocConnName, bstrMethodName, bstrPara1, bstrPara2);
end;

function TLCObject.Send3(const bstrLocConnName: WideString; const bstrMethodName: WideString; 
                         const bstrPara1: WideString; const bstrPara2: WideString; 
                         const bstrPara3: WideString): LongWord;
begin
  Result := DefaultInterface.Send3(bstrLocConnName, bstrMethodName, bstrPara1, bstrPara2, bstrPara3);
end;

procedure TLCObject.Test1(saParas: PSafeArray);
begin
  DefaultInterface.Test1(saParas);
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TLCObject]);
end;

end.
