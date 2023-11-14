-- --------------------------------------------------------------------------------------
-- Data Criacao ...........: 16/10/2023                                                --
-- Autor(es) ..............: Zenilda Vieira                                            --
-- Versao ..............: 1.0                                                          --
-- Banco de Dados .........: PostgreSQL                                                --
-- Descricao .........: Inclusão de CREATE TABLE de todas as tabelas do banco de dados.--
-- --------------------------------------------------------------------------------------
-- | Atualizacao : 16/10/2023 | Autor(es): Zenilda Vieira                       |      --
--                            | Descricao: Inclusão das linhas de CREATE TABLE  |      --
-- | Atualizacao : 29/10/2023 | Autor(es): Edilberto Cantuaria                  |      --
--                            | Descricao: Correção das linhas de CREATE TABLE  |      --
-- --------------------------------------------------------------------------------------

BEGIN TRANSACTION; 

CREATE TABLE Estacao (
    id_estacao SERIAL PRIMARY KEY,
    nome char(50) NOT NULL,
    descricao char(800)
);

CREATE TABLE Tipo_Item (
    id_tipo_item SERIAL PRIMARY KEY,
    nome_tipo_item char(50) NOT NULL
);

CREATE TABLE Item (
    id_item SERIAL PRIMARY KEY,
    id_tipo_item int NOT NULL,
    FOREIGN KEY (id_item) REFERENCES Tipo_Item (id_tipo_item)
);

CREATE TABLE Tipo_Local_Fechado (
    id_tipo_local_fechado SERIAL PRIMARY KEY,
    nome_tipo_local_fechado char(50) NOT NULL
);

CREATE TABLE Local_Fechado (
    id_local_fechado SERIAL PRIMARY KEY,
    id_tipo_local_fechado char(50) NOT NULL,
    FOREIGN KEY (id_local_fechado) REFERENCES Tipo_Local_Fechado (id_tipo_local_fechado)
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
    comeca_jogo_com BOOLEAN,
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
    id_item int NOT NULL,
    valor int NOT NULL,
    tipo char(100),
    FOREIGN KEY (id_item) REFERENCES Item (id_item)
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
    id_drop int NOT NULL,
    nome char(50) NOT NULL,
    descricao char(800),
    dano int NOT NULL,
    defesa int NOT NULL,
    saude_maxima int NOT NULL,
    FOREIGN KEY (id_drop) REFERENCES Item (id_item)
);

CREATE TABLE Informacao_Semente (
    id_info_semente SERIAL PRIMARY KEY,
    id_semente int NOT NULL,
    nome char(50) NOT NULL,
    descricao char(800),
    valor_venda int NOT NULL,
    dias_para_crescer int NOT NULL,
    FOREIGN KEY (id_semente) REFERENCES Item (id_item)
);

CREATE TABLE Semente (
    id_semente SERIAL PRIMARY KEY,
    id_info_semente int NOT NULL,
    id_estacao int NOT NULL,
    FOREIGN KEY (id_semente) REFERENCES Item (id_item),
    FOREIGN KEY (id_info_semente) REFERENCES Informacao_Semente (id_info_semente),
    FOREIGN KEY (id_estacao) REFERENCES Estacao (id_estacao)
);

CREATE TABLE Missao (
    id_missao SERIAL PRIMARY KEY,
    id_estacao int NOT NULL,
    nome char(50) NOT NULL,
    descricao char(800),
    FOREIGN KEY (id_estacao) REFERENCES Estacao (id_estacao)
);

CREATE TABLE Regiao (
    id_regiao SERIAL PRIMARY KEY,
    mundo int NOT NULL,
    nome char(50) NOT NULL,
    FOREIGN KEY (mundo) REFERENCES Mundo (id_mundo)
);

CREATE TABLE NPC (
    id_npc SERIAL PRIMARY KEY,
    id_regiao int NOT NULL,
    id_local_fechado int NOT NULL,
    nome char(50) NOT NULL,
    profissao char(100),
    FOREIGN KEY (id_regiao) REFERENCES Regiao (id_regiao),
    FOREIGN KEY (id_local_fechado) REFERENCES Local_Fechado (id_local_fechado)
);

CREATE TABLE Caverna (
    id_local_fechado SERIAL PRIMARY KEY,
    id_regiao int NOT NULL,
    nome char(50) NOT NULL,
    descricao char(800),
    FOREIGN KEY (id_local_fechado) REFERENCES Local_Fechado  (id_local_fechado),
    FOREIGN KEY (id_regiao) REFERENCES Regiao (id_regiao)
);


