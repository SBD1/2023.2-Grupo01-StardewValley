\c stardew_valley;


CREATE TABLE Estacao (
    id_estacao SERIAL PRIMARY KEY,
    nome char(50) NOT NULL,
    descricao char(800)
);

CREATE TABLE Item (
    id_item SERIAL PRIMARY KEY,
    id_tipo char(50) NOT NULL
);

CREATE TABLE Local_Fechado (
    id_local_fechado SERIAL PRIMARY KEY,
    id_tipo char(50) NOT NULL
);

CREATE TABLE Mundo (
    id_mundo SERIAL PRIMARY KEY,
    nome char(50) NOT NULL
);

CREATE TABLE Arma (
    id_arma SERIAL PRIMARY KEY,
    nome char(50) NOT NULL,
    descricao char(800),
    dano int NOT NULL,
    finalidade char(100) NOT NULL,
    FOREIGN KEY (id_arma) REFERENCES Item (id_item)
);

CREATE TABLE Artesanato (
    id_artesanato SERIAL PRIMARY KEY,
    nome char(50) NOT NULL,
    descricao char(800),
    FOREIGN KEY (id_artesanato) REFERENCES Item (id_item)
);

CREATE TABLE Consumivel (
    id_consumivel SERIAL PRIMARY KEY,
    nome char(50) NOT NULL,
    descricao char(800),
    FOREIGN KEY (id_consumivel) REFERENCES Item (id_item)
);

CREATE TABLE Efeito (
    id_efeito int NOT NULL PRIMARY KEY,
    item int NOT NULL,
    valor int NOT NULL,
    tipo char(100),
    FOREIGN KEY (item) REFERENCES Item (id_item)
);

CREATE TABLE Ferramenta (
    id_ferramenta SERIAL PRIMARY KEY,
    nome char(50) NOT NULL,
    descricao char(800),
    finalidade char(100) NOT NULL,
    FOREIGN KEY (id_ferramenta) REFERENCES Item (id_item)
);

CREATE TABLE Vestimenta (
    id_vestimenta SERIAL PRIMARY KEY,
    nome char(50) NOT NULL,
    descricao char(800),
    FOREIGN KEY (id_vestimenta) REFERENCES Item (id_item)
);

CREATE TABLE Monstro (
    id_monstro SERIAL PRIMARY KEY,
    item_drop int NOT NULL,
    nome char(50) NOT NULL,
    descricao char(800),
    dano int NOT NULL,
    defesa int NOT NULL,
    saude_maxima int NOT NULL,
    FOREIGN KEY (item_drop) REFERENCES Item (id_item)
);

CREATE TABLE Semente (
    id_semente SERIAL PRIMARY KEY,
    estacao int NOT NULL,
    nome char(50) NOT NULL,
    descricao char(800),
    valor_venda int NOT NULL,
    dias_para_crescer int NOT NULL,
    FOREIGN KEY (id_semente) REFERENCES Item (id_item),
    FOREIGN KEY (estacao) REFERENCES Estacao (id_estacao)
);


CREATE TABLE Missao (
    id_missao SERIAL PRIMARY KEY,
    estacao int NOT NULL,
    nome char(50) NOT NULL,
    descricao char(800),
    FOREIGN KEY (estacao) REFERENCES Estacao (id_estacao)
);

CREATE TABLE Regiao (
    id_regiao SERIAL PRIMARY KEY,
    mundo int NOT NULL,
    nome char(50) NOT NULL,
    FOREIGN KEY (mundo) REFERENCES Mundo (id_mundo)
);

CREATE TABLE NPC (
    id_npc SERIAL PRIMARY KEY,
    regiao int NOT NULL,
    local_NPC int NOT NULL,
    nome char(50) NOT NULL,
    profissao char(100),
    FOREIGN KEY (regiao) REFERENCES Regiao (id_regiao),
    FOREIGN KEY (local_NPC) REFERENCES Local_Fechado (id_local_fechado)
);

CREATE TABLE Caverna (
    id_caverna SERIAL PRIMARY KEY,
    regiao int NOT NULL,
    nome char(50) NOT NULL,
    descricao char(800),
    FOREIGN KEY (id_caverna) REFERENCES Local_Fechado  (id_local_fechado),
    FOREIGN KEY (regiao) REFERENCES Regiao (id_regiao)
);


