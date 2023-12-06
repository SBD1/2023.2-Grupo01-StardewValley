-- ----------------------------------------------------------------------------------------
-- Histórico de versões
-- ----------------------------------------------------------------------------------------
-- Data Criacao ...........: 30/11/2023                                                  --
-- Autor(es) ..............: Zenilda Vieira                                              --
-- Versao ..............: 1.0                                                            --
-- Banco de Dados .........: PostgreSQL                                                  --
-- Descricao .........: Consultas, SP, Triggers, Views                                   --
-- ----------------------------------------------------------------------------------------
-- | Atualizacao : 04/12/2023 | Autor(es): Zenilda Vieira e Edilberto Cantuária        | --
--                            | Descricao: Inclusão de SPs, Triggers, Views e Consultas| --
-- ----------------------------------------------------------------------------------------


-- =============================================
-- Consultas, Store Procedures, Triggers e Views
-- =============================================


-- =======================================================================================
-- 01 - Eu como Banco de Dados gostaria de Atualizar os dados do novo jogador na tabela 
-- "Jogador" para Para iniciar o jogo 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

-- Consulta simples para atualizar dados do novo jogador
UPDATE Jogador
SET 
    id_local_fechado = 1, 
    id_regiao = 1,
    id_estacao = 1,
    id_missao = 1,
    nome = 'NomeJogador', 
    energia = 100,
    dia = 1,
    hora = 360, 
    qtdd_ouro = 500 
WHERE id_jogador = 1; 

-- atualizar dados do novo jogador, verificando se o jogador já existe
CREATE OR REPLACE FUNCTION iniciar_jogo(novo_nome_jogador CHAR(50))
RETURNS VOID AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Jogador WHERE nome = novo_nome_jogador) THEN
        INSERT INTO Jogador (nome, energia, qtdd_ouro, dia, hora, id_estacao, id_missao, id_regiao)
        VALUES (novo_nome_jogador, 100, 500, 1, 360, 1, 1, 1);
        RAISE NOTICE 'Jogo iniciado para o jogador %!', novo_nome_jogador;
    ELSE
        RAISE NOTICE 'O jogador % já existe. Não é necessário iniciar novamente.', novo_nome_jogador;
    END IF;
END;
$$ LANGUAGE plpgsql;



-- =======================================================================================
-- 02 - Eu como Jogador gostaria de Iniciar o dia automaticamente quando energia = 5% ou 
-- hora = 02 para Manter o progresso do jogo mesmo se o jogador não dormir 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

-- iniciar o dia automaticamente
CREATE OR REPLACE PROCEDURE IniciarDiaAutomaticamente()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Jogador
    SET 
        dia = dia + 1,
        hora = 360
    WHERE 
        energia <= 5 OR
        hora = 120;
END;
$$;

-- trigger para chamar a stored procedure quando necessário
CREATE OR REPLACE FUNCTION VerificarIniciarDia()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.energia <= 5 OR NEW.hora = 120 THEN
        PERFORM IniciarDiaAutomaticamente();
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerIniciarDia
BEFORE UPDATE ON Jogador
FOR EACH ROW
EXECUTE FUNCTION VerificarIniciarDia();

-- =======================================================================================
-- 03 - Eu como Banco de Dados gostaria de Atualizar dados do jogador após iniciar o dia 
-- automaticamente para Reiniciar o dia com energia = 100%, incrementar +1 no dia 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

-- reiniciar o dia automaticamente
CREATE OR REPLACE PROCEDURE ReiniciarDiaAutomaticamente()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Jogador
    SET 
        energia = 100,
        dia = dia + 1
    WHERE 
        TRUE;
END;
$$;

-- trigger para chamar a stored procedure quando necessário
CREATE OR REPLACE FUNCTION VerificarReiniciarDia()
RETURNS TRIGGER AS $$
BEGIN
     IF NEW.dia > OLD.dia THEN
        PERFORM ReiniciarDiaAutomaticamente();
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerReiniciarDia
BEFORE UPDATE ON Jogador
FOR EACH ROW
EXECUTE FUNCTION VerificarReiniciarDia();

-- =======================================================================================
-- 04 - Eu como Banco de Dados gostaria de Verificar se o dia chegou a 29 e reiniciar 
-- para dia 01 para Controlar o ciclo de dias e estações do jogo 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

-- verificar e reiniciar o ciclo de dias
CREATE OR REPLACE PROCEDURE VerificarReiniciarCicloDias()
LANGUAGE plpgsql
AS $$
BEGIN
    IF (SELECT MAX(dia) FROM Jogador) >= 29 THEN
        UPDATE Jogador
        SET dia = 1;
    END IF;
END;
$$;

-- trigger para chamar a stored procedure diariamente
CREATE OR REPLACE FUNCTION DispararVerificacaoReinicioCicloDias()
RETURNS TRIGGER AS $$
BEGIN
    PERFORM VerificarReiniciarCicloDias();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerVerificacaoReinicioCicloDias
BEFORE INSERT OR UPDATE ON Jogador
FOR EACH ROW
EXECUTE FUNCTION DispararVerificacaoReinicioCicloDias();


-- =======================================================================================
-- 05 - Eu como Banco de Dados gostaria de Atualizar a estação do jogador após reiniciar 
-- para dia 01 para Registrar a mudança de estação 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================

