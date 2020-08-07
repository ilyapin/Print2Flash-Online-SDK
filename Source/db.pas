unit db;

interface

type
  TDocFormat = (dfNone, dfFlash, dfHTML, dfBoth);
  TDocStatus = (dsConverting, dsDone, dsError);

  IDocInfo = interface
    function FileID : string;
    function ConvID : string;
    function FileName : string;
    function OrigName : string;
    function DocFormat : TDocFormat;
    function UtcTimeStamp : integer;
  end;

  TNextDocInfo = class (TInterfacedObject, IDocInfo)
  private
    FFileID, FConvID,
    FFileName,
    FOrigName : string;
    FDF : TDocFormat;
    FTimeU : integer;
  public
    constructor Create(const FileID, ConvID, FileName, sOrigName:string; df:TDocFormat; time_u:integer);
    function FileID : string;
    function ConvID : string;
    function FileName : string;
    function OrigName : string;
    function DocFormat : TDocFormat;
    function UtcTimeStamp : integer;
  end;

  IDBIntf = interface
    function Connected:boolean;
    function GetNextInputFile:IDocInfo;
    procedure LogConversion(status : TDocStatus; const ConvID : string);
    procedure LogConversionError(const ConvID, Error : string);
    function GetLastError : string;
  end;

  function Str2DocFormat(const strValue:Variant):TDocFormat;
  function DocStatus2Str(const Value:TDocStatus):string;
implementation

function DocStatus2Str(const Value:TDocStatus):string;
const
   strVals : array [TDocStatus] of string = ('C','D', 'E');
begin
   Result := strVals[Value];
end;

function Str2DocFormat(const strValue:Variant):TDocFormat;
begin
  Result := dfNone;
  if strValue = 'F' then
     Result := dfFlash
  else if strValue = 'H' then
     Result := dfHTML
  else if strValue = 'B' then
     Result :=  dfBoth;
end;

// TNextDocInfo

function TNextDocInfo.ConvID: string;
begin
  Result := FConvID;
end;

constructor TNextDocInfo.Create(const FileID, ConvID, FileName, sOrigName:string; df:TDocFormat; time_u:integer);
begin
  FFileID := FileID;
  FConvID := ConvID;
  FFileName := FileName;
  FOrigName := sOrigName;
  FDF := df;
  FTimeU := time_u;
end;

function TNextDocInfo.DocFormat: TDocFormat;
begin
  Result := FDF;
end;

function TNextDocInfo.FileID: string;
begin
  Result := FFileID;
end;

function TNextDocInfo.FileName: string;
begin
  Result := FFileName;
end;

function TNextDocInfo.OrigName: string;
begin
  Result := FOrigName;
end;

function TNextDocInfo.UtcTimeStamp: integer;
begin
  Result := FTimeU;
end;

end.