CREATE TABLE Cabana_NPC (
    id_cabana_npc SERIAL PRIMARY KEY,
    npc int NOT NULL,
    regiao int NOT NULL,
    nome char(50) NOT NULL,
    descricao char(800),
    FOREIGN KEY (id_cabana_npc) REFERENCES Local_Fechado (id_local_fechado),
    FOREIGN KEY (npc) REFERENCES NPC (id_npc),
    FOREIGN KEY (regiao) REFERENCES Regiao (id_regiao)
);

CREATE TABLE Loja (
    id_loja SERIAL PRIMARY KEY,
    proprietario int NOT NULL,
    regiao int NOT NULL,
    nome char(50) NOT NULL,
    descricao char(800),
    FOREIGN KEY (id_loja) REFERENCES Local_Fechado (id_local_fechado),
    FOREIGN KEY (proprietario) REFERENCES NPC (id_npc),
    FOREIGN KEY (regiao) REFERENCES Regiao (id_regiao)
);

CREATE TABLE Jogador (
    id_jogador SERIAL PRIMARY KEY,
    local_jogador int NOT NULL,
    regiao int NOT NULL,
    estacao_atual int NOT NULL,
    missao_atual int,
    nome char(50) NOT NULL,
    saude int NOT NULL,
    energia int NOT NULL,
    dia int NOT NULL,
    qtdd_ouro int,
    FOREIGN KEY (local_jogador) REFERENCES Local_Fechado (id_local_fechado),
    FOREIGN KEY (regiao) REFERENCES Regiao (id_regiao),
    FOREIGN KEY (estacao_atual) REFERENCES Estacao (id_estacao),
    FOREIGN KEY (missao_atual) REFERENCES Missao (id_missao)
);


CREATE TABLE Item_Receita (
    artesanato int NOT NULL,
    item int NOT NULL,
    qtdd int NOT NULL,
    FOREIGN KEY (artesanato) REFERENCES Artesanato (id_artesanato),
    FOREIGN KEY (item) REFERENCES Item (id_item)
);

CREATE TABLE Item_Inventario (
    jogador int NOT NULL,
    item int NOT NULL,
    qtdd int NOT NULL,
    FOREIGN KEY (jogador) REFERENCES Jogador (id_jogador),
    FOREIGN KEY (item) REFERENCES Item (id_item)
);

CREATE TABLE Item_Estoque_Loja (
    produto int NOT NULL,
    loja int NOT NULL,
    preco int NOT NULL,
    FOREIGN KEY (produto) REFERENCES Item (id_item),
    FOREIGN KEY (loja) REFERENCES Loja (id_loja)
);

CREATE TABLE Instancia_Monstro (
    caverna int NOT NULL,
    monstro int NOT NULL,
    saude int NOT NULL,
    FOREIGN KEY (caverna) REFERENCES Local_Fechado (id_local_fechado),
    FOREIGN KEY (monstro) REFERENCES Monstro (id_monstro)
);

CREATE TABLE Habilidade (
    jogador int NOT NULL,
    nivel_coleta int NOT NULL,
    nivel_cultivo int NOT NULL,
    nivel_mineracao int NOT NULL,
    nivel_pesca int NOT NULL,
    nivel_combate int NOT NULL,
    FOREIGN KEY (jogador) REFERENCES Jogador (id_jogador)
);

CREATE TABLE Dialogo (
    id_dialogo SERIAL PRIMARY KEY,
    npc int NOT NULL,
    fala char(800) NOT NULL,
    FOREIGN KEY (npc) REFERENCES NPC (id_npc)
);

CREATE TABLE Cabana_Jogador (
    id_cabana_jog SERIAL PRIMARY KEY,
    jogador int NOT NULL,
    regiao int NOT NULL,
    nome char(50) NOT NULL,
    descricao char(800),
    FOREIGN KEY (id_cabana_jog) REFERENCES Local_Fechado (id_local_fechado),
    FOREIGN KEY (jogador) REFERENCES Jogador (id_jogador),
    FOREIGN KEY (regiao) REFERENCES Regiao (id_regiao)
);
