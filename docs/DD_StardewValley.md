## Histórico de versões

| Versão |    Data    | Descrição               | Autor                                              | Revisão |
| :----: | :--------: | ----------------------- | -------------------------------------------------- | ------- |
| `1.0`  | 16/09/2023 | Criação do documento DD | [Zenilda Vieira](https://github.com/ZenildaVieira) |         |

# DD - Dicionário de Dados

É... (definir)

## Tabela: Arma
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Artesanato
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-artesanto | Chave estrangeira referenciando o identificador da tabela Receita | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Cabana-Jogador
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-cabana-jog| Chave estrangeira referenciando o identificador da tabela Local-Fechado | Int |  | FK |
| jogador| Chave estrangeira referenciando o identificador da tabela Jogador | Int |  | FK |
| regiao| Chave estrangeira referenciando o identificador da tabela Regiao | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Cabana-NPC
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-cabana-npc| Chave estrangeira referenciando o identificador da tabela Local-Fechado | Int |  | FK |
| npc| Chave estrangeira referenciando o identificador da tabela NPC | Int |  | FK |
| regiao| Chave estrangeira referenciando o identificador da tabela Regiao | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Caverna
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-caverna | Chave estrangeira referenciando o identificador da tabela Local-Fechado | Int |  | FK |
| regiao | Chave estrangeira referenciando o identificador da tabela Regiao | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Consumível
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-consumivel | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Dialogo
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-dialogo | Chave primaria referenciando o identificador da tabela Dialogo | Int |  | PK |
| npc| Chave estrangeira referenciando o identificador da tabela NPC | Int |  | FK |
| fala | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Efeito
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-efeito | Chave primaria referenciando o identificador da tabela Efeito | Int |  | PK |
| item | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| valor | :-----------: | :-----: | :--------------------: | :----------------: |
| tipo | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Estacao
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Estoque
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Ferramenta
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Habilidade
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Instancia-Monstro
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Inventário
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Item
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Jogador
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Local-Fechado
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Loja
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Missao
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Monstro
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Mundo
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: NPC
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Receita
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Regiao
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Semente
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |


## Tabela: Vestimenta
#### Descrição:
#### Observações:
Possui uma chave estrangeira da tabela Item

|  Nome Variável  |  Descrição  |  Tipo de Dado  |  Tamanho  |  Restrições Domínio (PF, FK, Not Null, Check, Default, Identity)  |
| :---------: | :-----------: | :-----: | :--------------------: | :----------------: |
| id-arma | Chave estrangeira referenciando o identificador da tabela Item | Int |  | FK |
| nome | :-----------: | :-----: | :--------------------: | :----------------: |
| descricao | :-----------: | :-----: | :--------------------: | :----------------: |
| dano | :-----------: | :-----: | :--------------------: | :----------------: |
| finalidade | :-----------: | :-----: | :--------------------: | :----------------: |











# Modelos da Zenilda
## Tabela: Mundo
#### Descrição:
#### Observações

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
