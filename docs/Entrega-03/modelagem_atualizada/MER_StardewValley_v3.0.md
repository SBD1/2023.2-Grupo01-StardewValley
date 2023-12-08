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
  - **Consumivel**
  - **Ferramenta**
  - **Semente**
  - **Vestimenta**
- **Item_Estoque_Loja**
- **Item_Inventário**
- **Item_Receita**
  - **Artesanato**
- **Jogador**
- **Local_Fechado**
  - **Cabana_Jogador**
  - **Cabana_NPC**
  - **Caverna**
  - **Loja**
- **Missão**
- **Monstro**
- **Mundo**
- **NPC**
- **Região**

## 2. Atributos

- **Dialogo**: <ins>id_dialogo</ins>, id_npc, fala;
- **Efeito**: <ins>id_efeito</ins>, id_item, valor, tipo;
- **Estacao**: <ins>id_estacao</ins>, nome, descricao;
- **Habilidade**: <ins>id_jogador</ins>, nivel_coleta, nivel_cultivo, nivel_mineracao, nivel_pesca, nivel_combate;
- **Instância_Monstro**: caverna, monstro, saude;
- **Item**: <ins>id_item</ins>, id_tipo_item;
  - **Arma**: <ins>id_arma</ins>, nome, descricao, dano, finalidade, comeca_jogo_com;
  - **Artesanato**: <ins>id_artesanato</ins>, nome, descricao;
  - **Consumivel**: <ins>id_consumivel</ins>, id_regiao, id_local_fechado, nome, descricao;
  - **Ferramenta**: <ins>id_ferramenta</ins>, nome, descricao, finalidade;
  - **Semente**: <ins>id_semente</ins>, id_estacao, id_info_semente;
  - **Vestimenta**: <ins>id_vestimenta</ins>, nome, descricao;
- **Item_Estoque_Loja**: <ins>id_item</ins>, <ins>id_loja</ins>, preco;
- **Item_Inventário**: <ins>id_jogador</ins>, <ins>id_item</ins>, qtdd;
- **Item_Receita**: <ins>id_artesanato</ins>, <ins>id_item</ins>, qtdd;
- **Jogador**: <ins>id_jogador</ins>, id_local_fechado, id_regiao, id_estacao, id_missao, nome, saude, energia, dia, hora, qtdd_ouro;
- **Local_Fechado**: <ins>id_local_fechado</ins>, id_tipo_local_fechado;
  - **Cabana_Jogador**: <ins>id_cabana_jog</ins>, id_jogador, id_regiao, nome, descricao;
  - **Cabana_NPC**: <ins>id_cabana_NPC</ins>, id_npc, id_regiao, nome, descricao;
  - **Caverna**: <ins>id_caverna</ins>, id_regiao, nome, descricao;
  - **Loja**: <ins>id_loja</ins>, id_npc_prop, id_regiao, nome, descricao;
- **Missao**: <ins>id_missao</ins>, id_estacao, nome, descricao;
- **Monstro**: <ins>id_monstro</ins>, id_drop, nome, descricao, dano, defesa, saude_maxima;
- **Mundo**: <ins>id_mundo</ins>, nome;
- **NPC**: <ins>id_npc</ins>, id_regiao, id_caban_NPC, nome, profissao;
- **Região**: <ins>id_regiao</ins>, id_mundo, nome;


## 3. Relacionamentos

**Jogador _está_ em Estação**

- O jogador está em apenas uma única estação (1,1)
- A estação pode conter nenhum ou vários jogadores(0,N)

**Jogador _realiza_ Missao**

- O jogador realiza nenhuma ou várias missões (0,N)
- A missão é realizada por apenas um ou vários jogadores (1,N)

**Jogador _possui_ Item_Inventário**

- O jogador possui de nenhum a vários item_inventários (0,N)
- O item_inventário é de apenas um único jogador (1,1)

**Jogador _possui_ uma Habilidade**

- O jogador possui apenas uma única habilidade (1,1)
- Cada habilidade é única para cada jogador (1,1)

**Jogador _possui_ uma Cabana_Jogador**

- O jogador possui apenas uma única cabana_jogador (1,1)
- Cada cabana_jogador pertence apenas a um único jogador (1,1)

**Jogador _está_ em Local_Fechado**

