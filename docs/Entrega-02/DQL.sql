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

BEGIN TRANSACTION;

-- consultar o id e a descricao de uma estacao específica
SELECT id_estacao, descricao 
FROM Estacao 
WHERE nome = 'Primavera';

-- consultar o id de um tipo de item específico
SELECT Item.id_item 
FROM Item, Tipo_Item
WHERE Item.id_tipo_item = Tipo_Item.id_tipo_item
      and Tipo_Item.nome_tipo_item = 'Semente';

-- consultar o id de um local fechado específico
SELECT Local_Fechado.id_local_fechado
FROM Local_Fechado, Tipo_Local_Fechado
WHERE Local_Fechado.id_local_fechado = Tipo_Local_Fechado.id_tipo_local_fechado
      and Tipo_Local_Fechado.nome_tipo_local_fechado  = 'Loja';

-- consultar o id de um mundo específico
SELECT id_mundo 
FROM Mundo 
WHERE nome = 'Fazenda';

-- consultar o id e a descricao de uma arma específica
SELECT id_arma, descricao 
FROM Arma 
WHERE nome = 'espada';

-- consultar a descricao, o dano e a finalidade de uma arma específica
SELECT descricao, dano, finalidade 
FROM Arma 
WHERE id_arma = 1;

-- consultar o id de um artesanato específico
SELECT id_artesanato, descricao 
FROM Artesanato 
WHERE nome = 'Espantalho';

-- consultar o id e a descricao de um consumivel específico
SELECT id_consumivel, descricao 
FROM Consumivel 
WHERE nome = 'Omelete';

-- consultar o id, valor e tipo de um efeito de um item específico 
SELECT id_efeito, tipo, valor 
FROM Efeito 
WHERE  id_item = 2;

-- consultar o id, a descricao e a finalidade de uma ferramenta específica
SELECT id_ferramenta, descricao, finalidade 
FROM Ferramenta 
WHERE nome = 'enxada';

-- consultar o id e a descricao de um vestimenta específico
SELECT id_vestimenta, descricao 
FROM Vestimenta 
WHERE nome = 'Vestido de Baile de Inverno';

-- consultar o id e as informações de um monstro específico
SELECT id_monstro, id_drop, dano, defesa, saude_maxima 
FROM Monstro 
WHERE nome = 'Serpente';

-- consultar o id e as informações de uma semente específica
SELECT Semente.id_semente, id_estacao, descricao, valor_venda, dias_para_crescer 
FROM Informacao_Semente, Semente 
WHERE Informacao_Semente.nome = 'Semente de Couve-flor' 
      and Semente.id_info_semente = Informacao_Semente.id_info_semente;

-- consultar o id e as informações de uma missao específica
SELECT id_missao, id_estacao, descricao 
FROM Missao 
WHERE nome = 'Plantando as Sementes';

-- consultar o id e o mundo de uma regiao específica
SELECT id_regiao, mundo 
FROM Regiao 
WHERE nome = 'Vila Pelicanos';

-- consultar o id e as informações de um NPC específico
SELECT id_npc, id_regiao, id_local_fechado, profissao 
FROM NPC 
WHERE nome = 'Willy';

-- consultar o id e as informações de uma caverna específica
SELECT id_local_fechado, id_regiao, descricao 
FROM Caverna 
WHERE nome = 'Caverna das Minhocas';

-- consultar o id e as informações de uma cabana_NPC específica
SELECT id_local_fechado, id_regiao, descricao 
FROM Cabana_NPC 
WHERE nome = 'Cabana de Robin';

-- consultar o id e as informações de uma loja específica
SELECT id_loja, id_npc, id_regiao, descricao 
FROM Loja 
WHERE nome = 'Loja de Linus';

-- consultar o id e as informações de um jogador específico
SELECT id_jogador, id_local_fechado, id_regiao, id_estacao, id_missao, saude, energia, dia, hora, qtdd_ouro 
FROM Jogador 
WHERE nome = 'Marcus';

-- consultar a receita de um artesanato específico
SELECT id_item, qtdd 
FROM Item_Receita, Artesanato
WHERE Item_Receita.id_artesanato = Artesanato.id_artesanato 
      and Artesanato.nome = 'Tear';

-- Consultar Habilidades
SELECT nivel_coleta, nivel_cultivo, nivel_mineracao, nivel_pesca, nivel_combate 
FROM Habilidade, Jogador 
WHERE Habilidade.id_jogador = Jogador.id_jogador and Habilidade.id_jogador = 2;

-- consultar o id e a fala de um dialogo específico
SELECT id_dialogo, fala 
FROM Dialogo, NPC 
WHERE NPC.id_npc = Dialogo.id_npc and NPC.nome = 'Marlon';

-- consultar o id e as informações de uma cabana_jogador específica
SELECT Cabana_Jogador.id_local_fechado, Cabana_Jogador.id_regiao, Cabana_Jogador.nome, Cabana_Jogador.descricao 
FROM Cabana_Jogador, Jogador 
WHERE Cabana_Jogador.id_jogador = Jogador.id_jogador and Jogador.nome = 'Zenilda';

-- consultar o id de um item_inventario específico
SELECT Item_Inventario.id_item, SUM(qtdd) as SomaQtdd
FROM Item_Inventario, Item
WHERE Item_Inventario.id_item = Item.id_item
      and id_jogador = 3
GROUP BY Item_Inventario.id_item;

-- consultar o id e as informações de um item_estoque_loja específico
SELECT Tipo_Item.nome_tipo_item, Item_Estoque_Loja.preco
FROM Item_Estoque_Loja, Tipo_Item, Item
WHERE Tipo_Item.id_tipo_item = Item.id_tipo_item  
      and Item.id_item = Item_Estoque_Loja.id_item
      and Item_Estoque_Loja.id_loja = 1;

-- consultar o id e as informações de uma instância de monstro específica
SELECT Instancia_Monstro.id_monstro, nome, descricao, id_drop, dano, defesa, saude_maxima, saude 
FROM Monstro, Instancia_Monstro
WHERE Monstro.id_monstro = Instancia_Monstro.id_monstro 
      and Instancia_Monstro.id_caverna = 2;

COMMIT;