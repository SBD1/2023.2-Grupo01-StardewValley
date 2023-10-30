-- --------------------------------------------------------------------------------------
-- Data Criacao ...........: 16/10/2023                                                --
-- Autor(es) ..............: Zenilda Vieira                                            --
-- Versao ..............: 1.0                                                          --
-- Banco de Dados .........: PostgreSQL                                                --
-- Descricao .........: Consulta das tabelas do banco de dados.                        --
-- --------------------------------------------------------------------------------------
-- | Atualizacao : 29/10/2023 | Autor(es): Matheus Silverio e Zenilda Vieira        |  --
--                            | Descricao: Inclusão das consultas do banco de dados |  --
-- --------------------------------------------------------------------------------------

-- consultar o id e a descricao de uma estacao específica
SELECT id_estacao, descricao FROM Estacao WHERE nome = 'Primavera';

-- consultar o id de um tipo de item específico
SELECT id_item FROM Item WHERE id_tipo = 'Semente';

-- consultar o id de um local fechado específico
SELECT id_local_fechado FROM Local_Fechado WHERE id_tipo  = 'Loja';

-- consultar o id de um mundo específico
SELECT id_mundo FROM Mundo WHERE nome = 'Fazenda';

-- consultar o id e a descricao de uma arma específica
SELECT id_arma, descricao FROM Arma WHERE nome = 'espada';

-- consultar a descricao, o dano e a finalidade de uma arma específica
SELECT descricao, dano, finalidade FROM Arma WHERE id_arma = 1;

-- consultar o id de um artesanato específico
SELECT id_artesanato, descricao FROM Artesanato WHERE nome = 'Espantalho';

-- consultar o id e a descricao de um consumivel específico
SELECT id_consumivel, descricao FROM Consumivel WHERE nome = 'Omelete';

-- consultar o id e a descricao e o valor de um efeito específico
SELECT id_efeito, descricao, valor FROM Efeito WHERE tipo = 'tipo1';

-- consultar o id, a descricao e a finalidade de uma ferramenta específica
SELECT id_ferramenta, descricao, finalidade FROM Ferramenta WHERE nome = 'enxada';

-- consultar o id e a descricao de um vestimenta específico
SELECT id_vestimenta, descricao FROM Vestimenta WHERE nome = 'Vestido de Baile de Inverno';

-- consultar o id e as informações de um monstro específico
SELECT id_monstro, item_drop, dano, defesa, saude_maxima FROM Monstro WHERE nome = '';

-- consultar o id e as informações de uma semente específica
SELECT id_semente, estacao, descricao, valor_venda, dias_para_crescer FROM Semente WHERE nome = 'Semente de Couve-flor';

-- consultar o id e as informações de uma missao específica
SELECT id_missao, estacao, descricao FROM Missao WHERE nome = 'Plantando as Sementes';

-- consultar o id e o mundo de uma regiao específica
SELECT id_regiao, mundo FROM Regiao WHERE nome = 'Vila Pelicanos';

-- consultar o id e as informações de um NPC específico
SELECT id_npc, regiao, local_NPC, profissao FROM NPC WHERE nome = 'Willy';

-- consultar o id e as informações de uma caverna específica
SELECT id_caverna, regiao, descricao FROM Caverna WHERE nome = 'Caverna das Minhocas';

-- consultar o id e as informações de uma cabana_NPC específica
SELECT id_cabana_npc, regiao, descricao FROM Cabana_NPC WHERE npc = 'Cabana de Robin';

-- consultar o id e as informações de uma loja específica
SELECT id_loja, proprietario, regiao, descricao FROM Loja WHERE nome = 'Loja de Linus';

-- Dados geral sobre o jogador
SELECT regiao, estacao_atual, missao_atual, nome, saude, energia, qtdd_ouro FROM Jogador WHERE nome = ' Matheus';

-- consultar o id e as informações de um jogador específico
SELECT id_jogador, local_jogador, regiao, estacao_atual, missao_atual, saude, energia, dia, qtdd_ouro FROM Jogador WHERE nome = 'Marcus';

