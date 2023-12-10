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

        jogo_iniciado := TRUE;

    ELSE
        jogo_iniciado := FALSE;
    END IF;


END;
$$ LANGUAGE plpgsql;
-- =======================================================================================


COMMIT;