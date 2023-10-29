# Álgebra Relacional

## Dados Gerais Sobre Jogador

π regiao, estacao_atual, missao_atual, nome, saude, energia, qtdd_ouro (Jogador)

## Consultar todas as culturas da fazenda do jogador

σ id_fazenda = (π id_fazenda (σ id_jogador = ? (Fazendas))) |x| Plantacoes

## Dados sobre o inventário do jogador

π I.nome, II.qtdd (Item_Inventario |x| Item)

## Consultar habilidades

π id_tipo, COUNT(*) as QuantidadeTotal (Item_Inventario |x| Item)

## Consulta Estoque de Loja

π I.nome, I.id_tipo, I.id_item, I.descricao, I.preco, I.qtdd (Item_Estoque_Loja |x| Item)

## Consulta de instância de monstro

π M.id_monstro, M.nome, M.descricao, M.dano, M.defesa, M.saude_maxima, IM.saude (Monstro |x| Instancia_Monstro)
