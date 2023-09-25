## Histórico de versões

| Versão |    Data    | Descrição               | Autor                                                                                                   | Revisão |
| :----: | :--------: | ----------------------- | ------------------------------------------------------------------------------------------------------- | ------- |
| `1.0`  | 16/09/2023 | Criação do documento DD | [Zenilda Vieira](https://github.com/ZenildaVieira)                                                      |         |
| `1.1`  | 24/09/2023 | Adequação do DD ao DER  | [Marcus Martins](https://github.com/marcusmartinss) <br> [Edilberto](https://github.com/marcusmartinss) |         |
| `1.2`  | 25/09/2023 | Descrição das entidades | [Marcus Martins](https://github.com/marcusmartinss)                                                     |         |
| `1.3`  | 25/09/2023 | 1ª Revisão Geral        | [Zenilda Vieira](https://github.com/ZenildaVieira)                                                      |         |

# DD - Dicionário de Dados

> "Um dicionário de dados é uma coleção de nomes, atributos e definições sobre elementos de dados que estão sendo usados ​​em seu estudo. [...] O objetivo de um dicionário de dados é explicar o que todos os nomes e valores de variáveis ​​em sua planilha realmente significam. Em um dicionário de dados podem ser encontrados dados sobre os nomes das variáveis ​​exatamente como aparecem na planilha, nomes de variáveis ​​curtos (mas legíveis por humanos), o intervalo de valores ou valores aceitos para a variável, descrição da variável e outras informções pertinentes."(Dados Científicos: como construir metadados, descrição, readme, dicionário-de-dados e mais; Agência de Bibliotecas e Coleções Digitais da Universidade de São Paulo)

## Entidade: Arma

#### Descrição: A entidade Arma descreve as armas disponíveis no jogo e outras informações, como: seu número de identificação, nome, dano, finalidade

#### Observação

| Nome Variável |     Tipo     |         Descrição          | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|    id-arma    |     int      | Identificador do item arma |       1-5000       |          não           |    FK    |                   |
|     nome      | varchar[50]  |        Nome da arma        |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |     Descrição da arma      |      a-z, A-Z      |          sim           |          |                   |
|     dano      |     int      |        Dano da arma        |        1-10        |          não           |          |                   |
|  finalidade   | varchar[100] |     Finalidade da arma     |      a-z, A-Z      |          não           |          |                   |

## Entidade: Artesanato

#### Descrição: A entidade Artesanato descreve um item que é possível ser construído, contendo seu: seu número de identificação, nome e sua descrição

#### Observação

| Nome Variável |     Tipo     |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
| id-artesanato |     int      | Identificador do item artesanato |       1-5000       |          não           |    FK    |                   |
|     nome      | varchar[50]  |    Nome do item de artesanato     |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] | Descrição do item de artesanato  |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Cabana-Jogador

#### Descrição: A entidade Cabana-Jogador armazena os dados de onde o jogador mora, contendo: seu número de identificação, sua região, nome, qual jogador está associado e a descrição do local

#### Observação

- Essa tabela possui chaves estrangeiras das entidades `Jogador` e `Regiao`

| Nome Variável |     Tipo     |                    Descrição                    | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :---------------------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
| id-cabana-jog |     int      |       Identificador da cabana do jogador        |       1-5000       |          não           | FK       |                   |
|    jogador    |     int      | Identificador do Jogador proprietário da cabana |       1-5000       |          não           | FK       |                   |
|    regiao     |     int      |   Identificador da Região onde está a cabana    |       1-5000       |          não           | FK       |                   |
|     nome      | varchar[50]  |                 Nome da região                  |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |               Descrição da região               |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Cabana-NPC

#### Descrição: A entidade Cabana-NPC armazena os dados de onde o NPC mora, contendo: seu número de identificação, sua região, nome, qual jogador está associado e a descrição do local

#### Observação

- Essa tabela possui chaves estrangeiras das entidades `Local-Fechado`, `NPC` e `Regiao`

| Nome Variável |     Tipo     |                  Descrição                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :-----------------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
| id-cabana-npc |     int      |       Identificador da cabana do NPC        |       1-5000       |          não           | FK       |                   |
|      npc      |     int      | Identificador do NPC proprietário da cabana |       1-5000       |          não           | FK       |                   |
|    regiao     |     int      | Identificador da  Região onde estã a cabana |       1-5000       |          não           | FK       |                   |
|     nome      | varchar[50]  |            Nome da cabana do NPC            |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |         Descrição da cabana do NPC          |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Caverna

#### Descrição: A entidade Caverna guarda os dados da região onde a caverna está, seu número de identificação, seu nome e sua descrição

#### Observação

- Essa tabela possui chave estrangeira da entidade `Regiao`

| Nome Variável |     Tipo     |                  Descrição                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :-----------------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|  id-caverna   |     int      |          Identificador da caverna           |       1-5000       |          não           | FK       |                   |
|    regiao     |     int      | Identificador da Região onde está a caverna |       1-5000       |          não           | FK       |                   |
|     nome      | varchar[50]  |               Nome da caverna               |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |            Descrição da caverna             |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Consumível

#### Descrição: A entidade Consumível armazena o número de identificação do consumível, seu nome e sua descrição

#### Observação

| Nome Variável |     Tipo     |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
| id-consumivel |     int      | Identificador do item consumível |       1-5000       |          não           | FK       |                   |
|     nome      | varchar[50]  |     Nome do item consumível      |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |  Descrição do oitem consumível   |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Diálogo

#### Descrição: A entidade Diálogo descreve a relação entre: o número de identificação do diálogo, o npc relacionado ao diálogo e o que é dito

#### Observação

- Essa tabela possui chave estrangeira da entidade `NPC`

| Nome Variável |     Tipo     |              Descrição              | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :---------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|  id-dialogo   |     int      | Código de identificação do diálogo  |       1-5000       |          não           | PK       |                   |
|      npc      |     int      | codigo do NPC que usa essse dialogo |       1-5000       |          não           | FK       |                   |
|     fala      | varchar[150] |         Conteúdo do diálogo         |      a-z, A-Z      |          não           |          |                   |

## Entidade: Efeito

#### Descrição: A entidade Efeito armazena o número de identificação do efeito, o item relacionado e sua descrição

#### Observação: Essa tabela possui chave estrangeira da entidade `Item`

| Nome Variável |     Tipo     |                Descrição                 | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :--------------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|   id-efeito   |     int      |    Código de identificação do efeito     |       1-5000       |          não           | PK       |                   |
|     item      |     int      | Identificador do item que sofre o efeito |       1-5000       |          não           | FK       |                   |
|   descricao   | varchar[100] |           Descrição do efeito            |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Estação

#### Descrição: A entidade Estação armazena o número de identificação da estação, seu nome e sua descrição

#### Observação

| Nome Variável |     Tipo     |             Descrição              | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :--------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|  id-estacao   |     int      | Código de identificação da estação |       1-5000       |          não           | PK       |                   |
|     nome      | varchar[50]  |          Nome da estação           |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |        Descrição da estação        |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Estoque-Loja

#### Descrição: A entidade Estoque guarda o produto disponível, a loja associada e o preço associado

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Item` e `Loja`

| Nome Variável | Tipo  |           Descrição           | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :---: | :---------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|    produto    |  int  | Identificador do item-produto |       1-5000       |          não           | FK       |                   |
|     loja      |  int  |     Identificador da loja     |       1-5000       |          não           | FK       |                   |
|     preço     |  int  |  Preço do produto no estoque  |    0-2147483647    |          não           |          |                   |

## Entidade: Ferramenta

#### Descrição: A entidade Ferramenta armazena o número de identificação da ferramenta, seu nome, sua descrição e sua finalidade

#### Observação

| Nome Variável |     Tipo     |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
| id-ferramenta |     int      | Identificador do item ferramenta |       1-5000       |          não           | FK       |                   |
|     nome      | varchar[50]  |        Nome da ferramenta        |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |     Descrição da ferramenta      |      a-z, A-Z      |          sim           |          |                   |
|  finalidade   | varchar[100] |     Finalidade da ferramenta     |      a-z, A-Z      |          não           |          |                   |

## Entidade: Habilidade

#### Descrição: A entidade Habilidade contém: os dados do jogador e o seu nível nas habilidades de coleta, cultivo, mineração, pesca e combate

#### Observação: Essa tabela possui chave estrangeira da entidade `Jogador`

|  Nome Variável  | Tipo  |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-------------: | :---: | :------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|     jogador     |  int  |     Identificador do jogador     |       1-5000       |          não           | FK       |                   |
|  nivel-coleta   |  int  |  Nível da habilidade de coleta   |        1-10        |          não           |          |                   |
|  nivel-cultivo  |  int  |  Nível da habilidade de cultivo  |        1-10        |          não           |          |                   |
| nivel-mineracao |  int  | Nível da habilidade de mineração |        1-10        |          não           |          |                   |
|   nivel-pesca   |  int  |   Nível da habilidade de pesca   |        1-10        |          não           |          |                   |
|  nivel-combate  |  int  |  Nível da habilidade de combate  |        1-10        |          não           |          |                   |

## Entidade: Instancia-Monstro

#### Descrição: A entidade Instancia-Monstro diz respeito a: caverna onde as instâncias dos monstros estarão, o monstro que será instanciado e a saúde da sua instância

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Caverna` e `Monstro`

| Nome Variável | Tipo  |                         Descrição                         | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :---: | :-------------------------------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|    caverna    |  int  | Identificador da caverna onde está a instância do monstro |       1-5000       |          não           | FK       |                   |
|    monstro    |  int  |                 Identificador do Monstro                  |       1-5000       |          não           | FK       |                   |
|     saude     |  int  |               Saúde da instância de monstro               |       1-100        |          não           |          |                   |

## Entidade: Inventário

#### Descrição: A entidade Inventário relaciona o jogador, os seus itens e a quantidade de espaço disponível no inventário

#### Observação: Essa tabela possui chave estrangeira da entidade `Item`

| Nome Variável | Tipo  |        Descrição         | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :---: | :----------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|    jogador    |  int  | Identificador do Jogador |       1-5000       |          não           | FK       |                   |
|     item      |  int  |  Identificador do Item   |       1-5000       |          não           | FK       |                   |
|     qtdd      |  int  |    quantidade do item    |       1-5000       |          não           |          |                   |

## Entidade: Item

#### Descrição: A entidade Item armazena as informações de identificação do item e do seu tipo

#### Observação

| Nome Variável |    Tipo     |            Descrição            | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :---------: | :-----------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|    id-item    |     int     | Código de Identificação do item |       1-5000       |          não           | PK       |                   |
|    id-tipo    | varchar[50] |  Identificação do tipo do item  |      a-z, A-Z      |          não           |          |                   |

## Entidade: Jogador

#### Descrição: A entidade Jogador descreve as informações ligadas ao personável jogável, como: seu número de identificação, o local onde está, a região onde está, a estação atual do seu jogo, o conjunto de missões que está fazendo, seu nome, seu nível de saúde e energia, o dia em que está e a quantidade de ouro que tem

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Local`, `Regiao`,`Estacao` e `Missao`

| Nome Variável |    Tipo     |             Descrição              | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :---------: | :--------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|  id-jogador   |     int     | Código de identificação do jogador |       1-5000       |          não           | PK       |                   |
|     local     |     int     |       Identificador do local       |       1-5000       |          não           | FK       |                   |
|    regiao     |     int     |      Identificador da região       |       1-5000       |          não           | FK       |                   |
| estacao-atual |     int     |   Identificador da estação-atual   |       1-5000       |          não           | FK       |                   |
| missao-atual  |     int     |   Identificador da missao-atual    |       1-5000       |          sim           | FK       |                   |
|     nome      | varchar[50] |          Nome do jogador           |      a-z, A-Z      |          não           |          |                   |
|     saude     |     int     |          Saude do jogador          |       1-100        |          não           |          |                   |
|    energia    |     int     |         Energia do jogador         |       1-100        |          não           |          |                   |
|      dia      |     int     |           Dia do jogador           |       1-100        |          não           |          |                   |
|   qtdd-ouro   |     int     |   Quantidade de ouro do jogador    |       min. 0       |          sim           |          |                   |

## Entidade: Local-Fechado

#### Descrição: A entidade Local-Fechado possui os números de identificação do local e de qual é seu tipo

#### Observação

| Nome Variável |    Tipo     |                Descrição                 | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :---------: | :--------------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|   id-local    |     int     | Código de identificação do local fechado |       1-5000       |          não           | PK       |                   |
|    id-tipo    | varchar[50] |  Identificação do tipo de local fechado  |      a-z, A-Z      |          não           |          |                   |

## Entidade: Loja

#### Descrição: A entidade loja armazena as informações do: número de identificação da loja, seu proprietário, sua região, o nome da loja e sua descrição

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Local-Fechado`, `NPC` e `Regiao`

| Nome Variável |     Tipo     |                Descrição                 | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :--------------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|    id-loja    |     int      |          Identificador da loja           |       1-5000       |          não           | FK       |                   |
| proprietario  |     int      |      Identificador do proprietário       |       1-5000       |          não           | FK       |                   |
|    regiao     |     int      | Identificador da região onde está a loja |       1-5000       |          não           | FK       |                   |
|     nome      | varchar[50]  |               Nome da loja               |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |            Descrição da loja             |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Missao

#### Descrição: A entidade Missao relaciona o número de identificação da missão, a estação em que está sendo realizada, seu nome e sua descrição

#### Observação: Essa tabela possui chave estrangeira da entidade `Estacao`

| Nome Variável |     Tipo     |             Descrição              | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :--------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|   id-missao   |     int      | Código de identificação da missão  |       1-5000       |          não           | PK       |                   |
|    estacao    |     int      | Identificador da Estação da missão |       1-5000       |          não           | FK       |                   |
|     nome      | varchar[50]  |           Nome da missão           |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |        Descrição da missão         |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Monstro

#### Descrição: A entidade Monstro descreve a relação entre seu número de identificação, o item que será deixado após ser derrotado, seu nome, sua descrição, o dano que pode causar, sua defesa e sua saúde máxima

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Item`

| Nome Variável |     Tipo     |                           Descrição                           | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :-----------------------------------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|  id-monstro   |     int      |              Código de identificação do monstro               |       1-5000       |          não           | PK       |                   |
|     drop      |     int      | Identificador do item deixado pelo monstro após ser derrotado |       1-5000       |          não           | FK       |                   |
|     nome      | varchar[50]  |                        Nome do monstro                        |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |                     Descrição do monstro                      |      a-z, A-Z      |          sim           |          |                   |
|     dano      |     int      |                   Dano causado pelo monstro                   |        1-10        |          não           |          |                   |
|    defesa     |     int      |                       Defesa do monstro                       |      a-z, A-Z      |          não           |          |                   |
| saude-maxima  |     int      |                    Saúde máxima do monstro                    |      a-z, A-Z      |          não           |          |                   |

## Entidade: Mundo

#### Descrição: A entidade Mundo armazena dados do número de identificação do mundo e seu nome

#### Observação

| Nome Variável |    Tipo     |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :---------: | :------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|   id-mundo    |     int     | Código de identificação do mundo |       1-5000       |          não           | PK       |                   |
|     nome      | varchar[50] |          Nome do mundo           |      a-z, A-Z      |          não           |          |                   |

## Entidade: NPC

#### Descrição: A entidade NPC guarda as informações relacionada aos personagens não-jogáveis, tais como: seu número de identificação, a região em que está, o local em que está, seu nome e sua profissão

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Regiao` e `Local`

| Nome Variável |     Tipo     |                Descrição                | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :-------------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|    id-npc     |     int      |     Código de identificação do npc      |       1-5000       |          não           | PK       |                   |
|    regiao     |     int      | Identificador da regiao onde o NPC está |       1-5000       |          não           | FK       |                   |
|     local     |     int      | Identificador do local onde o NPC está  |       1-5000       |          não           | FK       |                   |
|     nome      | varchar[50]  |               Nome do npc               |      a-z, A-Z      |          não           |          |                   |
|   profissao   | varchar[100] |            Profissão do npc             |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Receita

#### Descrição: A entidade Receita armazena os dados do item, os itens que podem ser criados por meio do artesanato e a quantidade de itens que são necessários na receita

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Artesanato` e `Item`

| Nome Variável | Tipo  |           Descrição            | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :---: | :----------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|  artesanato   |  int  |  Identificador do artesanato   |       1-5000       |          não           | FK       |                   |
|     item      |  int  |     Identificador do item      |       1-5000       |          não           | FK       |                   |
|     qtdd      |  int  | Quantidade de itens da receita |       1-5000       |          não           |          |                   |

## Entidade: Região

#### Descrição: Descreve as regiões disponíveis disponíveis no jogo, seu nome e o mundo onde elas pertencem

#### Observação: Essa tabela possui chave estrangeira da entidade `Mundo`

| Nome Variável |    Tipo     |             Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :---------: | :-------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|   id-regiao   |     int     | Código de identificação da regiao |       1-5000       |          não           | PK       |                   |
|     mundo     |     int     |      Identificador do mundo       |       1-5000       |          não           | FK       |                   |
|     nome      | varchar[50] |          Nome da regiao           |      a-z, A-Z      |          não           |          |                   |

## Entidade: Semente

#### Descrição: Descreve as sementes disponíveis no jogo e outras informações, como: nome, estação, valor de venda e dias para crescer

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Item` e `Estacao`

|   Nome Variável   |     Tipo     |                Descrição                | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :---------------: | :----------: | :-------------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|    id-semente     |     int      |        Identificador do item semente    |       1-5000       |          não           | FK       |                   |
|      estacao      |     int      |        Identificador da estação         |       1-5000       |          não           | FK       |                   |
|       nome        |  varchar[]   |             Nome do item semente        |      a-z, A-Z      |          não           |          |                   |
|     descricao     | varchar[150] |          Descrição da semente           |      a-z, A-Z      |          sim           |          |                   |
|    valor-venda    |     int      |            Preço da semente             |       1-5000       |          não           |          |                   |
| dias-para-crescer |     int      | Dias que a semente precisa para crescer |        1-28        |          não           |          |                   |

## Entidade: Vestimenta

#### Descrição: A entidade Vestimenta armazena o número de identificação do vestimenta, seu nome e sua descrição

#### Observação: Essa tabela possui chave estrangeira da entidade `Vestimenta`

| Nome Variável |     Tipo     |         Description              | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
| id-vestimenta |     int      | Identificador do item vestimenta |       1-5000       |          não           | FK       |                   |
|     nome      | varchar[50]  |     Nome da vestimenta           |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |   Descrição da vestimenta        |      a-z, A-Z      |          sim           |          |                   |