-- Trigger para atualizar a estação do jogador após reiniciar para o dia 01
CREATE OR REPLACE FUNCTION atualizar_estacao()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o dia atual é 29 ou superior (após o dia 28)
    IF NEW.dia >= 29 THEN
        -- Atualiza a estação para o próximo ciclo (de 1 a 4)
        NEW.id_estacao = (NEW.id_estacao % 4) + 1;
        -- Atualiza o dia para 01
        NEW.dia = 1;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER reiniciar_jogo
BEFORE UPDATE ON Jogador
FOR EACH ROW
EXECUTE FUNCTION atualizar_estacao();

-- Stored Procedure para reiniciar o jogo
CREATE OR REPLACE PROCEDURE reiniciar_jogo_procedure(jogador_id INT)
AS $$
DECLARE
    jogador_rec Jogador%ROWTYPE;
BEGIN
    -- Obtém o jogador pelo ID
    SELECT * INTO jogador_rec FROM Jogador WHERE id_jogador = jogador_id;

    -- Chama a trigger para atualizar a estação
    PERFORM atualizar_estacao() FROM jogador_rec;
  
    -- Atualiza o jogador
    UPDATE Jogador SET 
        id_estacao = jogador_rec.id_estacao,
        dia = jogador_rec.dia
    WHERE id_jogador = jogador_id;
END;
$$ LANGUAGE plpgsql;

-- View para informações do jogador com nome da estação
CREATE OR REPLACE VIEW jogador_info AS
SELECT 
    j.id_jogador,
    j.nome,
    e.nome AS estacao,
    j.saude,
    j.energia,
    j.dia,
    j.hora,
    j.qtdd_ouro
FROM Jogador j
JOIN Estacao e ON j.id_estacao = e.id_estacao;


-- =======================================================================================
-- 06 - Eu como Banco de Dados gostaria de Apagar todas as linhas da tabela Plantacao 
-- ao mudar a estação para Limpar a tabela de plantações ao iniciar nova estação 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================

-- Trigger para apagar todas as linhas da tabela Plantacao ao mudar a estação
CREATE OR REPLACE FUNCTION LimparPlantacao()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se a estação foi alterada
    IF NEW.id_estacao <> OLD.id_estacao THEN
        -- Chama a stored procedure para iniciar nova estação
        PERFORM IniciarNovaEstacao(NEW.id_jogador, NEW.id_estacao);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criação da Trigger
CREATE TRIGGER LimparPlantacaoTrigger
AFTER UPDATE ON Jogador
FOR EACH ROW
EXECUTE FUNCTION LimparPlantacao();

-- Stored Procedure para iniciar nova estação
CREATE OR REPLACE PROCEDURE IniciarNovaEstacao(in_id_jogador INT, in_nova_estacao INT)
AS $$
BEGIN
    -- Atualiza a estação do jogador
    UPDATE Jogador
    SET id_estacao = in_nova_estacao
    WHERE id_jogador = in_id_jogador;
    
    -- Apaga todas as linhas da tabela Plantacao relacionadas ao jogador
    DELETE FROM Plantacao
    WHERE id_jogador = in_id_jogador;
END;
$$ LANGUAGE plpgsql;

-- View para obter informações da tabela Plantacao
CREATE OR REPLACE VIEW InformacoesPlantacao AS
SELECT *
FROM Plantacao;



-- =======================================================================================
-- 07 - Eu como Banco de Dados gostaria de Verificar se há plantações prontas para colher 
-- para Identificar e recompensar o jogador por plantações prontas 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================

-- Trigger para verificar e recompensar o jogador por plantações prontas
CREATE OR REPLACE FUNCTION verificar_colheita() RETURNS TRIGGER AS $$
BEGIN
    -- Verificar plantações prontas para colher
    UPDATE Jogador SET qtdd_ouro = qtdd_ouro + (SELECT COUNT(*) * valor_venda 
                                                 FROM Semente 
                                                 WHERE id_estacao = NEW.id_estacao 
                                                 AND dias_para_crescer <= NEW.dia - OLD.dia 
                                                 AND NEW.dia >= dias_para_crescer) 
    WHERE id_jogador = NEW.id_jogador;

    -- Retornar a linha atualizada
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para acionar a função ao atualizar o dia do jogador
CREATE TRIGGER trigger_verificar_colheita
AFTER UPDATE OF dia ON Jogador
FOR EACH ROW
EXECUTE FUNCTION verificar_colheita();

-- Stored Procedure para recompensar manualmente por plantações prontas
CREATE OR REPLACE FUNCTION recompensar_por_colheita(jogador_id INT) RETURNS VOID AS $$
BEGIN
    -- Verificar plantações prontas para colher
    UPDATE Jogador SET qtdd_ouro = qtdd_ouro + (SELECT COUNT(*) * valor_venda 
                                                 FROM Semente 
                                                 WHERE id_estacao = Jogador.id_estacao 
                                                 AND dias_para_crescer <= Jogador.dia
                                                 AND Jogador.dia >= dias_para_crescer) 
    WHERE id_jogador = jogador_id;
END;
$$ LANGUAGE plpgsql;

-- View que mostra as plantações prontas para colher
CREATE OR REPLACE VIEW Plantacoes_Prontas AS
SELECT Jogador.id_jogador, Jogador.nome AS jogador_nome, Semente.nome AS semente_nome, Semente.descricao AS semente_descricao
FROM Jogador
JOIN Semente ON Jogador.id_estacao = Semente.id_estacao
WHERE Jogador.dia >= Semente.dias_para_crescer;


