unit uUtils;

interface
uses System.SysUtils, System.DateUtils, System.IOUtils, System.Classes, System.Win.Registry,
     Winapi.Windows, System.IniFiles;

const
  SHKCURegistryKey = 'Software\Print2Flash\ConvSrv';

function ReadDirName(iniFile:TIniFile; const sName:string; Required:boolean;
                     const Section:string = 'Path') : string;
function ReadFileName(iniFile:TIniFile; const sName:string; Required:boolean;
                     const Section:string = 'Path') : string;

procedure WriteToLog(const str : string);
procedure LogException(const e: Exception);

function GetFlashVersionFromFileW(const FileName:string):byte;

function GetTempFileName(const ext, sDir : string):string;
function RandomStr(len:integer):string;

function NeedCopyToTrusted(const InputFileName:string) : boolean;
function CanReadFile(const FileName: string) : boolean;

function LoadStringFromResource(const sName: string; const sResType: string = 'TXT_SCRIPT') : RawByteString;
function RawStringReplace(const S, OldPattern, NewPattern: RawByteString) : RawByteString;
function HtmlEncode(const ASrc:string) : string;
function JSEncode(const ASrc:string) : string;
function StrHexEncoded(const s:UTF8String) : string;

procedure StoreTmpDir(const sDirName : string);
procedure ClearGarbageFiles;

function GetFullFilePathW(const s:string) : string;
function GetFileSize(const Filename: string) : Cardinal;

function UtcNowAsUnixTimeStamp : integer;
function UtcNow : TDateTime;

implementation

function ReadDirName(iniFile:TIniFile; const sName:string; Required:boolean; const Section:string):string;
begin
  Result := iniFile.ReadString(Section, sName, '');
  Result := GetFullFilePathW(Result);
  Result := ExcludeTrailingPathDelimiter(Result);
  if Required and not DirectoryExists(Result) then
     raise Exception.CreateFmt('Path not found. %s (%s)',[sName, Result]);
end;

function ReadFileName(iniFile:TIniFile; const sName:string; Required:boolean; const Section:string):string;
begin
  Result := iniFile.ReadString(Section, sName, '');
  Result := GetFullFilePathW(Result);
  Result := ExcludeTrailingPathDelimiter(Result);
  if Required and not FileExists(Result) then
     raise Exception.CreateFmt('File not found. %s (%s)',[sName, Result]);
end;

function GetLog2FN():string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))
            + 'convsrv.log'
end;

procedure WriteToLog(const str : string);
var
  fn, s : string;
begin
  fn := GetLog2FN();
  s := DateTimeToStr(Now) + ' ' + str + #13#10;
  if not TFile.Exists(fn) then
     TFile.WriteAllText(fn, s, TEncoding.UTF8)
  else
     TFile.AppendAllText(fn, s, TEncoding.UTF8);
end;

procedure LogException(const e: Exception);
begin
  WriteToLog(Format('%s : %s',[e.ClassName, e.Message]));
end;

function LoadStringFromResource(const sName, sResType: string) : RawByteString;
var
  cbTotalRead : integer;
  rs:TResourceStream;
begin
  rs := TResourceStream.Create(HInstance, sName, PWideChar(sResType));
  try
    cbTotalRead := rs.Size;
    SetLength(Result,cbTotalRead);
    rs.Read(PAnsiChar(Result)^,cbTotalRead);
  finally
    rs.Free;
  end;
end;

function GetFlashVersionFromFileW(const FileName:string):byte;
const
  defFlashVersion = 8;
  ValidDocTemplateFlashVersion = [8..28];
var
  Fh      : THandle;
  Memory  : array [0..3] of byte;
  cbBytesRead : DWORD;
