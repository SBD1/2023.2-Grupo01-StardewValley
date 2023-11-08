## Histórico de versões

| Versão |    Data    | Descrição                                         | Autor                                                                                                                |
| :----: | :--------: | ------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| `1.0`  | 16/09/2023 | Criação do documento MER                          | [Zenilda Vieira](https://github.com/ZenildaVieira)                                                                   |
| `1.1`  | 24/09/2023 | Adição das entidades                              | [Matheus Silverio](https://github.com/MattSilverio)                                                                  |
| `1.2`  | 24/09/2023 | Adição das entidades, atributos e relacionamentos | [Edilberto Cantuaria](https://github.com/edilbertocantuaria)                                                         |
| `1.3`  | 26/09/2023 | Revisão em pares                                  | [Edilberto Cantuaria](https://github.com/edilbertocantuaria), <br>[Zenilda Vieira](https://github.com/ZenildaVieira) |

# MER - Modelo Entidade Relacionamento

O Modelo Entidade Relacionamento de um bancos de dados é um modelo conceitual que descreve as entidades de um domínio de negócios, com seus atributos e seus relacionamentos.

> Entidades: os objetos da realidade a ser modelada.<br>
> Relacionamentos: as associações entre as entidades.<br>
> Atributos: características específicas de uma entidade.<br>

## 1. Entidades

- **Dialogo**
- **Efeito**
- **Estacao**
- **Habilidade**
- **Instância de Monstro**
- **Item**
  - **Arma**
  - **Consumível**
  - **Ferramenta**
  - **Semente**
  - **Vestimenta**
- **Item-Estoque-Loja**
- **Item-Inventário**
- **Item-Receita**
  - **Artesanato**
- **Jogador**
- **Local-Fechado**
  - **Cabana-Jogador**
  - **Cabana-NPC**
  - **Caverna**
  - **Loja**
- **Missão**
- **Monstro**
- **Mundo**
- **NPC**
- **Região**

## 2. Atributos

- **Dialogo**: <ins>id-dialogo</ins>, id-npc, fala;
- **Efeito**: <ins>id-efeito</ins>, id-item, valor, tipo;
- **Estacao**: <ins>id-estacao</ins>, nome, descricao;
- **Habilidade**: <ins>id-jogador</ins>, nivel-coleta, nivel-cultivo, nivel-mineracao, nivel-pesca, nivel-combate;
- **Instância-Monstro**: caverna, monstro, saude;
- **Item**: <ins>id-item</ins>, id-tipo-item;
  - **Arma**: <ins>id-arma</ins>, nome, descricao, dano, finalidade;
  - **Artesanato**: <ins>id-artesanato</ins>, nome, descricao;
  - **Consumível**: <ins>id-consumivel</ins>, nome, descricao;
  - **Ferramenta**: <ins>id-ferramenta</ins>, nome, descricao, finalidade;
  - **Semente**: <ins>id-semente</ins>, id-estacao, id-info-semente;
  - **Vestimenta**: <ins>id-vestimenta</ins>, nome, descricao;
- **Item-Estoque-Loja**: <ins>id-item</ins>, <ins>id-loja</ins>, preco;
- **Item-Inventário**: <ins>id-jogador</ins>, <ins>id-item</ins>, qtdd;
- **Item-Receita**: <ins>id-artesanato</ins>, <ins>id-item</ins>, qtdd;
- **Jogador**: <ins>id-jogador</ins>, id-local-fechado, id-regiao, id-estacao, id-missao, nome, saude, energia, dia, hora, qtdd-ouro;
- **Local-Fechado**: <ins>id-local-fechado</ins>, id-tipo-local-fechado;
  - **Cabana-Jogador**: <ins>id-local-fechado</ins>, id-jogador, id-regiao, nome, descricao;
  - **Cabana-NPC**: <ins>id-cabana-npc</ins>, id-npc, id-regiao, nome, descricao;
  - **Caverna**: <ins>id-caverna</ins>, id-regiao, nome, descricao;
  - **Loja**: <ins>id-loja</ins>, id-npc, id-regiao, nome, descricao;
- **Missao**: <ins>id-missao</ins>, id-estacao, nome, descricao;
- **Monstro**: <ins>id-monstro</ins>, id-drop, nome, descricao, dano, defesa, saude-maxima;
- **Mundo**: <ins>id-mundo</ins>, nome;
- **NPC**: <ins>id-npc</ins>, id-regiao, id-local-fechado, nome, profissao;
- **Região**: <ins>id-regiao</ins>, id-mundo, nome;


## 3. Relacionamentos

**Jogador _está_ em Estação**

- O jogador está em apenas uma única estação (1,1)
- A estação pode conter nenhum ou vários jogadores(0,N)

**Jogador _realiza_ Missao**

- O jogador realiza nenhuma ou várias missões (0,N)
- A missão é realizada por apenas um ou vários jogadores (1,N)

**Jogador _possui_ Item-Inventário**

- O jogador possui de nenhum a vários item-inventários (0,N)
- O item-inventário é de apenas um único jogador (1,1)

**Jogador _possui_ uma Habilidade**

- O jogador possui apenas uma única habilidade (1,1)
- Cada habilidade é única para cada jogador (1,1)

**Jogador _possui_ uma Cabana-Jogador**

- O jogador possui apenas uma única cabana-jogador (1,1)
- Cada cabana-jogador pertence apenas a um único jogador (1,1)

**Jogador _está_ em Local-Fechado**

- O jogador pode está em nenhum ou em um único local-fechado (0,1)
- O local-fechado pode conter nenhum ou vários jogadores (0, N)

**Jogador _está_ em uma Região**

- O jogador sempre está apenas em uma única região (1,1)
- A região contém nenhum ou vários jogadores (0, N)

**Jogador _mata_ Instância-Monstro**

- O jogador pode matar nenhum ou várias instâncias-monstros (0,N)
- A instância-monstro é morta apenas um único jogador (1, 1)

**Jogador _compra na_ Loja**

- O jogador pode comprar em nenhuma ou várias lojas (0,N)
- A loja pode vender para nenhum ou vários jogadores (0, N)

**Missão _está disponível_ em uma Estação**

- A missão está disponível em uma ou até quatro estações do ano (1,4)
- A estação contém de uma a várias missões (1, N)

**Estação _deixa crescer_ Semente**

- Durante a estação pode crescer nenhuma ou várias sementes (0,N)
- A semente pode crescer em uma ou em até 4 estações (1, 4)

**Item-Inventario _possui_ Item**

- O item-inventário do jogador pode possuir nenhum a vários itens (0,N)
- O item aparece em nenhum a vários item-inventários (0, N)

**Mundo _possui_ Região**

- O mundo possui uma ou várias regiões (1,N)
- A região possui apenas um único mundo (1, 1)

**Região _contém_ Local-fechado**

- A região pode conter nenhum ou vários locais-fechados (0,N)
- Cada local-fechado possui apenas uma única região (1, 1)

**Local-fechado _contém_ NPC**

- Um local-fechado pode conter nenhum a vários NPC (0,N)
- Cada NPC pode estar ou não em um local-fechado (0, 1)

**Local-fechado _possui exclusivamente_ tipos**

- Um local-fechado pode ser classificado **apenas com uma única** das seguintes categorias: cabana-jogador, caverna, cabana-npc ou loja

**Caverna _contém_ Monstro**

- Uma caverna pode conter nenhum ou vários monstros (0, N)
- O mesmo monstro pode aparecer em nenhuma ou várias cavernas (0,N)

**Monstro _possui_ Instância-de-Monstro**

- Um monstro possui nenhuma ou várias instâncias (0,N)
- Uma instância de monstro é de apenas um único monstro (1, 1)

**Instância de Monstro _dropa_ Item**

- Uma instância de monstro, ao sofrer um ataque, pode "liberar" apenas um único tipo de item (1,1)
- O item pode cair de nenhum a varios (0, N)

**Cabana-NPC _pertence_ NPC**

- Uma cabana-NPC pertecem apenas a um único NPC (1, 1)
- Um NPC possui apenas uma única cabana-NPC (1, 1)

**NPC _fala_ Dialogo**

- Um NPC possui nenhuma a várias falas em um diálogo (0, N)
- Um Dialogo pertence a um único NPC (1, 1)

**NPC _é proprietário_ da Loja**

- Um NPC pode ser proprietário de nenhuma ou várias lojas (0,N)
- Uma loja possui apenas um único priprietário NPC (1, 1)

**Loja _contem_ Item-Estoque-loja**

- Uma loja contém de nenhum a vários item-estoque-loja (0, N)
- Um item-estoque-loja é de apenas uma única loja (1, 1)

**Item-Estoque-loja _possui_ Item**

- Um item-estoque-loja possui nenhum a vários itens (0, N)
- Um item pode aparecer em nenhum ou em vários item-estoque-loja (0, N)

**Item _possui exclusivamente_ tipos**

- Um item pode ser classificado **apenas com uma única** das seguintes categorias: semente, ferramenta, consumível, vestimenta, arma, artesanato

**Consumível _possui_ Efeito**

- Consumível possui apenas um único efeito (1, 1)
- Um efeito faz parte de vários consumíveis (1, N)

**Vestimenta _possui_ Efeito**

- Vestimenta possui apenas um único efeito (1, 1)
- Um efeito faz parte de várias vestimentas (1, N)

**Artesanato _contém_ Item-Receita**

- Um artesanato contém de um a vários item-receitas (1, N)
- Um item-receita faz parte de apenas um único artesanato (1, 1)

**Item _está_ no Item-receita**

- Um item pode fazer parte de nenhuma a vários item-receitas (0, N)
- Um item-receita contém apenas um único item (1, 1)