-- =======================================================================================

-- 08 - Eu como Banco de Dados gostaria de Atualizar inventário após colher plantações 
-- para Registrar itens obtidos com a colheita de plantações 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================



-- =======================================================================================
-- 09 - Eu como Banco de Dados gostaria de Seta energia para 100% novamente após colher 
-- plantações para Garantir que o jogador esteja pronto para novas atividades 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================



-- =======================================================================================
-- 10 - Eu como Banco de Dados gostaria de Atualizar o horário com base no tempo jogado 
-- para Registrar a passagem do tempo durante o dia 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================



-- =======================================================================================
-- 11 - Eu como Jogador gostaria de Visualizar itens consumíveis disponíveis com efeitos 
-- para Conferir opções de itens para consumo e seus efeitos 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Exemplo de consulta para visualizar itens consumíveis com efeitos
SELECT
    i.id_item,
    i.nome AS nome_item,
    i.descricao AS descricao_item,
    e.nome AS nome_efeito,
    e.descricao AS descricao_efeito
FROM
    Item i
JOIN
    Item_Efeito ie ON i.id_item = ie.id_item
JOIN
    Efeito e ON ie.id_efeito = e.id_efeito
WHERE
    i.id_tipo_item = (SELECT id_tipo_item FROM Tipo_Item WHERE nome_tipo_item = 'consumivel');



-- =======================================================================================
-- 12 - Eu como Jogador gostaria de Escolher item consumível para comer efeito para 
-- Aumentar ou decrementar energia do jogador 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Criação da Stored Procedure
CREATE OR REPLACE FUNCTION consumir_item_consumivel(
    p_id_jogador INT,
    p_id_item_consumivel INT
)
RETURNS VOID AS $$
DECLARE
    v_energia_modificacao INT;
BEGIN
    -- Obtém o efeito do item consumível
    SELECT
        e.valor_modificacao
    INTO
        v_energia_modificacao
    FROM
        Item i
    JOIN
        Item_Efeito ie ON i.id_item = ie.id_item
    JOIN
        Efeito e ON ie.id_efeito = e.id_efeito
    WHERE
        i.id_item = p_id_item_consumivel;

    -- Atualiza a energia do jogador
    UPDATE
        Jogador
    SET
        energia = LEAST(100, GREATEST(0, energia + v_energia_modificacao))
    WHERE
        id_jogador = p_id_jogador;

    -- Remove o item consumível do inventário do jogador
    DELETE FROM
        Item_Inventario
    WHERE
        id_jogador = p_id_jogador
        AND id_item = p_id_item_consumivel;

    -- Commit da transação
    COMMIT;
END;
$$ LANGUAGE plpgsql;

-- =======================================================================================
-- 13 - Eu como Jogador gostaria de Visualizar aviso para ir dormir quando a hora é 0 
-- para Receber alerta para dormir e manter o ciclo do jogo 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

CREATE OR REPLACE FUNCTION verificar_hora_e_exibir_aviso()
RETURNS TRIGGER AS $$
BEGIN
    IF EXTRACT(HOUR FROM NEW.hora) = 0 AND EXTRACT(MINUTE FROM NEW.hora) = 0 THEN
        RAISE NOTICE 'Hora de ir dormir!'; 
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER verificar_hora_trigger
AFTER INSERT OR UPDATE
ON Jogador
FOR EACH ROW
EXECUTE FUNCTION verificar_hora_e_exibir_aviso();

-- =======================================================================================
-- 14 - Eu como Jogador gostaria de Decidir ir dormir ou comer quando energia atinge 10% 
-- para Escolher entre ir dormir ou comer para recuperar energia 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- decidir entre ir dormir ou comer
CREATE OR REPLACE FUNCTION decidir_dormir_ou_comer(id_jogador_param INT)
RETURNS VOID AS $$
DECLARE
    energia_jogador INT;
    escolha CHAR(1);
BEGIN
    SELECT energia INTO energia_jogador FROM jogador WHERE id_jogador = id_jogador_param;

    IF energia_jogador <= 10 THEN
        RAISE NOTICE 'Sua energia está baixa!';

        RAISE NOTICE 'Escolha "D" para ir dormir ou "C" para comer:';
 
        escolha := 'C'; -
        CASE escolha
            WHEN 'D' THEN
                RAISE NOTICE 'Indo dormir...';
            WHEN 'C' THEN
                RAISE NOTICE 'Escolhendo consumível para comer...';

                UPDATE jogador SET energia = 100 WHERE id_jogador = id_jogador_param;

                RAISE NOTICE 'Consumível consumido! Energia recuperada.';
            ELSE
                RAISE NOTICE 'Escolha inválida.';
        END CASE;
    END IF;
END;
$$ LANGUAGE plpgsql;


-- =======================================================================================
-- 15 - Eu como Jogador gostaria de Inicializar o jogo para Poder começar a jogar, 
-- verificando se eu já tenho meu nome na tabela jogador 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

-- inicializar o jogo
CREATE OR REPLACE FUNCTION inicializar_jogo(nome_jogador_param CHAR(50))
RETURNS VOID AS $$
DECLARE
    jogador_existente BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM jogador WHERE nome = nome_jogador_param) INTO jogador_existente;

     IF NOT jogador_existente THEN
        INSERT INTO jogador (nome, energia, qtdd_ouro) VALUES (nome_jogador_param, 100, 0);
        RAISE NOTICE 'Jogador inicializado com sucesso!';
    ELSE
        RAISE NOTICE 'Bem-vindo de volta, %!', nome_jogador_param;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- =======================================================================================
