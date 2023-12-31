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
CREATE OR REPLACE FUNCTION AtualizarEstacao()
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

CREATE TRIGGER tr_ReiniciarEstacao
BEFORE UPDATE ON Jogador
FOR EACH ROW
EXECUTE FUNCTION AtualizarEstacao();

-- Stored Procedure para reiniciar o jogo
CREATE OR REPLACE PROCEDURE sp_ReiniciarJogo(jogador_id INT)
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
CREATE OR REPLACE VIEW vw_JogadorInfo AS
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
CREATE TRIGGER tr_LimparPlantacao
AFTER UPDATE ON Jogador
FOR EACH ROW
EXECUTE FUNCTION LimparPlantacao();

-- Stored Procedure para iniciar nova estação
CREATE OR REPLACE PROCEDURE sp_IniciarNovaEstacao(in_id_jogador INT, in_nova_estacao INT)
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
CREATE OR REPLACE VIEW vw_InformacoesPlantacao AS
SELECT *
FROM Plantacao;



-- =======================================================================================
-- 07 - Eu como Banco de Dados gostaria de Verificar se há plantações prontas para colher 
-- para Identificar e recompensar o jogador por plantações prontas 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================

-- Trigger para verificar se há plantações prontas para colher
CREATE OR REPLACE FUNCTION VerificarColheita()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.dias_crescimento <= 0 THEN
        RAISE NOTICE 'Plantação pronta para colher!'; -- Substitua pela lógica desejada
        -- Você pode adicionar aqui a lógica para realizar alguma ação quando a plantação está pronta para colher
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Aplique a trigger na tabela de Sementes
CREATE TRIGGER tr_SementeVerificarColheita
BEFORE INSERT OR UPDATE ON Semente
FOR EACH ROW
EXECUTE FUNCTION VerificarColheita();

-- Stored Procedure para simular o plantio de uma semente
CREATE OR REPLACE PROCEDURE sp_PlantarSemente(
    IN semente_id INT,
    IN estacao_id INT
)
AS $$
DECLARE
    dias_crescimento INT;
BEGIN
    -- Obter informações da semente
    SELECT dias_para_crescer INTO dias_crescimento
    FROM Informacao_Semente
    WHERE id_info_semente = semente_id;

    -- Inserir a semente na tabela
    INSERT INTO Semente(id_info_semente, id_estacao, dias_crescimento)
    VALUES (semente_id, estacao_id, dias_crescimento);
END;
$$ LANGUAGE plpgsql;

-- View para listar plantações prontas para colher
CREATE OR REPLACE VIEW vw_PlantacoesProntasParaColher AS
SELECT
    S.id_semente,
    IS.nome AS nome_semente,
    S.id_estacao,
    E.nome AS nome_estacao,
    S.dias_crescimento
FROM
    Semente S
JOIN
    Informacao_Semente IS ON S.id_info_semente = IS.id_info_semente
JOIN
    Estacao E ON S.id_estacao = E.id_estacao
WHERE
    S.dias_crescimento <= 0;

-- =======================================================================================

-- =======================================================================================
-- 08 - Eu como Banco de Dados gostaria de Atualizar inventário após colher plantações 
-- para Registrar itens obtidos com a colheita de plantações 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Criar a stored procedure
CREATE OR REPLACE FUNCTION atualizar_inventario_apos_colher()
RETURNS TRIGGER AS $$
BEGIN
    -- Atualizar o inventário com os itens obtidos da colheita
    INSERT INTO Item_Inventario (id_jogador, id_item)
    SELECT NEW.id_jogador, I.id_item
    FROM Plantacao AS P
    JOIN Item AS I ON P.id_semente = I.id_item
    WHERE P.dia_colheita = CURRENT_DATE; -- ou qualquer outra condição para identificar plantações colhidas

    -- Limpar as plantações colhidas da tabela Plantacao
    DELETE FROM Plantacao
    WHERE dia_colheita = CURRENT_DATE; -- ou qualquer outra condição para identificar plantações colhidas

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criar a trigger associada à stored procedure
CREATE TRIGGER after_colheita_trigger
AFTER DELETE ON Plantacao
FOR EACH ROW
EXECUTE FUNCTION atualizar_inventario_apos_colher();

