## Histórico de versões

| Versão |    Data    | Descrição               | Autor                                                                                                                 |
| :----: | :--------: | ----------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `1.0`  | 16/09/2023 | Criação do documento DD | [Zenilda Vieira](https://github.com/ZenildaVieira)                                                                    |
| `1.1`  | 24/09/2023 | Adequação do DD ao DER  | [Marcus Martins](https://github.com/marcusmartinss) <br> [Edilberto Cantuaria](https://github.com/marcusmartinss)     |
| `1.2`  | 25/09/2023 | Descrição das entidades | [Marcus Martins](https://github.com/marcusmartinss)                                                                   |
| `1.3`  | 25/09/2023 | 1ª Revisão Geral        | [Zenilda Vieira](https://github.com/ZenildaVieira)                                                                    |
| `1.4`  | 26/09/2023 | Revisão em pares        | [Edilberto Cantuaria](https://github.com/edilbertocantuaria), <br> [Zenilda Vieira](https://github.com/ZenildaVieira) |
| `2.0`  | 22/10/2023 | Normalização na primeira e segunda forma normal | [Marcus Martins](https://github.com/marcusmartinss)                                           |
| `2.1`  | 23/10/2023 | Normalização na terceira forma normal           | [Marcus Martins](https://github.com/marcusmartinss)                                           |
| `3.0`  | 13/11/2023 | Modificações da terceira entrega                | [Zenilda Vieira](https://github.com/ZenildaVieira)                                            |
| `3.1`  | 14/11/2023 | Correções nos relacionamentos de chave estrangeira | [Matheus Phillipo](https://github.com/MattSilverio)                                            |


# DD - Dicionário de Dados

> "Um dicionário de dados é uma coleção de nomes, atributos e definições sobre elementos de dados que estão sendo usados ​​em seu estudo. [...] O objetivo de um dicionário de dados é explicar o que todos os nomes e valores de variáveis ​​em sua planilha realmente significam. Em um dicionário de dados podem ser encontrados dados sobre os nomes das variáveis ​​exatamente como aparecem na planilha, nomes de variáveis ​​curtos (mas legíveis por humanos), o intervalo de valores ou valores aceitos para a variável, descrição da variável e outras informções pertinentes."(Dados Científicos: como construir metadados, descrição, readme, dicionário-de-dados e mais; Agência de Bibliotecas e Coleções Digitais da Universidade de São Paulo)

## Entidade: Arma

### Descrição

A entidade Arma descreve as armas disponíveis no jogo e outras informações, como: seu número de identificação, nome, dano, finalidade e se elea já está disponível no inventário do jogador logo no início do jogo.

#### Observação

Essa tabela possui chave estrangeira da entidade `Item`.

|  Nome Variável  |   Tipo    |                    Descrição                    | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-------------: | :-------: | :---------------------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|     id_arma     |    int    |           Identificador do item arma            |       1-5000       |          não           |  PK  |                    |
|     id_item     |    int    |           Chave estrangeira para Item           |       1-5000       |          não           | FK  |                    |
|      nome       | char[50]  |                  Nome da arma                   |      a-z, A-Z      |          não           |          |                    |
|    descricao    | char[800] |                Descrição da arma                |      a-z, A-Z      |          sim           |          |                    |
|      dano       |    int    |                  Dano da arma                   |        1-10        |          não           |          |                    |
|   finalidade    | char[100] |               Finalidade da arma                |      a-z, A-Z      |          não           |          |                    |
| comeca_jogo_com |  boolean  | arma disponivel no inventario no inicio do jogo |    true, false     |          não           |          |                    |

## Entidade: Artesanato

### Descrição

A entidade Artesanato descreve um item que é possível ser construído, contendo seu: seu número de identificação, nome e sua descrição.

#### Observação

Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável |   Tipo    |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :-------: | :------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
| id_artesanato |    int    | Identificador do item artesanato |       1-5000       |          não           |  PK  |                    |
|     id_item     |    int    |           Chave estrangeira para Item           |       1-5000       |          não           | FK  |                    |
|     nome      | char[50]  |    Nome do item de artesanato    |      a-z, A-Z      |          não           |          |                    |
|   descricao   | char[800] | Descrição do item de artesanato  |      a-z, A-Z      |          sim           |          |                    |

## Entidade: Cabana_Jogador

### Descrição

A entidade Cabana_Jogador armazena os dados de onde o jogador mora, contendo: seu número de identificação, sua região, nome, qual jogador está associado e a descrição do local.

#### Observação

Essa tabela possui chaves estrangeiras das entidades `Local_Fechado`, `Jogador` e `Regiao`

|  Nome Variável  |   Tipo    |                    Descrição                    | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-------------: | :-------: | :---------------------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|  id_cabana_jogador  |    int    |         Identificador da cabana do jogador         |       1-5000       |          não           |  PK  |                    |
|     id_local_fechado     |    int    |           Chave estrangeira para Local Fechado           |       1-5000       |          não           | FK  |                    |
| id_prop_cab_jog |    int    | Identificador do Jogador proprietário da cabana |       1-5000       |          não           |  FK  |                    |
|    id_regiao    |    int    |   Identificador da Região onde está a cabana    |       1-5000       |          não           |    FK    | DEFAULT 1          |
|      nome       | char[50]  |                 Nome da cabana                  |      a-z, A-Z      |          não           |          |                    |
|    descricao    | char[800] |               Descrição da cabana               |      a-z, A-Z      |          sim           |          |                    |

## Entidade: Cabana_NPC

### Descrição

A entidade Cabana_NPC armazena os dados de onde o NPC mora, contendo: seu número de identificação, sua região, nome, qual jogador está associado e a descrição do local.

#### Observação

Essa tabela possui chaves estrangeiras das entidades `Local_Fechado`, `NPC` e `Regiao`

|  Nome Variável  |   Tipo    |                  Descrição                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-------------: | :-------: | :-----------------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|  id_cabana_npc  |    int    |       Identificador da Cabana NPC        |       1-5000       |          não           |  PK  |
|     id_local_fechado     |    int    |           Chave estrangeira para Local Fechado           |       1-5000       |          não           | FK  |                    |                    |
| id_npc |    int    | Identificador do NPC proprietário da cabana |       1-5000       |          não           |  FK  |                    |
|    id_regiao    |    int    | Identificador da Região onde estã a cabana  |       1-5000       |          não           |    FK    |                    |
|      nome       | char[50]  |            Nome da cabana do NPC            |      a-z, A-Z      |          não           |          |                    |
|    descricao    | char[800] |         Descrição da cabana do NPC          |      a-z, A-Z      |          sim           |          |                    |

## Entidade: Caverna

### Descrição

A entidade Caverna guarda os dados da região onde a caverna está, seu número de identificação, seu nome e sua descrição.

#### Observação

Essa tabela possui chaves estrangeiras das entidades `Caverna` e `Região`.

| Nome Variável |   Tipo    |                  Descrição                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :-------: | :-----------------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|  id_caverna   |    int    |       Identificador do local fechado        |       1-5000       |          não           |  PK  |                    |
|     id_local_fechado     |    int    |           Chave estrangeira para Local Fechado           |       1-5000       |          não           | FK  |                    |  
|   id_regiao   |    int    | Identificador da Região onde está a caverna |       1-5000       |          não           |   FK  |                    |
|     nome      | char[50]  |               Nome da caverna               |      a-z, A-Z      |          não           |          |                    |
|   descricao   | char[800] |            Descrição da caverna             |      a-z, A-Z      |          sim           |          |                    |

## Entidade: Consumivel

### Descrição

A entidade Consumivel armazena o número de identificação do item consumível, seu nome e sua descrição.

#### Observação

Essa tabela possui chave estrangeira da entidade `Item`, `Ferramenta`, `Regiao` e `Local_Fechado`.

|  Nome Variável   |   Tipo    |                     Descrição                      | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :--------------: | :-------: | :------------------------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|  id_consumivel   |    int    |          Identificador do item consumível          |       1-5000       |          não           |  PK  |                    |
|     id_item     |    int    |           Chave estrangeira para Item           |       1-5000       |          não           | FK  |   
|    id_regiao     |    int    | Identificador da regiao onde se encontra esse item |       1-5000       |          não           |    FK    |                    |
| id_local_fechado |    int    |   Id do local fechado onde se encontra esse item   |       1-5000       |          sim           |    FK    |                    |
|  id_ferramenta   |    int    |     Id da ferramenta que é usada com esse item     |       1-5000       |          não           |    FK    |                    |
|       nome       | char[50]  |              Nome do item consumível               |      a-z, A-Z      |          não           |          |                    |
|    descricao     | char[800] |            Descrição do item consumível            |      a-z, A-Z      |          sim           |          |                    |

## Entidade: Dialogo

### Descrição

A entidade Dialogo descreve a relação entre: o número de identificação do diálogo, o npc relacionado ao diálogo e o que é dito.

#### Observação

Essa tabela possui chave estrangeira da entidade `NPC`

| Nome Variável |   Tipo    |              Descrição              | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :-------: | :---------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|  id_dialogo   |    int    | Código de identificação do diálogo  |       1-5000       |          não           |    PK    |                    |
|    id_NPC     |    int    | codigo do NPC que usa essse dialogo |       1-5000       |          não           |    FK    |                    |
|     fala      | char[800] |         Conteúdo do diálogo         |      a-z, A-Z      |          não           |          |                    |

## Entidade: Efeito

### Descrição

A entidade Efeito armazena o número de identificação do efeito, o item relacionado e sua descrição.

#### Observação

Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável |   Tipo    |                Descrição                 |        Valores permitidos         | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :-------: | :--------------------------------------: | :-------------------------------: | :--------------------: | :------: | ------------------ |
|   id_efeito   |    int    |    Código de identificação do efeito     |              1-5000               |          não           |    PK    |                    |
|    id_item    |    int    | Identificador do item que sofre o efeito |              1-5000               |          não           |    FK    |                    |
|     valor     |    int    |       Valor produzido pelo efeito        |               1-50                |          não           |          |                    |
|     tipo      | char[100] |              tipo do efeito              | 'ganha_energia', 'perde_energia'' |          não           |          |                    |

## Entidade: Estacao

### Descrição

A entidade Estacao armazena o número de identificação da estação, seu nome e sua descrição.

#### Observação

A cada 28 dias, muda a estção do ano: primavera, verão, outono e inverno.

| Nome Variável |   Tipo    |             Descrição              | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :-------: | :--------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|  id_estacao   |    int    | Código de identificação da estação |       1-5000       |          não           |    PK    |                    |
|     nome      | char[50]  |          Nome da estação           |      a-z, A-Z      |          não           |          |                    |
|   descricao   | char[800] |        Descrição da estação        |      a-z, A-Z      |          sim           |          |                    |

## Entidade: Ferramenta

### Descrição

A entidade Ferramenta armazena o número de identificação da ferramenta, seu nome, sua descrição e sua finalidade.

#### Observação

Essa tabela possui chaves estrangeiras das entidades `Item`.

|  Nome Variável  |   Tipo    |                    Descrição                    | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-------------: | :-------: | :---------------------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|  id_ferramenta  |    int    |        Identificador do item ferramenta         |       1-5000       |          não           |  PK  |                    |
|     id_item     |    int    |           Chave estrangeira para Item           |       1-5000       |          não           | FK  |   
|      nome       | char[50]  |               Nome da ferramenta                |      a-z, A-Z      |          não           |          |                    |
|    descricao    | char[800] |             Descrição da ferramenta             |      a-z, A-Z      |          sim           |          |                    |
|   finalidade    | char[100] |            Finalidade da ferramenta             |      a-z, A-Z      |          não           |          |                    |
| comeca_jogo_com |  boolean  | arma disponivel no inventario no inicio do jogo |    true, false     |          não           |          |                    |

## Entidade: Habilidade

### Descrição

A entidade Habilidade contém: os dados do jogador e o seu nível nas habilidades de coleta, cultivo, mineração, pesca e combate.

#### Observação

Essa tabela possui chave estrangeira da entidade `Jogador`.

|  Nome Variável  | Tipo  |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-------------: | :---: | :------------------------------: | :----------------: | :--------------------: | :------: | :----------------: |
|     id_habilidade     |    int    |          Identificador da habilidade           |       1-5000       |          não           | PK  |  
|   id_jogador    |  int  |     Identificador do jogador     |       1-5000       |          não           |   FK  |                    |
|  nivel_coleta   |  int  |  Nível da habilidade de coleta   |       1-1000       |          não           |          |     DEFAULT 1      |
|  nivel_cultivo  |  int  |  Nível da habilidade de cultivo  |       1-1000       |          não           |          |     DEFAULT 1      |
| nivel_mineracao |  int  | Nível da habilidade de mineração |       1-1000       |          não           |          |     DEFAULT 1      |
|   nivel_pesca   |  int  |   Nível da habilidade de pesca   |       1-1000       |          não           |          |     DEFAULT 1      |
|  nivel_combate  |  int  |  Nível da habilidade de combate  |       1-1000       |          não           |          |     DEFAULT 1      |

## Entidade: Instancia_Monstro

### Descrição

A entidade Instancia_Monstro diz respeito a: caverna onde as instâncias dos monstros estarão, o monstro que será instanciado e a saúde da sua instância.

#### Observação

Essa tabela possui chaves estrangeiras das entidades `Caverna` e `Monstro`.

| Nome Variável | Tipo  |                         Descrição                         | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :---: | :-------------------------------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|     id_instancia_monstro    |    int    |           Identificador da instância do monstro           |       1-5000       |          não           | PK  |   
|  id_caverna   |  int  | Identificador da caverna onde está a instância do monstro |       1-5000       |          não           |  FK  |                    |
|  id_monstro   |  int  |                 Identificador do Monstro                  |       1-5000       |          não           |  FK  |                    |
|    energia    |  int  |              Energia da instância de monstro              |       1-100        |          não           |          |                    |

## Entidade: Item

### Descrição

A entidade Item armazena as informações de identificação do item e do seu tipo.

#### Observação

Esta entidade relaciona cada um dos itens com seu tipo. Essa tabela possui chave estrangeira da entidade `Tipo_Item`.

| Nome Variável | Tipo  |            Descrição            | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :---: | :-----------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|    id_item    |  int  | Código de Identificação do item |       1-5000       |          não           |    PK    |                    |
| id_tipo_item  |  int  |  Identificação do tipo do item  |        1-6         |          não           |    FK    |                    |

## Entidade: Item_Estoque_Loja

### Descrição

A entidade Item_Estoque_Loja guarda o produto disponível, a loja associada e o preço associado.

#### Observação

Essa tabela possui chaves estrangeiras das entidades `Item` e `Loja`.

| Nome Variável | Tipo  |           Descrição           | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :---: | :---------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|    id_estoque_loja    |  int  | Identificador do item em estoque da loja |       1-5000       |          não           |  PK  |                    |
|    id_item    |  int  | Identificador do item-produto |       1-5000       |          não           |   FK  |                    |
|    id_loja    |  int  |     Identificador da loja     |       1-5000       |          não           |   FK  |                    |
|     preco     |  int  |  Preço do produto no estoque  |      1-500000      |          não           |          |                    |

## Entidade: Item_Inventário

### Descrição

A entidade Item_Inventário relaciona o jogador, os seus itens e a quantidade de itens disponíveis no inventário.

#### Observação

Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável | Tipo  |        Descrição         | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :---: | :----------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|    id_item_inventario    |  int  | Identificador de um item no inventário |       1-5000       |          não           |  PK  |                    |
|  id_jogador   |  int  | Identificador do Jogador |       1-5000       |          não           |   FK  |                    |
|    id_item    |  int  |  Identificador do Item   |       1-5000       |          não           |   FK  |                    |
|     qtdd      |  int  |    quantidade do item    |       1-5000       |          não           |          |                    |

## Entidade: Item_Receita

### Descrição

A entidade Item_Receita armazena os dados do item, os itens que podem ser criados por meio do artesanato e a quantidade de itens que são necessários na receita.

#### Observação

Essa tabela possui chaves estrangeiras das entidades `Artesanato` e `Item`.

| Nome Variável | Tipo  |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :---: | :------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|    id_item_receita    |  int  | Identificador de um item na receita |       1-5000       |          não           |  PK  |                    |
| id_artesanato |  int  |   Identificador do artesanato    |       1-5000       |          não           |  FK  |                    |
|    id_item    |  int  |      Identificador do item       |       1-5000       |          não           |  FK  |                    |
|     qtdd      |  int  | Quantidade desse item na receita |       1-5000       |          não           |          |                    |

## Entidade: Jogador

### Descrição

A entidade Jogador descreve as informações ligadas ao personável jogável, como: seu número de identificação, o local onde está, a região onde está, a estação atual do seu jogo, a missão que está fazendo, seu nome, seu nível de saúde e energia, o dia em que está e a quantidade de ouro que tem.

#### Observação

Essa tabela possui chaves estrangeiras das entidades `Local`, `Regiao`,`Estacao` e `Missao`.

|  Nome Variável   |   Tipo   |                Descrição                | Valores permitidos | Permite valores nulos? | É chave? |      Outras Observações      |
| :--------------: | :------: | :-------------------------------------: | :----------------: | :--------------------: | :------: | :--------------------------: |
|    id_jogador    |   int    |   Código de identificação do jogador    |       1-5000       |          não           |    PK    |                              |
| id_local_fechado |   int    |         Identificador do local          |       1-5000       |          sim           |    FK    |          DEFAULT 1           |
|    id_regiao     |   int    |         Identificador da região         |       1-5000       |          não           |    FK    |                              |
|    id_estacao    |   int    |     Identificador da estação_atual      |        1-4         |          não           |    FK    |          DEFAULT 1           |
|    id_missao     |   int    |      Identificador da missao_atual      |       1-5000       |          sim           |    FK    |          DEFAULT 1           |
|       nome       | char[50] |             Nome do jogador             |      a-z, A-Z      |          não           |          |                              |
|     energia      |   int    |           Energia do jogador            |       1-100        |          não           |          |         DEFAULT 100          |
|       dia        |   int    |             Dia do jogador              |        1-28        |          não           |          |          DEFAULT 1           |
|       hora       |   int    | Hora em que o jogador está (em minutos) |       0-1440       |          não           |          | DEFAULT 360 - Começa em 6:00 |
|    qtdd_ouro     |   int    |      Quantidade de ouro do jogador      |       min. 0       |          não           |          |         DEFAULT 500          |

## Entidade: Local_Fechado

### Descrição

A entidade Local_Fechado possui os números de identificação do local e de qual é seu tipo.

#### Observação

Os locais fechados podem ser de 4 tipos: cabana do jogador, cabana de um NPC, caverna e loja. Essa tabela possui chave estrangeira da entidade `Tipo_Local_Fechado`.

|     Nome Variável     | Tipo  |                Descrição                 | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-------------------: | :---: | :--------------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|   id_local_fechado    |  int  | Código de identificação do local fechado |       1-5000       |          não           |    PK    |                    |
| id_tipo_local_fechado |  int  |  Identificação do tipo de local fechado  |        1-4         |          não           |    FK    |                    |

## Entidade: Loja

### Descrição

A entidade loja armazena as informações do: número de identificação da loja, seu proprietário, sua região, o nome da loja e sua descrição.

#### Observação

Essa tabela possui chaves estrangeiras das entidades `Local_Fechado`, `NPC` e `Regiao`.

| Nome Variável |   Tipo    |                Descrição                 | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :-------: | :--------------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|    id_loja    |    int    |      Identificador de loja      |       1-5000       |          não           |  PK  |                    |
|    id_local_fechado    |    int    |      Identificador do local fechado      |       1-5000       |          não           |   FK  |                    |
|  id_npc  |    int    |      Identificador do proprietário       |       1-5000       |          não           |    FK    |                    |
|   id_regiao   |    int    | Identificador da região onde está a loja |       1-5000       |          não           |    FK    |                    |
|     nome      | char[50]  |               Nome da loja               |      a-z, A-Z      |          não           |          |                    |
|   descricao   | char[800] |            Descrição da loja             |      a-z, A-Z      |          sim           |          |                    |

## Entidade: Missao

### Descrição

A entidade Missao relaciona o número de identificação da missão, a estação em que está sendo realizada, seu nome e sua descrição.

#### Observação

Essa tabela possui chave estrangeira da entidade `Estacao`.

| Nome Variável |   Tipo    |             Descrição              | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :-------: | :--------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|   id_missao   |    int    | Código de identificação da missão  |       1-5000       |          não           |    PK    |                    |
|  id_estacao   |    int    | Identificador da Estação da missão |        1-4         |          não           |    FK    |                    |
|     nome      | char[50]  |           Nome da missão           |      a-z, A-Z      |          não           |          |                    |
|   descricao   | char[800] |        Descrição da missão         |      a-z, A-Z      |          sim           |          |                    |

## Entidade: Monstro

### Descrição

A entidade Monstro descreve a relação entre seu número de identificação, o item que será deixado após ser derrotado, seu nome, sua descrição, o dano que pode causar, sua defesa e sua saúde máxima.

#### Observação

Essa tabela possui chaves estrangeiras das entidades `Item`.

| Nome Variável  |   Tipo    |                     Descrição                      | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :------------: | :-------: | :------------------------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|   id_monstro   |    int    |         Código de identificação do monstro         |       1-5000       |          não           |    PK    |                    |
|    id_drop     |    int    | Id do item deixado pelo monstro após ser derrotado |       1-5000       |          não           |    FK    |                    |
|      nome      | char[50]  |                  Nome do monstro                   |      a-z, A-Z      |          não           |          |                    |
|   descricao    | char[800] |                Descrição do monstro                |      a-z, A-Z      |          sim           |          |                    |
|      dano      |    int    |             Dano causado pelo monstro              |        1-10        |          não           |          |                    |
|     defesa     |    int    |                 Defesa do monstro                  |        1-10        |          não           |          |                    |
| energia_maxima |    int    |             Energia máxima do monstro              |       1-100        |          não           |          |                    |

## Entidade: Mundo

### Descrição

A entidade Mundo armazena dados do número de identificação do mundo e seu nome.

#### Observação

O mundo é formado por regiões e cada região tem uma fazenda diferente para o jogador cuidar.

| Nome Variável |   Tipo    |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :-------: | :------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|   id_mundo    |    int    | Código de identificação do mundo |       1-5000       |          não           |    PK    |                    |
|     nome      | char[50]  |          Nome do mundo           |      a-z, A-Z      |          não           |          |                    |
|   descricao   | char[800] |        Descrição do mundo        |      a-z, A-Z      |          não           |          |                    |

## Entidade: NPC

### Descrição

A entidade NPC guarda as informações relacionada aos personagens não-jogáveis, tais como: seu número de identificação, a região em que está, o local em que está, seu nome e sua profissão.

#### Observação

Essa tabela possui chaves estrangeiras das entidades `Regiao` e `Local`.

|  Nome Variável   |   Tipo    |                Descrição                | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :--------------: | :-------: | :-------------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|      id_npc      |    int    |     Código de identificação do npc      |       1-5000       |          não           |    PK    |                    |
|    id_regiao     |    int    | Identificador da regiao onde o NPC está |       1-5000       |          não           |    FK    |                    |
| id_local_fechado |    int    | Identificador do local onde o NPC está  |       1-5000       |          sim           |    FK    |                    |
|       nome       | char[50]  |               Nome do npc               |      a-z, A-Z      |          não           |          |                    |
|    profissao     | char[100] |            Profissão do npc             |      a-z, A-Z      |          sim           |          |                    |

## Entidade: Plantacao

### Descrição

Armazena as sementes que foram plantadas com seu respectivo dia de colheita.

#### Observação

Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável | Tipo  |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :---: | :------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|  id_plantacao   |  int  | Identificador da plantação |       1-5000       |          não           |  PK |  
|  id_semente   |  int  | Identificador do item da semente |       1-5000       |          não           |   FK  |                    |
| dia_colheita  |  int  |    dia de colheita calculado     |        1-28        |          não           |          |                    |

## Entidade: Região

### Descrição

Descreve as regiões disponíveis disponíveis no jogo, seu nome e o mundo onde elas pertencem.

#### Observação

Essa tabela possui chave estrangeira da entidade `Mundo`. As regiões contém locais ao ar livre e locais fechados.

| Nome Variável |   Tipo    |             Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :-------: | :-------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|   id_regiao   |    int    | Código de identificação da regiao |       1-5000       |          não           |    PK    |                    |
|   id_mundo    |    int    |      Identificador do mundo       |       1-5000       |          não           |    FK    |                    |
|     nome      | char[50]  |          Nome da regiao           |      a-z, A-Z      |          não           |          |                    |
|   descricao   | char[800] |        Descrição do mundo         |      a-z, A-Z      |          não           |          |                    |

## Entidade: Semente

### Descrição

Descreve as sementes disponíveis no jogo e outras informações, como: nome, estação que ela floresce, valor de venda e dias para crescer.

#### Observação

Essa tabela possui chaves estrangeiras das entidades `Item` e `Estacao`.

|   Nome Variável   |   Tipo    |                Descrição                | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :---------------: | :-------: | :-------------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
|    id_semente     |    int    |        Identificador da semente         |       1-5000       |          não           |  PK |                    |
|    id_item     |    int    |        Chave estrangeira para item         |       1-5000       |          não           |  FK  |                    |
|    id_estacao     |    int    |        Identificador da estação         |       1-5000       |          não           |    FK    |                    |
|       nome        | char[50]  |          Nome do item semente           |      a-z, A-Z      |          não           |          |                    |
|     descricao     | char[800] |          Descrição da semente           |      a-z, A-Z      |          sim           |          |                    |
|    valor_venda    |    int    |            Preço da semente             |       1-5000       |          não           |          |                    |
| dias_para_crescer |    int    | Dias que a semente precisa para crescer |        1-28        |          não           |          |                    |

## Entidade: Tipo_Item

### Descrição

Descreve os tipos de itens disponíveis no jogo e o nome desse tipo.

#### Observação

Os itens podem ser de 6 tipos: arma, ferramenta, consumivel, vestimenta, artesanato e semente.

| Nome Variável | Tipo  |           Descrição           | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :---: | :---------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
| id_tipo_item  |  int  | Identificador do tipo de Item |        1-6         |          não           |    PK    |                    |
| nome_tipo_item | char[20] |     Nome do tipo de item      | "arma", "ferramenta", "consumivel", "vestimenta", "artesanato", "semente" |          não           |          |                    |

## Entidade: Tipo_Local_Fechado

### Descrição

Descreve os tipos de locais fechados disponíveis no jogo e o nome desse tipo.

#### Observação

Os itens podem ser de 4 tipos: cabana do jogador, cabana de NPC, caverna ou loja.

|      Nome Variável      |   Tipo   |               Descrição                |              Valores permitidos               | Permite valores nulos? | É chave? | Outras Observações |
| :---------------------: | :------: | :------------------------------------: | :-------------------------------------------: | :--------------------: | :------: | ------------------ |
|  id_tipo_local_fechado  |   int    | Identificador do tipo de Local Fechado |                      1-4                      |          não           |    PK    |                    |
| nome_tipo_local_fechado | char[20] |          Nome do tipo de item          | "cabana_jog", "cabana_npc", "caverna", "loja" |          não           |          |                    |

## Entidade: Vestimenta

### Descrição

A entidade Vestimenta armazena o número de identificação do vestimenta, seu nome e sua descrição.

#### Observação

Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável |   Tipo    |           Description            | Valores permitidos | Permite valores nulos? | É chave? | Outras Observações |
| :-----------: | :-------: | :------------------------------: | :----------------: | :--------------------: | :------: | ------------------ |
| id_vestimenta |    int    | Identificador do item vestimenta |       1-5000       |          não           |  PK  |                    |
|     id_item     |    int    |           Chave estrangeira para Item           |       1-5000       |          não           | FK  |                    |
|     nome      | char[50]  |        Nome da vestimenta        |      a-z, A-Z      |          não           |          |                    |
|   descricao   | char[800] |     Descrição da vestimenta      |      a-z, A-Z      |          sim           |          |                    |
