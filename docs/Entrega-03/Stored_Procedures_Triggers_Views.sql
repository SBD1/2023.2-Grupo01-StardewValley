-- Histórico de versões
-- --------------------------------------------------------------------------------------
-- Data Criacao ...........: 30/11/2023                                                --
-- Autor(es) ..............: Zenilda Vieira                                            --
-- Versao ..............: 1.0                                                          --
-- Banco de Dados .........: PostgreSQL                                                --
-- Descricao .........: Consultas, SP, Triggers, Views                                 --
-- --------------------------------------------------------------------------------------
-- | Atualizacao : xx/11/2023 | Autor(es): xx                                   |      --
--                            | Descricao: xx                                   |      --
-- --------------------------------------------------------------------------------------


-- =============================================
-- Consultas, Store Procedures, Triggers e Views
-- =============================================


-- 01 - Eu como Banco de Dados gostaria de Atualizar os dados do novo jogador na tabela 
-- "Jogador" para Para iniciar o jogo 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 02 - Eu como Jogador gostaria de Iniciar o dia automaticamente quando energia = 5% ou 
-- hora = 02 para Manter o progresso do jogo mesmo se o jogador não dormir 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 03 - Eu como Banco de Dados gostaria de Atualizar dados do jogador após iniciar o dia 
-- automaticamente para Reiniciar o dia com energia = 100%, incrementar +1 no dia 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 04 - Eu como Banco de Dados gostaria de Verificar se o dia chegou a 29 e reiniciar 
-- para dia 01 para Controlar o ciclo de dias e estações do jogo 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 05 - Eu como Banco de Dados gostaria de Atualizar a estação do jogador após reiniciar 
-- para dia 01 para Registrar a mudança de estação 
-- Observações: 
-- Autor: Marcus Martins

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


-- 06 - Eu como Banco de Dados gostaria de Apagar todas as linhas da tabela Plantacao 
-- ao mudar a estação para Limpar a tabela de plantações ao iniciar nova estação 
-- Observações: 
-- Autor: Marcus Martins

-- Trigger para apagar todas as linhas da tabela Plantacao ao mudar a estação
CREATE OR REPLACE FUNCTION LimparPlantacao()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se a estação foi alterada
    IF NEW.id_estacao <> OLD.id_estacao THEN
        -- Apaga todas as linhas da tabela Plantacao
        DELETE FROM Plantacao;
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
    
    -- Chama a trigger para limpar a tabela Plantacao
    PERFORM LimparPlantacao()
    FROM Jogador
    WHERE id_jogador = in_id_jogador;
END;
$$ LANGUAGE plpgsql;

-- View para obter informações da tabela Plantacao
CREATE OR REPLACE VIEW InformacoesPlantacao AS
SELECT *
FROM Plantacao;


-- 07 - Eu como Banco de Dados gostaria de Verificar se há plantações prontas para colher 
-- para Identificar e recompensar o jogador por plantações prontas 
-- Observações: 
-- Autor: Marcus Martins




-- 08 - Eu como Banco de Dados gostaria de Atualizar inventário após colher plantações 
-- para Registrar itens obtidos com a colheita de plantações 
-- Observações: 
-- Autor: Matheus Silverio



-- 09 - Eu como Banco de Dados gostaria de Seta energia para 100% novamente após colher 
-- plantações para Garantir que o jogador esteja pronto para novas atividades 
-- Observações: 
-- Autor: Matheus Silverio



-- 10 - Eu como Banco de Dados gostaria de Atualizar o horário com base no tempo jogado 
-- para Registrar a passagem do tempo durante o dia 
-- Observações: 
-- Autor: Matheus Silverio



-- 11 - Eu como Jogador gostaria de Visualizar itens consumíveis disponíveis com efeitos 
-- para Conferir opções de itens para consumo e seus efeitos 
-- Observações: 
-- Autor: Zenilda Vieira



-- 12 - Eu como Jogador gostaria de Escolher item consumível para comer efeito para 
-- Aumentar ou decrementar energia do jogador 
-- Observações: 
-- Autor: Zenilda Vieira



-- 13 - Eu como Jogador gostaria de Visualizar aviso para ir dormir quando a hora é 00:00 
-- para Receber alerta para dormir e manter o ciclo do jogo 
-- Observações: 
-- Autor: Zenilda Vieira



-- 14 - Eu como Jogador gostaria de Decidir ir dormir ou comer quando energia atinge 10% 
-- para Escolher entre ir dormir ou comer para recuperar energia 
-- Observações: 
-- Autor: Zenilda Vieira



-- 15 - Eu como Jogador gostaria de Inicializar o jogo para Poder começar a jogar 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 16 - Eu como Banco de Dados gostaria de Atualizar os dados do novo jogador na tabela 
-- "Jogador" para Para iniciar o jogo 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 17 - Eu como Jogador gostaria de Escolher um mundo para Explorar diferentes ambientes 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 18 - Eu como Banco de Dados gostaria de Inserir dados do mundo escolhido na tabela 
-- "Mundo" para Registrar a escolha do jogador 
-- Observações: 
-- Autor: Marcus Martins