-- =======================================================================================
-- 09 - Eu como Banco de Dados gostaria de Seta energia para 100% novamente após colher 
-- plantações para Garantir que o jogador esteja pronto para novas atividades 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Criar a stored procedure
CREATE OR REPLACE FUNCTION restaurar_energia_apos_colheita(id_jogador_param INT)
RETURNS VOID AS $$
BEGIN
    -- Atualizar a energia do jogador para 100%
    UPDATE Jogador
    SET energia = 100
    WHERE id_jogador = id_jogador_param;

    -- Realizar outras ações se necessário

END;
$$ LANGUAGE plpgsql;

-- Chamar a stored procedure para restaurar energia após colher plantações para o jogador com ID 1
-- SELECT restaurar_energia_apos_colheita(1);


-- =======================================================================================
-- 10 - Eu como Banco de Dados gostaria de Atualizar o horário com base no tempo jogado 
-- para Registrar a passagem do tempo durante o dia 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Criar a tabela Tempo_Jogado se ainda não existir
CREATE TABLE IF NOT EXISTS Tempo_Jogado (
    id_jogador INT PRIMARY KEY,
    tempo_jogado INTERVAL
);

-- Criar a função que será chamada pela trigger
CREATE OR REPLACE FUNCTION atualizar_horario()
RETURNS TRIGGER AS $$
BEGIN
    -- Atualizar o horário com base no tempo jogado
    UPDATE Tempo_Jogado
    SET tempo_jogado = tempo_jogado + NEW.tempo_jogado
    WHERE id_jogador = NEW.id_jogador;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criar a trigger que acionará a função após a atualização do tempo jogado
CREATE TRIGGER trigger_atualizar_horario
AFTER UPDATE
ON Jogador
FOR EACH ROW
WHEN (NEW.tempo_jogado IS DISTINCT FROM OLD.tempo_jogado)
EXECUTE FUNCTION atualizar_horario();




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

-- Trigger para registrar a escolha do mundo quando um novo jogador é adicionado
CREATE OR REPLACE FUNCTION RegistrarMundoEscolhido()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Mundo (nome) VALUES (NEW.mundo);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Ativando a Trigger quando um novo jogador é adicionado
CREATE TRIGGER tg_RegistrarMundo
AFTER INSERT ON Jogador
FOR EACH ROW
EXECUTE FUNCTION RegistrarMundoEscolhido();

-- Stored Procedure para permitir que um jogador escolha o mundo
CREATE OR REPLACE PROCEDURE sp_EscolherMundo(
    IN jogador_nome VARCHAR(50),
    IN mundo_nome VARCHAR(50)
)
AS $$
BEGIN
    INSERT INTO Jogador (nome, mundo, saude, energia, dia, hora, qtdd_ouro)
    VALUES (jogador_nome, mundo_nome, 100, 100, 1, 12, 0);
END;
$$ LANGUAGE plpgsql;


-- View para obter informações sobre os jogadores e seus mundos
CREATE OR REPLACE VIEW vw_JogadorMundo AS
SELECT
    J.id_jogador,
    J.nome AS nome_jogador,
    J.mundo,
    M.descricao AS descricao_mundo
FROM Jogador J
JOIN Mundo M ON J.mundo = M.nome;



-- =======================================================================================
-- 19 - Eu como Jogador gostaria de Escolher uma região para Explorar diferentes áreas 
-- no mundo escolhido 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================