- O jogador pode está em nenhum ou em um único local_fechado (0,1)
- O local_fechado pode conter nenhum ou vários jogadores (0, N)

**Jogador _está_ em uma Região**

- O jogador sempre está apenas em uma única região (1,1)
- A região contém nenhum ou vários jogadores (0, N)

**Jogador _mata_ Instância_Monstro**

- O jogador pode matar nenhum ou várias instâncias_monstros (0,N)
- A instância_monstro é morta apenas um único jogador (1, 1)

**Jogador _compra na_ Loja**

- O jogador pode comprar em nenhuma ou várias lojas (0,N)
- A loja pode vender para nenhum ou vários jogadores (0, N)

**Missão _está disponível_ em uma Estação**

- A missão está disponível em uma ou até quatro estações do ano (1,4)
- A estação contém de uma a várias missões (1, N)

**Estação _deixa crescer_ Semente**

- Durante a estação pode crescer nenhuma ou várias sementes (0,N)
- A semente pode crescer em uma ou em até 4 estações (1, 4)

**Item_Inventario _possui_ Item**

- O item_inventário do jogador pode possuir nenhum a vários itens (0,N)
- O item aparece em nenhum a vários item_inventários (0, N)

**Mundo _possui_ Região**

- O mundo possui uma ou várias regiões (1,N)
- A região possui apenas um único mundo (1, 1)

**Região _contém_ Local_fechado**

- A região pode conter nenhum ou vários locais_fechados (0,N)
- Cada local_fechado possui apenas uma única região (1, 1)

**Local_fechado _contém_ NPC**

- Um local_fechado pode conter nenhum a vários NPC (0,N)
- Cada NPC pode estar ou não em um local_fechado (0, 1)

**Local_fechado _possui exclusivamente_ tipos**

- Um local_fechado pode ser classificado **apenas com uma única** das seguintes categorias: cabana_jogador, caverna, cabana_npc ou loja

**Caverna _contém_ Monstro**

- Uma caverna pode conter nenhum ou vários monstros (0, N)
- O mesmo monstro pode aparecer em nenhuma ou várias cavernas (0,N)

**Monstro _possui_ Instância_de_Monstro**

- Um monstro possui nenhuma ou várias instâncias (0,N)
- Uma instância de monstro é de apenas um único monstro (1, 1)

**Instância de Monstro _dropa_ Item**

- Uma instância de monstro, ao sofrer um ataque, pode "liberar" apenas um único tipo de item (1,1)
- O item pode cair de nenhum a varios (0, N)

**Cabana_NPC _pertence_ NPC**

- Uma cabana_NPC pertecem apenas a um único NPC (1, 1)
- Um NPC possui apenas uma única cabana_NPC (1, 1)

**NPC _fala_ Dialogo**

- Um NPC possui nenhuma a várias falas em um diálogo (0, N)
- Um Dialogo pertence a um único NPC (1, 1)

**NPC _é proprietário_ da Loja**

- Um NPC pode ser proprietário de nenhuma ou várias lojas (0,N)
- Uma loja possui apenas um único priprietário NPC (1, 1)

**Loja _contem_ Item_Estoque_loja**

- Uma loja contém de nenhum a vários item_estoque_loja (0, N)
- Um item_estoque_loja é de apenas uma única loja (1, 1)

**Item_Estoque_loja _possui_ Item**

- Um item_estoque_loja possui nenhum a vários itens (0, N)
- Um item pode aparecer em nenhum ou em vários item_estoque_loja (0, N)

**Item _possui exclusivamente_ tipos**

- Um item pode ser classificado **apenas com uma única** das seguintes categorias: semente, ferramenta, consumivel, vestimenta, arma, artesanato

**Consumivel _possui_ Efeito**

- Consumivel possui apenas um único efeito (1, 1)
- Um efeito faz parte de vários consumíveis (1, N)

**Vestimenta _possui_ Efeito**

- Vestimenta possui apenas um único efeito (1, 1)
- Um efeito faz parte de várias vestimentas (1, N)

**Artesanato _contém_ Item_Receita**

- Um artesanato contém de um a vários item_receitas (1, N)
- Um item_receita faz parte de apenas um único artesanato (1, 1)

**Item _está_ no Item_receita**

- Um item pode fazer parte de nenhuma a vários item_receitas (0, N)
- Um item_receita contém apenas um único item (1, 1)
