-- ----------------------------------------------------------------- 
-- Data Criacao ...........: 16/10/2023 
-- Autor(es) ..............: Zenilda Vieira 
-- Versao ..............: 1.0 
-- Banco de Dados .........: PostgreSQL 
-- Descricao .........: Inclusão de CREATE TABLE de todas as tabelas do banco de dados. 
-- ------------------------------------------------------------------------------ 
-- Data Atualizacao ...........: xx/xx/2023 
-- Autor(es) ..............: 
-- Descricao .........: 
-- ------------------------------------------------------------------------------ 

-- Tabela Arma
begin;
CREATE TABLE Arma (
    id-arma int NOT NULL,
    nome varchar(50) NOT NULL,
    descricao varchar(150),
    dano int NOT NULL,
    finalidade varchar(100) NOT NULL,
    FOREIGN KEY (id-arma) REFERENCES Item (id-item)
);
commit;

-- Tabela Artesanato
begin;
CREATE TABLE Artesanato (
    id-artesanato int NOT NULL,
    nome varchar(50) NOT NULL,
    descricao varchar(150),
    FOREIGN KEY (id-artesanato) REFERENCES Item (id-item)
);
commit;

-- Tabela Cabana-Jogador
begin;
CREATE TABLE Cabana-Jogador (
    id-cabana-jog int NOT NULL,
    jogador int NOT NULL,
    regiao int NOT NULL,
    nome varchar(50) NOT NULL,
    descricao varchar(150),
    FOREIGN KEY (id-cabana-jog) REFERENCES Local-Fechado (id-local-fechado)
    FOREIGN KEY (jogador) REFERENCES Jogador (id-jogador)
    FOREIGN KEY (regiao) REFERENCES Regiao (id-regiao)
);
commit;

-- Tabela Cabana-NPC
begin;
CREATE TABLE Cabana-NPC (
    id-cabana-npc int NOT NULL,
    npc int NOT NULL,
    regiao int NOT NULL,
    nome varchar(50) NOT NULL,
    descricao varchar(150)
    FOREIGN KEY (id-cabana-npc) REFERENCES Local-Fechado (id-local-fechado)
    FOREIGN KEY (npc) REFERENCES NPC (id-npc)
    FOREIGN KEY (regiao) REFERENCES Regiao (id-regiao)
);
commit;

-- Tabela Caverna
begin;
CREATE TABLE Caverna (
    id-caverna int NOT NULL,
    regiao int NOT NULL,
    nome varchar(50) NOT NULL,
    descricao varchar(150),
    FOREIGN KEY (id-caverna) REFERENCES Local-Fechado  (id-local-fechado)
 FOREIGN KEY (regiao) REFERENCES Regiao (id-regiao)
);
commit;

-- Tabela Consumível
begin;
CREATE TABLE Consumível (
    id-consumivel int NOT NULL,
    nome varchar(50) NOT NULL,
    descricao varchar(150),
    FOREIGN KEY (id-consumivel) REFERENCES Item (id-item)
);
commit;

-- Tabela Diálogo
begin;
CREATE TABLE Diálogo (
    id-dialogo int NOT NULL PRIMARY KEY,
    npc int NOT NULL,
    fala varchar(150) NOT NULL,
    FOREIGN KEY (npc) REFERENCES NPC (id-npc)
);
commit;

-- Tabela Efeito
begin;
CREATE TABLE Efeito (
    id-efeito int NOT NULL PRIMARY KEY,
    item int NOT NULL,
    valor int NOT NULL,
    tipo varchar(100),
    FOREIGN KEY (item) REFERENCES Item (id-item)
);
commit;

-- Tabela Estação
begin;
CREATE TABLE Estação (
    id-estacao int NOT NULL PRIMARY KEY,
    nome varchar(50) NOT NULL,
    descricao varchar(150),
);
commit;

-- Tabela Ferramenta
begin;
CREATE TABLE Ferramenta (
    id-ferramenta int NOT NULL,
    nome varchar(50) NOT NULL,
    descricao varchar(150),
    finalidade varchar(100) NOT NULL,
    FOREIGN KEY (id-ferramenta) REFERENCES Item (id-item)
);
commit;

-- Tabela Habilidade 
begin;
CREATE TABLE Habilidade (
    jogador int NOT NULL,
    nivel-coleta int NOT NULL,
    nivel-cultivo int NOT NULL,
    nivel-mineracao int NOT NULL,
    nivel-pesca int NOT NULL,
    nivel-combate int NOT NULL,
    FOREIGN KEY (jogador) REFERENCES Jogador (id-jogador)
);
commit;

-- Tabela Instancia-Monstro
begin;
CREATE TABLE Instancia-Monstro (
    caverna int NOT NULL,
    monstro int NOT NULL,
    saude int NOT NULL,
    FOREIGN KEY (caverna) REFERENCES Local-Fechado (id-local-fechado)
    FOREIGN KEY (monstro) REFERENCES Monstro (id-monstro)
);
commit;

