# 2023.2-Grupo01-StardewValley

<div align="center"> <img src="docs/imagens/capa_stardew-valley.jpg" height="230" width="auto"/> </div>

<div align="center">Repositório para desenvolvimento de um MUD inspirado em Stardew Valley da disciplina de SBD1 - 2023.2</div>

## Alunos

| Nome                                                               | Matrícula |
| :----------------------------------------------------------------- | :-------: |
| [Edilberto Cantuaria](https://github.com/edilbertocantuaria)       | 222014984 |
| [Marcus Vinícius Paiva Martins](https://github.com/marcusmartinss) | 211043683 |
| [Matheus Phillipo Silverio Silva](https://github.com/MattSilverio) | 150154348 |
| [Zenilda Vieira](https://github.com/zenildavieira)                 | 212002907 |

## Jogo

Após herdar a fazenda do seu avô no Vale do Orvalho, você decide deixar a vida na cidade para aprender a viver da terra. Equipado com ferramentas de segunda mão e algumas moedas, você irá começar sua nova vida. Será que você consegue transformar a fazenda em um próspero lar, conseguindo moedas e fazendo novos amigos?

### Como o jogo funciona?

Stardew Valley é um jogo que se desenrola em mundos variados, cada um contendo uma fazenda única que o jogador deve administrar. Nestes mundos, encontramos diversas áreas ao ar livre, algumas com construções fechadas, como casas de NPCs, casas de jogadores, lojas e cavernas.

Existe um ciclo de quatro estações: primavera, verão, outono e inverno, cada uma com 28 dias. Cada estação influencia quais sementes podem crescer e apresenta missões distintas. A jornada começa no dia 1 da primavera, com o jogador começando com saúde e energia em 100%. A energia do jogador diminui ao longo do dia, à medida que ele executa tarefas. Ele pode recuperá-la dormindo em sua cabana (100%) ou usando itens consumíveis com efeitos variados. A saúde só diminui ao combater monstros ou usar itens prejudiciais, mas pode ser restaurada com itens de cura.

As habilidades de coleta, cultivo, mineração, pesca e combate pertencem ao jogador, os itens obtidos com essas atividades podem ser vendidos por ouro e armazenados em um inventário.

É permitida a exploração áreas ao ar livre ou locais fechados, incluindo cavernas para minerar itens. Essas cavernas podem conter monstros que o jogador deve enfrentar, com danos baseados em suas habilidades de combate e na defesa do monstro. Os Monstros derrotados deixam itens específicos. NPCs também têm suas cabanas, profissões e podem possuir lojas. Eles interagem com o jogador, oferecendo dicas e vendendo itens.

O jogador pode criar itens manufaturados através de artesanato, utilizando receitas disponíveis para melhorar sua fazenda e experiência no jogo. Há diversos tipos de itens no jogo, como ferramentas para tarefas específicas, sementes para plantio, armas com valores de dano, consumíveis que afetam saúde, energia e combate, vestimentas, e produtos de artesanato criados com receitas disponíveis.

**No vídeo abaixo é possível identificar de forma visual:**

<div align="center">
<a href="https://www.youtube.com/watch?v=FjJx6u_5RdU"><img src="https://i.ytimg.com/vi/FjJx6u_5RdU/maxresdefault.jpg" width="50%"></a>
</div>

### Como jogar?

1. Após clonar o repositório, abra o terminal no seu sistema operacional.

2. Navegue até a pasta "StardewValley-Backend" usando o comando `cd` (change directory):

```bash
cd StardewValley-Backend
```

Certifique-se de que você está no diretório correto antes de prosseguir.

3. Crie um arquivo `.env` na pasta com a seguinte linha de comando, substituindo os parâmetros pelos dados do seu banco postgres.

```bash
CONNECTION_STRING=postgres://postgres:senha@localhost:5432/stardewvalley?charset=utf8
```

4. Instale as dependências necessárias para o jogo utilizando o comando `npm install`:

```bash
npm install
```

Isso garantirá que todas as bibliotecas e pacotes necessários estejam instalados para executar o jogo.

5. Após a conclusão da instalação, você estará pronto para rodar o jogo. Use o comando `npm run game` para criar o banco de dados e as tabelas necessárias e iniciar o jogo:

```bash
npm run game
```

Este comando executará o jogo, permitindo que você entre no mundo de Stardew Valley. 🏡🌾🐔

## Como jogar?

Se você já tiver executado o comando `npm run game` pelo menos uma vez, para rodar o jogo novamente basta executar o comando abaixo dentro da pasta "StardewValley-Backend":

```bash
npm run start
```

## Apresentações

| Módulo | Link da gravação                                                                                    | Data       |
| ------ | --------------------------------------------------------------------------------------------------- | ---------- |
| 1      | [Apresentação Módulo 1](./docs/apresentacoes/apresentacao_m01.mp4)                                  | 30/09/2023 |
| 2      | [Apresentação Módulo 2](./docs/apresentacoes/apresentacao_m02.mp4)                                  | 30/10/2023 |
| 3      | [Apresentação Módulo 3](./docs/apresentacoes/apresentacao_m03%20-%20Edilberto%20e%20Zenilda.mp4)    | 04/12/2023 |
| Final  | [Apresentação Final Zenilda e Matheus](./docs/apresentacoes/apresentacao_final_zenilda_matheus.mp4) | 11/12/2023 |
| Final  | [Apresentação Final Marcus](./docs/apresentacoes/apresentacao_final_marcus.mp4)                     | 11/12/2023 |

## Entregas

- Módulo 1

  - [Diagrama Entidade-Relacionamento](./docs/Entrega-01/DER_StardewValley_v1.0.md)
  - [Dicionário de Dados](./docs/Entrega-01/DD_StardewValley_v1.0.md)
  - [Modelo Entidade-Relacionamento](./docs/Entrega-01/MER_StardewValley_v1.0.md)
  - [Modelo Relacional](./docs/Entrega-01/MREL_StardewValley_v1.0.md)

- Módulo 2

  - [Normalização](./docs/Entrega-02/modelagem-normalizada)
  - [DDL](./docs/Entrega-02/DDL.sql)
  - [DML](./docs/Entrega-02/DML.sql)
  - [DQL](./docs/Entrega-02/DQL.sql)
  - [Álgebra Relacional](./docs/Entrega-02/algebra_relacional.pdf)

- Módulo 3

  - [Dinâmica do Jogo](./docs/Entrega-03/Definicoes_Dinamica_Jogo.md)
  - [Histórias de usuários adaptado](./docs/Entrega-03/Historias_de_Usuario_adaptado.md)
  - [Stored Procedures, Triggers e Views](./docs/Entrega-03/Stored_Procedures_Triggers_Views.sql)

- Módulo Final
  - Jogo MUD

### Histórico de versões

| Versão |    Data    | Descrição                                      | Autor                                               | Revisão                                                      |
| :----: | :--------: | ---------------------------------------------- | --------------------------------------------------- | ------------------------------------------------------------ |
| `1.0`  | 24/09/2023 | Inclusão das considerações feitas na modelagem | [Zenilda Vieira](https://github.com/ZenildaVieira)  | [Marcus Martins](https://github.com/marcusmartinss)          |
| `1.1`  | 28/09/2023 | Estruturação do README do projeto              | [Marcus Martins](https://github.com/marcusmartinss) |                                                              |
| `1.2`  | 30/10/2023 | Links da entrega 02                            | [Zenilda Vieira](https://github.com/ZenildaVieira)  | [Edilberto Cantuaria](https://github.com/edilbertocantuaria) |
| `1.3`  | 04/12/2023 | Links da entrega 03                            | [Zenilda Vieira](https://github.com/ZenildaVieira)  | [Edilberto Cantuaria](https://github.com/edilbertocantuaria) |
| `1.4`  | 11/12/2023 | Passo a passo para rodar o jogo - atualização  | [Zenilda Vieira](https://github.com/ZenildaVieira)  | [Edilberto Cantuaria](https://github.com/edilbertocantuaria) |