begin
  Result := defFlashVersion;
  Fh := CreateFileW(PWideChar(FileName), GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if Fh <>INVALID_HANDLE_VALUE then
  try
    if ReadFile(Fh,Memory,sizeof(Memory),cbBytesRead,nil) and
       (cbBytesRead = sizeof(Memory)) and
       (Memory[3] in ValidDocTemplateFlashVersion)
       then
         Result := Memory[3];
  finally
    CloseHandle(Fh);
  end;
end;

function StrHexEncoded(const s:UTF8String):string;
const
  Convert: array[0..15] of Char = '0123456789ABCDEF';
var
  I: Integer;
  Text :PChar;
begin
  SetLength(Result, Length(s)*4);
  Text := PChar(Result);
  for I := 1 to Length(s) do
  begin
    Text[0] := '\';
    Text[1] := 'x';
    Text[2] := Convert[Byte(s[I]) shr 4];
    Text[3] := Convert[Byte(s[I]) and $F];
    Inc(Text, 4);
  end;
end;

procedure EmptyDir(const DirName:string);
var
  FindDataW : _WIN32_FIND_DATAW;
  hSearch : THandle;
  sFileNameW, sFullFileNameW:string;
  dirWBS:string;
begin
  dirWBS:=IncludeTrailingPathDelimiter(DirName);
  hSearch := FindFirstFileW(PWideChar(dirWBS+'*'), FindDataW);
  if hSearch <> INVALID_HANDLE_VALUE then
  try
    repeat
      sFileNameW := FindDataW.cFileName;
      if (sFileNameW = '.') or (sFileNameW = '..') then
         continue;
      sFullFileNameW := dirWBS + sFileNameW;
      System.SysUtils.DeleteFile(sFullFileNameW);
    until not FindNextFileW(hSearch,FindDataW);
  finally
    FindClose(hSearch);
  end;
end;

function ExtInArray(const sDocName:string; const aExt:array of string):boolean;
var
  ext:string;
  i:integer;
begin
  Result := false;
  ext := LowerCase(ExtractFileExt(sDocName));
  for i := Low(aExt) to High(aExt) do
  if CompareStr(ext,aExt[i]) = 0 then
  begin
    Result := True;
    break;
  end;
end;

function NeedCopyToTrusted(const InputFileName:string):boolean;
begin
  Result := ExtInArray(InputFileName,
              ['.doc','.docm','.docx','.dot','.rtf',
               '.xls', '.xlt', '.xlsx', '.xlsm', '.xltx', '.xltm',
               '.ppt', '.pps', '.pptx', '.pptm']);
end;

function CanReadFile(const FileName: string):boolean;
var
  hf:THandle;
begin
  hf := CreateFileW(PWideChar(FileName), GENERIC_READ,
          FILE_SHARE_READ or FILE_SHARE_WRITE or FILE_SHARE_DELETE,
          nil,
          OPEN_EXISTING,0,0);
  Result := hf <> INVALID_HANDLE_VALUE;
  if Result then
     CloseHandle(hf);
end;

function RandomStr(len:integer):string;
const
	chars : string = 'abcdefghijklmnopqrstuvwxyz1234567890';
var
  i, j : integer;
begin
  SetLength(Result, len);
  for i := 1 to len do
  begin
    j := Random(Length(chars)) + 1;
    Result[i] := chars[j];
  end;
end;

function GetTempFileName(const ext, sDir : string):string;
var
  path : string;
begin
  path := IncludeTrailingPathDelimiter(sDir);
  repeat
    Result:= path + RandomStr(8) + Ext;
  until not FileExists(Result);
end;

function RawStringReplace(const S, OldPattern, NewPattern: RawByteString): RawByteString;
var
  SearchStr, NewStr: RawByteString;
  Offset: Integer;
begin
  SearchStr := S;
  NewStr := S;
  Result := '';
  while SearchStr <> '' do
  begin
    Offset := Pos(OldPattern, SearchStr);
    if Offset = 0 then
    begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    SearchStr := Copy(SearchStr, Offset + Length(OldPattern), MaxInt);
  end;
end;

function HtmlEncode(const ASrc:string):string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(ASrc) do
  begin
    if ASrc[i] = '&' then
       Result := Result + '&amp;'
    else if ASrc[i] = '<' then
       Result := Result + '&lt;'
    else if ASrc[i] = '>' then
       Result := Result + '&gt;'
    else if ASrc[i] = '"' then
       Result := Result + '&quot;'
    else
       Result := Result + ASrc[i];
  end;
end;

function JSEncode(const ASrc:string):string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(ASrc) do
  if ASrc[i] = '\' then
     Result := Result + '\\'
  else if ASrc[i] = '"' then
     Result := Result + '\"'
  else
     Result := Result + ASrc[i];
end;

procedure StoreTmpDir(const sDirName:string);
var
  r : TRegistry;
  sValueName : string;
begin
  r := TRegistry.Create;
  try
    if r.OpenKey(SHKCURegistryKey + '\TempFiles', true) then
    begin
      repeat
        sValueName := RandomStr(8);
      until not r.ValueExists(sValueName);
      r.WriteString(sValueName, sDirName);
    end;
  finally
    r.Free;
  end;
end;

procedure ClearGarbageFiles;
var
  r : TRegistry;
  sl : TStringList;
  sValueName, sDirName : string;
begin
  sl := TStringList.Create;
  r := TRegistry.Create;
  try
    if r.OpenKey(SHKCURegistryKey + '\TempFiles', false) then
    begin
      r.GetValueNames(sl);
      for sValueName in sl do
      try
         sDirName := r.ReadString(sValueName);
         EmptyDir(sDirName);
         RemoveDir(sDirName);
         if not DirectoryExists(sDirName) then
            r.DeleteValue(sValueName);
      except
         WriteToLog('ClearGarbageFiles:' + Exception(ExceptObject).Message);
      end;
    end;
  finally
    r.Free;
    sl.Free;
  end;
end;

function GetFullFilePathW(const s:string):string;
var
  cchSize, cchNeeded :DWORD;
  p:PWideChar;
begin
  cchSize := MAX_PATH;
  SetLength(Result,cchSize);
  cchNeeded := GetFullPathNameW(PWideChar(s), cchSize, PWideChar(Result), p);
  if cchNeeded <= 0 then // error
     SetLength(Result,0)
  else begin
    if cchNeeded > cchSize then // extend buffer
    begin
       cchSize := cchNeeded;
       SetLength(Result,cchSize);
       cchNeeded := GetFullPathNameW(PWideChar(s), cchNeeded, PWideChar(Result), p);
       if (cchNeeded <= 0) or (cchNeeded > cchSize) then // error
           cchNeeded := 0;
    end;
    SetLength(Result,cchNeeded);
  end;
end;

function GetFileSize(const Filename: string): Cardinal;
var
  FindData: TWin32FindData;
  LHandle: THandle;
begin
  LHandle := FindFirstFile(PChar(Filename), FindData);
  if LHandle <> INVALID_HANDLE_VALUE then
  begin
    Winapi.Windows.FindClose(LHandle);
    Result := FindData.nFileSizeLow;
  end
  else
    Result := 0;
end;

function UtcNowAsUnixTimeStamp : integer;
begin
  Result := DateTimeToUnix(UtcNow);
end;

function UtcNow : TDateTime;
var
  st : TSystemTime;
begin
  GetSystemTime(st);
  Result := SystemTimeToDateTime(st);
end;

end.