-- 16 - Eu como Banco de Dados gostaria de Atualizar os dados do novo jogador na tabela 
-- "Jogador" para Para iniciar o jogo 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

-- Consulta simples para atualizar dados do novo jogador
UPDATE Jogador
SET 
    id_local_fechado = 1, 
    id_regiao = 1,
    id_estacao = 1,
    id_missao = 1,
    nome = 'NomeJogador', 
    energia = 100,
    dia = 1,
    hora = 360, 
    qtdd_ouro = 500 
WHERE id_jogador = 1; 

-- atualizar dados do novo jogador, verificando se o jogador já existe
CREATE OR REPLACE FUNCTION iniciar_jogo(novo_nome_jogador CHAR(50))
RETURNS VOID AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Jogador WHERE nome = novo_nome_jogador) THEN
        INSERT INTO Jogador (nome, energia, qtdd_ouro, dia, hora, id_estacao, id_missao, id_regiao)
        VALUES (novo_nome_jogador, 100, 500, 1, 360, 1, 1, 1);
        RAISE NOTICE 'Jogo iniciado para o jogador %!', novo_nome_jogador;
    ELSE
        RAISE NOTICE 'O jogador % já existe. Não é necessário iniciar novamente.', novo_nome_jogador;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- =======================================================================================
-- 17 - Eu como Jogador gostaria de Escolher um mundo para Explorar diferentes ambientes 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

-- listar os mundos disponíveis
SELECT id_mundo, nome, descricao
FROM mundo;



-- =======================================================================================
-- 18 - Eu como Banco de Dados gostaria de Inserir dados do mundo escolhido na tabela 
-- "Mundo" para Registrar a escolha do jogador 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================



-- =======================================================================================
-- 19 - Eu como Jogador gostaria de Escolher uma região para Explorar diferentes áreas 
-- no mundo escolhido 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================



-- =======================================================================================
-- 20 - Eu como Banco de Dados gostaria de Inserir dados da região escolhida na tabela 
-- "Região join Mundo" para Registrar a escolha do jogador 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================



-- =======================================================================================
-- 21 - Eu como Banco de Dados gostaria de Inserir nova linha na tabela "Jogador" para 
-- Registrar o novo jogador 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================

CREATE OR REPLACE PROCEDURE AdicionarNovoJogador(
    nome_jogador CHAR(50),
    energia INT,
    qtdd_ouro INT,
    dia INT,
    hora INT,
    id_estacao INT,
    id_missao INT,
    id_regiao INT
)
AS $$
BEGIN
    -- Inserir um novo jogador
    INSERT INTO Jogador (nome, energia, qtdd_ouro, dia, hora, id_estacao, id_missao, id_regiao)
    VALUES (nome_jogador, energia, qtdd_ouro, dia, hora, id_estacao, id_missao, id_regiao);
END;
$$ LANGUAGE plpgsql;


-- =======================================================================================
-- 22 - Eu como Banco de Dados gostaria de Inserir nova linha na tabela "Habilidade" 
-- para Registrar as habilidades do novo jogador 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================

CREATE OR REPLACE PROCEDURE AdicionarHabilidadesIniciais(jogador_id INT)
AS $$
BEGIN
    -- Inserir habilidades iniciais para o jogador
    INSERT INTO Habilidade (id_jogador, nivel_coleta, nivel_cultivo, nivel_mineracao, nivel_pesca, nivel_combate)
    VALUES (jogador_id, 1, 1, 1, 1, 1);
END;
$$ LANGUAGE plpgsql;


-- =======================================================================================
-- 23 - Eu como Banco de Dados gostaria de Inserir linhas na tabela "Item-Inventário" 
-- para Registrar os itens iniciais do jogador 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================

CREATE OR REPLACE PROCEDURE AdicionarItensIniciaisInventario(jogador_id INT)
AS $$
BEGIN
    -- Inserir itens iniciais no inventário do jogador
    INSERT INTO Item_Inventario (id_jogador, id_item, qtdd)
    VALUES (jogador_id, 1, 1),
           (jogador_id, 2, 1);
END;
$$ LANGUAGE plpgsql;

-- TRIGGER PARA AUTOMATIZAR PROCESSOS 21 - 23

CREATE TRIGGER AdicionarNovoJogadorTrigger
AFTER INSERT ON Jogador
FOR EACH ROW
EXECUTE PROCEDURE AdicionarHabilidadesEItens();

CREATE OR REPLACE FUNCTION AdicionarHabilidadesEItens()
RETURNS TRIGGER AS $$
BEGIN
    -- Chama a stored procedure para adicionar habilidades iniciais
    CALL AdicionarHabilidadesIniciais(NEW.id_jogador);

    -- Chama a stored procedure para adicionar itens iniciais no inventário
    CALL AdicionarItensIniciaisInventario(NEW.id_jogador);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



-- =======================================================================================
-- 24 - Eu como Jogador gostaria de Verificar status do jogador para Conferir energia, 
-- quantidade de ouro e níveis de habilidade 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- View para verificar o status do jogador
CREATE OR REPLACE VIEW StatusJogador AS
SELECT
    j.id_jogador,
    j.nome,
    j.energia,
    j.ouro,
    h.nivel_coleta,
    h.nivel_cultivo,
    h.nivel_mineracao,
    h.nivel_pesca,
    h.nivel_combate
