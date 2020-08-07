unit convertForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmConvert = class(TForm)
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lbConverting: TLabel;
    lbConverted: TLabel;
    lbErrors: TLabel;
    Label4: TLabel;
    lbDocFormat: TLabel;
    Label6: TLabel;
    lbDBStatus: TLabel;
    Label7: TLabel;
    lbFSStatus: TLabel;
    Label8: TLabel;
    lbP2FStatus: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FTh:TThread;
    procedure UpdateUI(Sender: TObject);
    procedure StartThread;
    procedure StopThread;
  public
    { Public declarations }
  end;

var
  frmConvert: TfrmConvert;

implementation

uses ServerThread;

{$R *.dfm}

procedure TfrmConvert.UpdateUI(Sender:TObject);
var
  curStatus : TCurrentStatusData;
begin
  curStatus := TCurrentStatusData(Sender);

  lbConverted.Caption := IntToStr(curStatus.NumConverted);
  lbErrors.Caption := IntToStr(curStatus.NumErrors);

  lbConverting.Caption := curStatus.CurFileName;
  lbDocFormat.Caption := curStatus.DocFormat;
  // file system
  if Length(curStatus.FSStatus)>0 then
  begin
     lbFSStatus.Font.Color := clRed;
     lbFSStatus.Caption := curStatus.FSStatus;
  end else
  begin
     lbFSStatus.Font.Color := clWindowText;
     lbFSStatus.Caption := 'OK';
  end;
  // DB
  if Length(curStatus.DbStatus)>0 then
  begin
     lbDBStatus.Font.Color := clRed;
     lbDBStatus.Caption := curStatus.DbStatus;
  end else
  begin
     lbDBStatus.Font.Color := clWindowText;
     lbDBStatus.Caption := 'Connected';
  end;
  // P2F
  if Length(curStatus.P2FStatus)>0 then
  begin
     lbP2FStatus.Font.Color := clRed;
     lbP2FStatus.Caption := curStatus.P2FStatus;
  end else
  begin
     lbP2FStatus.Font.Color := clWindowText;
     lbP2FStatus.Caption := 'OK';
  end;
end;

procedure TfrmConvert.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  StopThread;
end;

procedure TfrmConvert.FormCreate(Sender: TObject);
begin
{$IF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  StartThread;
end;

procedure TfrmConvert.StartThread;
begin
  try
    FTh := TServerThread.Create(true);
    TServerThread(FTh).OnUpdateUI := UpdateUI;
    FTh.Resume;
  except
    ShowException(ExceptObject, ExceptAddr);
    Application.Terminate;
  end;
end;

procedure TfrmConvert.StopThread;
begin
  if Assigned(FTh) then
  begin
    FTh.Terminate;
    FTh.WaitFor;
    FreeAndNil(FTh);
  end;
end;

end.
