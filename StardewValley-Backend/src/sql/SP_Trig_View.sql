BEGIN TRANSACTION;

\c stardew_valley

-- =======================================================================================
-- 01 - Eu como Banco de Dados gostaria de Atualizar os dados do novo jogador na tabela 
-- "Jogador" para Para iniciar o jogo 
-- =======================================================================================
-- atualizar dados do novo jogador, verificando se o jogador ja existe
CREATE OR REPLACE FUNCTION iniciar_jogo(
    novo_nome_jogador CHAR(50), 
    id_nova_regiao INT, 
    nome_cabana VARCHAR(50), 
    OUT jogo_iniciado BOOLEAN
) RETURNS BOOLEAN AS $$
DECLARE
    id_novo_jogador INT;
    id_nova_cabana INT;
    id_novo_local_fechado INT;
    id_tipo_local_fechado_consultado INT;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Jogador WHERE nome = novo_nome_jogador) THEN

        id_novo_jogador := (SELECT COALESCE(MAX(id_jogador), 0) FROM Jogador) + 1;
        id_novo_local_fechado := (SELECT COALESCE(MAX(id_local_fechado), 0) FROM Local_Fechado) + 1;

        SELECT id_tipo_local_fechado INTO id_tipo_local_fechado_consultado FROM Tipo_Local_Fechado 
               WHERE nome_tipo_local_fechado = 'cabana_jog';

        INSERT INTO Local_Fechado (id_local_fechado, id_tipo_local_fechado) 
                    VALUES (id_novo_local_fechado, id_tipo_local_fechado_consultado);

        INSERT INTO Jogador (id_jogador, nome, id_regiao, id_local_fechado)
                    VALUES (id_novo_jogador, novo_nome_jogador, id_nova_regiao, id_novo_local_fechado);

        INSERT INTO Cabana_Jogador (id_cabana_jog, id_prop_cab_jog, id_regiao, nome, descricao) 
                    VALUES (id_novo_local_fechado, id_novo_jogador, id_nova_regiao, 'Cabana ' || nome_cabana, 
                   'Cabana do jogador ' || novo_nome_jogador);

        INSERT INTO habilidade (id_jogador) VALUES (id_novo_jogador);

        INSERT INTO Item_Inventario (id_jogador, id_item, qtdd) 
                    SELECT id_novo_jogador, id_arma, 1 FROM Arma WHERE comeca_jogo_com = TRUE;

        INSERT INTO Item_Inventario (id_jogador, id_item, qtdd) 
                    SELECT id_novo_jogador, id_ferramenta, 1 FROM Ferramenta WHERE comeca_jogo_com = TRUE;

        jogo_iniciado := TRUE;

    ELSE
        jogo_iniciado := FALSE;
    END IF;


END;
$$ LANGUAGE plpgsql;
-- =======================================================================================

-- =======================================================================================
-- 25 - Eu como Jogador gostaria de Listar itens do inventário para Visualizar os itens 
-- que o jogador possui 
-- =======================================================================================

-- View para listar itens do inventário do jogador
CREATE OR REPLACE VIEW vw_item_inventario AS
SELECT
    ii.id_jogador as id,
    ii.id_item,
    ii.qtdd,
    ti.nome_tipo_item,
    CASE
        WHEN ti.nome_tipo_item = 'arma' THEN a.nome
        WHEN ti.nome_tipo_item = 'artesanato' THEN art.nome
        WHEN ti.nome_tipo_item = 'consumivel' THEN c.nome
        WHEN ti.nome_tipo_item = 'ferramenta' THEN f.nome
        WHEN ti.nome_tipo_item = 'vestimenta' THEN v.nome
    END AS nome,
    CASE
        WHEN ti.nome_tipo_item = 'arma' THEN a.descricao
        WHEN ti.nome_tipo_item = 'artesanato' THEN art.descricao
        WHEN ti.nome_tipo_item = 'consumivel' THEN c.descricao
        WHEN ti.nome_tipo_item = 'ferramenta' THEN f.descricao
        WHEN ti.nome_tipo_item = 'vestimenta' THEN v.descricao
    END AS descricao
FROM Item_Inventario ii
JOIN Item i ON ii.id_item = i.id_item
JOIN Tipo_Item ti ON i.id_tipo_item = ti.id_tipo_item
LEFT JOIN Arma a ON ti.nome_tipo_item = 'arma' AND i.id_item = a.id_arma
LEFT JOIN Artesanato art ON ti.nome_tipo_item = 'artesanato' AND i.id_item = art.id_artesanato
LEFT JOIN Consumivel c ON ti.nome_tipo_item = 'consumivel' AND i.id_item = c.id_consumivel
LEFT JOIN Ferramenta f ON ti.nome_tipo_item = 'ferramenta' AND i.id_item = f.id_ferramenta
LEFT JOIN Vestimenta v ON ti.nome_tipo_item = 'vestimenta' AND i.id_item = v.id_vestimenta;

-- SP
CREATE OR REPLACE FUNCTION sp_obter_inventario_jogador(sp_id_jogador INT)
RETURNS TABLE (
    id_jogador INT,
    id_item INT,
    qtdd INT,
    nome_tipo_item VARCHAR(20),
    nome VARCHAR(50),
    descricao VARCHAR(800)
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM vw_item_inventario WHERE id_jogador = $1;
END;
$$ LANGUAGE plpgsql;



COMMIT;