-- 19 - Eu como Jogador gostaria de Escolher uma região para Explorar diferentes áreas 
-- no mundo escolhido 
-- Observações: 
-- Autor: Marcus Martins



-- 20 - Eu como Banco de Dados gostaria de Inserir dados da região escolhida na tabela 
-- "Região join Mundo" para Registrar a escolha do jogador 
-- Observações: 
-- Autor: Marcus Martins



-- 21 - Eu como Banco de Dados gostaria de Inserir nova linha na tabela "Jogador" para 
-- Registrar o novo jogador 
-- Observações: 
-- Autor: Matheus Silverio



-- 22 - Eu como Banco de Dados gostaria de Inserir nova linha na tabela "Habilidade" 
-- para Registrar as habilidades do novo jogador 
-- Observações: 
-- Autor: Matheus Silverio



-- 23 - Eu como Banco de Dados gostaria de Inserir linhas na tabela "Item-Inventário" 
-- para Registrar os itens iniciais do jogador 
-- Observações: 
-- Autor: Matheus Silverio



-- 24 - Eu como Jogador gostaria de Verificar status do jogador para Conferir energia, 
-- quantidade de ouro e níveis de habilidade 
-- Observações: 
-- Autor: Zenilda Vieira



-- 25 - Eu como Jogador gostaria de Listar itens do inventário para Visualizar os itens 
-- que o jogador possui 
-- Observações: 
-- Autor: Zenilda Vieira



-- 26 - Eu como Jogador gostaria de Confirmar mudança de região para Prosseguir para a 
-- próxima região 
-- Observações: 
-- Autor: Zenilda Vieira



-- 27 - Eu como Jogador gostaria de Inicializar o jogo para Poder começar a jogar 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 28 - Eu como Banco de Dados gostaria de Atualizar os dados do novo jogador na tabela 
-- "Jogador" para Para iniciar o jogo 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 29 - Eu como Jogador gostaria de Visualizar status do jogo para Conferir região, 
-- estação, dia e hora 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 30 - Eu como Jogador gostaria de Visualizar status do jogador para Conferir energia, 
-- quantidade de ouro e níveis de habilidade 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 31 - Eu como Jogador gostaria de Explorar descrição da região para Conhecer os 
-- locais fechados disponíveis 
-- Observações: 
-- Autor: Marcus Martins



-- 32 - Eu como Jogador gostaria de Realizar coleta para Coletar itens na região 
-- Observações: 
-- Autor: Marcus Martins



-- 33 - Eu como Banco de Dados gostaria de Registrar coleta na tabela "Item-Inventário" 
-- para Atualizar inventário do jogador 
-- Observações: 
-- Autor: Marcus Martins



-- 34 - Eu como Jogador gostaria de Realizar plantação para Plantar sementes na região 
-- Observações: 
-- Autor: Marcus Martins



-- 35 - Eu como Banco de Dados gostaria de Registrar plantação na tabela "Plantacao" 
-- para Atualizar dados de plantação do jogador 
-- Observações: 
-- Autor: Marcus Martins



-- 36 - Eu como Jogador gostaria de Realizar pesca para Pescar itens na região 
-- Observações: 
-- Autor: Matheus Silverio



-- 37 - Eu como Banco de Dados gostaria de Registrar pesca na tabela "Item_Inventario" 
-- para Atualizar inventário do jogador com itens pescados 
-- Observações: 
-- Autor: Matheus Silverio



-- 38 - Eu como Jogador gostaria de Realizar crafting para Craftar itens com receitas 
-- disponíveis 
-- Observações: 
-- Autor: Matheus Silverio



-- 39 - Eu como Banco de Dados gostaria de Atualizar inventário após crafting para 
-- Registrar itens craftados no inventário do jogador 
-- Observações: 
-- Autor: Matheus Silverio



-- 40 - Eu como Jogador gostaria de Conversar com NPC para Interagir com NPCs na região 
-- Observações: 
-- Autor: Matheus Silverio



-- 41 - Eu como Jogador gostaria de Realizar ações de combate/mineração para Explorar 
-- cavernas ou locais de combate na região 
-- Observações: 
-- Autor: Zenilda Vieira



-- 42 - Eu como Banco de Dados gostaria de Atualizar local_fechado na tabela "Jogador" 
-- para Registrar mudança para caverna ou local de combate 
-- Observações: 
-- Autor: Zenilda Vieira



-- 43 - Eu como Jogador gostaria de Acessar local fechado na região para Explorar locais 
-- fechados disponíveis na região 
-- Observações: 
-- Autor: Zenilda Vieira



