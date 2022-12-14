program Demo;

uses
  Vcl.Forms,
  uMain in 'view\uMain.pas' {frmMain},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sky');
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
