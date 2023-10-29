
-- Dados geral sobre o jogador
SELECT regiao, estacao_atual, missao_atual, nome, saude, energia, qtdd_ouro
FROM Jogador ;

-- Consultar todas as culturas da fazenda do jogador
SELECT * FROM Plantacoes WHERE id_fazenda = (SELECT id_fazenda FROM Fazendas WHERE id_jogador = ?);


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

-- Consulta Estoque de loja
SELECT I.nome AS NomeDoItem, I.id_tipo AS TipoDoItem, I.id_item AS IDItem, I.descricao AS DescricaoDoItem, I.preco, I.qtdd AS QuantidadeEmEstoque
FROM Item_Estoque_Loja IEL
JOIN Item I ON IEL.produto = I.id_item
WHERE IEL.loja = ?; -- Substituir ? pelo ID da loja desejada

-- Consulta de instancia de monstro
SELECT M.id_monstro, M.nome AS NomeDoMonstro, M.descricao AS DescricaoDoMonstro, M.dano AS DanoDoMonstro, M.defesa AS DefesaDoMonstro, M.saude_maxima AS SaudeMaximaDoMonstro, IM.saude AS SaudeAtualDoMonstro
FROM Monstro M
JOIN Instancia_Monstro IM ON M.id_monstro = IM.monstro
WHERE IM.id_local_fechado = ?; -- Substituir ? pelo ID da instância do monstro com o qual o jogador está lutando, necessário replicar a consulta para cada monstro
