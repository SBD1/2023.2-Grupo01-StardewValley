CREATE TABLE Mundo (
    id_mundo SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE Regiao (
    id_regiao SERIAL PRIMARY KEY,
    mundo INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    FOREIGN KEY (mundo) REFERENCES Mundo (id_mundo)
);

CREATE TABLE Estacao (
    id_estacao SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(150)
);

CREATE TABLE Missao (
    id_missao SERIAL PRIMARY KEY,
    estacao INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(150),
    FOREIGN KEY (estacao) REFERENCES Estacao (id_estacao)
);

CREATE TABLE Local_Fechado (
    id_local_fechado SERIAL PRIMARY KEY,
    id_tipo VARCHAR(50) NOT NULL
);

CREATE TABLE NPC (
    id_npc SERIAL PRIMARY KEY,
    regiao INT NOT NULL,
    local INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    profissao VARCHAR(100),
    FOREIGN KEY (regiao) REFERENCES Regiao (id_regiao),
    FOREIGN KEY (local) REFERENCES Local_Fechado (id_local_fechado)
);

CREATE TABLE Caverna (
    id_caverna SERIAL PRIMARY KEY,
    regiao INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(150),
    FOREIGN KEY (regiao) REFERENCES Regiao (id_regiao)
);

CREATE TABLE Semente (
    id_semente SERIAL PRIMARY KEY,
    estacao INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(150),
    valor_venda INT NOT NULL,
    dias_para_crescer INT NOT NULL,
    FOREIGN KEY (id_semente) REFERENCES Item (id_item),
    FOREIGN KEY (estacao) REFERENCES Estacao (id_estacao)
);

CREATE TABLE Item (
    id_item SERIAL PRIMARY KEY,
    id_tipo VARCHAR(50) NOT NULL
);

CREATE TABLE Vestimenta (
    id_vestimenta SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(150),
    FOREIGN KEY (id_vestimenta) REFERENCES Item (id_item)
);

CREATE TABLE Arma (
    id_arma SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(150),
    dano INT NOT NULL,
    finalidade VARCHAR(100) NOT NULL,
    id_item INT,
    FOREIGN KEY (id_item) REFERENCES Item (id_item)
);

CREATE TABLE Consumivel (
    id_consumivel SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(150)
);

CREATE TABLE Dialogo (
    id_dialogo SERIAL PRIMARY KEY,
    npc INT NOT NULL,
    fala VARCHAR(150) NOT NULL,
    FOREIGN KEY (npc) REFERENCES NPC (id_npc)
);

CREATE TABLE Efeito (
    id_efeito SERIAL PRIMARY KEY,
    item INT NOT NULL,
    valor INT NOT NULL,
    tipo VARCHAR(100),
    FOREIGN KEY (item) REFERENCES Item (id_item)
);

CREATE TABLE Ferramenta (
    id_ferramenta SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(150),
    finalidade VARCHAR(100) NOT NULL
);

CREATE TABLE Jogador (
    id_jogador SERIAL PRIMARY KEY,
    local INT NOT NULL,
    regiao INT NOT NULL,
    estacao_atual INT NOT NULL,
    missao_atual INT,
    nome VARCHAR(50) NOT NULL,
    saude INT NOT NULL,
    energia INT NOT NULL,
    dia INT NOT NULL,
    qtdd_ouro INT,
    FOREIGN KEY (local) REFERENCES Local_Fechado (id_local_fechado),
    FOREIGN KEY (regiao) REFERENCES Regiao (id_regiao),
    FOREIGN KEY (estacao_atual) REFERENCES Estacao (id_estacao),
    FOREIGN KEY (missao_atual) REFERENCES Missao (id_missao)
);

CREATE TABLE Cabana_NPC (
    id_cabana_npc SERIAL PRIMARY KEY,
    npc INT NOT NULL,
    regiao INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(150),
    FOREIGN KEY (id_cabana_npc) REFERENCES Local_Fechado (id_local_fechado),
    FOREIGN KEY (npc) REFERENCES NPC (id_npc),
    FOREIGN KEY (regiao) REFERENCES Regiao (id_regiao)
);

CREATE TABLE Cabana_Jogador (
    id_cabana_jog SERIAL PRIMARY KEY,
    jogador INT NOT NULL,
    regiao INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(150),
    FOREIGN KEY (id_cabana_jog) REFERENCES Local_Fechado (id_local_fechado),
    FOREIGN KEY (jogador) REFERENCES Jogador (id_jogador),
    FOREIGN KEY (regiao) REFERENCES Regiao (id_regiao)
);

CREATE TABLE Habilidade (
    jogador SERIAL PRIMARY KEY,
    nivel_coleta INT NOT NULL,
    nivel_cultivo INT NOT NULL,
    nivel_mineracao INT NOT NULL,
    nivel_pesca INT NOT NULL,
    nivel_combate INT NOT NULL,
    FOREIGN KEY (jogador) REFERENCES Jogador (id_jogador)
);

CREATE TABLE Monstro (
    id_monstro SERIAL PRIMARY KEY,
    item_drop INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(150),
    dano INT NOT NULL,
    defesa INT NOT NULL,
    saude_maxima INT NOT NULL,
    FOREIGN KEY (item_drop) REFERENCES Item (id_item)
);

CREATE TABLE Instancia_Monstro (
    caverna INT NOT NULL,
    monstro INT NOT NULL,
    saude INT NOT NULL,
    FOREIGN KEY (caverna) REFERENCES Local_Fechado (id_local_fechado),
    FOREIGN KEY (monstro) REFERENCES Monstro (id_monstro)
);
CREATE TABLE Loja (
    id_loja SERIAL PRIMARY KEY,
    proprietario int NOT NULL,
    regiao int NOT NULL,
    nome varchar(50) NOT NULL,
    descricao varchar(150),
    FOREIGN KEY (id-loja) REFERENCES Local-Fechado (id-local-fechado)
    FOREIGN KEY (proprietario) REFERENCES NPC (id-npc)
    FOREIGN KEY (regiao) REFERENCES Regiao (id-regiao)
);

CREATE TABLE Item_Estoque_Loja (
    produto INT NOT NULL,
    loja INT NOT NULL,
    preco INT NOT NULL,
    FOREIGN KEY (produto) REFERENCES Item (id_item),
    FOREIGN KEY (loja) REFERENCES Loja (id_loja)
);

CREATE TABLE Item_Inventario (
    jogador INT NOT NULL,
    item INT NOT NULL,
    qtdd INT NOT NULL,
    FOREIGN KEY (jogador) REFERENCES Jogador (id_jogador),
    FOREIGN KEY (item) REFERENCES Item (id_item)
);

CREATE TABLE Item_Receita (
    artesanato INT NOT NULL,
    item INT NOT NULL,
    qtdd INT NOT NULL,
    FOREIGN KEY (artesanato) REFERENCES Arma (id_arma),
    FOREIGN KEY (item) REFERENCES Item (id_item)
);
