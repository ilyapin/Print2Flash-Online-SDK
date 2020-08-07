unit dbSqlLite;

interface
uses System.SysUtils, db, Data.DbxSqlite, Data.DB, Data.SqlExpr;

type
  TSqlLiteDB = class (TInterfacedObject, IDBIntf)
  private
    DBQuery : TSQLQuery;
    DBConn : TSQLConnection;
    FLastError : string;
  public
    function  Connected:boolean;
    function  GetNextInputFile:IDocInfo;
    procedure LogConversion(status : TDocStatus; const ConvID : string);
    procedure LogConversionError(const ConvID, Error : string);
    function  GetLastError : string;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses uUtils, System.IniFiles, Data.DBXCommon;

const
  DefBusyTimeoutSec = 15;

type
  TIniParams = record
    DBPath : string;
    BusyTimeout : integer;
  end;

procedure ReadIniParams(out params:TIniParams);
var
  iniFile : TIniFile;
  sIniFileName : string;
begin
  sIniFileName := ChangeFileExt(ParamStr(0), '.ini');
  if not FileExists(sIniFileName) then
     raise Exception.CreateFmt('INI file(%s) not found',[sIniFileName]);
  iniFile := TIniFile.Create(sIniFileName);
  try
    params.DBPath := ReadFileName(iniFile, 'DBPath', true);
    params.BusyTimeout := StrToInt(
            iniFile.ReadString('Sqlite', 'BusyTimeoutSec', IntToStr(DefBusyTimeoutSec)));
  finally
    iniFile.Free;
  end;
end;

function IsDatabaseLockedException(e:TObject):boolean;
begin
  Result := (e is TDBXError) and (TDBXError(ExceptObject).ErrorCode = 5)
end;

// TSqlLiteDB

function TSqlLiteDB.Connected: boolean;
begin
  Result := Assigned(DBConn) and Assigned(DBQuery) and DBConn.Connected;
end;

constructor TSqlLiteDB.Create;
var
  iniParams : TIniParams;
begin
  inherited;
  ReadIniParams(iniParams);

  DBConn := TSQLConnection.Create(nil);
  DBConn.LoginPrompt := false;
  DBConn.DriverName := 'Sqlite';
  DBConn.Params.Add('Database=' + iniParams.DBPath);
  DBConn.Connected := true;
  DBConn.ExecuteDirect('PRAGMA busy_timeout = '+IntToStr(iniParams.BusyTimeout*1000)+';');

  DBQuery := TSQLQuery.Create(nil);
  DBQuery.SQLConnection := DBConn;
end;

destructor TSqlLiteDB.Destroy;
begin
  FreeAndNil(DBQuery);
  FreeAndNil(DBConn);
  inherited;
end;

function TSqlLiteDB.GetLastError: string;
begin
  Result := FLastError;
end;

function TSqlLiteDB.GetNextInputFile: IDocInfo;
begin
  Result := nil;
  try
    DBQuery.Close;
    DBQuery.SQL.Text :=
       'SELECT p2fconv.id, p2fconv.fileid, '+
             ' p2fconv.status, p2fconv.docformat, p2fconv.time_converted, '+
             ' p2ffile.origname, p2ffile.ext '+
       'FROM p2fconv INNER JOIN p2ffile ON p2fconv.fileid = p2ffile.id '+
       'WHERE p2fconv.status="U" '+
       'ORDER BY p2fconv.time_converted '+
       'LIMIT 1';
    DBQuery.Open;
    try
      if not DBQuery.Eof then
         Result := TNextDocInfo.Create(
                      DBQuery.FieldValues['fileid'],
                      DBQuery.FieldValues['id'],
                      'doc.' + DBQuery.FieldValues['ext'],
                      DBQuery.FieldValues['origname'],
                      Str2DocFormat(DBQuery.FieldValues['docformat']),
                      DBQuery.FieldValues['time_converted']);
    finally
      DBQuery.Close;
    end;

    FLastError := '';
  except
    FLastError := Exception(ExceptObject).Message;
    LogException(Exception(ExceptObject));
  end;
end;

procedure TSqlLiteDB.LogConversion(status : TDocStatus; const ConvID : string);
begin
  try
    DBQuery.Close;
    DBQuery.SQL.Text := 'UPDATE p2fconv SET status=:status, time_converted=:time WHERE id=:ConvID';
    DBQuery.Prepared := true;

    DBQuery.Params.ParamByName('status').AsString := DocStatus2Str(status);
    DBQuery.Params.ParamByName('time').AsInteger := UtcNowAsUnixTimeStamp;
    DBQuery.Params.ParamByName('ConvID').AsString := ConvID;

    DBQuery.ExecSQL;

    FLastError := '';
  except
    FLastError := Exception(ExceptObject).Message;
    LogException(Exception(ExceptObject));
    raise;
  end;
end;

procedure TSqlLiteDB.LogConversionError(const ConvID, Error: string);
var
  t : TDBXTransaction;
begin
  try
    t := DBConn.BeginTransaction;
    try
      DBQuery.Close;
      DBQuery.SQL.Text := 'UPDATE p2fconv SET status="E", time_converted=:time WHERE id=:ConvID';
      DBQuery.Prepared := true;
      DBQuery.Params.ParamByName('time').AsInteger := UtcNowAsUnixTimeStamp;
      DBQuery.Params.ParamByName('ConvID').AsString := ConvID;
      DBQuery.ExecSQL;

      DBQuery.Params.Clear;
      DBQuery.SQL.Text := 'INSERT INTO p2fconverror(convid, error) VALUES (:ConvID, :error)';
      DBQuery.Prepared := true;
      DBQuery.Params.ParamByName('error').AsString := Error;
      DBQuery.Params.ParamByName('ConvID').AsString := ConvID;
      DBQuery.ExecSQL;

      DBConn.CommitFreeAndNil(t);
    except
      DBConn.RollbackFreeAndNil(t);
      raise;
    end;

    FLastError := '';
  except
    FLastError := Exception(ExceptObject).Message;
    LogException(Exception(ExceptObject));
    raise;
  end;
end;

end.
