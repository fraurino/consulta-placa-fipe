unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MaskUtils, ShellApi, IdHTTP, IdSSLOpenSSL, System.JSON,
  StrUtils, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdStack, IdStackConsts,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, Vcl.StdCtrls,   WinInet,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB , ToolWin , Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  IdServerIOHandler, REST.Types, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Client, REST.Authenticator.Basic;

type
  TfrmMain = class(TForm)
    edtPlaca: TLabeledEdit;
    log: TMemo;
    cbbServico: TComboBox;
    Label1: TLabel;
    btnConsultar: TButton;
    Marca: TLabeledEdit;
    Municipio: TLabeledEdit;
    Renavam: TLabeledEdit;
    Ano: TLabeledEdit;
    Modelo: TLabeledEdit;
    Chassi: TLabeledEdit;
    Token: TLabeledEdit;
    CodigoFipe: TLabeledEdit;
    Label2: TLabel;
    procedure btnConsultarClick(Sender: TObject);
    procedure cbbServicoChange(Sender: TObject);
    procedure cbbServicoClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
    procedure addlog(value : string );
    procedure cleanedit ;

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation



{$R *.dfm}

procedure TfrmMain.addlog(value: string);
begin
log.Lines.Add(FormatDateTime('ddmmyyyy hhmmss', now)+ '|'+value);
update;
end;

procedure TfrmMain.btnConsultarClick(Sender: TObject);
var
    client        : TRESTClient ;
    resquest      : TRESTRequest;
    response      : TRESTResponse ;
    Authenticator : THTTPBasicAuthenticator;
    JSONResponse  : TJSONObject  ;

    extra : TJSONObject;
    fipe, fipe_dados :TJSONObject;
begin

    if cbbServico.ItemIndex =-1 then  Exit;
    if edtPlaca.text = EmptyStr then exit;

    cleanedit;
    update;

    btnConsultar.Caption :='Consultando. Aguarde...';
    btnConsultar.Repaint;
    client   := TRESTClient.Create(self);
    resquest := TRESTRequest.Create(self);
    response := TRESTResponse.Create(self);
    Authenticator := THTTPBasicAuthenticator.Create(self);

    try
      addlog('conectando ao servico') ;
      case cbbServico.ItemIndex of
       0: client.BaseURL := 'https://placa-fipe.apibrasil.com.br/placa/consulta';
       1: client.BaseURL := 'https://sinesp.contrateumdev.com.br/api';
      end;

      client.ContentType            := 'application/json';
      resquest.Client                := client;
      resquest.AcceptCharset         := 'utf-8, *;q=0.8';
      resquest.Method                := rmPOST;
      resquest.Response              := response;
      resquest.Params.Clear;
      resquest.params.AddItem;
      resquest.Params.Items[0].Value := '{"placa":"'+edtPlaca.text+'"}';
      resquest.Params.Items[0].Kind  := pkREQUESTBODY;
      resquest.Params.Items[0].ContentType := ctAPPLICATION_JSON;

      if Token.Text <>'' then
      begin
        resquest.params.AddItem;
        resquest.Params.Items[1].Name  := 'chave'; //campo do token;
        resquest.Params.Items[1].Value := token.Text;
        resquest.Params.Items[1].Kind  := pkHTTPHEADER;
      end;

      resquest.Execute;
      addlog('json response:' +#13+#10+ response.JSONText);
      JSONResponse := TJSONObject.Create;
      JSONResponse := response.JSONValue as TJSONObject;

        if response.StatusCode = 200 then
        begin
           if token.Text ='' then
           begin
            Marca.text       := JSONResponse.GetValue('Marca').Value;
            CodigoFipe.text  := JSONResponse.GetValue('CodigoFipe').Value;
            municipio.text   := JSONResponse.GetValue('municipio').Value +'/'+JSONResponse.GetValue('uf').Value ;
            renavam.text     := JSONResponse.GetValue('renavam').Value;
            ano.text         := JSONResponse.getvalue('AnoModelo').value;
            modelo.text      := JSONResponse.GetValue('Modelo').Value;
            chassi.Text      := JSONResponse.GetValue('chassi').Value;
           end;

           if token.Text <>'' then
           begin
            Marca.text       := JSONResponse.GetValue('MARCA').Value;
            municipio.text   := JSONResponse.GetValue('municipio').Value +'/'+JSONResponse.GetValue('uf').Value ;

            extra := TJSONObject(JsonResponse.GetValue('extra'));
            if extra.GetValue('chassi') <> nil then
            begin
              Chassi.text  := extra.GetValue('chassi').Value;
              renavam.text := extra.GetValue('renavam').Value;
              ano.text     := extra.getvalue('ano_modelo').value;
            end ;
           end;
        end
        else
        begin
          if Assigned(JSONResponse.GetValue('message')) then
          begin
             addlog('Error: ' + JSONResponse.GetValue('message').ToString);
             showmessage(JSONResponse.GetValue('message').ToString);
          end;
        end;

    finally
      response.free;
      resquest.free;
      client.free;
      btnConsultar.Caption :='Consultar Placa';
      btnConsultar.Repaint;
    end;

end;

procedure TfrmMain.cbbServicoChange(Sender: TObject);
begin
    case cbbservico.ItemIndex of
     0 : token.clear;
     1 : token.Text :='chavedemo';
    end;
    update;
end;

procedure TfrmMain.cbbServicoClick(Sender: TObject);
begin
  case cbbservico.ItemIndex of
   0 : token.clear;
   1 : token.Text :='chavedemo';
  end;
  update;
end;



procedure TfrmMain.cleanedit;
begin
  Marca.clear;
  CodigoFipe.clear;
  municipio.clear;
  renavam.clear;
  Chassi.Clear;
  Ano.clear;
  Modelo.clear;
  log.Lines.clear;
  update;
end;

procedure TfrmMain.Label2Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'https://github.com/fraurino', '', '', 1);
  ShellExecute(Handle, 'open', 'https://apigratis.com.br', '', '', 1);
end;

end.