-- Trigger para acionar a stored procedure após uma atualização no jogador
CREATE OR REPLACE FUNCTION EscolherRegiaoExplorarTrigger()
RETURNS TRIGGER AS $$
BEGIN
    -- Chama a stored procedure EscolherRegiaoExplorar passando os parâmetros necessários
    PERFORM EscolherRegiaoExplorar(NEW.id_jogador, 'Fazenda', 'Lavouras');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Adiciona a Trigger à tabela Jogador
CREATE TRIGGER tr_EscolherRegiao
AFTER UPDATE ON Jogador
FOR EACH ROW
EXECUTE FUNCTION EscolherRegiaoExplorarTrigger();

-- Stored Procedure para Escolher uma Região para Explorar
CREATE OR REPLACE PROCEDURE sp_EscolherRegiaoExplorar(
    jogador_id INT,
    mundo_nome VARCHAR(255),
    regiao_nome VARCHAR(255)
)
LANGUAGE SQL
AS $$
BEGIN
    -- Atualiza a região escolhida para o jogador
    UPDATE Jogador SET id_regiao = R.id_regiao
    FROM Regiao R, Mundo M
    WHERE R.mundo = M.id_mundo
        AND R.nome = regiao_nome
        AND M.nome = mundo_nome
        AND Jogador.id_jogador = jogador_id;
END;
$$;

-- View para fornecer informações simplificadas sobre a região escolhida
CREATE OR REPLACE VIEW vw_InformacoesRegiaoEscolhida AS
SELECT J.nome AS nome_jogador, R.nome AS nome_regiao, M.nome AS nome_mundo
FROM Jogador J
JOIN Regiao R ON J.id_regiao = R.id_regiao
JOIN Mundo M ON R.mundo = M.id_mundo;


-- =======================================================================================
-- 20 - Eu como Banco de Dados gostaria de Inserir dados da região escolhida na tabela 
-- "Região join Mundo" para Registrar a escolha do jogador 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================

-- Função para inserir dados na tabela Regiao_Mundo após a inserção de uma nova região
CREATE OR REPLACE FUNCTION InserirRegiaoMundo()
RETURNS TRIGGER AS $$
BEGIN
   -- Inserindo na tabela Regiao_Mundo os dados da nova região e seu respectivo mundo
   INSERT INTO Regiao_Mundo (id_regiao, id_mundo)
   VALUES (NEW.id_regiao, (SELECT id_mundo FROM Mundo WHERE nome = NEW.nome_mundo));
   
   -- Retornando a nova região
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que chama a função inserir_regiao_mundo após a inserção de uma nova região
CREATE TRIGGER tr_InserirRegiaoMundo
AFTER INSERT ON Regiao
FOR EACH ROW
EXECUTE FUNCTION InserirRegiaoMundo();

-- Procedure para escolher uma região, inserindo dados diretamente na tabela Regiao
CREATE OR REPLACE PROCEDURE sp_EscolherRegiao(in_nome_regiao VARCHAR, in_nome_mundo VARCHAR)
AS $$
BEGIN
   -- Inserindo na tabela Regiao os dados da nova região e seu respectivo mundo
   INSERT INTO Regiao (nome, mundo)
   VALUES (in_nome_regiao, in_nome_mundo);
END;
$$ LANGUAGE plpgsql;

-- View para visualizar dados da tabela Regiao_Mundo combinando informações das tabelas Regiao e Mundo
CREATE OR REPLACE VIEW vw_RegiaoMundo AS
SELECT R.nome AS nome_regiao, M.nome AS nome_mundo
FROM Regiao_Mundo RM
JOIN Regiao R ON RM.id_regiao = R.id_regiao
JOIN Mundo M ON RM.id_mundo = M.id_mundo;


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

-- Trigger que é acionada sempre que o jogador entra em uma nova região
CREATE OR REPLACE FUNCTION AtualizarInfoRegiao()
RETURNS TRIGGER AS $$
BEGIN
    -- Atualiza as informações da região e locais fechados para o jogador atual
    UPDATE Jogador J
    SET id_regiao = NEW.id_regiao
    WHERE J.id_jogador = NEW.id_jogador;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- A trigger é acionada ao entrar em uma nova região
