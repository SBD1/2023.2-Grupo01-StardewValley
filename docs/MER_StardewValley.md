
## Histórico de versões

| Versão | Data       | Descrição                | Autor                                              | Revisão              |
|:------:|:----------:| ------------------------ | -------------------------------------------------- | -------------------- |
| '1.0'  | 16/09/2023 | Criação do documento MER | [Zenilda Vieira](https://github.com/ZenildaVieira) |                      |


# MER - Modelo Entidade Relacionamento

O Modelo Entidade Relacionamento de um bancos de dados é um modelo conceitual que descreve as entidades de um domínio de negócios, com seus atributos e seus relacionamentos.

> Entidades: os objetos da realidade a ser modelada.<br>
> Relacionamentos: as associações entre as entidades.<br>
> Atributos: características específicas de uma entidade.<br>

## 1. Entidades
- **Mundo**
- **Região**
- **Jogador**
- **Casa**
- **Caverna**
- **Diálogo**
- **NPC**
- **Loja**
- **Habilidade**
- **Missão**
- **Inventário**
- **Item**


## 2. Atributos
- **Mundo**: <ins>ID_Mundo</ins>, Nome;
- **Região**: <ins>ID_Regiao</ins>, Nome, posição_x, posição_y, LocalMundo;
- **Jogador**: <ins>ID_Jogador</ins>, nível, nome;
- **Casa**
- **Caverna**
- **Diálogo**
- **NPC**: <ins>ID_NPC</ins>, Nome, id_regiao;
- **Loja**
- **Habilidade**
- **Missão**: <ins>ID_Missao</ins>, Min_Nivel;
- **Inventário**: <ins>ID_Inventario</ins>, Capacidade, id_personagem;
- **Item**: <ins>ID_Item</ins>, Nome, Valor, Descrição, Min_Level;

## 3. Relacionamentos

**Mundo – possui – Região**
- Um Mundo possui nenhuma ou várias regiões (0,N) e uma região pertence a um só mundo (1,1).

**Região – contém – Casa**
- Uma Região contém nenhuma ou várias casas (0,N) e uma casa pertence a uma só Região (1,1).

**Região – contém - Caverna**

**Região – contém - Loja**

**Jogador – possui – Casa**

**Jogador – possui – Habilidade**

**Jogador – está na – Região**

**Jogador – possui – Inventário**

**Jogador – possui - Missão**

**Jogador – usa - Item**

**Inventário – possui – Item**

**NPC – porta – Item**

**NPC – cuida – Loja**

**Loja – vende – Item**

**Diálogo – pertence a - NPC**

