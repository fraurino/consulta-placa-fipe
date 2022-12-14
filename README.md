# <h2>Consultas Veiculares via API </h2>
Consulta Placa Fipe - APi grátis

<b>Documentação:</b> https://documenter.getpostman.com/view/24382542/2s8YeptYeo#intro<Br>
Maiores informações da API, acesse https://apigratis.com.br/

<h2>Download IDE</h2>

<b>Lazarus 2.2.4 by FPC 3.2.2:</b> https://www.lazarus-ide.org/index.php?page=downloads <Br>
<b>Delphi Community Edition:</b> https://www.embarcadero.com/br/products/delphi/starter/free-download<Br>
<b>Visual Studio Code:</b> https://code.visualstudio.com/download<Br>
<b>Visual Studio 2022 Comunidade:</b> https://visualstudio.microsoft.com/pt-br/downloads/<Br>
<h2>Example code em VSCode | CSharp</h2>

```var client = new HttpClient();
var request = new HttpRequestMessage();
request.RequestUri = new Uri("https://placa-fipe.apibrasil.com.br/placa/consulta");
request.Method = HttpMethod.Post;
request.Headers.Add("Accept", "*/*");
request.Headers.Add("User-Agent", "Thunder Client (https://www.thunderclient.com)");
var bodyString = "{\"placa\":\"FMR7534\"}\r";
var content = new StringContent(bodyString, Encoding.UTF8, "application/json");
request.Content = content;
var response = await client.SendAsync(request);
var result = await response.Content.ReadAsStringAsync();
if (response.IsSuccessStatusCode)
{
    fipe veiculo = new fipe();
    log.AppendText(DateTime.Now.ToString() + "| placa encontrada. \n\r");
    var FipeJsonString = await response.Content.ReadAsStringAsync();
    veiculo = JsonConvert.DeserializeObject<fipe>(FipeJsonString);
    Marca.Text     = veiculo.Marca;
    Municipio.Text = veiculo.municipio;
    Renavam.Text   = veiculo.renavam;]
    Chassi.text    = veiculo.chassi;
    Ano.Text       = veiculo.ano;
    Modelo.Text    = veiculo.modelo;
    //--add demais registros;
}
else
{   
   log.AppendText(DateTime.Now.ToString() + "| placa não encontrada. \n\r"); 
}
```

<br>
<h2>Demo em Delphi</h2>
<b>consulta FIPE e consulta Dados</b><Br>

![image](https://user-images.githubusercontent.com/26030963/207500730-8cd55f2b-f340-44fb-b936-168ad19e6308.png)
![image](https://user-images.githubusercontent.com/26030963/207500743-bc3b3311-152c-4a09-9a54-8aa5d4841646.png)


<br><br><br>
<h2>Demo em Lazarus</h2>

![image](https://user-images.githubusercontent.com/26030963/207496081-174b5850-30c5-4113-b7cd-3e271696517f.png)
![image](https://user-images.githubusercontent.com/26030963/207500407-d1cc9d6f-e209-4762-a507-cd5cbef78fb8.png)

<br><br><br>
Requisitos:<br>
Lazarus: Indy; <br>
Delphi : TRest;

*dados retornados e plataforma apigratis.com.br, responsabilidade da api do serviço pelo seu idealizador e proprietário,
porém apenas utilizado neste exemplo de consulta usando Rest e Indy.
