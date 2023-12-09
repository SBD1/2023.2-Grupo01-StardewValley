CREATE DATABASE stardew_valley
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    IS_TEMPLATE = False;

BEGIN TRANSACTION;

\c stardew_valley;

CREATE TABLE Tipo_Item (
    id_tipo_item INT PRIMARY KEY,
    nome_tipo_item VARCHAR(20) NOT NULL,
    CHECK (id_tipo_item BETWEEN 1 AND 6),
    CHECK (nome_tipo_item IN ('arma', 'ferramenta', 'consumivel', 'vestimenta', 'artesanato', 'semente'))
);

CREATE TABLE Item (
    id_item INT PRIMARY KEY,
    id_tipo_item INT,
    FOREIGN KEY (id_tipo_item) REFERENCES Tipo_Item(id_tipo_item),
    CHECK (id_item BETWEEN 1 AND 5000),
    CHECK (id_tipo_item BETWEEN 1 AND 6)
);

CREATE TABLE Mundo (
    id_mundo INT PRIMARY KEY,
    nome CHAR(50) NOT NULL,
    descricao CHAR(800) NOT NULL,
    CHECK (id_mundo BETWEEN 1 AND 5000)
);

CREATE TABLE Regiao (
    id_regiao INT PRIMARY KEY,
    id_mundo INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(800) NOT NULL,
    CHECK (id_regiao BETWEEN 1 AND 5000),
    CHECK (id_mundo BETWEEN 1 AND 5000),
    FOREIGN KEY (id_mundo) REFERENCES Mundo(id_mundo)
);


CREATE TABLE Estacao (
    id_estacao INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(800),
    CHECK (id_estacao BETWEEN 1 AND 5000)
);

CREATE TABLE Missao (
    id_missao INT PRIMARY KEY,
    id_estacao INT NOT NULL,
    nome CHAR(50) NOT NULL,
    descricao CHAR(800),
    FOREIGN KEY (id_estacao) REFERENCES Estacao(id_estacao),
    CHECK (id_missao BETWEEN 1 AND 5000),
    CHECK (id_estacao BETWEEN 1 AND 4)
);

CREATE TABLE Tipo_Local_Fechado (
    id_tipo_local_fechado INT PRIMARY KEY,
    nome_tipo_local_fechado VARCHAR(20) NOT NULL,
    CHECK (id_tipo_local_fechado BETWEEN 1 AND 4),
    CHECK (nome_tipo_local_fechado IN ('cabana_jog', 'cabana_npc', 'caverna', 'loja'))
);

CREATE TABLE Local_Fechado (
    id_local_fechado INT PRIMARY KEY,
    id_tipo_local_fechado INT NOT NULL,
    FOREIGN KEY (id_tipo_local_fechado) REFERENCES Tipo_Local_Fechado(id_tipo_local_fechado),
    CHECK (id_local_fechado BETWEEN 1 AND 5000),
    CHECK (id_tipo_local_fechado BETWEEN 1 AND 4)
);

CREATE TABLE Jogador (
    id_jogador INT PRIMARY KEY,
    id_local_fechado INT,
    id_regiao INT NOT NULL,
    id_estacao INT DEFAULT 1,
    id_missao INT DEFAULT 1,
    nome CHAR(50) NOT NULL,
    energia INT DEFAULT 100,
    dia INT NOT NULL,
    hora INT DEFAULT 360,
    qtdd_ouro INT DEFAULT 500,
    FOREIGN KEY (id_local_fechado) REFERENCES Local_Fechado(id_local_fechado),
    FOREIGN KEY (id_regiao) REFERENCES Regiao(id_regiao),
    FOREIGN KEY (id_estacao) REFERENCES Estacao(id_estacao),
    FOREIGN KEY (id_missao) REFERENCES Missao(id_missao),
    CHECK (id_jogador BETWEEN 1 AND 5000),
    CHECK (id_local_fechado BETWEEN 1 AND 5000),
    CHECK (id_regiao BETWEEN 1 AND 5000),
    CHECK (id_estacao BETWEEN 1 AND 4),
    CHECK (id_missao BETWEEN 1 AND 5000),
    CHECK (energia BETWEEN 0 AND 100),
    CHECK (dia BETWEEN 1 AND 28),
    CHECK (hora BETWEEN 0 AND 1440),
    CHECK (qtdd_ouro >= 0)
);

