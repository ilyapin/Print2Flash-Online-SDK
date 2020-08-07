// JCL_DEBUG_EXPERT_GENERATEJDBG ON
// JCL_DEBUG_EXPERT_INSERTJDBG ON
program convsrv;

{$R 'template.res' 'template.rc'}

uses
  Vcl.Forms,
  ServerThread in 'ServerThread.pas',
  convertForm in 'convertForm.pas' {frmConvert},
  Print2Flash5_TLB in 'Print2Flash5_TLB.pas',
  uUtils in 'uUtils.pas',
  db in 'db.pas',
  dbSqlLite in 'dbSqlLite.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmConvert, frmConvert);
  Application.Run;
end.
