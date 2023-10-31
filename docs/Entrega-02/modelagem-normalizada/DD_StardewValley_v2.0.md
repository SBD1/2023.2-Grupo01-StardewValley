## Histórico de versões

| Versão |    Data    | Descrição                                       | Autor                                                                                                                 |
| :----: | :--------: | ----------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `1.0`  | 16/09/2023 | Criação do documento DD                         | [Zenilda Vieira](https://github.com/ZenildaVieira)                                                                    |
| `1.1`  | 24/09/2023 | Adequação do DD ao DER                          | [Marcus Martins](https://github.com/marcusmartinss) <br> [Edilberto Cantuaria](https://github.com/marcusmartinss)     |
| `1.2`  | 25/09/2023 | Descrição das entidades                         | [Marcus Martins](https://github.com/marcusmartinss)                                                                   |
| `1.3`  | 25/09/2023 | 1ª Revisão Geral                                | [Zenilda Vieira](https://github.com/ZenildaVieira)                                                                    |
| `1.4`  | 26/09/2023 | Revisão em pares                                | [Edilberto Cantuaria](https://github.com/edilbertocantuaria), <br> [Zenilda Vieira](https://github.com/ZenildaVieira) |
| `2.0`  | 22/10/2023 | Normalização na primeira e segunda forma normal | [Marcus Martins](https://github.com/marcusmartinss)                                                                   |
| `2.1`  | 23/10/2023 | Normalização na terceira forma normal           | [Marcus Martins](https://github.com/marcusmartinss)                                                                   |

# DD - Dicionário de Dados

> "Um dicionário de dados é uma coleção de nomes, atributos e definições sobre elementos de dados que estão sendo usados ​​em seu estudo. [...] O objetivo de um dicionário de dados é explicar o que todos os nomes e valores de variáveis ​​em sua planilha realmente significam. Em um dicionário de dados podem ser encontrados dados sobre os nomes das variáveis ​​exatamente como aparecem na planilha, nomes de variáveis ​​curtos (mas legíveis por humanos), o intervalo de valores ou valores aceitos para a variável, descrição da variável e outras informções pertinentes."(Dados Científicos: como construir metadados, descrição, readme, dicionário-de-dados e mais; Agência de Bibliotecas e Coleções Digitais da Universidade de São Paulo)

## Entidade: Arma

#### Descrição: A entidade Arma descreve as armas disponíveis no jogo e outras informações, como: seu número de identificação, nome, dano, finalidade.

#### Observação: Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável |     Tipo     |         Descrição          | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|    id-arma    |     int      | Identificador do item arma |       1-5000       |          não           |  PK, FK  |                   |
|     nome      | varchar[50]  |        Nome da arma        |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |     Descrição da arma      |      a-z, A-Z      |          sim           |          |                   |
|     dano      |     int      |        Dano da arma        |        1-10        |          não           |          |                   |
|  finalidade   | varchar[100] |     Finalidade da arma     |      a-z, A-Z      |          não           |          |                   |

## Entidade: Artesanato

#### Descrição: A entidade Artesanato descreve um item que é possível ser construído, contendo seu: seu número de identificação, nome e sua descrição.

#### Observação: Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável |     Tipo     |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
| id-artesanato |     int      | Identificador do item artesanato |       1-5000       |          não           |  PK, FK  |                   |
|     nome      | varchar[50]  |    Nome do item de artesanato    |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] | Descrição do item de artesanato  |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Cabana-Jogador

#### Descrição: A entidade Cabana-Jogador armazena os dados de onde o jogador mora, contendo: seu número de identificação, sua região, nome, qual jogador está associado e a descrição do local.

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Local-Fechado`, `Jogador` e `Regiao`

|  Nome Variável   |     Tipo     |                    Descrição                    | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------: | :----------: | :---------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
| id-local-fechado |     int      |         Identificador do local fechado          |       1-5000       |          não           |  PK, FK  |                   |
|    id-jogador    |     int      | Identificador do Jogador proprietário da cabana |       1-5000       |          não           |  PK, FK  |                   |
|    id-regiao     |     int      |   Identificador da Região onde está a cabana    |       1-5000       |          não           |    FK    |                   |
|       nome       | varchar[50]  |                 Nome da cabana                  |      a-z, A-Z      |          não           |          |                   |
|    descricao     | varchar[150] |               Descrição da cabana               |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Cabana-NPC

#### Descrição: A entidade Cabana-NPC armazena os dados de onde o NPC mora, contendo: seu número de identificação, sua região, nome, qual jogador está associado e a descrição do local.

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Local-Fechado`, `NPC` e `Regiao`

|  Nome Variável   |     Tipo     |                  Descrição                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------: | :----------: | :-----------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
| id-local-fechado |     int      |       Identificador do local fechado        |       1-5000       |          não           |  PK, FK  |                   |
|      id-npc      |     int      | Identificador do NPC proprietário da cabana |       1-5000       |          não           |  PK, FK  |                   |
|    id-regiao     |     int      | Identificador da Região onde estã a cabana  |       1-5000       |          não           |    FK    |                   |
|       nome       | varchar[50]  |            Nome da cabana do NPC            |      a-z, A-Z      |          não           |          |                   |
|    descricao     | varchar[150] |         Descrição da cabana do NPC          |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Caverna

#### Descrição: A entidade Caverna guarda os dados da região onde a caverna está, seu número de identificação, seu nome e sua descrição.

#### Observação:Essa tabela possui chaves estrangeiras das entidades `Caverna` e `Região`.

|  Nome Variável   |     Tipo     |                  Descrição                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------: | :----------: | :-----------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
| id-local-fechado |     int      |       Identificador do local fechado        |       1-5000       |          não           |  PK, FK  |                   |
|    id-regiao     |     int      | Identificador da Região onde está a caverna |       1-5000       |          não           |  PK, FK  |                   |
|       nome       | varchar[50]  |               Nome da caverna               |      a-z, A-Z      |          não           |          |                   |
|    descricao     | varchar[150] |            Descrição da caverna             |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Consumivel

#### Descrição: A entidade Consumivel armazena o número de identificação do item consumível, seu nome e sua descrição.

#### Observação: Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável |     Tipo     |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
| id-consumivel |     int      | Identificador do item consumível |       1-5000       |          não           |  PK, FK  |                   |
|     nome      | varchar[50]  |     Nome do item consumível      |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |   Descrição do item consumível   |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Dialogo

#### Descrição: A entidade Dialogo descreve a relação entre: o número de identificação do diálogo, o npc relacionado ao diálogo e o que é dito.

#### Observação: Essa tabela possui chave estrangeira da entidade `NPC`

| Nome Variável |     Tipo     |              Descrição              | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :---------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|  id-dialogo   |     int      | Código de identificação do diálogo  |       1-5000       |          não           |    PK    |                   |
|    id-npc     |     int      | codigo do NPC que usa essse dialogo |       1-5000       |          não           |    FK    |                   |
|     fala      | varchar[150] |         Conteúdo do diálogo         |      a-z, A-Z      |          não           |          |                   |

## Entidade: Efeito

#### Descrição: A entidade Efeito armazena o número de identificação do efeito, o item relacionado e sua descrição.

#### Observação: Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável |     Tipo     |                Descrição                 | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :--------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|   id-efeito   |     int      |    Código de identificação do efeito     |       1-5000       |          não           |    PK    |                   |
|    id-item    |     int      | Identificador do item que sofre o efeito |       1-5000       |          não           |    FK    |                   |
|     valor     |     int      |       Valor produzido pelo efeito        |        1-50        |          não           |          |                   |
|     tipo      | varchar[100] |              tipo do efeito              |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Estação

#### Descrição: A entidade Estação armazena o número de identificação da estação, seu nome e sua descrição.

#### Observação: A cada 28 dias, muda a estção do ano: primavera, verão, outono e inverno.

| Nome Variável |     Tipo     |             Descrição              | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :--------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|  id-estacao   |     int      | Código de identificação da estação |       1-5000       |          não           |    PK    |                   |
|     nome      | varchar[50]  |          Nome da estação           |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |        Descrição da estação        |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Ferramenta

#### Descrição: A entidade Ferramenta armazena o número de identificação da ferramenta, seu nome, sua descrição e sua finalidade.

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Item`.

| Nome Variável |     Tipo     |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
| id-ferramenta |     int      | Identificador do item ferramenta |       1-5000       |          não           |  PK, FK  |                   |
|     nome      | varchar[50]  |        Nome da ferramenta        |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |     Descrição da ferramenta      |      a-z, A-Z      |          sim           |          |                   |
|  finalidade   | varchar[100] |     Finalidade da ferramenta     |      a-z, A-Z      |          não           |          |                   |

## Entidade: Habilidade

#### Descrição: A entidade Habilidade contém: os dados do jogador e o seu nível nas habilidades de coleta, cultivo, mineração, pesca e combate.

#### Observação: Essa tabela possui chave estrangeira da entidade `Jogador`.

|  Nome Variável  | Tipo |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-------------: | :--: | :------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|   id-jogador    | int  |     Identificador do jogador     |       1-5000       |          não           |  PK, FK  |                   |
|  nivel-coleta   | int  |  Nível da habilidade de coleta   |        1-10        |          não           |          |                   |
|  nivel-cultivo  | int  |  Nível da habilidade de cultivo  |        1-10        |          não           |          |                   |
| nivel-mineracao | int  | Nível da habilidade de mineração |        1-10        |          não           |          |                   |
|   nivel-pesca   | int  |   Nível da habilidade de pesca   |        1-10        |          não           |          |                   |
|  nivel-combate  | int  |  Nível da habilidade de combate  |        1-10        |          não           |          |                   |

## Entidade: Informacao-Semente

#### Descrição: A entidade Informacao-Semente diz respeito as informações das sementes, como: nome, descrição, valor de venda, dias para crescer.

#### Observação: Essa tabela possui chave estrangeira da entidade `Semente`.

|   Nome Variável   |     Tipo     |                Descrição                | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :---------------: | :----------: | :-------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|  id-info-semente  |     int      | Identificador da informação da semente  |       1-5000       |          não           |    PK    |                   |
|    id-semente     |     int      |        Identificador da semente         |       1-5000       |          não           |  PK, FK  |                   |
|       nome        | varchar[50]  |          Nome do item semente           |      a-z, A-Z      |          não           |          |                   |
|     descricao     | varchar[150] |          Descrição da semente           |      a-z, A-Z      |          sim           |          |                   |
|    valor-venda    |     int      |            Preço da semente             |       1-5000       |          não           |          |                   |
| dias-para-crescer |     int      | Dias que a semente precisa para crescer |        1-28        |          não           |          |                   |

## Entidade: Instancia-Monstro

#### Descrição: A entidade Instancia-Monstro diz respeito a: caverna onde as instâncias dos monstros estarão, o monstro que será instanciado e a saúde da sua instância.

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Caverna` e `Monstro`.

| Nome Variável | Tipo |                         Descrição                         | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :--: | :-------------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|  id-caverna   | int  | Identificador da caverna onde está a instância do monstro |       1-5000       |          não           |  PK, FK  |                   |
|  id-monstro   | int  |                 Identificador do Monstro                  |       1-5000       |          não           |  PK, FK  |                   |
|     saude     | int  |               Saúde da instância de monstro               |       1-100        |          não           |          |                   |

## Entidade: Item

#### Descrição: A entidade Item armazena as informações de identificação do item e do seu tipo.

#### Observação: Esta entidade relaciona cada um dos itens com seu tipo.

| Nome Variável | Tipo |            Descrição            | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :--: | :-----------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|    id-item    | int  | Código de Identificação do item |       1-5000       |          não           |    PK    |                   |
| id-tipo-item  | int  |  Identificação do tipo do item  |        1-6         |          não           |    FK    |                   |

## Entidade: Item-Estoque-Loja

#### Descrição: A entidade Item-Estoque-Loja guarda o produto disponível, a loja associada e o preço associado.

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Item` e `Loja`.

| Nome Variável | Tipo |           Descrição           | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :--: | :---------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|    id-item    | int  | Identificador do item-produto |       1-5000       |          não           |  PK, FK  |                   |
|    id-loja    | int  |     Identificador da loja     |       1-5000       |          não           |  PK, FK  |                   |
|     preco     | int  |  Preço do produto no estoque  |      1-500000      |          não           |          |                   |

## Entidade: Item-Inventário

#### Descrição: A entidade Item-Inventário relaciona o jogador, os seus itens e a quantidade de itens disponíveis no inventário.

#### Observação: Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável | Tipo |        Descrição         | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :--: | :----------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|  id-jogador   | int  | Identificador do Jogador |       1-5000       |          não           |  PK, FK  |                   |
|    id-item    | int  |  Identificador do Item   |       1-5000       |          não           |  PK, FK  |                   |
|     qtdd      | int  |    quantidade do item    |       1-5000       |          não           |          |                   |

## Entidade: Item-Receita

#### Descrição: A entidade Item-Receita armazena os dados do item, os itens que podem ser criados por meio do artesanato e a quantidade de itens que são necessários na receita.

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Artesanato` e `Item`.

| Nome Variável | Tipo |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :--: | :------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
| id-artesanato | int  |   Identificador do artesanato    |       1-5000       |          não           |  PK, FK  |                   |
|    id-item    | int  |      Identificador do item       |       1-5000       |          não           |  PK, FK  |                   |
|     qtdd      | int  | Quantidade desse item na receita |       1-5000       |          não           |          |                   |

## Entidade: Jogador

#### Descrição: A entidade Jogador descreve as informações ligadas ao personável jogável, como: seu número de identificação, o local onde está, a região onde está, a estação atual do seu jogo, a missão que está fazendo, seu nome, seu nível de saúde e energia, o dia em que está e a quantidade de ouro que tem.

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Local`, `Regiao`,`Estacao` e `Missao`.

|  Nome Variável   |    Tipo     |             Descrição              | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------: | :---------: | :--------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|    id-jogador    |     int     | Código de identificação do jogador |       1-5000       |          não           |    PK    |                   |
| id-local-fechado |     int     |       Identificador do local       |       1-5000       |          sim           |    FK    |                   |
|    id-regiao     |     int     |      Identificador da região       |       1-5000       |          não           |    FK    |                   |
|    id-estacao    |     int     |   Identificador da estação-atual   |       1-5000       |          não           |    FK    |                   |
|    id-missao     |     int     |   Identificador da missao-atual    |       1-5000       |          sim           |    FK    |                   |
|       nome       | varchar[50] |          Nome do jogador           |      a-z, A-Z      |          não           |          |                   |
|      saude       |     int     |          Saude do jogador          |       1-100        |          não           |          |                   |
|     energia      |     int     |         Energia do jogador         |       1-100        |          não           |          |                   |
|       dia        |     int     |           Dia do jogador           |       1-100        |          não           |          |                   |
|       hora       |     int     |     Hora em que o jogador está     |       0-144        |          não           |          |                   |
|    qtdd-ouro     |     int     |   Quantidade de ouro do jogador    |       min. 0       |          sim           |          |                   |

## Entidade: Local-Fechado

#### Descrição: A entidade Local-Fechado possui os números de identificação do local e de qual é seu tipo.

#### Observação: Os locais fechados podem ser de 4 tipos: cabana do jogador, cabana de um NPC, caverna e loja.

|     Nome Variável     | Tipo |                Descrição                 | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-------------------: | :--: | :--------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|   id-local-fechado    | int  | Código de identificação do local fechado |       1-5000       |          não           |    PK    |                   |
| id-tipo-local-fechado | int  |  Identificação do tipo de local fechado  |        1-4         |          não           |    FK    |                   |

## Entidade: Loja

#### Descrição: A entidade loja armazena as informações do: número de identificação da loja, seu proprietário, sua região, o nome da loja e sua descrição.

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Local-Fechado`, `NPC` e `Regiao`.

|  Nome Variável   |     Tipo     |                Descrição                 | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------: | :----------: | :--------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
| id-local-fechado |     int      |      Identificador do local fechado      |       1-5000       |          não           |  PK, FK  |                   |
|      id-npc      |     int      |      Identificador do proprietário       |       1-5000       |          não           |    FK    |                   |
|    id-regiao     |     int      | Identificador da região onde está a loja |       1-5000       |          não           |    FK    |                   |
|       nome       | varchar[50]  |               Nome da loja               |      a-z, A-Z      |          não           |          |                   |
|    descricao     | varchar[150] |            Descrição da loja             |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Missao

#### Descrição: A entidade Missao relaciona o número de identificação da missão, a estação em que está sendo realizada, seu nome e sua descrição.

#### Observação: Essa tabela possui chave estrangeira da entidade `Estacao`.

| Nome Variável |     Tipo     |             Descrição              | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :--------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|   id-missao   |     int      | Código de identificação da missão  |       1-5000       |          não           |    PK    |                   |
|  id-estacao   |     int      | Identificador da Estação da missão |       1-5000       |          não           |    FK    |                   |
|     nome      | varchar[50]  |           Nome da missão           |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |        Descrição da missão         |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Monstro

#### Descrição: A entidade Monstro descreve a relação entre seu número de identificação, o item que será deixado após ser derrotado, seu nome, sua descrição, o dano que pode causar, sua defesa e sua saúde máxima.

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Item`.

| Nome Variável |     Tipo     |                           Descrição                           | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :-----------------------------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|  id-monstro   |     int      |              Código de identificação do monstro               |       1-5000       |          não           |    PK    |                   |
|    id-drop    |     int      | Identificador do item deixado pelo monstro após ser derrotado |       1-5000       |          não           |    FK    |                   |
|     nome      | varchar[50]  |                        Nome do monstro                        |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |                     Descrição do monstro                      |      a-z, A-Z      |          sim           |          |                   |
|     dano      |     int      |                   Dano causado pelo monstro                   |        1-10        |          não           |          |                   |
|    defesa     |     int      |                       Defesa do monstro                       |        1-10        |          não           |          |                   |
| saude-maxima  |     int      |                    Saúde máxima do monstro                    |       1-100        |          não           |          |                   |

## Entidade: Mundo

#### Descrição: A entidade Mundo armazena dados do número de identificação do mundo e seu nome.

#### Observação: O mundo é formado por regiões e cada região tem uma fazenda diferente para o jogador cuidar.

| Nome Variável |    Tipo     |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :---------: | :------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|   id-mundo    |     int     | Código de identificação do mundo |       1-5000       |          não           |    PK    |                   |
|     nome      | varchar[50] |          Nome do mundo           |      a-z, A-Z      |          não           |          |                   |

## Entidade: NPC

#### Descrição: A entidade NPC guarda as informações relacionada aos personagens não-jogáveis, tais como: seu número de identificação, a região em que está, o local em que está, seu nome e sua profissão.

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Regiao` e `Local`.

|  Nome Variável   |     Tipo     |                Descrição                | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :--------------: | :----------: | :-------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|      id-npc      |     int      |     Código de identificação do npc      |       1-5000       |          não           |    PK    |                   |
|    id-regiao     |     int      | Identificador da regiao onde o NPC está |       1-5000       |          não           |    FK    |                   |
| id-local-fechado |     int      | Identificador do local onde o NPC está  |       1-5000       |          sim           |    FK    |                   |
|       nome       | varchar[50]  |               Nome do npc               |      a-z, A-Z      |          não           |          |                   |
|    profissao     | varchar[100] |            Profissão do npc             |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Região

#### Descrição: Descreve as regiões disponíveis disponíveis no jogo, seu nome e o mundo onde elas pertencem.

#### Observação: Essa tabela possui chave estrangeira da entidade `Mundo`. As regiões contém locais ao ar livre e locais fechados.

| Nome Variável |    Tipo     |             Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :---------: | :-------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|   id-regiao   |     int     | Código de identificação da regiao |       1-5000       |          não           |    PK    |                   |
|     id-mundo     |     int     |      Identificador do mundo       |       1-5000       |          não           |    FK    |                   |
|     nome      | varchar[50] |          Nome da regiao           |      a-z, A-Z      |          não           |          |                   |

## Entidade: Semente

#### Descrição: Descreve as sementes disponíveis no jogo e outras informações, como: nome, estação que ela floresce, valor de venda e dias para crescer.

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Item` e `Estacao`.

|  Nome Variável  | Tipo |               Descrição                | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-------------: | :--: | :------------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
|   id-semente    | int  |    Identificador do item da semente    |       1-5000       |          não           |  PK, FK  |                   |
| id-info-semente | int  | Identificador da informação da semente |       1-5000       |          não           |    FK    |                   |
|   id-estacao    | int  |        Identificador da estação        |       1-5000       |          não           |    FK    |                   |

## Entidade: Tipo-Item

#### Descrição: Descreve os tipos de itens disponíveis no jogo e o nome desse tipo.

#### Observação: Os itens podem ser de 6 tipos: arma, ferramenta, consumível, vestimenta, artesanato e semente.

| Nome Variável  |    Tipo     |              Descrição              |                            Valores permitidos                             | Permite valores nulos? | É chave? | Outras Restrições |
| :------------: | :---------: | :---------------------------------: | :-----------------------------------------------------------------------: | :--------------------: | :------: | ----------------- |
|  id-tipo-item  |     int     |    Identificador do tipo de Item    |                                    1-6                                    |          não           |    PK    |                   |
| nome-tipo-item | varchar[20] | Nome que o tipo de item vai receber | "arma", "ferramenta", "consumivel", "vestimenta", "artesanato", "semente" |          não           |          |                   |

## Entidade: Tipo-Local-Fechado

#### Descrição: Descreve os tipos de locais fechados disponíveis no jogo e o nome desse tipo.

#### Observação: Os itens podem ser de 4 tipos: cabana do jogador, cabana de NPC, caverna ou loja.

|      Nome Variável      |    Tipo     |                  Descrição                   |              Valores permitidos               | Permite valores nulos? | É chave? | Outras Restrições |
| :---------------------: | :---------: | :------------------------------------------: | :-------------------------------------------: | :--------------------: | :------: | ----------------- |
|  id-tipo-local-fechado  |     int     |    Identificador do tipo de Local Fechado    |                      1-4                      |          não           |    PK    |                   |
| nome-tipo-local-fechado | varchar[20] | Nome que o tipo do local fechado vai receber | "cabana-jog", "cabana-npc", "caverna", "loja" |          não           |          |                   |

## Entidade: Vestimenta

#### Descrição: A entidade Vestimenta armazena o número de identificação do vestimenta, seu nome e sua descrição.

#### Observação: Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável |     Tipo     |           Description            | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :----------: | :------------------------------: | :----------------: | :--------------------: | :------: | ----------------- |
| id-vestimenta |     int      | Identificador do item vestimenta |       1-5000       |          não           |  PK, FK  |                   |
|     nome      | varchar[50]  |        Nome da vestimenta        |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar[150] |     Descrição da vestimenta      |      a-z, A-Z      |          sim           |          |                   |