CREATE TRIGGER tg_AtualizarInfoRegiao
AFTER UPDATE OF id_regiao ON Jogador
FOR EACH ROW
EXECUTE FUNCTION AtualizarInfoRegiao();

-- View que retorna informações sobre a região atual e seus locais fechados
CREATE VIEW vw_InfoRegiaoLocal AS
SELECT 
    R.id_regiao,
    R.nome AS nome_regiao,
    R.mundo,
    LF.id_local_fechado,
    LF.nome_tipo_local_fechado,
    LF.descricao AS descricao_local
FROM
    Regiao R
JOIN
    Local_Fechado LF ON R.id_regiao = LF.id_regiao;

-- =======================================================================================
-- 32 - Eu como Jogador gostaria de Realizar coleta para Coletar itens espalhados pela
-- região em que estou
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================



-- =======================================================================================
-- 33 - Eu como Banco de Dados gostaria de Registrar coleta na tabela "Item-Inventário" 
-- para Atualizar inventário do jogador 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================

-- Função para verificar e atualizar o inventário do jogador
CREATE OR REPLACE FUNCTION VerificarAtualizarInventario(
    jogador_id INT,
    item_id INT,
    quantidade INT
)
RETURNS VOID AS $$
BEGIN
    -- Verifica se o item já existe no inventário do jogador
    IF EXISTS (SELECT 1 FROM Item_Inventario WHERE id_jogador = jogador_id AND id_item = item_id) THEN
        -- Se o item existir, incrementa a quantidade
        UPDATE Item_Inventario
        SET qtdd = qtdd + quantidade
        WHERE id_jogador = jogador_id AND id_item = item_id;
    ELSE
        -- Se o item não existir, insere um novo registro
        INSERT INTO Item_Inventario (id_jogador, id_item, qtdd)
        VALUES (jogador_id, item_id, quantidade);
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Trigger para registrar coleta na tabela "Item-Inventário"
CREATE OR REPLACE FUNCTION tr_RegistrarColeta()
RETURNS TRIGGER AS $$
BEGIN
    PERFORM VerificarAtualizarInventario(NEW.id_jogador, NEW.id_item, NEW.qtdd);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Associa a Trigger à tabela "Item-Inventário"
CREATE TRIGGER tr_Coleta
AFTER INSERT ON Item_Receita
FOR EACH ROW
EXECUTE FUNCTION tr_RegistrarColeta();

-- Stored Procedure para registrar coleta manualmente
CREATE OR REPLACE PROCEDURE sp_RegistrarColetaManual(
    jogador_id INT,
    item_id INT,
    quantidade INT
)
AS $$
BEGIN
    PERFORM VerificarAtualizarInventario(jogador_id, item_id, quantidade);
END;
$$ LANGUAGE plpgsql;

-- View para exibir o inventário consolidado do jogador
CREATE OR REPLACE VIEW vw_InventarioJogador AS
SELECT
    J.id_jogador,
    J.nome AS nome_jogador,
    II.id_item,
    I.nome AS nome_item,
    I.descricao AS descricao_item,
    II.qtdd
FROM
    Jogador J
    JOIN Item_Inventario II ON J.id_jogador = II.id_jogador
    JOIN Item I ON II.id_item = I.id_item;


-- =======================================================================================
-- 34 - Eu como Jogador gostaria de Realizar plantação para Plantar sementes na região 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================

