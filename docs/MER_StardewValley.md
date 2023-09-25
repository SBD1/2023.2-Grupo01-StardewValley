## Histórico de versões

| Versão |    Data    | Descrição                | Autor                                              | Revisão |
| :----: | :--------: | ------------------------ | -------------------------------------------------- | ------- |
| `1.0`  | 16/09/2023 | Criação do documento MER | [Zenilda Vieira](https://github.com/ZenildaVieira) |         |
| `1.1`  | 24/09/2023 | Adição das entidades | [Matheus Silverio](https://github.com/MattSilverio) |         |

# MER - Modelo Entidade Relacionamento

O Modelo Entidade Relacionamento de um bancos de dados é um modelo conceitual que descreve as entidades de um domínio de negócios, com seus atributos e seus relacionamentos.

> Entidades: os objetos da realidade a ser modelada.<br>
> Relacionamentos: as associações entre as entidades.<br>
> Atributos: características específicas de uma entidade.<br>

## 1. Entidades

- **Jogador**
- **Inventário**
- **Habilidade**
- **Missão**
- **Estação**
- **NPC**
- **Monstro**
- **Instância de monstro**
- **Mundo**
- **Região**
- **Local-Fechado**
  - **Cabana-Jogador**
  - **Caverna**
  - **Cabana-NPC**
  - **Loja**
- **Estoque**
- **Item**
  - **Semente**
  - **Ferramenta**
  - **Consumível**
  - **Vestimenta**
  - **Arma**
  - **Artesanato**
- **Efeito**
- **Receita**   

## 2. Atributos

- **Mundo**: <ins>id_mundo</ins>, nome;
- **Região**: <ins>id_regiao</ins>, mundo, nome;
...


## 3. Relacionamentos

**Mundo – possui – Região**

- Um mundo possui uma ou várias regiões (1,N).<br>
- Uma região pertence a um só mundo (1,1).

**Região – contém – Local-Fechado**

- Uma região contém nenhum ou vários locais fechados (0,N).<br>
- Um local fechado está locado em uma só Região (1,1).
...