FROM
    Jogador j
JOIN
    Habilidade h ON j.id_jogador = h.id_jogador;


-- =======================================================================================
-- 25 - Eu como Jogador gostaria de Listar itens do inventário para Visualizar os itens 
-- que o jogador possui 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- View para listar itens do inventário do jogador
CREATE OR REPLACE VIEW ItensInventario AS
SELECT
    ii.id_jogador,
    ii.id_item,
    i.nome AS nome_item,
    ii.qtdd
FROM
    Item_Inventario ii
JOIN
    Item i ON ii.id_item = i.id_item;



-- =======================================================================================
-- 26 - Eu como Jogador gostaria de Confirmar mudança de região para Prosseguir para a 
-- próxima região 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Confirmar mudança de região
CREATE OR REPLACE FUNCTION ConfirmarMudancaRegiao(p_id_jogador INT, p_nova_regiao INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Jogador SET id_regiao = p_nova_regiao WHERE id_jogador = p_id_jogador;
END;
$$ LANGUAGE plpgsql;



-- =======================================================================================
-- 27 - Eu como Jogador gostaria de Inicializar o jogo para Poder começar a jogar 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

-- inicializar o jogo
CREATE OR REPLACE FUNCTION inicializar_jogo(nome_jogador_param CHAR(50))
RETURNS VOID AS $$
DECLARE
    jogador_existente BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM jogador WHERE nome = nome_jogador_param) INTO jogador_existente;

     IF NOT jogador_existente THEN
        INSERT INTO jogador (nome, energia, qtdd_ouro) VALUES (nome_jogador_param, 100, 0);
        RAISE NOTICE 'Jogador inicializado com sucesso!';
    ELSE
        RAISE NOTICE 'Bem-vindo de volta, %!', nome_jogador_param;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- =======================================================================================
-- 28 - Eu como Banco de Dados gostaria de Atualizar os dados do novo jogador na tabela 
-- "Jogador" para Para iniciar o jogo 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

-- Consulta simples para atualizar dados do novo jogador
UPDATE Jogador
SET 
    id_local_fechado = 1, 
    id_regiao = 1,
    id_estacao = 1,
    id_missao = 1,
    nome = 'NomeJogador', 
    energia = 100,
    dia = 1,
    hora = 360, 
    qtdd_ouro = 500 
WHERE id_jogador = 1; 

-- atualizar dados do novo jogador, verificando se o jogador já existe
CREATE OR REPLACE FUNCTION iniciar_jogo(novo_nome_jogador CHAR(50))
RETURNS VOID AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Jogador WHERE nome = novo_nome_jogador) THEN
        INSERT INTO Jogador (nome, energia, qtdd_ouro, dia, hora, id_estacao, id_missao, id_regiao)
        VALUES (novo_nome_jogador, 100, 500, 1, 360, 1, 1, 1);
        RAISE NOTICE 'Jogo iniciado para o jogador %!', novo_nome_jogador;
    ELSE
        RAISE NOTICE 'O jogador % já existe. Não é necessário iniciar novamente.', novo_nome_jogador;
    END IF;
END;
$$ LANGUAGE plpgsql;


-- =======================================================================================
-- 29 - Eu como Jogador gostaria de Visualizar status do jogo para Conferir região, 
-- estação, dia e hora 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

-- Criação da View para Visualizar status do jogo
CREATE OR REPLACE VIEW StatusDoJogo AS
SELECT
    j.nome AS nome_jogador,
    r.nome AS nome_regiao,
    e.nome AS nome_estacao,
    mj.dia,
    mj.hora
FROM
    Jogador j
JOIN Mundo m ON j.id_mundo = m.id_mundo
JOIN Regiao r ON j.id_regiao = r.id_regiao
JOIN Estacao e ON m.id_estacao = e.id_estacao;

-- =======================================================================================
-- 30 - Eu como Jogador gostaria de Visualizar status do jogador para Conferir energia, 
-- quantidade de ouro e níveis de habilidade 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

-- Criação da View para Visualizar status do jogador
CREATE OR REPLACE VIEW StatusJogador AS
SELECT
    j.id_jogador,
    j.nome AS nome_jogador,
    j.energia,
    j.qtdd_ouro,
    h.nivel_coleta,
    h.nivel_cultivo,
    h.nivel_mineracao,
    h.nivel_pesca,
    h.nivel_combate
FROM
    Jogador j
JOIN Habilidade h ON j.id_jogador = h.id_jogador;


-- =======================================================================================
-- 31 - Eu como Jogador gostaria de Explorar descrição da região para Conhecer os 
-- locais fechados disponíveis 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================



-- =======================================================================================
-- 32 - Eu como Jogador gostaria de Realizar coleta para Coletar itens na região 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================



-- =======================================================================================
-- 33 - Eu como Banco de Dados gostaria de Registrar coleta na tabela "Item-Inventário" 
-- para Atualizar inventário do jogador 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================



-- =======================================================================================
-- 34 - Eu como Jogador gostaria de Realizar plantação para Plantar sementes na região 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================



-- =======================================================================================
-- 35 - Eu como Banco de Dados gostaria de Registrar plantação na tabela "Plantacao" 
-- para Atualizar dados de plantação do jogador 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================