-- Stored procedure para realizar o plantio
CREATE OR REPLACE PROCEDURE sp_PlantarSemente(
    jogador_id INT,
    semente_nome VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    semente_id INT;
    qtdd_semente INT;
BEGIN
    -- Obter o ID da semente e a quantidade no inventário do jogador
    SELECT id_semente, qtdd INTO semente_id, qtdd_semente
    FROM Item_Inventario
    WHERE id_jogador = jogador_id
        AND id_item = (
            SELECT id_info_semente
            FROM Informacao_Semente
            WHERE nome = semente_nome
        );

    -- Verificar se o jogador possui a semente no inventário
    IF semente_id IS NOT NULL THEN
        -- Verificar se a estação atual é adequada para plantar
        IF EXISTS (
            SELECT 1
            FROM Jogador
            WHERE id_jogador = jogador_id
                AND id_estacao = (
                    SELECT id_estacao
                    FROM Informacao_Semente
                    WHERE nome = semente_nome
                )
        ) THEN
            -- Remover a semente do inventário do jogador
            IF qtdd_semente > 1 THEN
                -- Se houver mais de uma unidade, reduzir a quantidade
                UPDATE Item_Inventario
                SET qtdd = qtdd - 1
                WHERE id_jogador = jogador_id
                    AND id_item = semente_id
                RETURNING NEW.qtdd INTO qtdd_semente;
            ELSE
                -- Se houver apenas uma unidade, remover a linha
                DELETE FROM Item_Inventario
                WHERE id_jogador = jogador_id
                    AND id_item = semente_id;
            END IF;

            -- Inserir o plantio na tabela correspondente (supondo que você tenha uma tabela para isso)
            INSERT INTO Plantio (id_jogador, id_semente, data_plantio)
            VALUES (jogador_id, semente_id, CURRENT_DATE);

            RAISE NOTICE 'Semente plantada com sucesso!';
        ELSE
            RAISE EXCEPTION 'Estação inadequada para plantar esta semente!';
        END IF;
    ELSE
        RAISE EXCEPTION 'Jogador não possui a semente no inventário!';
    END IF;
END;
$$;


-- =======================================================================================
-- 35 - Eu como Banco de Dados gostaria de Registrar plantação na tabela "Plantacao" 
-- para Atualizar dados de plantação do jogador 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================

-- Trigger para registrar plantação quando uma semente é plantada
CREATE OR REPLACE FUNCTION RegistrarPlantacao()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO Plantacao (id_jogador, id_semente, quantidade, data_plantio)
  VALUES (NEW.id_jogador, NEW.id_semente, NEW.qtdd, CURRENT_DATE);
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Ativando a trigger quando uma semente é plantada
CREATE TRIGGER tg_TriggerPlantacao
AFTER INSERT ON Item_Inventario
FOR EACH ROW
WHEN (NEW.id_semente IS NOT NULL)
EXECUTE FUNCTION registrar_plantacao();

-- Stored Procedure para registrar plantação
CREATE OR REPLACE FUNCTION sp_PlantarSemente(
  jogador_id INT,
  semente_id INT,
  quantidade INT
)
RETURNS VOID AS $$
BEGIN
  INSERT INTO Plantacao (id_jogador, id_semente, quantidade, data_plantio)
  VALUES (jogador_id, semente_id, quantidade, CURRENT_DATE);
END;
$$ LANGUAGE plpgsql;e

-- View para visualizar informações de plantação do jogador
CREATE OR REPLACE VIEW vw_PlantacaoJogador AS
SELECT
  p.id_plantacao,
  j.nome AS jogador,
  s.nome AS semente,
  p.quantidade,
  p.data_plantio
FROM Plantacao p
JOIN Jogador j ON p.id_jogador = j.id_jogador
JOIN Semente s ON p.id_semente = s.id_semente;


-- =======================================================================================
-- 36 - Eu como Jogador gostaria de Realizar pesca para Pescar itens na região 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Tela de Pesca
-- Mostra itens que podem ser pescados na região
SELECT
    c.id_consumivel,
    c.nome AS nome_item_pescado,
    c.descricao,
    c.id_ferramenta,
    f.nome AS nome_ferramenta
FROM
    Consumivel c
JOIN
    Ferramenta f ON c.id_ferramenta = f.id_ferramenta
WHERE
    c.id_local_fechado = (SELECT id_local_fechado FROM Jogador WHERE id_jogador = [ID_DO_JOGADOR]); -- Substituir [ID_DO_JOGADOR] pelo ID real do jogador

-- Dinâmica de Pesca
-- Substituir [ID_DO_JOGADOR] pelo ID real do jogador
DECLARE @id_jogador INT = [ID_DO_JOGADOR];

-- Verifica se o jogador tem a ferramenta necessária para a pesca
DECLARE @id_ferramenta_jogador INT;
SELECT @id_ferramenta_jogador = id_ferramenta FROM Jogador WHERE id_jogador = @id_jogador;

-- Substituir [ID_DA_FERRAMENTA] pelo ID real da ferramenta de pesca escolhida
DECLARE @id_ferramenta_pescaria INT = [ID_DA_FERRAMENTA];

IF @id_ferramenta_jogador = @id_ferramenta_pescaria
BEGIN
    -- Realiza a pesca
    -- Substituir [ID_DA_LOCALIZACAO] pelo ID real da localização do jogador
    INSERT INTO Item_Inventario (id_jogador, id_item)
    SELECT
        @id_jogador,
        c.id_consumivel
    FROM
        Consumivel c
    WHERE
        c.id_local_fechado = (SELECT id_local_fechado FROM Jogador WHERE id_jogador = @id_jogador);

    -- Incrementa habilidade de pesca do jogador
    UPDATE Habilidade SET nivel_pesca = nivel_pesca + 1 WHERE id_jogador = @id_jogador;

    -- Decrementa energia do jogador em 5%
    UPDATE Jogador SET energia = energia - 5 WHERE id_jogador = @id_jogador;
END
ELSE
BEGIN
    -- Informa que o jogador não tem a ferramenta necessária
    SELECT 'Ferramenta necessária indisponível' AS mensagem;
END;


-- =======================================================================================
-- 37 - Eu como Banco de Dados gostaria de Registrar pesca na tabela "Item_Inventario" 
-- para Atualizar inventário do jogador com itens pescados 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================
-- Autor: Zenilda Vieira
-- =======================================================================================

-- ja foi contemplado acima


-- =======================================================================================
-- 38 - Eu como Jogador gostaria de Realizar crafting para Craftar itens com receitas 
-- disponíveis 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Stored Procedure para Craftar Itens
CREATE OR REPLACE FUNCTION CraftarItem(
    p_id_jogador INT,
    p_id_receita INT,
    p_quantidade INT
)
RETURNS TABLE (
    mensagem VARCHAR(200)
)
AS $$
DECLARE
    v_qtdd_item_inventario INT;
BEGIN
    -- Verifica se o jogador tem os itens necessários na quantidade suficiente para a receita
    SELECT COUNT(*) INTO v_qtdd_item_inventario
    FROM Item_Inventario ii
    JOIN Item_Receita ir ON ii.id_item = ir.id_item
    WHERE ii.id_jogador = p_id_jogador
      AND ir.id_receita = p_id_receita
      AND ii.quantidade >= (ir.quantidade * p_quantidade);

    -- Se o jogador tem os itens necessários
    IF v_qtdd_item_inventario > 0 THEN
        -- Decrementa os itens necessários do inventário
        DELETE FROM Item_Inventario
        WHERE id_jogador = p_id_jogador
          AND id_item IN (SELECT id_item FROM Item_Receita WHERE id_receita = p_id_receita)
          AND quantidade >= (SELECT ir.quantidade * p_quantidade FROM Item_Receita ir WHERE ir.id_receita = p_id_receita);

        -- Incrementa os itens craftados no inventário
        INSERT INTO Item_Inventario (id_jogador, id_item, quantidade)
        SELECT
            p_id_jogador,
            ir.id_item_craftado,
            ir.quantidade_craftada * p_quantidade
        FROM Item_Receita ir
        WHERE ir.id_receita = p_id_receita;

        -- Retorna mensagem de sucesso
        RETURN QUERY SELECT 'Crafting realizado com sucesso!'::VARCHAR;

    ELSE
        -- Retorna mensagem de erro
        RETURN QUERY SELECT 'Itens necessários para crafting indisponíveis'::VARCHAR;
    END IF;
END;
$$ LANGUAGE PLPGSQL;


-- =======================================================================================
-- 39 - Eu como Banco de Dados gostaria de Atualizar inventário após crafting para 
-- Registrar itens craftados no inventário do jogador 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================
-- Autor: Zenilda Vieira
-- =======================================================================================

-- ja foi contemplado acima


-- =======================================================================================
-- 40 - Eu como Jogador gostaria de Conversar com NPC para Interagir com NPCs na região 
-- Observações: 
-- Autor: Matheus Silverio
-- =======================================================================================
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Consulta para Conversar com NPC
SELECT
    npc.id_npc,
    npc.nome AS nome_npc,
    npc.descricao AS descricao_npc,
    dialogo.texto AS texto_dialogo
FROM
    NPC npc
JOIN
    Dialogo dialogo ON npc.id_dialogo = dialogo.id_dialogo
WHERE
    npc.id_regiao = :id_regiao; -- Substitua :id_regiao pelo ID da região atual do jogador



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

-- Stored Procedure para Verificar Ouro Suficiente
CREATE OR REPLACE PROCEDURE VerificarOuroSuficiente(
    p_id_jogador INT,
    p_id_item INT,
    p_quantidade INT
)
LANGUAGE plpgsql AS $$
DECLARE
    v_preco_item INT;
    v_ouro_jogador INT;
BEGIN
    -- Obter o preço do item da tabela Item-Estoque-Loja
    SELECT preco INTO v_preco_item
    FROM Item_Estoque_Loja
    WHERE id_item = p_id_item;

    -- Obter a quantidade de ouro do jogador
    SELECT qtdd_ouro INTO v_ouro_jogador
    FROM Jogador
    WHERE id_jogador = p_id_jogador;

    -- Verificar se o jogador tem ouro suficiente para a compra
    IF v_ouro_jogador >= v_preco_item * p_quantidade THEN
        -- Atualizar a quantidade de ouro do jogador após a compra
        UPDATE Jogador
        SET qtdd_ouro = v_ouro_jogador - v_preco_item * p_quantidade
        WHERE id_jogador = p_id_jogador;

        RAISE NOTICE 'Compra realizada com sucesso!';
    ELSE
        RAISE EXCEPTION 'O jogador não possui ouro suficiente para realizar a compra.';
    END IF;
END;
$$;

-- Trigger para Chamar a Stored Procedure antes da Compra
CREATE OR REPLACE FUNCTION CompraItem()
RETURNS TRIGGER AS $$
BEGIN
    -- Chamar a stored procedure VerificarOuroSuficiente antes de permitir a compra
    PERFORM VerificarOuroSuficiente(NEW.id_jogador, NEW.id_item, NEW.qtdd);

    -- Se a compra for bem-sucedida, permitir a inserção na tabela Item_Inventario
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger associada à tabela Item_Inventario para verificar ouro antes da compra
CREATE TRIGGER VerificarOuroAntesDaCompra
BEFORE INSERT
ON Item_Inventario
FOR EACH ROW
EXECUTE FUNCTION CompraItem();


-- =======================================================================================
-- 53 - Eu como Banco de Dados gostaria de Atualizar inventário após compra para Registrar 
-- itens adquiridos no inventário 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================

-- Já contemplado em 51


-- =======================================================================================
-- 54 - Eu como Banco de Dados gostaria de Atualizar estoque da loja após compra para 
-- Atualizar quantidade de itens no estoque da loja 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================

-- Já contemplado em 51


-- =======================================================================================
-- 55 - Eu como Jogador gostaria de Escolher ação na caverna (minerar, combater, sair) 
-- para Participar de atividades específicas na caverna 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Stored Procedure para Escolher Ação na Caverna
CREATE OR REPLACE FUNCTION escolher_acao_na_caverna(
    jogador_id INT,
    escolha VARCHAR(10) -- Opções: 'minerar', 'combater', 'sair'
) RETURNS VOID AS
$$
DECLARE
    energia_jogador INT;
BEGIN
    -- Obter energia do jogador
    SELECT energia
    INTO energia_jogador
    FROM Jogador
    WHERE id_jogador = jogador_id;

    -- Verificar a escolha do jogador
    CASE escolha
        WHEN 'minerar' THEN
            -- Realizar ação de mineração
            -- (lógica de mineração aqui)

        WHEN 'combater' THEN
            -- Realizar ação de combate
            -- (lógica de combate aqui)

        WHEN 'sair' THEN
            -- Sair da caverna
            -- (lógica de sair aqui)

        ELSE
            RAISE EXCEPTION 'Escolha inválida. Opções: ''minerar'', ''combater'', ''sair''.';
    END CASE;

    -- Atualizar energia do jogador após a ação
    UPDATE Jogador
    SET energia = energia_jogador - 5 -- Exemplo: decrementa 5% da energia
    WHERE id_jogador = jogador_id;

    RAISE NOTICE 'Ação realizada com sucesso na caverna: %', escolha;
END;
$$
LANGUAGE plpgsql;



-- =======================================================================================
-- 56 - Eu como Jogador gostaria de Na caverna, visualizar itens disponíveis para 
-- mineração para Conferir recursos disponíveis para mineração 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Consulta para Visualizar Itens Disponíveis para Mineração na Caverna
SELECT
    c.id_consumivel,
    c.nome AS nome_consumivel,
    c.descricao,
    c.id_ferramenta,
    f.nome AS nome_ferramenta
FROM
    Consumivel c
JOIN
    Ferramenta f ON c.id_ferramenta = f.id_ferramenta
WHERE
    c.id_local_fechado = (SELECT id_local_fechado FROM Local_Fechado WHERE nome = 'caverna');



-- =======================================================================================
-- 57 - Eu como Jogador gostaria de Na caverna, participar da mineração para Adquirir 
-- itens ao realizar a mineração 
-- Observações: 
-- Autor: Marcus Martins
-- =======================================================================================

-- REPETIDA - 41.1

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


-- REPETIDA - 51

-- =======================================================================================
-- 61 - Eu como Jogador gostaria de Na caverna, visualizar monstros disponíveis para 
-- combate para Conferir instâncias de monstros na caverna 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Consulta para visualizar monstros disponíveis na caverna
SELECT
    im.id_caverna,
    im.id_monstro,
    m.nome AS nome_monstro,
    m.descricao,
    m.dano,
    m.defesa,
    m.energia_maxima,
    im.energia
FROM
    Instancia_Monstro im
    JOIN Monstro m ON im.id_monstro = m.id_monstro
WHERE
    im.id_caverna = [ID_DA_CAVERNA_ATUAL];


-- =======================================================================================
-- 62 - Eu como Jogador gostaria de Na caverna, participar do combate para Enfrentar 
-- monstros e obter recompensas Atualizando inventário após combate para 
-- Registrar itens obtidos no inventário após o combate 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- REPETIDA - 41

-- =======================================================================================
-- 63 - Eu como Banco de Dados gostaria de Atualizar inventário após combate para 
-- Registrar itens obtidos no inventário após o combate 
-- Observações: 
-- Autor: Zenilda Vieira
-- =======================================================================================

-- Já contemplada em 41


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
