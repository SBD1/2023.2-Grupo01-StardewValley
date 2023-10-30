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