-- =======================================================================================
-- 36 - Eu como Jogador gostaria de Realizar pesca para Pescar itens na região 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================



-- =======================================================================================
-- 37 - Eu como Banco de Dados gostaria de Registrar pesca na tabela "Item_Inventario" 
-- para Atualizar inventário do jogador com itens pescados 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================



-- =======================================================================================
-- 38 - Eu como Jogador gostaria de Realizar crafting para Craftar itens com receitas 
-- disponíveis 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================



-- =======================================================================================
-- 39 - Eu como Banco de Dados gostaria de Atualizar inventário após crafting para 
-- Registrar itens craftados no inventário do jogador 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================



-- =======================================================================================
-- 40 - Eu como Jogador gostaria de Conversar com NPC para Interagir com NPCs na região 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================



-- =======================================================================================
-- 41 - Eu como Jogador gostaria de Realizar ações de combate para Explorar 
-- cavernas ou locais de combate na região 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Combate na Caverna
CREATE OR REPLACE PROCEDURE enfrentar_monstros(
    IN p_id_jogador INT,
    IN p_id_caverna INT
)
AS $$
DECLARE
    v_energia_jogador INT;
    v_energia_monstro INT;
    v_dano_jogador INT;
    v_dano_monstro INT;
    v_id_drop INT;
BEGIN
    SELECT energia INTO v_energia_jogador
    FROM Jogador
    WHERE id_jogador = p_id_jogador;

    SELECT energia, id_drop INTO v_energia_monstro, v_id_drop
    FROM Instancia_Monstro
    WHERE id_caverna = p_id_caverna;

    WHILE v_energia_jogador > 0 AND v_energia_monstro > 0 LOOP
        v_dano_jogador := FLOOR(RANDOM() * 10) + 1;
        v_energia_monstro := GREATEST(v_energia_monstro - v_dano_jogador, 0);

        IF v_energia_monstro = 0 THEN
            INSERT INTO Item_Inventario (id_jogador, id_item, quantidade)
            VALUES (p_id_jogador, v_id_drop, 1)
            ON CONFLICT (id_jogador, id_item)
            DO UPDATE SET quantidade = Item_Inventario.quantidade + 1;

            DELETE FROM Instancia_Monstro WHERE id_caverna = p_id_caverna;
        ELSE
            v_dano_monstro := FLOOR(RANDOM() * 8) + 1; 

            v_energia_jogador := GREATEST(v_energia_jogador - v_dano_monstro, 0);
        END IF;
    END LOOP;

    UPDATE Jogador
    SET energia = v_energia_jogador
    WHERE id_jogador = p_id_jogador;

END;
$$ LANGUAGE plpgsql;

-- =======================================================================================
-- 41.1 - Eu como Jogador gostaria de Realizar ações de mineração para Explorar 
-- cavernas ou locais de combate na região 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Mineração
CREATE OR REPLACE PROCEDURE realizar_mineracao(
    IN jogador_id INT,
    IN local_fechado_id INT
)
AS $$
DECLARE
    jogador_vida INT;
    mineraveis_disponiveis INT;
    item_minerado_id INT;
BEGIN
    SELECT energia INTO jogador_vida FROM Jogador WHERE id_jogador = jogador_id;

    SELECT COUNT(*) INTO mineraveis_disponiveis
    FROM Consumivel
    WHERE id_local_fechado = local_fechado_id;

    IF mineraveis_disponiveis > 0 THEN
        SELECT id_consumivel INTO item_minerado_id
        FROM Consumivel
        WHERE id_local_fechado = local_fechado_id
        ORDER BY RANDOM()
        LIMIT 1;

        INSERT INTO Item_Inventario (id_jogador, id_item)
        VALUES (jogador_id, item_minerado_id);

        DELETE FROM Consumivel
        WHERE id_consumivel = item_minerado_id;

        UPDATE Jogador SET energia = jogador_vida - 5 WHERE id_jogador = jogador_id;

    ELSE
        RAISE EXCEPTION 'Não há itens mineráveis disponíveis neste local fechado.';
    END IF;
END;
$$ LANGUAGE plpgsql;


-- =======================================================================================
-- 42 - Eu como Banco de Dados gostaria de Atualizar local_fechado na tabela "Jogador" 
-- para Registrar mudança para caverna ou local de combate 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Atualizar Local Fechado do Jogador
CREATE OR REPLACE PROCEDURE atualizar_local_fechado(
    IN jogador_id INT,
    IN novo_local_fechado_id INT
)
AS $$
BEGIN
    UPDATE Jogador
    SET local_fechado = novo_local_fechado_id
    WHERE id_jogador = jogador_id;

END;
$$ LANGUAGE plpgsql;



-- =======================================================================================
-- 43 - Eu como Jogador gostaria de Acessar local fechado na região para Explorar locais 
-- fechados disponíveis na região 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- explorar Locais Fechados da Região
SELECT LF.id_local_fechado, LF.nome AS nome_local_fechado, LF.descricao AS descricao_local_fechado
FROM Regiao R
JOIN Local_Fechado LF ON R.id_regiao = LF.id_regiao
WHERE R.nome = 'Nome da Região'; 


-- =======================================================================================
-- 44 - Eu como Banco de Dados gostaria de Atualizar local_fechado na tabela "Jogador" 
-- para Registrar escolha do local fechado 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Atualizar Local Fechado do Jogador
CREATE OR REPLACE PROCEDURE atualizar_local_fechado(
    IN jogador_id INT,
    IN novo_local_fechado_id INT
)
AS $$
BEGIN
    UPDATE Jogador
    SET local_fechado = novo_local_fechado_id
    WHERE id_jogador = jogador_id;

