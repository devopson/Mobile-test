# Teste Mobile iOS - Editora Positivo
Usando a API da Marvel (https://developer.marvel.com), crie um  App mostrando uma listagem dos personagens para o usuário consultar. 
O usuário tem que poder filtrar os personagens com base no nome, inicial ou data de modificação (ano), sendo que a seleção de um filtro afeta o outro.  A aplicação tem que ser feita em Swift 5. O layout (cores, ícones, imagens) fica a seu cargo. 

Observação: No arquivo README do projeto explique o funcionamento e a solução adotada na sua implementação do desafio.

Frameworks / Bibliotecas:
- AlamofireObjectMapper
- Alamofire
- Package Manager

Diferenciais:
- Componentização
- MVVM(ReactiveCocoa, RxSwift ou implementação própria)

Critérios:
- Performance
- Usabilidade
- Criatividade
- Clean code (código limpo e organizado)


# Teste Mobile Android - Editora Positivo
Usando a API da Marvel (https://developer.marvel.com), crie um  App mostrando uma listagem dos personagens para o usuário consultar. 
O usuário tem que poder filtrar os personagens com base no nome, inicial ou data de modificação (ano), sendo que a seleção de um filtro afeta o outro.  A aplicação tem que ser feita em Kotlin / Java. O layout (cores, ícones, imagens) fica a seu cargo. 

Observação: No arquivo README do projeto explique o funcionamento e a solução adotada na sua implementação do desafio.

Frameworks / Bibliotecas:
- Retrofit

Diferenciais:
- Componentização
- MVVM(RxKotlin ou RxJava)
- Material Design

Critérios:
- Performance
- Usabilidade
- Criatividade
- Clean code (código limpo e organizado)

# Teste Mobile iOS - Implementação

O app IOS criado consiste em uma listagem dos personagens da Marvel em uma tableView, possibilitando ao usuário filtar buscas por nome e ano de modificação. As informações que populam essa tableView são buscadas na Api disponibilizada pela  própria Marvel.

Foi utilizado para fazer as requisição a Api o framework Alamofire, bem como o framework AlamofireObjectMapper para tratar as informações vindas deste.

Optei por incluir esses frameworks via Pods, pois  os 2 framewors tem suporte a ele. Nas minhas pesquisas sobre SPM (Swift Package Manager), vi que é uma plataforma mais voltada para Backend  em Swift e que não possuí compatibilidade com  AlamofireObjectMapper.

A arquitetura empregada foi o MVVM em implementação própria.

Sobre o projeto em si, optei por fazer os filtros de pesquisa acontecendo a cada mudança do valor da searchBar e da alteração do ano de modificação, embora a implementação tenha ficado um pouco mais complexa, acredito que o resultado final tenha sido melhor, do que só realizar a ação quando o usuário apertar um botão.

No código:

Na estrutura MVVM implementada temos a ViewController como nossa view, e a ViewControllerViewModel como nossa view model. 

Na nossa view todas as informações de layout são setadas, e os protocolos e métodos dos componentes utilizados como UITableView, UIPickerView, UISearch. Temos também nela a inicialização da nossa viewControllerViewModel que é a responsável por toda lógica do sistema na nossa view. 

Há vários métodos importantes em nossa ViewControllerViewModel, e é em seus métodos que acessamos a chamada da Api na classe API do sistema, onde se faz a chamada e o parse. 

Os métodos chaves para o sistema funcionar são searchCharacters, reponsável pela primeira requisição e a paginação de todas as listas com filtros e sem filtros, e o searchCharactersSearchBar, reponsável pelas buscas quando existe um valor para a searchBar.

A separação desses códigos foi importante pois ficou mais fácil de trabalhar com buscas em tempo de digitação, que foi implementado da seguinte forma:

Cada vez que o usuário digitasse alguma letra na searchbar o método getSearch da viewmodel é chamado, nele chamo se estiver vazio o método  searchCharacters, para popular a lista com todos os personagens. Já quando a string não é vazio  salvo o valor da search bar em uma variavel chamada oldSearch, e chamo o método searchCharactersSearchBar ela irá executar em recursividade até que a oldString seja igual ao valor da searchBar atual parando assim de puxar informações do servidor.

Vale ressaltar que enquanto a searchbar fica em recursividade, o método  getSearch não é chamado quando se tem mudança na search bar, isso porque se não o sistema faria 2 requisições ao mesmo tempo, o que poderia ocasionar em listagens erradas para algumas buscas se a ultima requisição solicitada acabasse primeiro do que a primeira. E com isso a função recursiva da conta de atualizar os resultados pois ele só executa quando a searchbar tem um valor diferente da oldSearch. 

Assim caso o usuário digite "spider" a requisição puxará o "s" depois que executar ela, ela irá puxar o valor da searchbar atual que no momento pode ser  "sp", "spi", "spid", "spide" ou até mesmo "spider". Diminuindo o número de requisições para somente o necessário.

As funções searchCharacters e searchCharactersSearchBar contemplam também a busca por data de modificação quando há. Fazendo o proposto no desafio que era os filtros serem dependentes.


No mais separei a cell da tableview em uma xib para melhor replicação do layout, e criei uma viewModel para a própria cell.








