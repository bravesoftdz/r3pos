

unit ZipUtils;

interface

uses
  Windows, SysUtils, Classes, vclunzip,VCLZip;

var
  ErrorMsg: string;

procedure InitPosHandle(PosHandle: HWND);
function GetMsgHead(APackFile:string; var APackHead:string):boolean;
function UnPackToFile(APackFile, APath:string; var ADataFile:string):boolean;
function PackToFile(ADataFile, APackHead, APackFile:string):boolean;
function ZipFiles(AFileList, AZipFile, AKey:string):boolean;
function UnZipFiles(AZipFile, APath, AKey:string;var AFileList:string):boolean;
function ZipStream(inStream:TStream;outStream:TStream):boolean;
function UnZipStream(inStream:TStream;outStream:TStream;filename:string='0'):boolean;
function ZipString(instr:string):string;
function UnZipString(instr:string):string;


implementation

resourcestring
  rsFileNotExists   = '文件%s不存在';
  rsFileCreateError = '创建文件%s错误';
  rsFileOpenError   = '打开文件%s错误';
  rsMsgFormatError  = '数据包%s格式错误';
  rsMsgNoData       = '数据包%s没有数据';
  rsUnZipKeyError   = '压缩文件%s不完整或解压密码错误';
  rsUnZipNoRewrite  = '无法覆盖已存在的文件%s';

const
  MSG_TAG_B  = '[DATAMSG]'#13#10;
  MSG_TAG_E  = '[/DATAMSG]'#13#10;
  MSG_HEAD_B = '[HEAD]'#13#10;
  MSG_HEAD_E = '[/HEAD]'#13#10;
  MSG_DATA_B = '[DATA]'#13#10;
  MSG_DATA_E = '[/DATA]'#13#10;

  ZIP_KEY    = 'HSYYMIS';
  ENC_KEY    = '3#&@lph(g3=22_;2t|q8a/zfc>}s';
  TMP_FILE   = '~%s.tmp';

type
  TMsgUnZip  = class(TVCLUnZip)
    procedure OnPercentDone(Sender: TObject; Percent: LongInt);
    procedure OnFileSkip(Sender: TObject; Reason: TSkipReason; FName: string;
                               FileIndex: Integer; var Retry: Boolean);
  end;

  TMsgZip  = class(TVCLZip)
    procedure OnPercentDone(Sender: TObject; Percent: LongInt);
    procedure OnFileSkip(Sender: TObject; Reason: TSkipReason; FName: string;
                               FileIndex: Integer; var Retry: Boolean);
  end;

var
  PosHWND: HWND = 0;

procedure TMsgUnZip.OnPercentDone(Sender: TObject; Percent: LongInt);
begin
  if PosHWND<>0 then SendMessage(PosHWND, $0400+2, Percent, 0);
end;

procedure TMsgUnZip.OnFileSkip(Sender: TObject; Reason: TSkipReason; FName: string;
                               FileIndex: Integer; var Retry: Boolean);
begin
  Retry:=false;
  case Reason of
    srBadPassword  : raise Exception.CreateFmt(rsUnZipKeyError,[ZipName]);
    srNoOverwrite  : raise Exception.CreateFmt(rsUnZipNoRewrite,[FName]);
    srFileOpenError: raise Exception.CreateFmt(rsFileOpenError,[FName]);
  end;
end;

procedure TMsgZip.OnFileSkip(Sender: TObject; Reason: TSkipReason; FName: string;
                               FileIndex: Integer; var Retry: Boolean);
begin
  case Reason of
    srBadPassword  : raise Exception.CreateFmt(rsUnZipKeyError,[ZipName]);
    srNoOverwrite  : raise Exception.CreateFmt(rsUnZipNoRewrite,[FName]);
    srFileOpenError: raise Exception.CreateFmt(rsFileOpenError,[FName]);
  end;
end;

