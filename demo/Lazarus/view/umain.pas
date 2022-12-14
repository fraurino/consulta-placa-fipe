unit uMain;
{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, shellapi,TypInfo, Buttons, ComCtrls, ExtCtrls, DBGrids, fpjson,
  jsonparser, IdHTTP, IdSSLOpenSSL, IdStack, IdStackConsts, DateUtils, BufDataset ;

type
  { TfrMain }
  TfrMain = class(TForm)
    Ano: TLabeledEdit;
    btnConsultar: TButton;
    cbbServico: TComboBox;
    Chassi: TLabeledEdit;
    CodigoFipe: TLabeledEdit;
    edtPlaca: TLabeledEdit;
    Label1: TLabel;
    Label2: TLabel;
    log: TMemo;
    Marca: TLabeledEdit;
    Modelo: TLabeledEdit;
    Municipio: TLabeledEdit;
    Renavam: TLabeledEdit;
    Token: TLabeledEdit;
    procedure btnConsultarClick(Sender: TObject);
    procedure cbbServicoChange(Sender: TObject);
    procedure cbbServicoChangeBounds(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    procedure addlog(value : string );
    procedure cleanedit ;
  public
  end;
var
  frMain: TfrMain;

implementation
{$R *.lfm}

{ TfrMain }

procedure TfrMain.Label2Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'https://github.com/fraurino', '', '', 1);
  ShellExecute(Handle, 'open', 'https://apigratis.com.br', '', '', 1);
end;
procedure TfrMain.cbbServicoChange(Sender: TObject);
begin
   case cbbservico.ItemIndex of
     0 : token.clear;
     1 : token.Text :='chavedemo';
    end;
    update;
end;
procedure TfrMain.btnConsultarClick(Sender: TObject);
const
  _notfound : string = 'Placa não encontrada na base.';
var
httpclient    : TIdHTTP;
idssl  : TIdSSLIOHandlerSocketOpenSSL;
response : TStringStream;
RequestBody: TStringStream;
url: string ;
json : TJSONData;
extra :  TJSONData;
begin
  try
    btnConsultar.Caption :='Consultando. Aguarde...';
    btnConsultar.Repaint;
    cleanedit;
    update;
    case cbbServico.ItemIndex of
      0: url := 'https://placa-fipe.apibrasil.com.br/placa/consulta';
      1: url := 'https://sinesp.contrateumdev.com.br/api';
    end;

    addlog('conectando ao servico');

    httpclient := TidHTTP.Create;
    idssl := TIdSSLIOHandlerSocketOpenSSL.Create;
    httpclient.IOHandler := idssl;
    idssl.SSLOptions.SSLVersions := [sslvTLSv1_2]  ;
    httpclient.Request.Clear;
    httpclient.Request.CustomHeaders.Clear;
    httpclient.Request.Method := 'POST' ;
    httpclient.Request.ContentType := 'application/json' ;
    httpclient.ConnectTimeout:= 30000;
    httpclient.Request.CustomHeaders.FoldLines := False;
    if token.text =''then
    begin
     RequestBody := TStringStream.Create('{"placa":"'+edtPlaca.text+'"}', TEncoding.UTF8); 
    end;
    if token.text <> ''then
    begin
     RequestBody := TStringStream.Create('{"placa":"'+edtPlaca.text+'"}', TEncoding.UTF8);
     HttpClient.Request.CustomHeaders.Values['chave'] := token.text ;
    end;
    Response := TStringStream.Create('');
    Response.Position := 0;
    try
      httpclient.post   ( url, RequestBody, response);
      json := GetJSON(UTF8ToString(Response.DataString));
      if httpclient.ResponseCode = 429 then
      begin
       addlog('aguarde 60 segundos para próxima consulta');
      end
      else
      if httpclient.ResponseCode = 200 then
      begin
         addlog( 'json response: '+ #10#13+ json.FormatJSON() );
         if token.text ='' then
         begin
          Marca.text       := json.GetPath('Marca').Value;
          CodigoFipe.text  := json.GetPath('CodigoFipe').Value;
          municipio.text   := json.GetPath('municipio').Value +'/'+json.GetPath('uf').Value ;
          renavam.text     := json.GetPath('renavam').Value;
          ano.text         := copy(json.GetPath('AnoModelo').Value, 1,4);
          modelo.text      := copy(json.GetPath('Modelo').Value, 6,9);
          chassi.Text      := json.GetPath('chassi').Value;
         end;
         if json.getpath('message').value <> _notfound then
         begin
           if token.Text <>'' then
           begin
             Marca.text       := json.GetPath('MARCA').Value;
             municipio.text   := json.GetPath('municipio').Value +'/'+json.GetPath('uf').Value ;
             extra := TJSONObject(json.GetPath('extra'));
             if extra.GetPath('chassi') <> nil then
             begin
               Chassi.text  := extra.GetPath('chassi').Value;
               renavam.text := extra.GetPath('renavam').Value;
               ano.text     := extra.GetPath('ano_modelo').value;
             end ;
           end;
         end;
      end;
    except on E: EIdSocketError do
      begin
        case e.LastError of
          Id_WSAETIMEDOUT: addlog ('A conexão expirou');
          Id_WSAEACCES:    addlog ('não há acesso');
        else
         addlog( e.message);
        end;
      end;
      on E: Exception do
      begin
        if {--} pos('400',E.Message) > 0 then
        ShowMessage('400 – Requisição ruim: A requisição não pôde ser interpretada pelo servidor em razão de erros de formato/sintaxe.')
        Else if pos('401',E.Message) > 0 then
        ShowMessage('401 – Não autorizado:'#13#13'A requisição requer autenticação por parte do cliente e as informações de'#13'autenticação não foram localizadas ou não são válidas.')
        Else if pos('405',E.Message) > 0 then
        ShowMessage('405 – Método não permitido:'#13'O método HTTP utilizado não é permitido para o recurso identificado na URL')
        Else if pos('422',E.Message) > 0 then
        ShowMessage('422 – Entidade não processável:'#13'O servidor reconhece que as informações estão na sintaxe correta, mas seu conteúdo está semanticamente incorreto.')
        Else if pos('11001',E.Message) > 0 then
        ShowMessage('11001 – Sem conexão com a Internet')
        Else if pos('429',E.Message) > 0 then
        ShowMessage('429 – Muitas solicitações. tempo entre consultas de 60 segundos.');
      end;
    end;
  finally
    idssl.free;
    response.free;
    httpclient.free;
    btnConsultar.Caption :='Consultar Placa';
    btnConsultar.Repaint;
    update;
  end;
end;
procedure TfrMain.cbbServicoChangeBounds(Sender: TObject);
begin
   case cbbservico.ItemIndex of
     0 : token.clear;
     1 : token.Text :='chavedemo'; //chame apenas para teste. contrate o token para uso em produção. https://apigratis.com.br
    end;
    update;
end;
procedure TfrMain.addlog(value: string);
begin
  log.Lines.Add(FormatDateTime('dd-mm-yyyy hh.mm.ss-zzz', now)+ '|'+value);
  update;
end;
procedure TfrMain.cleanedit;
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

end.

