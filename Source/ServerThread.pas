unit ServerThread;

interface

uses System.SysUtils, System.Classes, System.Types, System.zip, System.IOUtils, System.Json,
     db, Print2Flash5_TLB;

type
  TCurrentStatusData = class
  public
    NumConverted, NumErrors : integer;
    CurFileName, DocFormat : string;
    FSStatus, DbStatus, P2FStatus : string;
  end;

  TServerThread = class (TThread)
  private
    // settings
    OutputPath,
    InputPath,
    TrustedPath,
    DocViewerPath : string;
    QueueTimeoutSec : integer;

    // interfaces
    FDB : IDBIntf;
    FP2FSrv : IServer;

    // current file
    FCurrentInputFile : IDocInfo;
    // current status for UI
    FCurrentStatus : TCurrentStatusData;

    FOnUpdateUI: TNotifyEvent;

    procedure UpdateUI;
    procedure CallOnUpdateUI;

    procedure ReadParameters;

    procedure CreateTxtFile(const FileName:String; const sContent:String);

    function SaveBothPreview(const Title, sFileName: string; const Params, Values: array of RawByteString):RawByteString;
    function SaveSVGDocPreview(const Title, sFileName: string; const Params, Values: array of RawByteString):RawByteString;

    procedure ReplaceFlashVerPlaceHolders(var sHtml: RawByteString; const sSwfFileName: string);
    function  GetFlashPlayerVersion(iSWFVersion: integer; out iMinorVer, iRevision: integer): integer;
    procedure CreateZipFile(const sFolderNameWBS:string; const sPreview:RawByteString);
    procedure addToZipFile(z: TZipFile; const sFolderName, sArchName: string);
    function  GetFlashVerPhpStr(const sSwfFileName: string): string;

    procedure Execute_impl;
    procedure CheckFileSystem;
    procedure ProcessFile(InputFile: IDocInfo);
    procedure WriteSrvStatusFile;
    function InitP2FServerObj: IServer;
    function InitDatabase: IDBIntf;
  public
    constructor Create(CreateSuspended: Boolean);
    procedure  Execute;override;
    destructor Destroy; override;
    property   OnUpdateUI:TNotifyEvent read FOnUpdateUI write FOnUpdateUI;
  end;

implementation

uses  Winapi.Windows, System.Win.Registry, System.Variants, DateUtils, ActiveX, IniFiles, uUtils, dbSqlLite;

const
  DefQueueTimeout = SecsPerHour;
  ErrorPauseMs = 500;
  QueueEmptyPauseMs = 100;
  SvrStatusPeriodMs = 20000;

{ TServerThread }

constructor TServerThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FreeOnTerminate := false;
  FCurrentStatus := TCurrentStatusData.Create;
  ReadParameters;
end;

procedure TServerThread.CreateTxtFile(const FileName, sContent: String);
var
  FH:THandle;
  cb:DWORD;
  content:UTF8String;