-- Tabela Item-Estoque-Loja
begin;
CREATE TABLE Item-Estoque-Loja (
    produto int NOT NULL,
    loja int NOT NULL,
    preço int NOT NULL,
    FOREIGN KEY (produto) REFERENCES Item (id-item)
    FOREIGN KEY (loja) REFERENCES Loja (id-loja)
);
commit;

-- Tabela Item-Inventário
begin;
CREATE TABLE Item-Inventário (
    jogador int NOT NULL,
    item int NOT NULL,
    qtdd int NOT NULL,
    FOREIGN KEY (jogador) REFERENCES Jogador (id-jogador)
    FOREIGN KEY (item) REFERENCES Item (id-item)
);
commit;
 
-- Tabela Item-Receita 
begin;
CREATE TABLE Item-Receita (
    artesanato int NOT NULL,
    item int NOT NULL,
    qtdd int NOT NULL,
    FOREIGN KEY (artesanato) REFERENCES Artesanato (id-artesanato)
    FOREIGN KEY (item) REFERENCES Item (id-item)
);
commit;
 
-- Tabela Item 
begin;
CREATE TABLE Item (
    id-item int NOT NULL PRIMARY KEY,
    id-tipo varchar(50) NOT NULL,
);
commit;
 
-- Tabela Jogador 
begin;
CREATE TABLE Jogador (
    id-jogador int NOT NULL PRIMARY KEY,
    local int NOT NULL,
    regiao int NOT NULL,
    estacao-atual int NOT NULL,
    missao-atual int,
    nome varchar(50) NOT NULL,
    saude int NOT NULL,
    energia int NOT NULL,
    dia int NOT NULL,
    qtdd-ouro int,
    FOREIGN KEY (local) REFERENCES Local-Fechado (id-local-fechado)
    FOREIGN KEY (regiao) REFERENCES Regiao (id-regiao)
    FOREIGN KEY (estacao-atual) REFERENCES Estacao (id-estacao)
    FOREIGN KEY (missao-atual) REFERENCES Missao (id-missao)
);
commit;

-- Tabela Local-Fechado
begin;
CREATE TABLE Local-Fechado (
    id-local-fechado int NOT NULL PRIMARY KEY,
    id-tipo varchar(50) NOT NULL,
);
commit;

-- Tabela Loja
begin;
CREATE TABLE Loja (
    id-loja int NOT NULL,
    proprietario int NOT NULL,
    regiao int NOT NULL,
    nome varchar(50) NOT NULL,
    descricao varchar(150),
    FOREIGN KEY (id-loja) REFERENCES Local-Fechado (id-local-fechado)
    FOREIGN KEY (proprietario) REFERENCES NPC (id-npc)
    FOREIGN KEY (regiao) REFERENCES Regiao (id-regiao)
);
commit;

-- Tabela Missao
begin;
CREATE TABLE Missao (
    id-missao int NOT NULL PRIMARY KEY,
    estacao int NOT NULL,
    nome varchar(50) NOT NULL,
    descricao varchar(150),
    FOREIGN KEY (estacao) REFERENCES Estacao (id-estacao)
);
commit;

-- Tabela Monstro
begin;
CREATE TABLE Monstro (
    id-monstro int NOT NULL PRIMARY KEY,
    drop int NOT NULL,
    nome varchar(50) NOT NULL,
    descricao varchar(150),
    dano int NOT NULL,
    defesa int NOT NULL,
    saude-maxima int NOT NULL,
    FOREIGN KEY (drop) REFERENCES Item (id-item)
);
commit;
 
-- Tabela Mundo 
begin;
CREATE TABLE Mundo (
    id-mundo int NOT NULL PRIMARY KEY,
    nome varchar(50) NOT NULL,
);
commit;

-- Tabela NPC
begin;
CREATE TABLE NPC (
    id-npc int NOT NULL PRIMARY KEY,
    regiao int NOT NULL,
    local int NOT NULL,
    nome varchar(50) NOT NULL,
    profissao varchar(100),
    FOREIGN KEY (regiao) REFERENCES Regiao (id-regiao)
    FOREIGN KEY (local) REFERENCES Local-Fechado (id-local-fechado)
);
commit;

-- Tabela Região
begin;
CREATE TABLE Região (
    id-regiao int NOT NULL PRIMARY KEY,
    mundo int NOT NULL,
    nome varchar(50) NOT NULL,
    FOREIGN KEY (mundo) REFERENCES Mundo (id-mundo)
);
commit;

-- Tabela Semente
begin;
CREATE TABLE Semente (
    id-semente int NOT NULL,
    estacao int NOT NULL,
    nome varchar(50) NOT NULL,
    descricao varchar(150),
    valor-venda int NOT NULL,
    dias-para-crescer int NOT NULL,
    FOREIGN KEY (id-semente) REFERENCES Item (id-item)
    FOREIGN KEY (estacao) REFERENCES Estacao (id-estacao)
);
commit;

-- Tabela Vestimenta
begin;
CREATE TABLE Vestimenta (
    id-vestimenta int NOT NULL,
    nome varchar(50) NOT NULL,
    descricao varchar(150),
    FOREIGN KEY (id-vestimenta) REFERENCES Item (id-item)
);
commit;
