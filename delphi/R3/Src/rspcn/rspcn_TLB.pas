unit rspcn_TLB;

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
// File generated on 2013/2/27 18:58:49 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\myWork\Delphi\R3\Src\rspcn\rspcn.tlb (1)
// LIBID: {0DA3C686-11D6-4090-89BC-FB6E37712AFF}
// LCID: 0
// Helpfile: 
// HelpString: rspcn Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  rspcnMajorVersion = 1;
  rspcnMinorVersion = 0;

  LIBID_rspcn: TGUID = '{0DA3C686-11D6-4090-89BC-FB6E37712AFF}';

  IID_IjavaScriptExt: TGUID = '{858D01A3-0A92-4F43-8F53-B35EADE2A7BC}';
  CLASS_javaScriptExt: TGUID = '{A8BBED49-81F9-44BF-A65B-EACD663C502A}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IjavaScriptExt = interface;
  IjavaScriptExtDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  javaScriptExt = IjavaScriptExt;


// *********************************************************************//
// Interface: IjavaScriptExt
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {858D01A3-0A92-4F43-8F53-B35EADE2A7BC}
// *********************************************************************//
  IjavaScriptExt = interface(IDispatch)
    ['{858D01A3-0A92-4F43-8F53-B35EADE2A7BC}']
    function signIn(const username: WideString; const password: WideString; 
                    const verify: WideString; online: WordBool): WordBool; safecall;
    procedure signOut; safecall;
    function getVerify: WideString; safecall;
    function getToken(const appId: WideString): WideString; safecall;
    function createDataSet: Integer; safecall;
    function connect: WordBool; safecall;
    procedure disconnet; safecall;
    procedure append(ds: Integer); safecall;
    procedure edit(ds: Integer); safecall;
    function getAsString(ds: Integer; const fieldname: WideString): WideString; safecall;
    function getAsInteger(ds: Integer; const fieldname: WideString): Integer; safecall;
    function getAsValue(ds: Integer; const fieldname: WideString): OleVariant; safecall;
    function getAsDouble(ds: Integer; const fieldname: WideString): Double; safecall;
    procedure setAsString(ds: Integer; const fieldname: WideString; const value: WideString); safecall;
    procedure setAsInteger(ds: Integer; const fieldname: WideString; value: Integer); safecall;
    procedure setAsValue(ds: Integer; const fieldname: WideString; value: OleVariant); safecall;
    procedure setAsDouble(ds: Integer; const fieldname: WideString; value: Double); safecall;
    procedure post(ds: Integer); safecall;
    function eof(ds: Integer): WordBool; safecall;
    procedure first(ds: Integer); safecall;
    procedure last(ds: Integer); safecall;
    procedure next(ds: Integer); safecall;
    procedure prior(ds: Integer); safecall;
    procedure eraseDataSet(ds: Integer); safecall;
    function locate(ds: Integer; const fieldname: WideString; value: OleVariant): WordBool; safecall;
    procedure setSQL(ds: Integer; const SQL: WideString); safecall;
    procedure open(ds: Integer; const ns: WideString; const Params: WideString); safecall;
    function getLastError: WideString; safecall;
    procedure beginbatch; safecall;
    procedure addbatch(ds: Integer; const ns: WideString; const Params: WideString); safecall;
    procedure openBatch; safecall;
    procedure commitBatch; safecall;
    procedure cancelBatch; safecall;
    procedure updatebatch(ds: Integer; const ns: WideString; const Params: WideString); safecall;
    function execSQL(const SQL: WideString): Integer; safecall;
    function iDbType: Integer; safecall;
    procedure moveToRemote; safecall;
    procedure moveToSqlite; safecall;
    function getUserInfo: WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  IjavaScriptExtDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {858D01A3-0A92-4F43-8F53-B35EADE2A7BC}
// *********************************************************************//
  IjavaScriptExtDisp = dispinterface
    ['{858D01A3-0A92-4F43-8F53-B35EADE2A7BC}']
    function signIn(const username: WideString; const password: WideString; 
                    const verify: WideString; online: WordBool): WordBool; dispid 202;
    procedure signOut; dispid 203;
    function getVerify: WideString; dispid 204;
    function getToken(const appId: WideString): WideString; dispid 205;
    function createDataSet: Integer; dispid 201;
    function connect: WordBool; dispid 206;
    procedure disconnet; dispid 207;
    procedure append(ds: Integer); dispid 208;
    procedure edit(ds: Integer); dispid 209;
    function getAsString(ds: Integer; const fieldname: WideString): WideString; dispid 210;
    function getAsInteger(ds: Integer; const fieldname: WideString): Integer; dispid 211;
    function getAsValue(ds: Integer; const fieldname: WideString): OleVariant; dispid 212;
    function getAsDouble(ds: Integer; const fieldname: WideString): Double; dispid 213;
    procedure setAsString(ds: Integer; const fieldname: WideString; const value: WideString); dispid 214;
    procedure setAsInteger(ds: Integer; const fieldname: WideString; value: Integer); dispid 215;
    procedure setAsValue(ds: Integer; const fieldname: WideString; value: OleVariant); dispid 216;
    procedure setAsDouble(ds: Integer; const fieldname: WideString; value: Double); dispid 217;
    procedure post(ds: Integer); dispid 218;
    function eof(ds: Integer): WordBool; dispid 219;
    procedure first(ds: Integer); dispid 220;
    procedure last(ds: Integer); dispid 221;
    procedure next(ds: Integer); dispid 222;
    procedure prior(ds: Integer); dispid 223;
    procedure eraseDataSet(ds: Integer); dispid 224;
    function locate(ds: Integer; const fieldname: WideString; value: OleVariant): WordBool; dispid 225;
    procedure setSQL(ds: Integer; const SQL: WideString); dispid 226;
    procedure open(ds: Integer; const ns: WideString; const Params: WideString); dispid 227;
    function getLastError: WideString; dispid 228;
    procedure beginbatch; dispid 229;
    procedure addbatch(ds: Integer; const ns: WideString; const Params: WideString); dispid 230;
    procedure openBatch; dispid 231;
    procedure commitBatch; dispid 232;
    procedure cancelBatch; dispid 233;
    procedure updatebatch(ds: Integer; const ns: WideString; const Params: WideString); dispid 234;
    function execSQL(const SQL: WideString): Integer; dispid 235;
    function iDbType: Integer; dispid 236;
    procedure moveToRemote; dispid 237;
    procedure moveToSqlite; dispid 238;
    function getUserInfo: WideString; dispid 239;
  end;

// *********************************************************************//
// The Class CojavaScriptExt provides a Create and CreateRemote method to          
// create instances of the default interface IjavaScriptExt exposed by              
// the CoClass javaScriptExt. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CojavaScriptExt = class
    class function Create: IjavaScriptExt;
    class function CreateRemote(const MachineName: string): IjavaScriptExt;
  end;

implementation

uses ComObj;

class function CojavaScriptExt.Create: IjavaScriptExt;
begin
  Result := CreateComObject(CLASS_javaScriptExt) as IjavaScriptExt;
end;

class function CojavaScriptExt.CreateRemote(const MachineName: string): IjavaScriptExt;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_javaScriptExt) as IjavaScriptExt;
end;

end.
