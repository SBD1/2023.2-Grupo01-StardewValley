## Histórico de versões

| Versão |    Data    | Descrição               | Autor                                              | Revisão |
| :----: | :--------: | ----------------------- | -------------------------------------------------- | ------- |
| `1.0`  | 16/09/2023 | Criação do documento DD | [Zenilda Vieira](https://github.com/ZenildaVieira) |         |

# DD - Dicionário de Dados

É... (definir)

## Entidade: Mundo

#### Descrição:

|  Variável   | Nome Variável |  Tipo   |       Descrição        | Valores permitidos | Possui valores nulo? | É chave? |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: | :------------------: | -------- |
| ID do mundo |   id_mundo    |   int   | Identificação do mundo |        1-10        |         não          |    PK    |
|    Nome     |     nome      | varchar |     Nome do mundo      |        1-10        |         não          |          |

## Entidade: Região

#### Descrição:

|   Variável   | Nome Variável |  Tipo   |        Descrição        | Valores permitidos | Possui valores nulo? | É chave? |
| :----------: | :-----------: | :-----: | :---------------------: | :----------------: | :------------------: | -------- |
| ID da região |   ID_Região   |   int   | Identificação da região |        1-10        |         não          |    PK    |
|     Nome     |     nome      | varchar |     Nome da região      |        1-10        |         não          |          |

## Entidade: Jogador

#### Descrição:

|   Variável    | Nome Variável |  Tipo   |        Descrição         | Valores permitidos | Possui valores nulo? | É chave? |
| :-----------: | :-----------: | :-----: | :----------------------: | :----------------: | :------------------: | -------- |
| ID do jogador |  ID_Jogador   |   int   | Identificação do jogador |        1-10        |         não          |    PK    |
|     Nome      |     nome      | varchar |     Nome do jogador      |        1-10        |         não          |          |

## Entidade: Casa

#### Descrição:

|  Variável  | Nome Variável |  Tipo   |       Descrição       | Valores permitidos | Possui valores nulo? | É chave? |
| :--------: | :-----------: | :-----: | :-------------------: | :----------------: | :------------------: | -------- |
| ID da casa |    ID_Casa    |   int   | Identificação da casa |        1-10        |         não          |    PK    |
|    Nome    |     nome      | varchar |     Nome da casa      |        1-10        |         não          |          |

## Entidade: Caverna

#### Descrição:

|  Variável  | Nome Variável |  Tipo   |       Descrição       | Valores permitidos | Possui valores nulo? | É chave? |
| :--------: | :-----------: | :-----: | :-------------------: | :----------------: | :------------------: | -------- |
| ID da casa |    ID_Casa    |   int   | Identificação da casa |        1-10        |         não          |    PK    |
|    Nome    |     nome      | varchar |     Nome da casa      |        1-10        |         não          |          |

## Entidade: Diálogo

#### Descrição:

|  Variável  | Nome Variável |  Tipo   |       Descrição       | Valores permitidos | Possui valores nulo? | É chave? |
| :--------: | :-----------: | :-----: | :-------------------: | :----------------: | :------------------: | -------- |
| ID da casa |    ID_Casa    |   int   | Identificação da casa |        1-10        |         não          |    PK    |
|    Nome    |     nome      | varchar |     Nome da casa      |        1-10        |         não          |          |

## Entidade: NPC

#### Descrição:

|  Variável  | Nome Variável |  Tipo   |       Descrição       | Valores permitidos | Possui valores nulo? | É chave? |
| :--------: | :-----------: | :-----: | :-------------------: | :----------------: | :------------------: | -------- |
| ID da casa |    ID_Casa    |   int   | Identificação da casa |        1-10        |         não          |    PK    |
|    Nome    |     nome      | varchar |     Nome da casa      |        1-10        |         não          |          |

## Entidade: Loja

#### Descrição:

|  Variável  | Nome Variável |  Tipo   |       Descrição       | Valores permitidos | Possui valores nulo? | É chave? |
| :--------: | :-----------: | :-----: | :-------------------: | :----------------: | :------------------: | -------- |
| ID da casa |    ID_Casa    |   int   | Identificação da casa |        1-10        |         não          |    PK    |
|    Nome    |     nome      | varchar |     Nome da casa      |        1-10        |         não          |          |

## Entidade: Habilidade

#### Descrição:

|  Variável  | Nome Variável |  Tipo   |       Descrição       | Valores permitidos | Possui valores nulo? | É chave? |
| :--------: | :-----------: | :-----: | :-------------------: | :----------------: | :------------------: | -------- |
| ID da casa |    ID_Casa    |   int   | Identificação da casa |        1-10        |         não          |    PK    |
|    Nome    |     nome      | varchar |     Nome da casa      |        1-10        |         não          |          |

## Entidade: Missão

#### Descrição:

|  Variável  | Nome Variável |  Tipo   |       Descrição       | Valores permitidos | Possui valores nulo? | É chave? |
| :--------: | :-----------: | :-----: | :-------------------: | :----------------: | :------------------: | -------- |
| ID da casa |    ID_Casa    |   int   | Identificação da casa |        1-10        |         não          |    PK    |
|    Nome    |     nome      | varchar |     Nome da casa      |        1-10        |         não          |          |

## Entidade: Inventário

#### Descrição:

|  Variável  | Nome Variável |  Tipo   |       Descrição       | Valores permitidos | Possui valores nulo? | É chave? |
| :--------: | :-----------: | :-----: | :-------------------: | :----------------: | :------------------: | -------- |
| ID da casa |    ID_Casa    |   int   | Identificação da casa |        1-10        |         não          |    PK    |
|    Nome    |     nome      | varchar |     Nome da casa      |        1-10        |         não          |          |

## Entidade: Item

#### Descrição:

|  Variável  | Nome Variável |  Tipo   |       Descrição       | Valores permitidos | Possui valores nulo? | É chave? |
| :--------: | :-----------: | :-----: | :-------------------: | :----------------: | :------------------: | -------- |
| ID da casa |    ID_Casa    |   int   | Identificação da casa |        1-10        |         não          |    PK    |
|    Nome    |     nome      | varchar |     Nome da casa      |        1-10        |         não          |          |