-- 44 - Eu como Banco de Dados gostaria de Atualizar local_fechado na tabela "Jogador" 
-- para Registrar escolha do local fechado 
-- Observações: 
-- Autor: Zenilda Vieira



-- 45 - Eu como Jogador gostaria de Mudar de região para Explorar outras regiões disponíveis 
-- Observações: 
-- Autor: Zenilda Vieira



-- 46 - Eu como Jogador gostaria de Visualizar status do jogo: região, estação, dia e hora 
-- para Acompanhar o contexto do jogo 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 47 - Eu como Jogador gostaria de Visualizar status do jogador: energia, qtdd-ouro, 
-- níveis de habilidade para Conferir meu progresso e recursos disponíveis 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 48 - Eu como Jogador gostaria de Visualizar descrição da região atual e do local 
-- fechado para Entender o ambiente em que estou 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 49 - Eu como Jogador gostaria de Escolher ação a ser realizada no local fechado para 
-- Interagir com o ambiente e realizar atividades específicas 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 50 - Eu como Jogador gostaria de Na loja, visualizar o estoque para compras para 
-- Conferir itens disponíveis para compra 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 51 - Eu como Jogador gostaria de Na loja, escolher itens para comprar e quantidade 
-- para Adquirir itens necessários 
-- Observações: 
-- Autor: Edilberto Cantuária



-- 52 - Eu como Banco de Dados gostaria de Verificar se jogador possui ouro suficiente 
-- para compra para Garantir que o jogador tem recursos necessários 
-- Observações: 
-- Autor: Marcus Martins



-- 53 - Eu como Banco de Dados gostaria de Atualizar inventário após compra para Registrar 
-- itens adquiridos no inventário 
-- Observações: 
-- Autor: Marcus Martins



-- 54 - Eu como Banco de Dados gostaria de Atualizar estoque da loja após compra para 
-- Atualizar quantidade de itens no estoque da loja 
-- Observações: 
-- Autor: Marcus Martins



-- 55 - Eu como Jogador gostaria de Escolher ação na caverna (minerar, combater, sair) 
-- para Participar de atividades específicas na caverna 
-- Observações: 
-- Autor: Marcus Martins



-- 56 - Eu como Jogador gostaria de Na caverna, visualizar itens disponíveis para 
-- mineração para Conferir recursos disponíveis para mineração 
-- Observações: 
-- Autor: Marcus Martins



-- 57 - Eu como Jogador gostaria de Na caverna, participar da mineração para Adquirir 
-- itens ao realizar a mineração 
-- Observações: 
-- Autor: Marcus Martins



-- 58 - Eu como Banco de Dados gostaria de Atualizar inventário após mineração para 
-- Registrar itens minerados no inventário 
-- Observações: 
-- Autor: Matheus Silverio



-- 59 - Eu como Banco de Dados gostaria de Incrementar habilidade de mineração após 
-- mineração para Melhorar habilidade de mineração do jogador 
-- Observações: 
-- Autor: Matheus Silverio



-- 60 - Eu como Jogador gostaria de Escolher ação de combate na caverna para Participar 
-- de combates contra monstros na caverna 
-- Observações: 
-- Autor: Matheus Silverio



-- 61 - Eu como Jogador gostaria de Na caverna, visualizar monstros disponíveis para 
-- combate para Conferir instâncias de monstros na caverna 
-- Observações: 
-- Autor: Matheus Silverio



-- 62 - Eu como Jogador gostaria de Na caverna, participar do combate para Enfrentar 
-- monstros e obter recompensas 
-- Observações: 
-- Autor: Matheus Silverio



-- 63 - Eu como Banco de Dados gostaria de Atualizar inventário após combate para 
-- Registrar itens obtidos no inventário após o combate 
-- Observações: 
-- Autor: Matheus Silverio



-- 64 - Eu como Banco de Dados gostaria de Incrementar habilidade de combate após 
-- combate para Melhorar habilidade de combate do jogador 
-- Observações: 
-- Autor: Zenilda Vieira



-- 65 - Eu como Jogador gostaria de Na casa do NPC, escolher NPC para interação para 
-- Interagir com NPCs na casa do NPC 
-- Observações: 
-- Autor: Zenilda Vieira



-- 66 - Eu como Jogador gostaria de Na casa do NPC, visualizar fala do NPC para 
-- Conferir diálogos e interagir com o NPC 
-- Observações: 
-- Autor: Zenilda Vieira



-- 67 - Eu como Jogador gostaria de Na casa do NPC, escolher continuar dialogando ou 
-- sair para Continuar interação ou voltar para escolher outra ação 
-- Observações: 
-- Autor: Zenilda Vieira



-- 68 - Eu como Jogador gostaria de Na casa do jogador, escolher ir dormir ou sair 
-- para Decidir se deseja dormir ou continuar explorando 
-- Observações: 
-- Autor: Zenilda Vieira