CREATE TABLE NPC (
    id_NPC INT PRIMARY KEY,
    id_regiao INT NOT NULL,
    id_local_fechado INT,
    nome CHAR(50) NOT NULL,
    profissao CHAR(100),
    CHECK (id_NPC BETWEEN 1 AND 5000),
    FOREIGN KEY (id_regiao) REFERENCES Regiao(id_regiao),
    FOREIGN KEY (id_local_fechado) REFERENCES Local_Fechado(id_local_fechado)
);

CREATE TABLE Arma (
    id_arma INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(800),
    dano INT NOT NULL CHECK (dano BETWEEN 1 AND 10),
    finalidade VARCHAR(100) NOT NULL,
    comeca_jogo_com BOOLEAN NOT NULL CHECK (comeca_jogo_com IN (TRUE, FALSE)),
    FOREIGN KEY (id_arma) REFERENCES Item(id_item)
);

CREATE TABLE Artesanato (
    id_artesanato INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(800),
    FOREIGN KEY (id_artesanato) REFERENCES Item(id_item)
);

CREATE TABLE Cabana_Jogador (
    id_cabana_jog INT PRIMARY KEY,
    id_prop_cab_jog INT NOT NULL,
    id_regiao INT NOT NULL DEFAULT 1,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(800),
    FOREIGN KEY (id_prop_cab_jog) REFERENCES Jogador(id_jogador),
    FOREIGN KEY (id_regiao) REFERENCES Regiao(id_regiao)
);

CREATE TABLE Cabana_NPC (
    id_cabana_NPC INT PRIMARY KEY,
    id_prop_cab_NPC INT NOT NULL,
    id_regiao INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(800),
    FOREIGN KEY (id_prop_cab_NPC) REFERENCES NPC(id_npc),
    FOREIGN KEY (id_regiao) REFERENCES Regiao(id_regiao)
);

CREATE TABLE Caverna (
    id_caverna INT PRIMARY KEY,
    id_regiao INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(800),
    FOREIGN KEY (id_regiao) REFERENCES Regiao(id_regiao)
);

CREATE TABLE Ferramenta (
    id_ferramenta INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(800),
    finalidade VARCHAR(100) NOT NULL,
    comeca_jogo_com BOOLEAN NOT NULL,
    CHECK (id_ferramenta BETWEEN 1 AND 5000)
);

CREATE TABLE Consumivel (
    id_consumivel INT PRIMARY KEY,
    id_regiao INT NOT NULL,
    id_local_fechado INT,
    id_ferramenta INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(800),
    FOREIGN KEY (id_regiao) REFERENCES Regiao(id_regiao),
    FOREIGN KEY (id_local_fechado) REFERENCES Local_Fechado(id_local_fechado),
    FOREIGN KEY (id_ferramenta) REFERENCES Ferramenta(id_ferramenta)
);

CREATE TABLE Dialogo (
    id_dialogo INT PRIMARY KEY,
    id_NPC INT NOT NULL,
    fala VARCHAR(800) NOT NULL,
    FOREIGN KEY (id_NPC) REFERENCES NPC(id_NPC)
);

CREATE TABLE Efeito (
    id_efeito INT PRIMARY KEY,
    id_item INT NOT NULL,
    valor INT NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_item) REFERENCES Item(id_item)
);

CREATE TABLE Habilidade (
    id_jogador INT PRIMARY KEY,
    nivel_coleta INT DEFAULT 1,
    nivel_cultivo INT DEFAULT 1,
    nivel_mineracao INT DEFAULT 1,
    nivel_pesca INT DEFAULT 1,
    nivel_combate INT DEFAULT 1,
    FOREIGN KEY (id_jogador) REFERENCES Jogador(id_jogador),
    CHECK (id_jogador BETWEEN 1 AND 5000),
    CHECK (nivel_coleta BETWEEN 1 AND 1000),
    CHECK (nivel_cultivo BETWEEN 1 AND 1000),
    CHECK (nivel_mineracao BETWEEN 1 AND 1000),
    CHECK (nivel_pesca BETWEEN 1 AND 1000),
    CHECK (nivel_combate BETWEEN 1 AND 1000)
);

