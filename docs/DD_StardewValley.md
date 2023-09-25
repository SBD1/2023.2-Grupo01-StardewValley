## Histórico de versões

| Versão |    Data    | Descrição               | Autor                                                                                                   | Revisão |
| :----: | :--------: | ----------------------- | ------------------------------------------------------------------------------------------------------- | ------- |
| `1.0`  | 16/09/2023 | Criação do documento DD | [Zenilda Vieira](https://github.com/ZenildaVieira)                                                      |         |
| `1.1`  | 24/09/2023 | Adequação do DD ao DER  | [Marcus Martins](https://github.com/marcusmartinss) <br> [Edilberto](https://github.com/marcusmartinss) |         |

# DD - Dicionário de Dados

> "Um dicionário de dados é uma coleção de nomes, atributos e definições sobre elementos de dados que estão sendo usados ​​em seu estudo. [...] O objetivo de um dicionário de dados é explicar o que todos os nomes e valores de variáveis ​​em sua planilha realmente significam. Em um dicionário de dados podem ser encontrados dados sobre os nomes das variáveis ​​exatamente como aparecem na planilha, nomes de variáveis ​​curtos (mas legíveis por humanos), o intervalo de valores ou valores aceitos para a variável, descrição da variável e outras informções pertinentes."(Dados Científicos: como construir metadados, descrição, readme, dicionário-de-dados e mais; Agência de Bibliotecas e Coleções Digitais da Universidade de São Paulo)

## Entidade: Arma

#### Descrição:

#### Observação: 

| Nome Variável |  Tipo   |       Descrição        | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :--------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|    id-arma    |   int   | Identificação do mundo |       1-5000       |          não           | PK       |                   |
|     nome      | varchar |      Nome da arma      |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar |   Descrição da arma    |      a-z, A-Z      |          sim           |          |                   |
|     dano      |   int   |      Dano da arma      |       1-100        |          não           |          |                   |
|  finalidade   | varchar |   Finalidade da arma   |      a-z, A-Z      |          não           |          |                   |

## Entidade: Artesanato

#### Descrição:

#### Observação:

| Nome Variável |  Tipo   |              Descrição              | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :---------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
| id-artesanato |   int   | Código de identificação da entidade |       1-5000       |          não           | PK       |                   |
|     nome      | varchar |           Nome da região            |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar |       Descrição do artesanato       |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Cabana-Jogador

#### Descrição:



#### Observação:

- Essa tabela possui chaves estrangeiras das entidades `Jogador` e `Regiao`

| Nome Variável |  Tipo   |             Descrição              | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :--------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
| id-cabana-jog |   int   | Identificação da cabana do jogador |       1-5000       |          não           | PK       |                   |
|    jogador    |   int   |   Jogador proprietário da cabana   |        1-10        |          não           | FK       |                   |
|    regiao     |   int   |    Região da cabana do jogador     |        1-10        |          não           | FK       |                   |
|     nome      | varchar |           Nome da região           |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar |        Descrição da região         |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Cabana-NPC

#### Descrição:

#### Observação:

- Essa tabela possui chaves estrangeiras das entidades `Local-Fechado`, `NPC` e `Regiao`

| Nome Variável |  Tipo   |           Descrição            | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :----------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
| id-cabana-npc |   int   | Identificação da cabana do NPC |       1-5000       |          não           | FK       |                   |
|      npc      |   int   |   NPC proprietário da cabana   |        1-10        |          não           | FK       |                   |
|    regiao     |   int   |    Região da cabana do NPC     |        1-10        |          não           | FK       |                   |
|     nome      | varchar |     Nome da cabana do NPC      |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar |   Descrição da cabana do NPC   |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Caverna

#### Descrição:

#### Observação:

- Essa tabela possui chave estrangeira da entidade `Regiao`

| Nome Variável |  Tipo   |        Descrição         | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :----------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|  id-caverna   |   int   | Identificação da caverna |       1-5000       |          não           | PK       |                   |
|    regiao     |   int   |    Região da caverna     |        1-10        |          não           | FK       |                   |
|     nome      | varchar |     Nome da caverna      |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar |   Descrição da caverna   |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Consumível

#### Descrição:

#### Observação:

| Nome Variável |  Tipo   |          Descrição          | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :-------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
| id-consumivel |   int   | Identificação do consumível |       1-5000       |          não           | PK       |                   |
|     nome      | varchar |     Nome do consumível      |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar |   Descrição do consumível   |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Diálogo

#### Descrição:

#### Observação:

- Essa tabela possui chave estrangeira da entidade `NPC`

| Nome Variável |  Tipo   |        Descrição         | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :----------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|  id-dialogo   |   int   | Identificação do diálogo |       1-5000       |          não           | PK       |                   |
|      npc      | varchar |     Nome do diálogo      |      a-z, A-Z      |          não           | FK       |                   |
|     fala      | varchar |   Conteúdo do diálogo    |      a-z, A-Z      |          não           |          |                   |

## Entidade: Efeito

#### Descrição:

#### Observação: Essa tabela possui chave estrangeira da entidade `Item`

| Nome Variável |  Tipo   |        Descrição        | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :---------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|   id-efeito   |   int   | Identificação do efeito |       1-5000       |          não           | PK       |                   |
|     item      |   int   |     Nome do efeito      |        1-10        |          não           | FK       |                   |
|   descricao   | varchar |   Descrição do efeito   |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Estação

#### Descrição:

#### Observação:

| Nome Variável |  Tipo   |        Descrição         | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :----------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|  id-estacao   |   int   | Identificação da estação |       1-5000       |          não           | PK       |                   |
|     nome      | varchar |     Nome da estação      |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar |   Descrição da estação   |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Estoque

#### Descrição:

#### Observação:  Essa tabela possui chaves estrangeiras das entidades `Item` e `Loja`

| Nome Variável |  Tipo   |          Descrição          | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :-------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|    produto    |   int   |     Conteúdo de produto     |                    |          não           | FK       |                   |
|     loja      | varchar |      Conteúdo da loja       |      a-z, A-Z      |          não           | FK       |                   |
|     preço     |   int   | Preço do produto no estoque |    0-2147483647    |          não           |          |                   |

## Entidade: Ferramenta

#### Descrição:

#### Observação:

| Nome Variável |  Tipo   |          Descrição          | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :-------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
| id-ferramenta |   int   | Identificação da ferramenta |       1-5000       |          não           | PK       |                   |
|     nome      | varchar |     Nome da ferramenta      |        1-10        |          não           |          |                   |
|   descricao   | varchar |   Descrição da ferramenta   |        1-10        |          sim           |          |                   |
|  finalidade   | varchar |  Finalidade da ferramenta   |        1-10        |          não           |          |                   |

## Entidade: Habilidade

#### Descrição:

#### Observação: Essa tabela possui chave estrangeira da entidade `Jogador`

|  Nome Variável  |  Tipo   |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-------------: | :-----: | :------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|     jogador     |   int   |       Conteúdo do jogador        |        1-10        |          não           | FK       |                   |
|  nivel-coleta   | varchar |  Nível da habilidade de coleta   |        1-10        |          não           |          |                   |
|  nivel-cultivo  | varchar |  Nível da habilidade de cultivo  |        1-10        |          não           |          |                   |
| nivel-mineracao | varchar | Nível da habilidade de mineração |        1-10        |          não           |          |                   |
|   nivel-pesca   | varchar |   Nível da habilidade de pesca   |        1-10        |          não           |          |                   |
|  nivel-combate  | varchar |  Nível da habilidade de combate  |        1-10        |          não           |          |                   |


## Entidade: Instancia-Monstro

#### Descrição:

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Caverna` e `Monstro`

| Nome Variável |  Tipo   |                 Descrição                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :----------------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|    caverna    |   int   | Caverna onde estará a instância do monstro |        1-10        |          não           | FK       |                   |
|    monstro    | varchar |            Conteúdo de Monstro             |        1-10        |          não           | FK       |                   |
|     saude     | varchar |       Saúde da instância de monstro        |        1-10        |          não           |          |                   |

## Entidade: Inventário

#### Descrição:

#### Observação:  Essa tabela possui chave estrangeira da entidade `Item`

| Nome Variável |  Tipo   |            Descrição            | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :-----------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|    jogador    |   int   |       Conteúdo de Jogador       |        1-10        |          não           | FK       |                   |
|     item      | varchar |        Conteúdo de Item         |        1-10        |          não           | FK       |                   |
|     qtdd      | varchar | Espaço disponível no inventário |        1-10        |          não           |          |                   |

## Entidade: Item

#### Descrição:

#### Observação:

| Nome Variável |  Tipo   |           Descrição           | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :---------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|    id-item    |   int   |  Identificação da vestimenta  |       1-5000       |          não           | PK       |                   |
|    id-tipo    | varchar | Identificação do tipo do item |                    |          não           |          |                   |

## Entidade: Jogador

#### Descrição:

#### Observação:  Essa tabela possui chaves estrangeiras das entidades `Local`, `Regiao`,`Estacao` e `Missao` 

| Nome Variável |  Tipo   |           Descrição            | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :----------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|  id-jogador   |   int   |    Identificação do jogador    |       1-5000       |          não           | PK       |                   |
|     local     |   int   |     Identificação do local     |       1-5000       |          não           | FK       |                   |
|    regiao     |   int   |    Identificação da região     |       1-5000       |          não           | FK       |                   |
| estacao-atual |   int   | Identificação da estação-atual |       1-5000       |          não           | FK       |                   |
| missao-atual  |   int   | Identificação da missao-atual  |       1-5000       |          sim           | FK       |                   |
|     nome      | varchar |        Nome do jogador         |      a-z, A-Z      |          não           |          |                   |
|     saude     | varchar |        Saude do jogador        |      a-z, A-Z      |          não           |          |                   |
|    energia    | varchar |       Energia do jogador       |      a-z, A-Z      |          não           |          |                   |
|      dia      | varchar |         Dia do jogador         |      a-z, A-Z      |          não           |          |                   |
|   qtdd-ouro   |   int   | Quantidade de ouro do jogador  |       min. 0       |          sim           |          |                   |

## Entidade: Local-Fechado

#### Descrição:

#### Observação:

| Nome Variável | Tipo  |               Descrição                | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :---: | :------------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|   id-local    |  int  |     Identificação do local fechado     |       1-5000       |          não           | PK       |                   |
|    id-tipo    |  int  | Identificação do tipo de local fechado |       1-5000       |          não           |          |                   |


## Entidade: Loja

#### Descrição:

#### Observação:  Essa tabela possui chaves estrangeiras das entidades `Local-Fechado`, `NPC` e `Regiao`

| Nome Variável |  Tipo   |           Descrição           | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :---------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|    id-loja    |   int   |     Identificação da loja     |       1-5000       |          não           | PK       |                   |
| proprietario  |   int   | Identificação do proprietário |       1-5000       |          não           | FK       |                   |
|    regiao     |   int   |    Identificação da região    |       1-5000       |          não           | FK       |                   |
|     nome      | varchar |         Nome da loja          |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar |       Descrição da loja       |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Missao

#### Descrição:

#### Observação: Essa tabela possui chave estrangeira da entidade `Estacao`

| Nome Variável |  Tipo   |        Descrição        | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :---------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|   id-missao   |   int   | Identificação da missão |       1-5000       |          não           | PK       |                   |
|    estacao    |   int   |    Estação da missão    |       1-5000       |          não           | FK       |                   |
|     nome      | varchar |     Nome da missão      |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar |   Descrição da missão   |      a-z, A-Z      |          sim           |          |                   |

## Entidade: Monstro

#### Descrição:

#### Observação:  Essa tabela possui chaves estrangeiras das entidades `Item`
| Nome Variável |  Tipo   |                 Descrição                  | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :----------------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|  id-monstro   |   int   |          Identificação do monstro          |       1-5000       |          não           | PK       |                   |
|     drop      |   int   | Itens deixados pelo monstro após um ataque |       1-5000       |          não           | FK       |                   |
|     nome      | varchar |              Nome do monstro               |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar |            Descrição do monstro            |      a-z, A-Z      |          sim           |          |                   |
|     dano      | varchar |         Cano causado pelo monstro          |      a-z, A-Z      |          não           |          |                   |
|    defesa     | varchar |             Defesa do monstro              |      a-z, A-Z      |          não           |          |                   |
| saude-maxima  | varchar |          Saúde máxima do monstro           |      a-z, A-Z      |          não           |          |                   |

## Entidade: Mundo

#### Descrição:

#### Observação:  
| Nome Variável |  Tipo   |       Descrição        | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :--------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|   id-mundo    |   int   | Identificação do mundo |       1-5000       |          não           | PK       |                   |
|     nome      | varchar |     Nome do mundo      |      a-z, A-Z      |          não           |          |                   |

## Entidade: NPC

#### Descrição:

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Regiao` e `Local`

| Nome Variável |  Tipo   |        Descrição        | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :---------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|    id-npc     |   int   |  Identificação do npc   |       1-5000       |          não           | PK       |                   |
|    regiao     |   int   | Identificação da regiao |       1-5000       |          não           | FK       |                   |
|     local     |   int   | Identificação do local  |       1-5000       |          não           | FK       |                   |
|     nome      | varchar |       Nome do npc       |      a-z, A-Z      |          não           |          |                   |
|   profissao   | varchar |    Profissão do npc     |      a-z, A-Z      |          não           |          |                   |

## Entidade: Receita

#### Descrição:

#### Observação:  Essa tabela possui chaves estrangeiras das entidades `Artesanato` e `Item`

| Nome Variável | Tipo  |           Descrição            | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :---: | :----------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|  artesanato   |  int  |    Identificação da receita    |       1-5000       |          não           | FK       |                   |
|     item      |  int  |     Identificação do item      |       1-5000       |          não           | FK       |                   |
|     qtdd      |  int  | Quantidade de itens da receita |       1-5000       |          não           |          |                   |

## Entidade: Região

#### Descrição:

#### Observação:  Essa tabela possui chave estrangeira da entidade `Mundo`

| Nome Variável |  Tipo   |        Descrição        | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :---------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|   id-regiao   |   int   | Identificação da regiao |       1-5000       |          não           | PK       |                   |
|     mundo     |   int   | Identificação do mundo  |       1-5000       |          não           | FK       |                   |
|     nome      | varchar |     Nome da regiao      |      a-z, A-Z      |          não           |          |                   |

## Entidade: Semente

#### Descrição:

#### Observação: Essa tabela possui chaves estrangeiras das entidades `Item` e `Estacao`

|   Nome Variável   |  Tipo   |                Descrição                | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :---------------: | :-----: | :-------------------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
|    id-semente     |   int   |        Identificação da semente         |       1-5000       |          não           | FK       |                   |
|      estacao      |   int   |        Identificação da estação         |       1-5000       |          não           | FK       |                   |
|       nome        | varchar |             Nome da semente             |      a-z, A-Z      |          não           |          |                   |
|     descricao     | varchar |          Descrição da semente           |      a-z, A-Z      |          sim           |          |                   |
|    valor-venda    |   int   |            Preço da semente             |       1-5000       |          não           |          |                   |
| dias-para-crescer |   int   | Dias que a semente precisa para crescer |        1-28        |          não           |          |                   |

## Entidade: Vestimenta

#### Descrição:

#### Observação: Essa tabela possui chave estrangeira da entidade `Vestimenta`

| Nome Variável |  Tipo   |         Description         | Valores permitidos | Permite valores nulos? | É chave? | Outras Restrições |
| :-----------: | :-----: | :-------------------------: | :----------------: | :--------------------: | -------- | ----------------- |
| id-vestimenta |   int   | Identificação da vestimenta |       1-5000       |          não           | FK       |                   |
|     nome      | varchar |     Nome da vestimenta      |      a-z, A-Z      |          não           |          |                   |
|   descricao   | varchar |   Descrição da vestimenta   |      a-z, A-Z      |          sim           |          |                   |