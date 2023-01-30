<p align="center">
    <img src="assets\logo.png" width="100" alt="Logo App ToDoList"/>
</p>

<h1 align="center">ToDoList</h1>

---

<h2>Tópicos 📋</h2>

   <p>

   - [📖 Sobre](#-sobre)
   - [📱 Preview](#-preview)
   - [📦 Assets](#-assets)
   - [🛠️ Funcionalidades e Tecnologias Estudadas](#%EF%B8%8F-funcionalidades-e-tecnologias-estudadas)
   - [🤯 Desafios e Aprendizados ao longo do caminho](#-desafios-e-aprendizados-ao-longo-do-caminho)
   - [🤔 Como usar](#-como-usar)
   - [💪 Como contribuir](#-como-contribuir)
   - [📝 Licença](#-licença)

   </p>

---

<h2>📖 Sobre</h2>

<p>
    Projeto desenvolvido na <a href="http://academiadoflutter.com.br/">Academia do Flutter (ADF)</a>, do Especialista em Flutter, <a href="https://github.com/rodrigorahman">Rodrigo Rahman</a>.<br><br>
    No desenvolvimento desse app, pude aprender como é feita uma arquitetura de módulos, semelhante ao que o <a href="https://pub.dev/packages/flutter_modular">flutter_modular</a> faz.<br>
    Utilizamos o package <a href="https://pub.dev/packages/provider">provider</a> para podermos gerenciar nossa dependências (DI) e uma navegação própria, chamada de AppNavigator.<br>
    Para gerenciar o estado de aplicação, utilizamos a gerência nativa do Flutter, o ChangeNotifier.
</p>

---

<h2>📱 Preview</h2>

   <p align="center">
      <img src=".github/ToDoList-Demo.gif" width="400" alt="ToDoList Demonstração">
   </p>

---

<h2>🛠️ Funcionalidades e Tecnologias Estudadas</h2>

- Consulta da API usando o package Dio
- ChangeNotifier como Gerenciamento de Estado
- Fluxo de Login e Logout com a aplicação
- Armazenamento de dados no celular com o SQLite
- Navegação própria do app
- Migrations
- Modularização
- Autenticação com Firebase
- Providers
- Mixins
- Telas: 
  - Splash (tela inicial do app para transição)
  - Home (tela principal do app, lista todas as tarefas, podendo filtrar por finalizadas ou não e que serve de fluxo inicial para as demais telas descritas abaixo)
  - Login (onde possui o fluxo de login)
  - Register (onde possui o fluxo de cadastro de usuário)
  - Tasks (criação da tarefa, necessitando preencher uma data e uma descrição da mesma)
   </p>

---

<h2>🤯 Desafios e Aprendizados ao longo do caminho</h2>

   <p>
   Com esse aplicativo, aprendi muito uma arquitetura diferente e à priori, divertida para se usar em desenvolvimento com Flutter. Modularizar o app facilita para a manutenção do código e adição de novas features também, onde cada módulo é indidivual, não dependendo do outro para funcionar.<br>
   Aprendi também a usar o provider a fundo com o ChangeNotifier, recomendado pela própria Google. Foi desafiador entender de começo como funciona essa gerência de estado, mas gratificante saber o que de fato está ocorrendo!
   </p>

---

<h2>🤔 Como usar</h2>

   ```
   É necessário ter o Flutter instalado. Para configurar o ambiente de desenvolvimento na sua máquina:
   https://flutter.dev/docs/get-started/install

   - Clone o repositório:
   $ git clone https://github.com/GabrielCR99/dw9_vakinha_burger_bloc dw9_vakinhar_burger_bloc

   - Entre no diretório:
   $ cd dw9_vakinhar_burger_bloc

   - Instale as dependências:
   $ flutter pub get

   - Em outro terminal, no diretório raiz do projeto, execute:
   $ flutter run
   ```

---

<h2>💪 Como contribuir</h2>

   ```
   - Gosto bastante de seguir a seguinte Style Guide de Commits 😊:
   https://udacity.github.io/git-styleguide/

   - Dê um fork no projeto 

   - Cria uma nova branch com suas mudanças:
   $ git checkout -b my-feature

   - Salve suas mudanças e faça uma mensagem de commit message sobre suas alterações:
   $ git commit -m "feat: My new feature"

   - Envie suas mudanças:
   $ git push origin my-feature
   ```

---

<h2>📝 Licença</h2>

<p>
   Esse repositório está sobre a Licença MIT, e você pode vê-la no arquivo <a href="https://github.com/GabrielCR99/dw9_vakinha_burger_bloc/blob/master/LICENSE">LICENSE</a> para mais detalhes. 😉
</p>

---

   >Esse projeto foi desenvolvido com ❤️ por **[@Gabriel Roveri](https://www.linkedin.com/in/gabriel-roveri/)**, com o instrutor **[@Rodrigo Rahman](https://br.linkedin.com/in/rodrigo-rahman)**, no evento #DartWeek da **[Academia do Flutter](https://instituto.academiadoflutter.com.br)**.<br>
   Se isso te ajudou, dê uma ⭐, e contribua, isso irá me ajudar também 😉

---

   <div align="center">

   [![Linkedin Badge](https://img.shields.io/badge/-Gabriel%20Roveri-292929?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/gabriel-roveri/)](https://www.linkedin.com/in/gabriel-roveri/)

   </div>