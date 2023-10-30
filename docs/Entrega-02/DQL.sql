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