begin
  content := UTF8Encode(sContent);
  FH := CreateFile(PChar(FileName), GENERIC_WRITE, 0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  if FH <> INVALID_HANDLE_VALUE then
  try
    WriteFile(FH, content[1], Length(content), cb, nil);
  finally
    CloseHandle(FH);
  end;
end;

procedure TServerThread.CreateZipFile(const sFolderNameWBS:string; const sPreview : RawByteString);
var
  z : TZipFile;
procedure AddToPreviewIFExists(const fileName:string);
begin
  if FileExists(fileName) then
     z.Add(fileName, 'preview_files\'+ExtractFileName(fileName));
end;
begin
  z := TZipFile.Create;
  try
    z.Open(sFolderNameWBS + 'preview.zip',zmWrite);
    z.Add(TBytes(sPreview), 'preview.html');
    z.Add(DocViewerPath, 'preview_files\'+ExtractFileName(DocViewerPath));
    AddToPreviewIFExists(sFolderNameWBS + 'doc.swf');
    AddToPreviewIFExists(sFolderNameWBS + 'doc.xml');
    if DirectoryExists(sFolderNameWBS + 'doc_files') then
       addToZipFile(z, sFolderNameWBS + 'doc_files', 'preview_files\doc_files');
    z.Close;
  finally
    z.Free;
  end;
end;

procedure TServerThread.addToZipFile(z:TZipFile; const sFolderName:string; const sArchName:string);
var
  sFileName : string;
begin
  for sFileName in TDirectory.GetFiles(IncludeTrailingPathDelimiter(sFolderName)) do
      z.Add(sFileName, sArchName+'\'+ExtractFileName(sFileName));
  for sFileName in TDirectory.GetDirectories(IncludeTrailingPathDelimiter(sFolderName)) do
      addToZipFile(z, sFileName, sArchName+'\'+ExtractFileName(sFileName));
end;

destructor TServerThread.Destroy;
begin
  FCurrentStatus.Free;
  inherited;
end;

function TServerThread.GetFlashVerPhpStr(const sSwfFileName:string):string;
var
  FlashVersion, FlashVersionMinor, FlashVersionRev:integer;
begin
  // $fv $fvm $fvr
  FlashVersion := GetFlashPlayerVersion(
                        GetFlashVersionFromFileW(sSwfFileName),
                        FlashVersionMinor, FlashVersionRev);
  if FlashVersion <= 0 then
    raise Exception.Create('Invalid SWF Version');

  Result := Format('$fv=%d; $fvm=%d; $fvr=%d;'#13#10,
         [FlashVersion, FlashVersionMinor, FlashVersionRev]);
end;

function TServerThread.InitP2FServerObj:IServer;
begin
  try
    Result := CoServer.Create;
    Result.DefaultProfile.InterfaceOptions:=$7FFFFFFF;
    Result.DefaultProfile.FlashVersion:=9;
    Result.DefaultProfile.JpegQuality:=60;
    Result.DefaultProfile.UseJpeg:=true;
    Result.DefaultProfile.ProtectionOptions:=0;
    Result.DefaultProfile.ExtractLinks := ACROBAT_PRO or MSPOWERPOINT;
    Result.DefaultProfile.DocTemplate := NULL;
    Result.DefaultProfile.OutputFormat := 1;
    Result.DefaultProfile.CreateMetadataFile := FALSE;
    Result.DefaultProfile.ThumbnailPageRange := '';
    Result.DefaultPrintingPreferences.SetFormName('Letter');
    Result.DefaultPrintingPreferences.Orientation:=ORIENT_PORTRAIT;
    Result.DefaultPrintingPreferences.Resolution:=192;

    Result.DefaultBatchProcessingOptions.CreateLogFile:=true;
    Result.DefaultBatchProcessingOptions.GenerateExternalViewer := false;
    Result.DefaultBatchProcessingOptions.BeforePrintingTimeout:=30000;
    Result.DefaultBatchProcessingOptions.PrintingTimeout:=240000;
    Result.DefaultBatchProcessingOptions.KillProcessIfTimeout:=1;
    Result.DefaultBatchProcessingOptions.AfterPrintingTimeout:=10000;
    Result.DefaultBatchProcessingOptions.UseAutomation := $7FFFFFFF;
    Result.DefaultBatchProcessingOptions.KillAllAutomationProcesses := $7FFFFFFF;
    Result.DefaultBatchProcessingOptions.KillAutoProcessBeforeConversion := $7FFFFFFF;
    Result.DefaultBatchProcessingOptions.KeepAutomationAppRef := 0;
    Result.DefaultBatchProcessingOptions.ExcelOptions.OverridePrintQuality := true;
    Result.DefaultBatchProcessingOptions.PowerPointOptions.FitToPage := true;
    Result.DefaultBatchProcessingOptions.LogFileName := ChangeFileExt(ParamStr(0),'.log');
    FCurrentStatus.P2FStatus := '';
  except
    LogException(Exception(ExceptObject));
    FCurrentStatus.P2FStatus := Exception(ExceptObject).Message;
    Sleep(ErrorPauseMs);
  end;
end;

function TServerThread.InitDatabase:IDBIntf;
begin
  try
    Result := TSqlLiteDB.Create;
    FCurrentStatus.DbStatus := '';
  except
    LogException(Exception(ExceptObject));
    FCurrentStatus.DbStatus := Exception(ExceptObject).Message;
    Sleep(ErrorPauseMs);
  end;
end;

procedure TServerThread.Execute;
begin
  try
    CoInitialize(nil);
    try
      Execute_impl;
    finally
      CoUninitialize;
    end;
  except
    LogException(Exception(ExceptObject));
    MessageBox(0, PChar(Exception(ExceptObject).Message), 'ConvSrv', MB_OK or MB_ICONSTOP);
  end;
end;

procedure TServerThread.Execute_impl;
var
  iLastSrvStatusTicks : Cardinal;
begin
  iLastSrvStatusTicks := 0;
  while not Terminated do
  try
    UpdateUI;

    if not Assigned(FP2FSrv) then
       FP2FSrv := InitP2FServerObj;

    if not Assigned(FDB) then
       FDB := InitDatabase;

    if (GetTickCount - iLastSrvStatusTicks) > SvrStatusPeriodMs then
    begin
      CheckFileSystem;

      WriteSrvStatusFile;
      iLastSrvStatusTicks := GetTickCount;

      ClearGarbageFiles;
    end;

    if Assigned(FDB) and Assigned(FP2FSrv) then
    begin
      FCurrentInputFile := FDB.GetNextInputFile;
      if Assigned(FCurrentInputFile) then
      begin
        ProcessFile(FCurrentInputFile);
        continue;
      end;
    end;
    Sleep(QueueEmptyPauseMs);
  except
    LogException(Exception(ExceptObject));
    Sleep(ErrorPauseMs);
  end;

  FDB := nil;
  FP2FSrv := nil;
  FCurrentInputFile := nil;
end;

procedure TServerThread.ProcessFile(InputFile:IDocInfo);
var
  OutputFile, FullInputFileName, LogFileName : string;
  bUseTrusted : boolean;
  TrustedDir, TrustedFN : string;
  sPhp : string;
  sPreview : RawByteString;
begin
  try
    if (UtcNowAsUnixTimeStamp() - InputFile.UtcTimeStamp) > QueueTimeoutSec  then
    begin
      FDB.LogConversionError(InputFile.ConvID, 'Queue Timeout');
      exit;
    end;
    try
      FDB.LogConversion(dsConverting, InputFile.ConvID);

      UpdateUI;

      ForceDirectories(OutputPath+'\'+InputFile.ConvID);

      LogFileName := OutputPath + '\' + InputFile.ConvID + '\convlog.log';
      FP2FSrv.DefaultBatchProcessingOptions.LogFileName := LogFileName;
      FP2FSrv.DefaultBatchProcessingOptions.LoggingLevel := 2;
      FP2FSrv.DefaultBatchProcessingOptions.CreateLogFile:=true;

      FullInputFileName := InputPath + '\' + InputFile.FileID + '\' + InputFile.FileName;
      if not CanReadFile(FullInputFileName) then
         raise Exception.Create('Can not open (' + FullInputFileName + ') for reading.');

      bUseTrusted := (Length(TrustedPath)>0) and NeedCopyToTrusted(InputFile.FileName);
      if bUseTrusted then
      begin
        TrustedDir := TrustedPath + '\' + InputFile.ConvID;
        TrustedFN :=  TrustedDir + '\' + InputFile.FileName;
        if not ForceDirectories(TrustedDir) then
           raise Exception.Create('Can not create '+TrustedDir);
        if not CopyFile(PChar(FullInputFileName), PChar(TrustedFN), true) then
        begin
          StoreTmpDir(TrustedDir);
          raise Exception.Create('Can not copy to '+TrustedFN);
        end;
        FullInputFileName := TrustedFN;
      end;

      try
        if inputFile.DocFormat = dfFlash then
        begin
           FP2FSrv.DefaultProfile.DocumentType := FLASH;

           OutputFile := OutputPath + '\' + InputFile.ConvID + '\doc.swf';
           FP2FSrv.ConvertFile(FullInputFileName, OutputFile, NULL, NULL, NULL)
        end
        else begin
           if inputFile.DocFormat = dfHTML then begin
              FP2FSrv.DefaultProfile.DocumentType := HTML5;
              OutputFile := OutputPath + '\' + InputFile.ConvID + '\doc.xml';
           end
           else begin
              FP2FSrv.DefaultProfile.DocumentType := FLASH or HTML5;
              OutputFile := OutputPath + '\' + InputFile.ConvID + '\doc.swf';
           end;
           FP2FSrv.ConvertFile(FullInputFileName, OutputFile, NULL, NULL, NULL)
        end;
      finally
        if (bUseTrusted) then
            StoreTmpDir(TrustedDir);
      end;

      Inc(FCurrentStatus.NumConverted);
      UpdateUI;

      sPhp := '$foldername="' + InputFile.ConvID + '";'#13#10+
              '$docname="' + StrHexEncoded(UTF8Encode(InputFile.OrigName))+ '";'#13#10;
      if InputFile.DocFormat = dfFlash then
      begin
        sPhp := sPhp +
            '$format="F";'#13#10+
            '$fn_swf="doc.swf";'#13#10+
            '$fn_htm="";'#13#10+
            '$fn_zip="";'#13#10;

        sPhp := sPhp + GetFlashVerPhpStr(OutputFile);
      end
      else begin
        if InputFile.DocFormat = dfHTML then
        begin
           sPhp := sPhp +
                '$format="H";'#13#10+
                '$fn_swf="";'#13#10+
                '$fn_htm="doc.xml";'#13#10+
                '$fn_zip="preview.zip";'#13#10;

           sPreview := SaveSVGDocPreview(
                          InputFile.OrigName,
                          OutputPath + '\' + InputFile.ConvID + '\preview.html',
                          [ '%%WIDTH%%', '%%HEIGHT%%', '%%PRIORITY%%'],
                          [ UTF8Encode('100%'), UTF8Encode('100%'), UTF8Encode('html5')]);
        end
        else begin // dfBoth
           sPhp := sPhp +
                '$format="B";'#13#10+
                '$fn_swf="doc.swf";'#13#10+
                '$fn_htm="doc.xml";'#13#10+
                '$fn_zip="preview.zip";'#13#10;

           sPhp := sPhp + GetFlashVerPhpStr(OutputPath + '\' + InputFile.ConvID + '\doc.swf');

           sPreview := SaveBothPreview(
                          InputFile.OrigName,
                          OutputPath + '\' + InputFile.ConvID + '\preview.html',
                          [ '%%WIDTH%%', '%%HEIGHT%%', '%%PRIORITY%%'],
                          [ UTF8Encode('100%'), UTF8Encode('100%'), UTF8Encode('flash')]);
        end;
        CreateZipFile(OutputPath + '\' + InputFile.ConvID + '\', sPreview);
      end;

      CreateTxtFile(OutputPath + '\' + InputFile.ConvID + '\index.php',
        '<?php '#13#10 + sPhp + #13#10+
        'require_once(dirname(__FILE__)."/../index3.php");'#13#10+
        '?>');
      CreateTxtFile(OutputPath + '\' + InputFile.ConvID + '\doc.php',
        '<?php '#13#10 + sPhp + #13#10+
        'require_once(dirname(__FILE__)."/../doc3.php");'#13#10+
        '?>');

      FDB.LogConversion(dsDone, InputFile.ConvID);
    except
      FDB.LogConversionError(InputFile.ConvID, Exception(ExceptObject).Message);

      // remove dir content
      StoreTmpDir(OutputPath + '\' + InputFile.ConvID);

      LogException(Exception(ExceptObject));
      Inc(FCurrentStatus.NumErrors);
    end;
  finally
    UpdateUI;
    // delete input
    StoreTmpDir(InputPath + '\' + InputFile.FileID);
  end;
end;

procedure TServerThread.CheckFileSystem;
procedure CheckDir(const sPath:string);
var
  TmpName  : string;
begin
  TmpName:= GetTempFileName('.dir', sPath);
  if not CreateDir(TmpName) then
     raise Exception.CreateFmt('CreateDir failed %d',[GetLastError()]);
  if not RemoveDir(PChar(TmpName)) then
     raise Exception.CreateFmt('RemoveDir failed %d',[GetLastError()]);
end;
procedure CheckDir2(const sPath, sName:string);
begin
  try
     CheckDir(sPath);
  except on E: Exception do
     FCurrentStatus.FSStatus := FCurrentStatus.FSStatus + sName + ':' + e.Message;
  end;
end;
begin
  FCurrentStatus.FSStatus := '';
  CheckDir2(OutputPath,'content');
  CheckDir2(InputPath, 'input');
end;

procedure TServerThread.ReadParameters;
var
  sIniFileName : string;
  iniFile : TIniFile;
  i : integer;
begin
  sIniFileName := ChangeFileExt(ParamStr(0), '.ini');
  try
    if not FileExists(sIniFileName) then
       raise Exception.CreateFmt('INI file(%s) not found',[sIniFileName]);
    iniFile:=TIniFile.Create(sIniFileName);
    try
      OutputPath := ReadDirName(iniFile, 'OutputPath', true);
      InputPath :=  ReadDirName(iniFile, 'InputPath', true);
      TrustedPath := ReadDirName(iniFile, 'TrustedPath', false);
      DocViewerPath := ReadFileName(iniFile, 'DocViewer', true);

      if TryStrToInt(iniFile.ReadString('Timeouts','QueueTimeoutSec',''), i) then
         QueueTimeoutSec := i
      else
         QueueTimeoutSec := DefQueueTimeout;
    finally
      iniFile.Free;
    end;
  except
    raise Exception.Create('Read parameters failed - '+Exception(ExceptObject).Message+
                       #13+'Please check '+sIniFileName);
  end;
end;

procedure TServerThread.UpdateUI;
const
  sDFNames : array[TDocFormat] of string = ('','Flash', 'HTML', 'Both');
begin
  if Assigned(FOnUpdateUI) then
  begin
    if Assigned(FCurrentInputFile) then begin
       FCurrentStatus.CurFileName := FCurrentInputFile.OrigName;
       FCurrentStatus.DocFormat := sDFNames[FCurrentInputFile.DocFormat];
    end
    else begin
       FCurrentStatus.CurFileName := '';
       FCurrentStatus.DocFormat := '';
    end;

    if Assigned(FDB) then
       FCurrentStatus.DbStatus := FDB.GetLastError;

    Synchronize(CallOnUpdateUI);
  end;
end;

procedure TServerThread.WriteSrvStatusFile;
var
  json : TJSONObject;
  sDBStatus : string;
begin
  try
    sDBStatus := FCurrentStatus.DbStatus;
    if Assigned(FDB) then
       sDBStatus := FDB.GetLastError;

    json := TJSONObject.Create;
    try
      json.AddPair('nConverted', TJSONNumber.Create(FCurrentStatus.NumConverted));
      json.AddPair('nErrors', TJSONNumber.Create(FCurrentStatus.NumErrors));
      json.AddPair('P2FError', FCurrentStatus.P2FStatus);
      json.AddPair('FSError', FCurrentStatus.FSStatus);
      json.AddPair('DBError', sDBStatus);
      json.AddPair('UtcTime', TJSONNumber.Create(UtcNowAsUnixTimeStamp));
      TFile.WriteAllText(InputPath+'\convsrv.txt', json.ToString);
    finally
      json.Free;
    end;
  except
    // ignore exceptions
  end;
end;

procedure TServerThread.CallOnUpdateUI;
begin
  if Assigned(FOnUpdateUI) then
     FOnUpdateUI(FCurrentStatus);
end;

type
  TFlashPlayerVer = record
     swf:byte;
     v,m,r:byte;
  end;
const
  aFlashPlayerVerArr : array [0..23-1] of TFlashPlayerVer =
  (
    (swf:6; v:6; m:0; r:0),
    (swf:7; v:7; m:0; r:0),
    (swf:8; v:8; m:0; r:0),
    (swf:9; v:9; m:0; r:28),
    (swf:10; v:10; m:1; r:0),
    (swf:11; v:10; m:2; r:0),
    (swf:12; v:10; m:3; r:0),
    (swf:13; v:11; m:0; r:0),
    (swf:14; v:11; m:1; r:0),
    (swf:15; v:11; m:2; r:0),
    (swf:16; v:11; m:3; r:0),
    (swf:17; v:11; m:4; r:0),
    (swf:18; v:11; m:5; r:0),
    (swf:19; v:11; m:6; r:0),
    (swf:20; v:11; m:7; r:0),
    (swf:21; v:11; m:8; r:0),
    (swf:22; v:11; m:9; r:0),
    (swf:23; v:12; m:0; r:0),
    (swf:24; v:13; m:0; r:0),
    (swf:25; v:14; m:0; r:0),
    (swf:26; v:15; m:0; r:0),
    (swf:27; v:16; m:0; r:0),
    (swf:28; v:16; m:0; r:0)
  );

function TServerThread.GetFlashPlayerVersion(iSWFVersion: integer; out iMinorVer, iRevision: integer): integer;
var
  i:integer;
begin
  Result := 0;
  for i:=0 to Length(aFlashPlayerVerArr)-1 do
  if aFlashPlayerVerArr[i].swf = iSWFVersion then
  begin
    Result := aFlashPlayerVerArr[i].v;
    iMinorVer := aFlashPlayerVerArr[i].m;
    iRevision := aFlashPlayerVerArr[i].r;
    break;
  end;
end;

procedure TServerThread.ReplaceFlashVerPlaceHolders(var sHtml: RawByteString;
  const sSwfFileName: string);
var
  SWFVer, FlashVersion, FlashVersionMinor, FlashVersionRev:integer;
begin
  SWFVer := GetFlashVersionFromFileW(sSwfFileName);
  FlashVersion := GetFlashPlayerVersion(SWFVer, FlashVersionMinor, FlashVersionRev);
  if FlashVersion <= 0 then
     raise Exception.CreateFmt('Invalid SWF Version %d',[SWFVer]);

  sHtml := RawStringReplace(sHtml,'%%FLASH_VERSION%%',UTF8Encode(IntToStr(FlashVersion)));
  sHtml := RawStringReplace(sHtml,'%%FLASH_VERSION_MINOR%%',UTF8Encode(IntToStr(FlashVersionMinor)));
  sHtml := RawStringReplace(sHtml,'%%FLASH_VERSION_REV%%',UTF8Encode(IntToStr(FlashVersionRev)));
end;

const
  SDocName = 'doc.xml';
  SViewerName = 'docviewer.html';
  SFlashDocName = 'doc.swf';

function TServerThread.SaveSVGDocPreview(const Title, sFileName: string;
  const Params, Values: array of RawByteString):RawByteString;
var
  s : RawByteString;
  i : integer;
  sFolderFullName, sFolder : string;
begin
  sFolderFullName := ChangeFileExt(sFileName,'') + '_files\';
  sFolder := ChangeFileExt(ExtractFileName(sFileName),'') + '_files/';

  s := LoadStringFromResource('HTMLTEMPLATE');

// var width = "%%WIDTH%%"
// var height = "%%HEIGHT%%"
// var align = "%%ALIGN%%"
// var htmldocurl ="%%HTMLDOCURL%%"
// var htmlviewerurl = "%%HTMLVIEWERURL%%"

  s := RawStringReplace(s,'%%TITLE%%',UTF8Encode(HtmlEncode(Title)));
  for i := 0 to length(Params) - 1 do
      s := RawStringReplace(s,Params[i],Values[i]);
  s := RawStringReplace(s,'%%HTMLDOCURL%%',SDocName);
  s := RawStringReplace(s,'%%HTMLVIEWERURL%%',UTF8Encode(JSEncode(sFolder + SViewerName)));

  Result := s;
end;

function TServerThread.SaveBothPreview(const Title, sFileName: string;
  const Params, Values: array of RawByteString):RawByteString;
var
  s : RawByteString;
  i : integer;
  sFolderFullName, sFolder : string;
  sFlashVars, sFlashFormat : string;
begin
  sFolderFullName := ChangeFileExt(sFileName,'') + '_files\';
  sFolder := ChangeFileExt(ExtractFileName(sFileName),'') + '_files/';

// flash
  s := LoadStringFromResource('BOTHTEMPLATE');

// var width = "%%WIDTH%%"
// var height = "%%HEIGHT%%"
// var align = "%%ALIGN%%"
// var htmldocurl ="%%HTMLDOCURL%%"
// var htmlviewerurl = "%%HTMLVIEWERURL%%"
// var flashdocurl ="%%FLASHDOCURL%%"
// var flashvars = "%%FLASHVARS%%"
// var flashformat = "%%FLASHFORMAT%%"
// var priority = "%%PRIORITY%%"

  ReplaceFlashVerPlaceHolders(s,sFolderFullName+SFlashDocName);
  s := RawStringReplace(s,'%%TITLE%%',UTF8Encode(HtmlEncode(Title)));
  for i := 0 to length(Params) - 1 do
     s := RawStringReplace(s,Params[i],Values[i]);
  s := RawStringReplace(s,'%%HTMLDOCURL%%',SDocName);
  s := RawStringReplace(s,'%%HTMLVIEWERURL%%',UTF8Encode(JSEncode(sFolder + SViewerName)));
  s := RawStringReplace(s,'%%FLASHDOCURL%%', UTF8Encode(JSEncode(sFolder + SFlashDocName)));
  s := RawStringReplace(s,'%%FLASHVARS%%', UTF8Encode(JSEncode(sFlashVars)));
  s := RawStringReplace(s,'%%FLASHFORMAT%%', UTF8Encode(JSEncode(sFlashFormat)));

  Result := s;
end;

end.