CREATE TABLE Cabana_NPC (
    id_local_fechado SERIAL PRIMARY KEY,
    id_npc int NOT NULL,
    id_regiao int NOT NULL,
    nome char(50) NOT NULL,
    descricao char(800),
    FOREIGN KEY (id_local_fechado) REFERENCES Local_Fechado (id_local_fechado),
    FOREIGN KEY (id_npc) REFERENCES NPC (id_npc),
    FOREIGN KEY (id_regiao) REFERENCES Regiao (id_regiao)
);

CREATE TABLE Loja (
    id_loja SERIAL PRIMARY KEY,
    id_npc int NOT NULL,
    id_regiao int NOT NULL,
    nome char(50) NOT NULL,
    descricao char(800),
    FOREIGN KEY (id_loja) REFERENCES Local_Fechado (id_local_fechado),
    FOREIGN KEY (id_npc) REFERENCES NPC (id_npc),
    FOREIGN KEY (id_regiao) REFERENCES Regiao (id_regiao)
);

CREATE TABLE Jogador (
    id_jogador SERIAL PRIMARY KEY,
    id_local_fechado int NOT NULL,
    id_regiao int NOT NULL,
    id_estacao int NOT NULL,
    id_missao int,
    nome char(50) NOT NULL,
    saude int NOT NULL,
    energia int NOT NULL,
    dia int NOT NULL,
    hora int NOT NULL,
    qtdd_ouro int,
    FOREIGN KEY (id_local_fechado) REFERENCES Local_Fechado (id_local_fechado),
    FOREIGN KEY (id_regiao) REFERENCES Regiao (id_regiao),
    FOREIGN KEY (id_estacao) REFERENCES Estacao (id_estacao),
    FOREIGN KEY (id_missao) REFERENCES Missao (id_missao)
);


CREATE TABLE Item_Receita (
    id_artesanato int NOT NULL,
    id_item int NOT NULL,
    qtdd int NOT NULL,
    FOREIGN KEY (id_artesanato) REFERENCES Artesanato (id_artesanato),
    FOREIGN KEY (id_item) REFERENCES Item (id_item)
);

CREATE TABLE Item_Inventario (
    id_jogador int NOT NULL,
    id_item int NOT NULL,
    qtdd int NOT NULL,
    FOREIGN KEY (id_jogador) REFERENCES Jogador (id_jogador),
    FOREIGN KEY (id_item) REFERENCES Item (id_item)
);

CREATE TABLE Item_Estoque_Loja (
    id_item int NOT NULL,
    id_loja int NOT NULL,
    preco int NOT NULL,
    FOREIGN KEY (id_item) REFERENCES Item (id_item),
    FOREIGN KEY (id_loja) REFERENCES Loja (id_loja)
);

CREATE TABLE Instancia_Monstro (
    id_caverna int NOT NULL,
    id_monstro int NOT NULL,
    saude int NOT NULL,
    FOREIGN KEY (id_caverna) REFERENCES Local_Fechado (id_local_fechado),
    FOREIGN KEY (id_monstro) REFERENCES Monstro (id_monstro)
);

CREATE TABLE Habilidade (
    id_jogador int NOT NULL,
    nivel_coleta int NOT NULL,
    nivel_cultivo int NOT NULL,
    nivel_mineracao int NOT NULL,
    nivel_pesca int NOT NULL,
    nivel_combate int NOT NULL,
    FOREIGN KEY (id_jogador) REFERENCES Jogador (id_jogador)
);

CREATE TABLE Dialogo (
    id_dialogo SERIAL PRIMARY KEY,
    id_npc int NOT NULL,
    fala char(800) NOT NULL,
    FOREIGN KEY (id_npc) REFERENCES NPC (id_npc)
);

CREATE TABLE Cabana_Jogador (
    id_local_fechado SERIAL PRIMARY KEY,
    id_jogador int NOT NULL,
    id_regiao int NOT NULL,
    nome char(50) NOT NULL,
    descricao char(800),
    FOREIGN KEY (id_local_fechado) REFERENCES Local_Fechado (id_local_fechado),
    FOREIGN KEY (id_jogador) REFERENCES Jogador (id_jogador),
    FOREIGN KEY (id_regiao) REFERENCES Regiao (id_regiao)
);

COMMIT;