procedure TMsgZip.OnPercentDone(Sender: TObject; Percent: LongInt);
begin
  if PosHWND<>0 then SendMessage(PosHWND, $0400+2, Percent, 0);
end;

function UnPack(APackFile:string; APackData:TStream): boolean;
var
  TagLen, TagPos1, TagPos2: integer;
  Buf: string;
  PackFile: TFileStream;
begin
  if not FileExists(APackFile) then
    begin
      ErrorMsg:=Format(rsFileNotExists,[APackFile]);
      Result:=false;
      Exit;
    end;
  try
    PackFile:=TFileStream.Create(APackFile, fmOpenRead+fmShareDenyWrite);
  except
    ErrorMsg:=Format(rsFileOpenError,[APackFile]);
    Result:=false;
    Exit;
  end;
  try
   SetLength(Buf,PackFile.Size);
   PackFile.Read(Buf[1],PackFile.Size);
   TagLen:=Length(MSG_DATA_B);
   TagPos1:=Pos(MSG_DATA_B,Buf);
   TagPos2:=Pos(MSG_DATA_E,Buf);
   if (TagPos1=0)or(TagPos2=0)or(TagPos1>TagPos2) then
     raise Exception.CreateFmt(rsMsgFormatError,[APackFile]);
   APackData.Write(Buf[TagPos1+TagLen],TagPos2-TagPos1-TagLen);
   SetLength(Buf,0);
   APackData.Position:=0;
   Result:=true;
   ErrorMsg:='';
  except
   on E: Exception do
    begin
      ErrorMsg:=E.Message;
      Result:=false;
    end;
  end;
  PackFile.Free;
end;

function Pack(APackHead:string; APackData:TStream; APackFile:string): boolean;
var
  Buf: string;
  PackFile: TFileStream;
begin
  try
    PackFile:=TFileStream.Create(APackFile,fmCreate);
  except
    ErrorMsg:=Format(rsFileCreateError,[APackFile]);
    Result:=false;
    Exit;
  end;
  try
   Buf:=MSG_TAG_B+MSG_HEAD_B+APackHead+MSG_HEAD_E;
   PackFile.Write(Buf[1],Length(Buf));
   PackFile.Write(MSG_DATA_B[1],Length(MSG_DATA_B));
   PackFile.CopyFrom(APackData,0);
   PackFile.Write(MSG_DATA_E[1],Length(MSG_DATA_E));
   PackFile.Write(MSG_TAG_E[1],Length(MSG_TAG_E));
   Result:=true;
   ErrorMsg:='';
  except
   on E: Exception do
    begin
      ErrorMsg:=E.Message;
      Result:=false;
    end;
  end;
  PackFile.Free;
end;

procedure InitPosHandle(PosHandle: HWND);
begin
  PosHWND:=PosHandle;
  if PosHWND<>0 then SendMessage(PosHWND, $0400+2, 0, 0);
end;

function GetMsgHead(APackFile:string; var APackHead:string):boolean;
var
  MsgText: TextFile;
  MsgLine: string;