END;
$$ LANGUAGE plpgsql;

-- =======================================================================================
-- 45 - Eu como Jogador gostaria de Mudar de região para Explorar outras regiões disponíveis 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Confirmar mudança de região
CREATE OR REPLACE FUNCTION ConfirmarMudancaRegiao(p_id_jogador INT, p_nova_regiao INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Jogador SET id_regiao = p_nova_regiao WHERE id_jogador = p_id_jogador;
END;
$$ LANGUAGE plpgsql;


-- =======================================================================================
-- 46 - Eu como Jogador gostaria de Visualizar status do jogo: região, estação, dia e hora 
-- para Acompanhar o contexto do jogo 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

-- Criação da View para Visualizar status do jogo
CREATE OR REPLACE VIEW StatusDoJogo AS
SELECT
    j.nome AS nome_jogador,
    r.nome AS nome_regiao,
    e.nome AS nome_estacao,
    mj.dia,
    mj.hora
FROM
    Jogador j
JOIN Mundo m ON j.id_mundo = m.id_mundo
JOIN Regiao r ON j.id_regiao = r.id_regiao
JOIN Estacao e ON m.id_estacao = e.id_estacao;

-- =======================================================================================
-- 47 - Eu como Jogador gostaria de Visualizar status do jogador: energia, qtdd-ouro, 
-- níveis de habilidade para Conferir meu progresso e recursos disponíveis 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

-- View para verificar o status do jogador
CREATE OR REPLACE VIEW StatusJogador AS
SELECT
    j.id_jogador,
    j.nome,
    j.energia,
    j.qtdd_ouro,
    h.nivel_coleta,
    h.nivel_cultivo,
    h.nivel_mineracao,
    h.nivel_pesca,
    h.nivel_combate
FROM
    Jogador j
JOIN
    Habilidade h ON j.id_jogador = h.id_jogador;


-- =======================================================================================
-- 48 - Eu como Jogador gostaria de Visualizar descrição da região atual e do local 
-- fechado para Entender o ambiente em que estou 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

-- Descrição da Região Atual e do Local Fechado
SELECT R.nome AS nome_regiao, R.descricao AS descricao_regiao,
       LF.nome AS nome_local_fechado, LF.descricao AS descricao_local_fechado
FROM Jogador J
JOIN Regiao R ON J.id_regiao = R.id_regiao
LEFT JOIN Local_Fechado LF ON J.id_local_fechado = LF.id_local_fechado
WHERE J.id_jogador = 1; 

-- =======================================================================================
-- 49 - Eu como Jogador gostaria de Escolher ação a ser realizada no local fechado para 
-- Interagir com o ambiente e realizar atividades específicas 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

CREATE OR REPLACE FUNCTION RealizarAtividadeLocalFechado(
    jogador_id INT,
    acao_escolhida VARCHAR(50) 
)
RETURNS VOID AS $$
BEGIN
    IF acao_escolhida = 'Coletar' THEN

    ELSIF acao_escolhida = 'Plantar' THEN

    ELSE
        RAISE EXCEPTION 'Ação desconhecida: %', acao_escolhida;
    END IF;
END;
$$ LANGUAGE plpgsql;


-- =======================================================================================
-- 50 - Eu como Jogador gostaria de Na loja, visualizar o estoque para compras para 
-- Conferir itens disponíveis para compra 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

SELECT
    iel.id_item_estoque_loja,
    i.nome AS nome_item,
    iel.preco
FROM
    Item_Estoque_Loja iel
JOIN
    Item i ON iel.id_item = i.id_item
WHERE
    iel.id_loja = 1; 


-- =======================================================================================
-- 51 - Eu como Jogador gostaria de Na loja, escolher itens para comprar e dizer a quantidade 
-- para Adquirir itens necessários 
-- Observações: 
-- Autor: Edilberto Cantuária
-- =======================================================================================

-- Comprar Itens na Loja
CREATE OR REPLACE FUNCTION comprar_itens_na_loja(
    jogador_id INT,
    loja_id INT,
    item_id INT,
    quantidade INT
) RETURNS VOID AS
$$
DECLARE
    preco_item INT;
    ouro_jogador INT;
BEGIN
    SELECT preco
    INTO preco_item
    FROM Item_Estoque_Loja
    WHERE id_loja = loja_id
    AND id_item = item_id;

    SELECT qtdd_ouro
    INTO ouro_jogador
    FROM Jogador
    WHERE id_jogador = jogador_id;

    IF ouro_jogador >= preco_item * quantidade THEN
        UPDATE Jogador
        SET qtdd_ouro = ouro_jogador - preco_item * quantidade
        WHERE id_jogador = jogador_id;

        INSERT INTO Item_Inventario (id_jogador, id_item, quantidade)
        VALUES (jogador_id, item_id, quantidade);

        RAISE NOTICE 'Compra realizada com sucesso!';
    ELSE
        RAISE EXCEPTION 'O jogador não possui ouro suficiente para realizar a compra.';
    END IF;
END;
$$
LANGUAGE plpgsql;



-- =======================================================================================
-- 52 - Eu como Banco de Dados gostaria de Verificar se jogador possui ouro suficiente 
-- para compra para Garantir que o jogador tem recursos necessários 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================



-- =======================================================================================
-- 53 - Eu como Banco de Dados gostaria de Atualizar inventário após compra para Registrar 
-- itens adquiridos no inventário 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================



-- =======================================================================================
-- 54 - Eu como Banco de Dados gostaria de Atualizar estoque da loja após compra para 
-- Atualizar quantidade de itens no estoque da loja 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================



-- =======================================================================================
-- 55 - Eu como Jogador gostaria de Escolher ação na caverna (minerar, combater, sair) 
-- para Participar de atividades específicas na caverna 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================



-- =======================================================================================
-- 56 - Eu como Jogador gostaria de Na caverna, visualizar itens disponíveis para 
-- mineração para Conferir recursos disponíveis para mineração 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================



-- =======================================================================================
-- 57 - Eu como Jogador gostaria de Na caverna, participar da mineração para Adquirir 
-- itens ao realizar a mineração 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================



-- =======================================================================================
-- 58 - Eu como Banco de Dados gostaria de Atualizar inventário após mineração para 
-- Registrar itens minerados no inventário 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================

-- Atualizar o inventário do jogador após a mineração
CREATE OR REPLACE PROCEDURE AtualizarInventarioAposMineracao(
    jogador_id INT, 
    item_minerado_id INT, 
    quantidade INT
)
AS $$
BEGIN
    INSERT INTO Item_Inventario (id_jogador, id_item, qtdd)
    VALUES (jogador_id, item_minerado_id, quantidade)
    ON CONFLICT (id_jogador, id_item)
    DO UPDATE SET qtdd = Item_Inventario.qtdd + quantidade;
END;
$$ LANGUAGE plpgsql;


-- =======================================================================================
-- 59 - Eu como Banco de Dados gostaria de Incrementar habilidade de mineração após 
-- mineração para Melhorar habilidade de mineração do jogador 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================

-- Incrementar a habilidade de mineração do jogador após a mineração
CREATE OR REPLACE PROCEDURE IncrementarHabilidadeMineracao(
    jogador_id INT
)
AS $$
BEGIN
    UPDATE Habilidade
    SET nivel_mineracao = nivel_mineracao + 1
    WHERE id_jogador = jogador_id;
END;
$$ LANGUAGE plpgsql;


-- =======================================================================================
-- 60 - Eu como Jogador gostaria de Escolher ação de combate na caverna para Participar 
-- de combates contra monstros na caverna 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================



-- =======================================================================================
-- 61 - Eu como Jogador gostaria de Na caverna, visualizar monstros disponíveis para 
-- combate para Conferir instâncias de monstros na caverna 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================



-- =======================================================================================
-- 62 - Eu como Jogador gostaria de Na caverna, participar do combate para Enfrentar 
-- monstros e obter recompensas 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================



-- =======================================================================================
-- 63 - Eu como Banco de Dados gostaria de Atualizar inventário após combate para 
-- Registrar itens obtidos no inventário após o combate 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================



-- =======================================================================================
-- 64 - Eu como Banco de Dados gostaria de Incrementar habilidade de combate após 
-- combate para Melhorar habilidade de combate do jogador 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Incrementar Habilidade de Combate
CREATE OR REPLACE PROCEDURE incrementar_habilidade_combate(
    IN p_id_jogador INT
)
AS $$
BEGIN
    UPDATE Habilidade
    SET nivel_combate = nivel_combate + 1
    WHERE id_jogador = p_id_jogador;
END;
$$ LANGUAGE plpgsql;

-- Trigger para Acionar Incremento de Habilidade de Combate Após o Combate
CREATE OR REPLACE FUNCTION trigger_incrementar_habilidade_combate()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.energia <= 0 THEN
        CALL incrementar_habilidade_combate(NEW.id_jogador);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER incrementar_habilidade_combate_trigger
AFTER UPDATE OF energia ON Jogador
FOR EACH ROW
EXECUTE FUNCTION trigger_incrementar_habilidade_combate();


-- =======================================================================================
-- 65 - Eu como Jogador gostaria de Na casa do NPC, escolher NPC para interação para 
-- Interagir com NPCs na casa do NPC 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

SELECT
    NPC.id_npc,
    NPC.nome AS nome_npc,
    NPC.descricao AS descricao_npc
FROM
    Cabana_NPC
JOIN NPC ON Cabana_NPC.id_npc = NPC.id_npc
WHERE
    Cabana_NPC.id_cabana = 1;


-- =======================================================================================
-- 66 - Eu como Jogador gostaria de Na casa do NPC, visualizar fala do NPC para 
-- Conferir diálogos e interagir com o NPC 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

SELECT
    Dialogo.id_dialogo,
    Dialogo.texto AS fala_npc
FROM
    Cabana_NPC
JOIN NPC ON Cabana_NPC.id_npc = NPC.id_npc
JOIN Dialogo ON NPC.id_dialogo = Dialogo.id_dialogo
WHERE
    Cabana_NPC.id_cabana = 1;


-- =======================================================================================
-- 67 - Eu como Jogador gostaria de Na casa do NPC, escolher continuar dialogando ou 
-- sair para Continuar interação ou voltar para escolher outra ação 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- implementar no frontend

-- =======================================================================================
-- 68 - Eu como Jogador gostaria de Na casa do jogador, escolher ir dormir ou sair 
-- para Decidir se deseja dormir ou continuar explorando 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- implementar no frontend
