# Documentação de Deploy da API .NET no Azure

Esta documentação descreve como a API foi publicada no **Azure** utilizando o **Azure App Service** e um **Azure SQL Database**, além de instruções para realizar o mesmo processo via **Azure CLI**.
O projeto foi criado com foco da documentação de jogos, preços e suas respectivas datas de lancamento. Uma API .NET Core voltada para criação de EndPoints que possam fornecer essa criação, deleção, alteração e deleção desses jogos e suas informações.
---

## 1. Estrutura do Projeto

- **Projeto:** MinhaAPI
- **Tecnologia:** .NET 9 (ou versão do seu projeto)
- **Banco de Dados:** Azure SQL Database
- **Hospedagem:** Azure App Service

---

## 2. Deploy via Portal do Azure

O deploy foi feito diretamente pelo portal do Azure seguindo os passos abaixo:

1. **Criar App Service**
   - No portal do Azure, clique em **"Criar um recurso" → "Web App"**.
   - Preencha os campos:
     - **Nome do App:** `nome-do-app`
     - **Assinatura e Grupo de Recursos:** selecione os desejados
     - **Sistema Operacional:** Windows/Linux
     - **Plano de Serviço:** Crie um novo ou utilize um existente
   - Clique em **Revisar + Criar → Criar**.

2. **Criar Banco de Dados SQL**
   - No portal, clique em **"Criar um recurso" → "Banco de Dados SQL"**.
   - Preencha os campos:
     - **Nome do Banco:** `nome-do-banco`
     - **Servidor:** Crie um novo servidor ou utilize um existente
     - **Autenticação:** SQL Server Authentication (usuário e senha)
   - Clique em **Revisar + Criar → Criar**.

3. **Configurar Connection String**
   - No App Service, vá em **Configurações → Configurações de Aplicativo**.
   - Adicione a **Connection String** do banco:
     ```
     Server=tcp:cp5-devops.database.windows.net
     Initial Catalog=GameCatalog;
     User ID=admin123;
     Password=Senha123;
     ```
   - Defina o **tipo** como `SQLServer`.

4. **Publicar a API**
   - No Visual Studio:
     - Clique com o botão direito no projeto → **Publicar → Azure → Azure App Service → Selecionar App existente**.
     - Selecione o **App Service** criado.
     - Clique em **Publicar**.

5. **Testar a API**
   - Acesse a URL do App Service:
     ```
     devops-cp5-efbcfebpdkg9f3er.brazilsouth-01.azurewebsites.net/swagger
     ```
     - Forcei no Program.cs para a aplicação utilizar o Swagger em prod!

---

## 3. Deploy via Azure CLI

Para realizar o deploy pelo terminal, siga os passos abaixo:

### 3.1 Login no Azure
```bash
az login
```
### 3.2 Criar Grupo de Recursos
```
az group create --name MeuGrupoRecursos --location brazilsouth
```
### 3.3 Criar App Service Plan
```
az appservice plan create --name MeuPlano --resource-group MeuGrupoRecursos --sku B1 --is-linux
```
### 3.4 Criar Web App
```
az webapp create --resource-group MeuGrupoRecursos --plan MeuPlano --name NomeDoApp --runtime "DOTNET|9.0"
```
### 3.5 Criar Banco Azure SQL
```
az sql server create --name MeuServidorSQL --resource-group MeuGrupoRecursos --location brazilsouth --admin-user meuusuario --admin-password minhaSenha123!
```
```
az sql db create --resource-group MeuGrupoRecursos --server MeuServidorSQL --name MeuBanco --service-objective S0
```
### 3.6 Configurar Connection String
```
az webapp config connection-string set --resource-group MeuGrupoRecursos --name NomeDoApp --settings DefaultConnection="Server=tcp:MeuServidorSQL.database.windows.net,1433;Initial Catalog=MeuBanco;User ID=meuusuario;Password=minhaSenha123!" --connection-string-type SQLAzure
```
### 3.7 Publicar via CLI (opcional)

#### Gere um pacote de publicação (zip) no Visual Studio ou CLI:
```
dotnet publish -c Release -o ./publish
```

### Faça o deploy via CLI:
```
- az webapp deploy --resource-group MeuGrupoRecursos --name NomeDoApp --src-path ./publish
```
### 4. Observações

Certifique-se de que a porta 1433 está liberada no firewall do Azure SQL Server.
Atualize a Connection String antes de publicar.
Para logs e diagnósticos, use o Azure Monitor ou habilite Application Insights.

## 5. Referências

- Documentação Azure App Service
- Documentação Azure SQL Database
- Azure CLI
- Vídeo explicativo de Deploy utilizando github actions no youtube: https://www.youtube.com/watch?v=giCR4VgKjQY
