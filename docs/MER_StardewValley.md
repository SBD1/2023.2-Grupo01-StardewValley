## Histórico de versões

| Versão |    Data    | Descrição                                         | Autor                                                        | Revisão |
| :----: | :--------: | ------------------------------------------------- | ------------------------------------------------------------ | ------- |
| `1.0`  | 16/09/2023 | Criação do documento MER                          | [Zenilda Vieira](https://github.com/ZenildaVieira)           |         |
| `1.1`  | 24/09/2023 | Adição das entidades                              | [Matheus Silverio](https://github.com/MattSilverio)          |         |
| `1.2`  | 24/09/2023 | Adição das entidades, atributos e relacionamentos | [Edilberto Cantuaria](https://github.com/edilbertocantuaria) |         |

# MER - Modelo Entidade Relacionamento

O Modelo Entidade Relacionamento de um bancos de dados é um modelo conceitual que descreve as entidades de um domínio de negócios, com seus atributos e seus relacionamentos.

> Entidades: os objetos da realidade a ser modelada.<br>
> Relacionamentos: as associações entre as entidades.<br>
> Atributos: características específicas de uma entidade.<br>

## 1. Entidades

- **Efeito**
- **Estacao**
- **Estoque-Loja**
- **Habilidade**
- **Instância de Monstro**
- **Inventário**
- **Item**
  - **Semente**
  - **Ferramenta**
  - **Consumível**
  - **Vestimenta**
  - **Arma**
  - **Artesanato**
- **Jogador**
- **Local-Fechado**
  - **Cabana-Jogador**
  - **Caverna**
  - **Cabana-NPC**
  - **Loja**
- **Missão**
- **Monstro**
- **Mundo**
- **NPC**
- **Receita**
- **Região**   

## 2. Atributos

- **Efeito**: <ins>id-efeito</ins>, item, valor, tipo;
- **Estacao**: <ins>id-estacao</ins>, nome, descricao;
- **Estoque-Loja**: produto, loja, preco;
- **Habilidade**: <ins>jogador</ins>, nivel-coleta, nivel-cultivo, nivel-mineracao, nivel-pesca, nivel-combate;
- **Instância de Monstro**: caverna, monstro, saude;
- **Inventário**: <ins>jogador</ins>, item, qtdd;
- **Item**: <ins>id-item</ins>, id-tipo;
  - **Semente**: <ins>id-semente</ins>, estacao, nome, descricao, valor-venda, dias-para-crescer;
  - **Ferramenta**: <ins>id-ferramenta</ins>, nome, descricao;
  - **Consumível**: <ins>id-consumivel</ins>, estacao, nome, descricao, valor-venda, dias-para-crescer;
  - **Vestimenta**: <ins>id-vestimenta</ins>, nome, descricao; 
  - **Arma**: <ins>id-arma</ins>, nome, descricao, dano, finalidade;
  - **Artesanato**: <ins>id-artesanato</ins>, nome, descricao;
- **Jogador**: <ins>id-jogador</ins>, local, regiao, estacao-atual, missao-atual, nome, saude, energia, dia, qtdd-ouro;
- **Local-Fechado**: <ins>id-local</ins>, id-tipo;
  - **Cabana-Jogador**: <ins>id-cabana-jog</ins>, jogador, regiao, nome, descricao;
  - **Caverna**: <ins>id-caverna</ins>, regiao, nome, descricao;
  - **Cabana-NPC**: <ins>id-cabana-npc</ins>, npc, regiao, nome, descricao;
  - **Loja**: <ins>id-loja</ins>, proprietario, regiao, nome, descricao;
- **Missao**: <ins>id-missao</ins>, estacao, nome, descricao;
- **Monstro**: <ins>id-monstro</ins>, drop, nome, descricao, dano, defesa, saude-maxima;
- **Mundo**: <ins>id-mundo</ins>, nome;
- **NPC**: <ins>id-npc</ins>, regiao, local, nome, profissao;
- **Receita**: <ins>id-artesanato</ins>, item, qtdd;
- **Região**: <ins>id-regiao</ins>, mundo, nome;


## 3. Relacionamentos

**Jogador *está* em Estação**

- O jogador está em apenas uma única estação (1,1)
- A estação pode conter nenhum ou vários jogadores(0,N)

**Jogador *realiza* Missão**

- O jogador realiza nenhuma ou várias estação (0,N)
- A missão é realizada por apenas um ou vários jogadores (1,N)

**Jogador *possui* Inventário**

- O jogador realiza nenhuma ou várias estação (0,N)
- A missão é realizada por apenas um ou vários jogadores (1,N)

**Jogador *possui* uma Habilidade**

- O jogador possui apenas uma única habilidade (1,1)
- Cada habilidade é única para cada jogador (1,1) 

**Jogador *possui* uma Cabana-Jogador**

- O jogador possui apenas uma única cabana-jogador (1,1)
- Cada cabana-jogador é única para cada jogador (1,1) 

**Jogador *está* em Local-Fechado**

- O jogador pode está em nenhum ou em um único local-fechado (0,1)
- O local-fechado pode conter nenhum ou vários jogadores (0, N)

**Jogador *está* em uma Região**

- O jogador está apenas em uma única região (1,1)
- A região contém nenhum ou vários jogadores (0, N)

**Missão *acontece* em uma Estação**

- A missão acontece em uma ou várias estações (1,N)
- A estação aparece em uma a quatro missões (0, 4)

**Estação *deixa crescer* Semente**

- Durante a estação pode crescer nenhuma ou várias sementes (0,N)
- A semente pode crescer em uma ou em até 4 estações (1, 4)

**Inventário *deixa crescer* Semente**

- O jogador incia o jogo (inventário) com nenhum a vários itens (0,N)
- O item aparece em nenhum ou vários inventários (0, N)

**Mundo *possui* Região**

- O mundo possui uma ou várias regiões (1,N)
- A região possui apenas um único mundo (1, 1)

**Região *contém* Local-fechado**

- A região pode conter nenhum ou vários locais-fechados (0,N)
- Cada local-fechado possui apenas uma única região (1, 1)

**Local-fechado *contém* NPC**

- Um local-fechado pode contém apenas um único NPC (0,N)
- Cada NPC pode estar ou não em um local-fechado (0, 1)

**Local-fechado *possui exclusivamente* tipos**

- Um local-fechado pode ser classificado **apenas com uma única** das seguintes categorias: cabana-jogador, caverna, cabana-npc ou loja

**Caverna *contém* Monstro**

- Uma caverna pode conter nenhum ou vários monstros (0, N)
- O mesmo monstro pode aparecer em nenhuma ou várias cavernas (0,N)


**Monstro *possui* Instância-de-Monstro**

- Um monstro possui uma única instância de monstro (1,1)
- Uma instância de monstro pode aparecer nenhuma ou várias vezes (0, N)
  
**Monstro *dropa* Item**

- Um monstro, ao sofrer um ataque, pode "liberar" nenhum ou vários itens (0,N)
- O item pode cair de apenas um único monstro (1, 1)

**Cabana-NPC *pertence* NPC**

- Uma cabana-NPC pertecem apenas a um único NPC (1, 1)
- Um NPC possui apenas uma única cabana-NPC (1, 1)

**NPC *fala* Diálogo**

- Um NPC fala apenas a um único diálogo (1, 1)
- Um Dialogo pode ser de nenhum a vários NPC (0, N)

**Monstro *dropa* Item**

- Um monstro, ao sofrer um ataque, pode "liberar" nenhum ou vários itens (0,N)
- O item pode cair de apenas um único monstro (1, 1)

**Cabana-NPC *pertence* NPC**

- Uma cabana-NPC pertecem apenas a um único NPC (1, 1)
- Um NPC possui apenas uma única cabana-NPC (1, 1)

**NPC *fala* Diálogo**

- Um NPC fala apenas a um único diálogo (1, 1)
- Um Dialogo pode ser de nenhum a vários NPC (0, N)
- **Monstro *dropa* Item**

- Um monstro, ao sofrer um ataque, pode "liberar" nenhum ou vários itens (0,N)
- O item pode cair de apenas um único monstro (1, 1)

**Cabana-NPC *pertence* NPC**

- Uma cabana-NPC pertecem apenas a um único NPC (1, 1)
- Um NPC possui apenas uma única cabana-NPC (1, 1)

**NPC *fala* Diálogo**

- Um NPC fala apenas a um único diálogo (1, 1)
- Um Dialogo pode ser de nenhum a vários NPC (0, N)
- **Monstro *dropa* Item**

- Um monstro, ao sofrer um ataque, pode "liberar" nenhum ou vários itens (0,N)
- O item pode cair de apenas um único monstro (1, 1)

**Cabana-NPC *pertence* NPC**

- Uma cabana-NPC pertecem apenas a um único NPC (1, 1)
- Um NPC possui apenas uma única cabana-NPC (1, 1)

**NPC *fala* Diálogo**

- Um NPC fala apenas a um único diálogo (1, 1)
- Um Dialogo pode ser de nenhum a vários NPC (0, N)

**NPC *é proprietário* da Loja**

- Um NPC pode ser proprietário de nenhuma ou várias lojas (0,N)
- Uma loja possui apenas um único priprietário NPC (1, 1)

**Loja *contem* Estoque-loja**

- Uma loja contém apenas um único estoque-loja (1, 1)
- Um estoque-loja é apenas de uma única loja (1, 1)

**Estoque-loja *possui* Item**

- Estoque-loja possui nenhum a vários itens (0, N)
- Um item pode aparecer em nenhum ou em vários estoque-loja (0, N)

**Item *possui exclusivamente* tipos**

- Um item pode ser classificado **apenas com uma única** das seguintes categorias: semente, ferramenta, consumível, vestimenta, arma, artesanato

**Consumível *possui* Efeito**

- Consumível possui nenhum a vários efeitos (0, N)
- Um efeito faz parte de apenas um único item consumível (1, 1)

**Vestimenta *possui* Efeito**
- Vestimenta possui nenhum a vários efeitos (0, N)
- Um efeito faz parte de apenas uma única ferramenta (1, 1)

**Artesanato *contém* Receita**
- Um artesanato faz parte de apenas uma única receita (1, 1)
- Uma receita faz parte de apenas um único artesanato (1, 1)

**Receita *está* item**
- Uma receita faz parte de apenas um único item (1, 1)
- Um item pode fazer parte de nenhuma ou várias receitas (0, N)