begin
  if not FileExists(APackFile) then
    begin
      ErrorMsg:=Format(rsFileNotExists,[APackFile]);
      Result:=false;
      Exit;
    end;
  AssignFile(MsgText,APackFile);
  try
   Reset(MsgText);
   try
    Result:=false;
    while (MsgLine+#13#10<>MSG_HEAD_B)and not EOF(MsgText) do
      Readln(MsgText,MsgLine);
    if EOF(MsgText) then
      raise Exception.CreateFmt(rsMsgFormatError,[APackFile]);
    APackHead:='';
    Readln(MsgText,MsgLine);
    while (MsgLine+#13#10<>MSG_HEAD_E)and not EOF(MsgText) do
      begin
        APackHead:=APackHead+MsgLine+#13#10;
        Readln(MsgText,MsgLine);
      end;
    if EOF(MsgText) then
      raise Exception.CreateFmt(rsMsgFormatError,[APackFile]);
    Result:=true;
    ErrorMsg:='';
   finally
    Close(MsgText);
   end;
  except
   on E: Exception do
    begin
      ErrorMsg:=E.Message;
      Result:=false;
    end;
  end;
end;

function UnPackToFile(APackFile, APath:string;var ADataFile:string):boolean;
var
  UnZip: TMsgUnZip;
  APackData: TStream;
  TempFile: string;
begin
  try
    if (Length(APath)>0) and (APath[Length(APath)]<>'\') then
      APath:=APath+'\';
    TempFile:=APath+Format(TMP_FILE,[ExtractFileName(APackFile)]);
    APackData:=TFileStream.Create(TempFile,fmCreate);
  except
    ErrorMsg:=Format(rsFileCreateError,[TempFile]);
    Result:=false;
    Exit;
  end;
  if UnPack(APackFile,APackData) then
    try
      if APackData.Size=0 then
        raise Exception.CreateFmt(rsMsgNoData,[APackFile]);
      UnZip:= TMsgUnZip.Create(nil);
      try
        APackData.Position:=0;
        UnZip.KeepZipOpen:=true;
        UnZip.ArchiveStream:=APackData;
        UnZip.DestDir:=APath;
        UnZip.OnTotalPercentDone:=UnZip.OnPercentDone;
        UnZip.OnSkippingFile:=UnZip.OnFileSkip;
        UnZip.OverwriteMode:=Always;
        UnZip.Password:=ZIP_KEY;
        UnZip.DoAll:=true;
        UnZip.UnZip;
        ADataFile:=UnZip.Filename[0];
        Result:=true;
        ErrorMsg:='';
      finally
        UnZip.ArchiveStream:=nil;
        UnZip.Free;
      end;
    except
      on E: Exception do
       begin
        ErrorMsg:=E.Message;
        Result:=false;
       end;
    end
  else Result:=false;
  APackData.Free;
  DeleteFile(TempFile);
end;

function PackToFile(ADataFile, APackHead, APackFile:string):boolean;
var
  Zip: TMsgZip;
  APackData: TStream;
  TempFile: string;
begin
  if not FileExists(ADataFile) then
    begin
      ErrorMsg:=Format(rsFileNotExists,[ADataFile]);
      Result:=false;
      Exit;
    end;
  try
    TempFile:=ExtractFilePath(APackFile)+Format(TMP_FILE,[ExtractFileName(APackFile)]);
    APackData:=TFileStream.Create(TempFile,fmCreate);
  except
    ErrorMsg:=Format(rsFileCreateError,[TempFile]);
    Result:=false;
    Exit;
  end;
  Zip:= TMsgZip.Create(nil);
  try
    Zip.ArchiveStream:=APackData;
    Zip.OnTotalPercentDone:=Zip.OnPercentDone;
    Zip.OnSkippingFile:=Zip.OnFileSkip;
    Zip.FilesList.Add(ADataFile);
    Zip.Password:=ZIP_KEY;
    Zip.Recurse:=true;
    Zip.StorePaths:=false;
    Zip.PackLevel:=7;
    Zip.Zip;
    if Pack(APackHead,APackData,APackFile) then
     begin
       Result:=true;
       ErrorMsg:='';
     end
     else Result:=false;
  except
    on E: Exception do
     begin
      ErrorMsg:=E.Message;
      Result:=false;
     end;
  end;
  Zip.Free;
  DeleteFile(TempFile);
end;

function ZipFiles(AFileList, AZipFile, AKey:string):boolean;
var
  Zip : TMsgZip;
begin
  Zip:= TMsgZip.Create(nil);
  try
    Zip.ZipName:=AZipFile;
    Zip.OnTotalPercentDone:=Zip.OnPercentDone;
    Zip.OnSkippingFile:=Zip.OnFileSkip;
    Zip.FilesList.Text:=AFileList;
    Zip.Password:=AKey;
    Zip.Recurse:=true;
    Zip.StorePaths:=false;
    Zip.PackLevel:=7;
    Zip.Zip;
    Result:=true;
    ErrorMsg:='';
  except
    on E: Exception do
     begin
      ErrorMsg:=E.Message;
      Result:=false;
     end;
  end;
  Zip.Free;
end;

function UnZipFiles(AZipFile, APath, AKey:string; var AFileList:string):boolean;
var
  UnZip : TMsgUnZip;
  i : integer;
begin
  if not FileExists(AZipFile) then
    begin
      ErrorMsg:=Format(rsFileNotExists,[AZipFile]);
      Result:=false;
      Exit;
    end;
  UnZip:= TMsgUnZip.Create(nil);
  try
    UnZip.ZipName:=AZipFile;
    UnZip.KeepZipOpen:=true;
    UnZip.DestDir:=APath;
    UnZip.RecreateDirs := true;
    UnZip.OnTotalPercentDone:=UnZip.OnPercentDone;
    UnZip.OnSkippingFile:=UnZip.OnFileSkip;
    UnZip.OverwriteMode:=Always;
    UnZip.ReplaceReadOnly:=true;
    UnZip.RetainAttributes:=false;
    UnZip.Password:=AKey;
    UnZip.DoAll:=true;
    i:=UnZip.UnZip;
    AFileList:='';
    if i>0 then
     for i:=0 to i-1 do
      AFileList:=AFileList+UnZip.Filename[i]+#13#10;
    Result:=true;
    ErrorMsg:='';
  except
    on E: Exception do
     begin
      ErrorMsg:=E.Message;
      Result:=false;
     end;
  end;
  UnZip.Free;
end;

function ZipStream(inStream:TStream;outStream:TStream):boolean;
var
  Zip : TMsgZip;
begin
  Zip:= TMsgZip.Create(nil);
  try
    Zip.ArchiveStream:=outStream;
    Zip.OnTotalPercentDone:=Zip.OnPercentDone;
    Zip.OnSkippingFile:=Zip.OnFileSkip;
    Zip.Password:='';
    Zip.Recurse:=true;
    Zip.StorePaths:=false;
    Zip.PackLevel:=7;
    Zip.ZipFromStream(inStream,'ZippedFile');
    result := true;
  except
    on E: Exception do
     begin
      ErrorMsg:=E.Message;
      Result:=false;
     end;
  end;
  Zip.Free;
end;
function UnZipStream(inStream:TStream;outStream:TStream;filename:string='0'):boolean;
var
  UnZip: TMsgUnZip;
  w:string;
begin
  UnZip:= TMsgUnZip.Create(nil);
  try
    UnZip.KeepZipOpen:=true;
    UnZip.ArchiveStream:=inStream;
    UnZip.DestDir:=ExtractFilePath(ParamStr(0));
    UnZip.OnTotalPercentDone:=UnZip.OnPercentDone;
    UnZip.OnSkippingFile:=UnZip.OnFileSkip;
    UnZip.OverwriteMode:=Always;
    UnZip.Password:='';
    UnZip.UnZipToStream(outStream,filename);
    Result:=true;
    ErrorMsg:='';
  except
    on E: Exception do
     begin
      ErrorMsg:=E.Message;
      Result:=false;
     end;
  end;
  UnZip.Free;
end;
function ZipString(instr:string):string;
var
  Zip : TMsgZip;
begin
  Zip:= TMsgZip.Create(nil);
  try
    result := Zip.ZLibCompressString(instr);
  finally
    Zip.Free;
  end;
end;
function UnZipString(instr:string):string;
var
  UnZip: TMsgUnZip;
begin
  UnZip:= TMsgUnZip.Create(nil);
  try
    result := UnZip.ZLibDecompressString(instr);
  finally
    UnZip.Free;
  end;
end;
end.