-- consultar a receita de um artesanato específico
SELECT item, qtdd FROM Item_Receita, Artesanato WHERE Item_Receita.artesanato = Artesanato.id_artesanato and Artesanato.nome = 'Tear';

-- Consultar Habilidades
SELECT nivel_coleta, nivel_cultivo, nivel_mineracao, nivel_pesca, nivel_combate FROM Habilidade, Jogador WHERE Habilidade.jogador = Jogador.id_jogador and Habilidade.jogador = 'Edilberto';

-- consultar o id e a fala de um dialogo específico
SELECT id_dialogo, fala FROM Dialogo, NPC WHERE NPC.id_npc = Dialogo.npc and NPC.nome = 'Marlon';

-- consultar o id e as informações de uma cabana_jogador específica
SELECT id_cabana_jog, regiao, nome, descricao FROM Cabana_Jogador, Jogador WHERE Cabana_Jogador.jogador = Jogador.id_jogador and Jogador.nome = 'Zenilda' 


-- Dados sobre o inventario do jogador
SELECT I.nome, II.qtdd
FROM Item_Inventario II
JOIN Item I ON II.item = I.id_item
--WHERE II.jogador = ?;

-- Consultar a quantidade total de um tipo específico de item no inventário de um jogador:
SELECT I.id_tipo, COUNT(*) as QuantidadeTotal
FROM Item_Inventario II
JOIN Item I ON II.item = I.id_item
--WHERE II.jogador = ? AND I.id_tipo = 'Arma'; -- ou qualquer outro tipo

-- consultar o id de um item_inventario específico
SELECT * FROM Item_Inventario (
    jogador int NOT NULL,
    item int NOT NULL,
    qtdd int NOT NULL,
    FOREIGN KEY (jogador) REFERENCES Jogador (id_jogador),
    FOREIGN KEY (item) REFERENCES Item (id_item)
);

-- Consulta Estoque de loja
SELECT I.nome AS NomeDoItem, I.id_tipo AS TipoDoItem, I.id_item AS IDItem, I.descricao AS DescricaoDoItem, I.preco, I.qtdd AS QuantidadeEmEstoque
FROM Item_Estoque_Loja IEL
JOIN Item I ON IEL.produto = I.id_item
WHERE IEL.loja = ?; -- Substituir ? pelo ID da loja desejada

-- consultar o id de um item_estoque_loja específico
SELECT * FROM Item_Estoque_Loja (
    produto int NOT NULL,
    loja int NOT NULL,
    preco int NOT NULL,
    FOREIGN KEY (produto) REFERENCES Item (id_item),
    FOREIGN KEY (loja) REFERENCES Loja (id_loja)
);


-- Consulta de instancia de monstro
SELECT M.id_monstro, M.nome AS NomeDoMonstro, M.descricao AS DescricaoDoMonstro, M.dano AS DanoDoMonstro, M.defesa AS DefesaDoMonstro, M.saude_maxima AS SaudeMaximaDoMonstro, IM.saude AS SaudeAtualDoMonstro
FROM Monstro M
JOIN Instancia_Monstro IM ON M.id_monstro = IM.monstro
WHERE IM.id_local_fechado = ?; -- Substituir ? pelo ID da instância do monstro com o qual o jogador está lutando, necessário replicar a consulta para cada monstro

-- consultar o id de um instancia_monstro específico
SELECT * FROM Instancia_Monstro (
    caverna int NOT NULL,
    monstro int NOT NULL,
    saude int NOT NULL,
    FOREIGN KEY (caverna) REFERENCES Local_Fechado (id_local_fechado),
    FOREIGN KEY (monstro) REFERENCES Monstro (id_monstro)
);





-- Consultas da tabela Jogador

-- Atualizar os atributos do jogador
-- atualizar local_jogador
-- atualizar regiao int NOT NULL,
-- atualizar estacao_atual int NOT NULL,
-- atualizar missao_atual int,
-- atualizar nome varchar(50) NOT NULL,
-- atualizar saude int NOT NULL,
-- atualizar energia int NOT NULL,
-- atualizar dia int NOT NULL,
-- atualizar qtdd_ouro int,

-- UPDATE Jogador SET local_jogador = 

