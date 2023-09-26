## Histórico de versões

| Versão  |    Data    | Descrição                                         | Autor                                                                                                            | Revisão |
| :-----: | :--------: | ------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ------- |
|  `1.0`  | 16/09/2023 | Criação do documento MER                          | [Zenilda Vieira](https://github.com/ZenildaVieira)                                                               |         |
|  `1.1`  | 24/09/2023 | Adição das entidades                              | [Matheus Silverio](https://github.com/MattSilverio)                                                              |         |
|  `1.2`  | 24/09/2023 | Adição das entidades, atributos e relacionamentos | [Edilberto Cantuaria](https://github.com/edilbertocantuaria)                                                     |         |
| `1.2.1` | 26/09/2023 | Revisão em pares                                  | [Edilberto Cantuaria](https://github.com/edilbertocantuaria), [Zenilda Vieira](https://github.com/ZenildaVieira) |         |

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

- **Dialogo**: <ins>id-dialogo</ins>, npc, fala;
- **Efeito**: <ins>id-efeito</ins>, item, valor, tipo;
- **Estacao**: <ins>id-estacao</ins>, nome, descricao;
- **Estoque-Loja**: produto, loja, preco;
- **Habilidade**: jogador, nivel-coleta, nivel-cultivo, nivel-mineracao, nivel-pesca, nivel-combate;
- **Instância-Monstro**: caverna, monstro, saude;
- **Inventário**: jogador, item, qtdd;
- **Item**: <ins>id-item</ins>, id-tipo;
  - **Semente**: id-semente, estacao, nome, descricao, valor-venda, dias-para-crescer;
  - **Ferramenta**: id-ferramenta, nome, descricao;
  - **Consumível**: id-consumivel, estacao, nome, descricao, valor-venda, dias-para-crescer;
  - **Vestimenta**: id-vestimenta, nome, descricao; 
  - **Arma**: id-arma, nome, descricao, dano, finalidade;
  - **Artesanato**: id-artesanato, nome, descricao;
- **Jogador**: <ins>id-jogador</ins>, local, regiao, estacao-atual, missao-atual, nome, saude, energia, dia, qtdd-ouro;
- **Local-Fechado**: <ins>id-local-fechado</ins>, id-tipo;
  - **Cabana-Jogador**: id-cabana-jog, jogador, regiao, nome, descricao;
  - **Caverna**: id-caverna, regiao, nome, descricao;
  - **Cabana-NPC**: id-cabana-npc, npc, regiao, nome, descricao;
  - **Loja**: id-loja, proprietario, regiao, nome, descricao;
- **Missao**: <ins>id-missao</ins>, estacao, nome, descricao;
- **Monstro**: <ins>id-monstro</ins>, drop, nome, descricao, dano, defesa, saude-maxima;
- **Mundo**: <ins>id-mundo</ins>, nome;
- **NPC**: <ins>id-npc</ins>, regiao, local, nome, profissao;
- **Receita**: id-artesanato, item, qtdd;
- **Região**: <ins>id-regiao</ins>, mundo, nome;


## 3. Relacionamentos

**Jogador *está* em Estação**

- O jogador está em apenas uma única estação (1,1)
- A estação pode conter nenhum ou vários jogadores(0,N)

**Jogador *realiza* Missão**

- O jogador realiza nenhuma ou várias missões (0,N)
- A missão é realizada por apenas um ou vários jogadores (1,N)

**Jogador *possui* Inventário**

- O jogador possui de nenhum a vários inventários (0,N)
- O inventário é de apenas um único jogador (1,1)

**Jogador *possui* uma Habilidade**

- O jogador possui apenas uma única habilidade (1,1)
- Cada habilidade é única para cada jogador (1,1) 

**Jogador *possui* uma Cabana-Jogador**

- O jogador possui apenas uma única cabana-jogador (1,1)
- Cada cabana-jogador pertence apenas a um único jogador (1,1) 

**Jogador *está* em Local-Fechado**

- O jogador pode está em nenhum ou em um único local-fechado (0,1)
- O local-fechado pode conter nenhum ou vários jogadores (0, N)

**Jogador *está* em uma Região**

- O jogador sempre está apenas em uma única região (1,1)
- A região contém nenhum ou vários jogadores (0, N)

**Jogador *mata* Instância-Monstro**

- O jogador pode matar nenhum ou várias instâncias-monstros (0,N)
- A instância-monstro é morta apenas um único jogador (1, 1)

**Jogador *compra na* Loja**

- O jogador pode comprar em nenhuma ou várias lojas (0,N)
- A loja pode vender para nenhum ou vários jogadores (0, N)

**Missão *está disponível* em uma Estação**

- A missão está disponível em uma ou até quatro estações do ano (1,4)
- A estação contém de uma a várias missões (1, N)

**Estação *deixa crescer* Semente**

- Durante a estação pode crescer nenhuma ou várias sementes (0,N)
- A semente pode crescer em uma ou em até 4 estações (1, 4)

**Inventário *possui* Item**

- O inventário do jogador pode possuir nenhum a vários itens (0,N)
- O item aparece em nenhum a vários inventários (0, N)

**Mundo *possui* Região**

- O mundo possui uma ou várias regiões (1,N)
- A região possui apenas um único mundo (1, 1)

**Região *contém* Local-fechado**

- A região pode conter nenhum ou vários locais-fechados (0,N)
- Cada local-fechado possui apenas uma única região (1, 1)

**Local-fechado *contém* NPC**

- Um local-fechado pode conter nenhum a vários NPC (0,N)
- Cada NPC pode estar ou não em um local-fechado (0, 1)

**Local-fechado *possui exclusivamente* tipos**

- Um local-fechado pode ser classificado **apenas com uma única** das seguintes categorias: cabana-jogador, caverna, cabana-npc ou loja

**Caverna *contém* Monstro**

- Uma caverna pode conter nenhum ou vários monstros (0, N)
- O mesmo monstro pode aparecer em nenhuma ou várias cavernas (0,N)


**Monstro *possui* Instância-de-Monstro**

- Um monstro possui nenhuma ou várias instâncias (0,N)
- Uma instância de monstro é de apenas um único monstro (1, 1)
  
**Instância de Monstro *dropa* Item**

- Uma instância de monstro, ao sofrer um ataque, pode "liberar" apenas um único tipo de item (1,1)
- O item pode cair de nenhum a varios (0, N)

**Cabana-NPC *pertence* NPC**

- Uma cabana-NPC pertecem apenas a um único NPC (1, 1)
- Um NPC possui apenas uma única cabana-NPC (1, 1)

**NPC *fala* Diálogo**

- Um NPC possui nenhuma a várias falas em um diálogo  (0, N)
- Um Dialogo pertence a um único NPC (1, 1)

**NPC *é proprietário* da Loja**

- Um NPC pode ser proprietário de nenhuma ou várias lojas (0,N)
- Uma loja possui apenas um único priprietário NPC (1, 1)

**Loja *contem* Estoque-loja**

- Uma loja contém de nenhum a vários estoque-loja (0, N)
- Um estoque-loja é de apenas uma única loja (1, 1)

**Estoque-loja *possui* Item**

- Estoque-loja possui nenhum a vários itens (0, N)
- Um item pode aparecer em nenhum ou em vários estoque-loja (0, N)

**Item *possui exclusivamente* tipos**

- Um item pode ser classificado **apenas com uma única** das seguintes categorias: semente, ferramenta, consumível, vestimenta, arma, artesanato

**Consumível *possui* Efeito**

- Consumível possui apenas um único efeito (1, 1)
- Um efeito faz parte de vários consumíveis (1, N)

**Vestimenta *possui* Efeito**
- Vestimenta possui apenas um único efeito (1, 1)
- Um efeito faz parte de várias vestimentas (1, N)

**Artesanato *contém* Receita**
- Um artesanato contém de uma a várias receitas (1, N)
- Uma receita faz parte de apenas um único artesanato (1, 1)

**Item *está* na receita**
- Um item pode fazer parte de nenhuma a várias receitas (0, N)
- Uma receita contém apenas um único item (1, 1)