CREATE TABLE Monstro (
    id_monstro INT PRIMARY KEY,
    id_drop INT NOT NULL,
    nome CHAR(50) NOT NULL,
    descricao CHAR(800),
    dano INT NOT NULL CHECK (dano BETWEEN 1 AND 10),
    defesa INT NOT NULL CHECK (defesa BETWEEN 1 AND 10),
    energia_maxima INT NOT NULL CHECK (energia_maxima BETWEEN 1 AND 100),
    FOREIGN KEY (id_drop) REFERENCES Item(id_item),
    CHECK (id_monstro BETWEEN 1 AND 5000)
);

CREATE TABLE Instancia_Monstro (
    id_caverna INT,
    id_monstro INT,
    energia INT,
    PRIMARY KEY (id_caverna, id_monstro),
    FOREIGN KEY (id_caverna) REFERENCES Caverna(id_caverna),
    FOREIGN KEY (id_monstro) REFERENCES Monstro(id_monstro),
    CHECK (id_caverna BETWEEN 1 AND 5000),
    CHECK (id_monstro BETWEEN 1 AND 5000),
    CHECK (energia BETWEEN 1 AND 100)
);


CREATE TABLE Loja (
    id_loja INT PRIMARY KEY,
    id_npc_prop INT NOT NULL,
    id_regiao INT NOT NULL,
    nome CHAR(50) NOT NULL,
    descricao CHAR(800),
    FOREIGN KEY (id_loja) REFERENCES Local_Fechado(id_local_fechado),
    FOREIGN KEY (id_npc_prop) REFERENCES NPC(id_NPC),
    FOREIGN KEY (id_regiao) REFERENCES Regiao(id_regiao),
    CHECK (id_loja BETWEEN 1 AND 5000),
    CHECK (id_npc_prop BETWEEN 1 AND 5000),
    CHECK (id_regiao BETWEEN 1 AND 5000)
);

CREATE TABLE Item_Estoque_Loja (
    id_item INT,
    id_loja INT,
    preco INT,
    PRIMARY KEY (id_item, id_loja),
    FOREIGN KEY (id_item) REFERENCES Item(id_item),
    FOREIGN KEY (id_loja) REFERENCES Loja(id_loja),
    CHECK (id_item BETWEEN 1 AND 5000),
    CHECK (id_loja BETWEEN 1 AND 5000),
    CHECK (preco BETWEEN 1 AND 500000)
);

CREATE TABLE Item_Inventario (
    id_jogador INT,
    id_item INT,
    qtdd INT,
    PRIMARY KEY (id_jogador, id_item),
    FOREIGN KEY (id_jogador) REFERENCES Jogador(id_jogador),
    FOREIGN KEY (id_item) REFERENCES Item(id_item),
    CHECK (id_jogador BETWEEN 1 AND 5000),
    CHECK (id_item BETWEEN 1 AND 5000),
    CHECK (qtdd >= 0)
);

CREATE TABLE Item_Receita (
    id_artesanato INT,
    id_item INT,
    qtdd INT,
    PRIMARY KEY (id_artesanato, id_item),
    FOREIGN KEY (id_artesanato) REFERENCES Artesanato(id_artesanato),
    FOREIGN KEY (id_item) REFERENCES Item(id_item),
    CHECK (id_artesanato BETWEEN 1 AND 5000),
    CHECK (id_item BETWEEN 1 AND 5000),
    CHECK (qtdd >= 0)
);

CREATE TABLE Plantacao (
    id_semente INT PRIMARY KEY,
    dia_colheita INT NOT NULL,
    CHECK (id_semente BETWEEN 1 AND 5000),
    CHECK (dia_colheita BETWEEN 1 AND 28),
    FOREIGN KEY (id_semente) REFERENCES Item(id_item)
);

CREATE TABLE Semente (
    id_semente INT PRIMARY KEY,
    id_estacao INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(800),
    valor_venda INT NOT NULL,
    dias_para_crescer INT NOT NULL,
    CHECK (id_semente BETWEEN 1 AND 5000),
    CHECK (id_estacao BETWEEN 1 AND 5000),
    CHECK (valor_venda >= 1 AND valor_venda <= 5000),
    CHECK (dias_para_crescer BETWEEN 1 AND 28),
    FOREIGN KEY (id_estacao) REFERENCES Estacao(id_estacao)
);

CREATE TABLE Vestimenta (
    id_vestimenta INT PRIMARY KEY,
    nome char(50) NOT NULL,
    descricao char(800),
    FOREIGN KEY (id_vestimenta) REFERENCES Item(id_item)
);

COMMIT;