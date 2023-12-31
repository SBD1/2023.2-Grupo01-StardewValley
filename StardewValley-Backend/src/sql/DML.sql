BEGIN TRANSACTION;

\c stardew_valley

SET client_encoding = 'UTF8';

-- Inserção de dados para a entidade Tipo_Item
INSERT INTO Tipo_Item (id_tipo_item, nome_tipo_item)
VALUES
    (1, 'arma'),
    (2, 'ferramenta'),
    (3, 'consumivel'),
    (4, 'vestimenta'),
    (5, 'artesanato'),
    (6, 'semente');

-- Inserção de dados para a entidade Item
INSERT INTO Item (id_item, id_tipo_item)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 5),
    (5, 5),
    (6, 5),
    (7, 5),
    (8, 5),
    (9, 5),
    (10, 5),
    (11, 5),
    (12, 5),
    (13, 5),
    (14, 2),
    (15, 2),
    (16, 2),
    (17, 2),
    (18, 2),
    (19, 2),
    (20, 3),
    (21, 3),
    (22, 3),
    (23, 3),
    (24, 3),
    (25, 3),
    (26, 3),
    (27, 3),
    (28, 3),
    (29, 3),
    (30, 4),
    (31, 4),
    (32, 4),
    (33, 4),
    (34, 4),
    (35, 4),
    (36, 4),
    (37, 4),
    (38, 4),
    (39, 4);

-- Inserção de dados para a entidade Mundo
INSERT INTO Mundo (id_mundo, nome, descricao)
VALUES
    (1, 'Vale', 'Um vale encantador cheio de mistérios e aventuras.'),
    (2, 'Floresta Mágica', 'Uma floresta repleta de criaturas mágicas e segredos antigos.'),
    (3, 'Deserto do Sol', 'Um deserto vasto e quente, lar de artefatos perdidos e tesouros enterrados.'),
    (4, 'Montanhas Geladas', 'Montanhas cobertas de neve, onde desafios e descobertas aguardam.'),
    (5, 'Ilha dos Sonhos', 'Uma ilha paradisíaca com praias douradas e mistérios subaquáticos.');

-- Inserção de dados para a entidade Regiao
INSERT INTO Regiao (id_regiao, id_mundo, nome, descricao)
VALUES
    (1, 1, 'Vale', 'Uma região rural e encantadora.'),
    (2, 1, 'Deserto', 'Uma vasta extensão de areia e segredos.'),
    (3, 2, 'Floresta Encantada', 'Um lugar mágico cheio de criaturas encantadoras.'),
    (4, 2, 'Montanhas Geladas', 'Um ambiente frio e cheio de desafios.'),
    (5, 3, 'Ilha Tropical', 'Um paraíso tropical com praias exuberantes.'),
    (6, 3, 'Floresta Sombria', 'Uma floresta densa e misteriosa.'),
    (7, 4, 'Planície Verdejante', 'Ampla área verde com campos e rios.'),
    (8, 4, 'Caverna Misteriosa', 'Uma caverna cheia de segredos subterrâneos.'),
    (9, 5, 'Vale da Lua', 'Um local mágico iluminado pela luz da lua.'),
    (10, 5, 'Desfiladeiro Profundo', 'Um desfiladeiro com paisagens impressionantes.');

-- Inserção de dados para a entidade Estacao
INSERT INTO Estacao (id_estacao, nome, descricao)
VALUES
    (1, 'Primavera', 'Estação das flores e do renascimento.'),
    (2, 'Verão', 'Estação quente e ensolarada.'),
    (3, 'Outono', 'Estação das folhas caídas e das colheitas.'),
    (4, 'Inverno', 'Estação fria e de neve.');

-- Inserção de dados para a entidade Missao
INSERT INTO Missao (id_missao, id_estacao, nome, descricao)
VALUES
    (1, 1, 'Plantio de Primavera', 'Plante diversas sementes na primavera e obtenha recompensas.'),
    (2, 2, 'Colheita de Verão', 'Colha diferentes culturas no verão para completar esta missão.'),
    (3, 3, 'Mineração de Outono', 'Explore as cavernas e colete minerais durante o outono.'),
    (4, 4, 'Pesca de Inverno', 'Pesque peixes específicos durante o inverno para ganhar prêmios.'),
    (5, 1, 'Ajudando os Moradores', 'Ajude os moradores de Pelican Town com tarefas diversas.'),
    (6, 2, 'Construção na Comunidade', 'Contribua para projetos de construção na comunidade.'),
    (7, 3, 'Caça aos Monstros', 'Derrote monstros nas cavernas para manter a segurança na cidade.'),
    (8, 4, 'Negócios na JojaMart', 'Complete tarefas comerciais para a JojaMart e ganhe recompensas.'),
    (9, 1, 'Exploração da Floresta', 'Explore a floresta em busca de recursos e segredos.'),
    (10, 2, 'Festival da Estação', 'Prepare-se para o festival da estação com atividades especiais.');

-- Inserção de dados para a entidade Tipo_Local_Fechado
INSERT INTO Tipo_Local_Fechado (id_tipo_local_fechado, nome_tipo_local_fechado)
VALUES
    (1, 'cabana_jog'),
    (2, 'cabana_npc'),
    (3, 'caverna'),
    (4, 'loja');

-- Inserção de dados para a entidade Local_Fechado
INSERT INTO Local_Fechado (id_local_fechado, id_tipo_local_fechado)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 2),
    (5, 2),
    (6, 2),
    (7, 2),
    (8, 2),
    (9, 2),
    (10, 2),
    (11, 2),
    (12, 2),
    (13, 2),
    (14, 3),
    (15, 3),
    (16, 3),
    (17, 3),
    (18, 3),
    (19, 3),
    (20, 3),
    (21, 3),
    (22, 3),
    (23, 3),
    (24, 4),
    (25, 4),
    (26, 4),
    (27, 4),
    (28, 4),
    (29, 4),
    (30, 4),
    (31, 4),
    (32, 4),
    (33, 4);

-- Inserção de dados para a entidade Jogador
INSERT INTO Jogador (id_jogador, id_local_fechado, id_regiao, id_estacao, id_missao, nome, energia, dia, hora, qtdd_ouro)
VALUES
    (1, 1, 1, 1, 1, 'Jogador1', 80, 5, 720, 1000),
    (2, 3, 2, 2, 2, 'Jogador2', 90, 15, 960, 800),
    (3, 2, 3, 3, 3, 'Jogador3', 100, 28, 1320, 1200);

-- Inserção de dados para a entidade NPC
INSERT INTO NPC (id_NPC, id_regiao, id_local_fechado, nome, profissao)
VALUES
    (1, 1, 2, 'Robin', 'Construtora'),
    (2, 1, 3, 'Demetrius', 'Cientista'),
    (3, 2, 1, 'Evelyn', 'Aposentada'),
    (4, 3, NULL, 'Krobus', 'Mercador do Deserto'),
    (5, 4, 5, 'Clint', 'Ferreiro'),
    (6, 5, NULL, 'Willy', 'Pescador'),
    (7, 1, 1, 'Lewis', 'Prefeito'),
    (8, 3, 2, 'Pierre', 'Proprietário da Mercearia'),
    (9, 2, 4, 'Haley', 'Fotógrafa'),
    (10, 4, 3, 'Linus', 'Morador de Rua');

-- Exemplo de inserção de dados para a entidade Arma
INSERT INTO Arma (id_arma, nome, descricao, dano, finalidade, comeca_jogo_com)
VALUES
    (1, 'Espada de aço', 'Uma espada afiada para combate', 5, 'Combate', TRUE),
    (2, 'Adaga de cristal', 'A lâmina é feita de quartzo purificado.', 4, 'Combate', FALSE),
    (3, 'Clava', 'A companhia de um bruto.', 3, 'Combate', FALSE);

-- Inserção de dados para a entidade Artesanato
INSERT INTO Artesanato (id_artesanato, nome, descricao)
VALUES
    (4, 'Queijo', 'Um pedaço saboroso de queijo artesanal'),
    (5, 'Mel', 'Um pote de mel fresco e doce'),
    (6, 'Cerveja', 'Uma garrafa de cerveja caseira'),
    (7, 'Joia', 'Uma joia valiosa feita à mão'),
    (8, 'Tecido', 'Um rolo de tecido artesanal'),
    (9, 'Óleo Essencial', 'Um frasco de óleo essencial aromático'),
    (10, 'Bolo', 'Um delicioso bolo caseiro'),
    (11, 'Sapato', 'Um par de sapatos feitos sob medida'),
    (12, 'Vinho', 'Uma garrafa de vinho envelhecido'),
    (13, 'Sorvete', 'Um pote de sorvete artesanal');

-- Inserção de dados para a entidade Cabana_Jogador
INSERT INTO Cabana_Jogador (id_cabana_jog, id_prop_cab_jog, id_regiao, nome, descricao)
VALUES
    (1, 1, 1, 'Cabana do Jogador 1', 'Uma pequena cabana no Vale'),
    (2, 2, 2, 'Cabana do Jogador 2', 'Uma cabana acolhedora perto da montanha'),
    (3, 3, 1, 'Cabana do Jogador 3', 'Um refúgio tranquilo próximo ao rio');

-- Inserção de dados para a entidade Cabana_NPC
INSERT INTO Cabana_NPC (id_cabana_NPC, id_prop_cab_NPC, id_regiao, nome, descricao)
VALUES
    (4, 1, 1, 'Cabana do Robin', 'Oficina da Robin, onde ela trabalha com carpintaria'),
    (5, 2, 2, 'Cabana do Shane', 'O trailer modesto de Shane, repleto de caixas de frango'),
    (6, 3, 1, 'Cabana do Lewis', 'A casa elegante de Lewis, cercada por jardins bem cuidados'),
    (7, 4, 3, 'Cabana da Abigail', 'O quarto cheio de cores de Abigail, com instrumentos musicais espalhados'),
    (8, 5, 2, 'Cabana da Emily', 'A casa artística de Emily, com pincéis e tintas por toda parte'),
    (9, 6, 1, 'Cabana do Gus', 'O trailer de Gus, onde ele prepara suas deliciosas refeições'),
    (10, 7, 3, 'Cabana do Pierre', 'A loja de Pierre, com prateleiras cheias de produtos'),
    (11, 8, 2, 'Cabana do Willy', 'A cabana beira-mar de Willy, cheia de equipamentos de pesca'),
    (12, 9, 1, 'Cabana da Haley', 'A casa elegante de Haley, com um estúdio de fotografia improvisado'),
    (13, 10, 3, 'Cabana do Harvey', 'A clínica de Harvey, com equipamentos médicos e um ambiente acolhedor');

-- Inserção de dados para a entidade Caverna
INSERT INTO Caverna (id_caverna, id_regiao, nome, descricao)
VALUES
    (14, 1, 'Caverna das Minas', 'Uma caverna misteriosa cheia de minerais e monstros'),
    (15, 2, 'Caverna do Deserto', 'Uma caverna nas areias do deserto, com segredos enterrados'),
    (16, 3, 'Caverna da Floresta', 'Uma caverna escondida entre as árvores, cheia de criaturas mágicas'),
    (17, 1, 'Caverna da Mina de Carvão', 'Uma caverna escura e profunda, cheia de depósitos de carvão'),
    (18, 2, 'Caverna do Oásis', 'Uma caverna luxuosa no oásis, com tesouros exóticos'),
    (19, 3, 'Caverna das Fadas', 'Uma caverna encantada onde as fadas residem'),
    (20, 1, 'Caverna do Ferro', 'Uma caverna rica em minério de ferro e desafios'),
    (21, 2, 'Caverna do Mar Profundo', 'Uma caverna submarina com criaturas marinhas e tesouros submersos'),
    (22, 3, 'Caverna da Lua Crescente', 'Uma caverna iluminada pela luz da lua crescente'),
    (23, 1, 'Caverna da Geleira', 'Uma caverna gelada com depósitos de minerais congelados');

-- Inserção de dados para a entidade Ferramenta
INSERT INTO Ferramenta (id_ferramenta, nome, descricao, finalidade, comeca_jogo_com)
VALUES
    (14, 'Enxada', 'Usada para cavar e plantar sementes.', 'Agricultura', true),
    (15, 'Picareta', 'Usada para minerar pedras e minérios.', 'Mineração', true),
    (16, 'Machado', 'Usado para cortar árvores.', 'Lenhador', true),
    (17, 'Vara de Pesca', 'Usada para pescar peixes.', 'Pesca', true),
    (18, 'Foice', 'Usada para colher plantas.', 'Colheita', true),
    (19, 'Regador', 'Usado para irrigar as plantações.', 'Agricultura', true);

-- Inserção de dados para a entidade Consumivel
INSERT INTO Consumivel (id_consumivel, id_regiao, id_local_fechado, id_ferramenta, nome, descricao)
VALUES
    (20, 1, 1, 14, 'Poção de Energia', 'Restaura 30 pontos de energia do jogador'),
    (21, 2, 2, 15, 'Elixir de Força', 'Aumenta temporariamente a força do jogador em 20%'),
    (22, 3, NULL, 17, 'Isca de Pesca', 'Aumenta as chances de pegar peixes ao pescar'),
    (23, 1, 4, 14, 'Semente Mágica', 'Uma semente que cresce em uma planta mágica'),
    (24, 2, 5, 14, 'Fruta Silvestre', 'Uma fruta deliciosa encontrada nas florestas'),
    (25, 3, NULL, 14, 'Bebida Energética', 'Aumenta temporariamente a energia do jogador em 10%'),
    (26, 1, 7, 15, 'Minério Encantado', 'Minério especial com propriedades mágicas'),
    (27, 2, 8, 14, 'Cogumelo Venenoso', 'Um cogumelo que pode ser usado em poções venenosas'),
    (28, 3, NULL, 14, 'Mel do Vale', 'Um mel doce e valioso produzido nas colmeias'),
    (29, 1, 10, 14, 'Pó de Fada', 'Um pó mágico usado em rituais de encantamento');


-- Inserção de dados para a entidade Dialogo
INSERT INTO Dialogo (id_dialogo, id_NPC, fala)
VALUES
    (1, 1, 'Olá, aventureiro! Em busca de tesouros?'),
    (2, 2, 'Bem-vindo à minha loja! Temos os melhores produtos da cidade.'),
    (3, 3, 'As criaturas da caverna podem ser perigosas, tome cuidado!'),
    (4, 4, 'O deserto é um lugar misterioso, cheio de segredos a serem descobertos.'),
    (5, 5, 'Você sabia que as plantas mágicas crescem mais rápido com cuidados especiais?'),
    (6, 6, 'A pesca é uma atividade relaxante. Você deveria experimentar!'),
    (7, 7, 'Os monstros da caverna são agressivos. Esteja preparado para o combate!'),
    (8, 8, 'A floresta esconde muitos tesouros. Explore com cautela!'),
    (9, 9, 'As abelhas são essenciais para a produção de mel. Cuide bem delas!'),
    (10, 10, 'A lua crescente tem propriedades mágicas. Fique atento a eventos especiais!');

-- Inserção de dados para a entidade Efeito
INSERT INTO Efeito (id_efeito, id_item, valor, tipo)
VALUES
    (20, 1, 10, 'ganha_energia'),
    (21, 2, -5, 'perde_energia'),
    (22, 3, 20, 'ganha_energia'),
    (23, 4, -10, 'perde_energia'),
    (24, 5, 15, 'ganha_energia'),
    (25, 6, -8, 'perde_energia'),
    (26, 7, 25, 'ganha_energia'),
    (27, 8, -12, 'perde_energia'),
    (28, 9, 30, 'ganha_energia'),
    (29, 10, -15, 'perde_energia');

-- Inserção de dados para a entidade Habilidade
INSERT INTO Habilidade (id_jogador, nivel_coleta, nivel_cultivo, nivel_mineracao, nivel_pesca, nivel_combate)
VALUES
    (1, 5, 3, 4, 2, 1),
    (2, 2, 1, 3, 6, 4),
    (3, 7, 5, 2, 8, 3);

-- Inserção de dados para a entidade Monstro
INSERT INTO Monstro (id_monstro, id_drop, nome, descricao, dano, defesa, energia_maxima)
VALUES
    (101, 1, 'Slime Verde', 'Um monstro gelatinoso e verde.', 2, 1, 90),
    (102, 2, 'Inseto Voador', 'Um pequeno inseto voador.', 3, 1, 70),
    (103, 3, 'Morcego Caveira', 'Um morcego com olhos brilhantes.', 4, 2, 80),
    (104, 4, 'Serpente Venenosa', 'Uma serpente venenosa e rápida.', 5, 2, 100),
    (105, 5, 'Fantasma Sombrio', 'Um fantasma assustador.', 7, 3, 50),
    (106, 6, 'Lobo Selvagem', 'Um lobo ágil e feroz.', 8, 3, 30),
    (107, 1, 'Yeti Gigante', 'Um yeti enorme e poderoso.', 10, 4, 40),
    (108, 2, 'Dragão de Fogo', 'Um dragão cuspidor de fogo.', 10, 5, 50),
    (109, 3, 'Golem de Pedra', 'Um golem feito de pedra.', 5, 7, 60),
    (110, 4, 'Espectro Sombrio', 'Um espectro sombrio com habilidades mágicas.', 8, 8, 70);

-- Inserção de dados para a entidade Instancia_Monstro
INSERT INTO Instancia_Monstro (id_caverna, id_monstro, energia)
VALUES
    (14, 101, 80),
    (14, 102, 65),
    (15, 103, 90),
    (16, 104, 75),
    (16, 105, 60),
    (17, 106, 85),
    (18, 107, 70),
    (18, 108, 50),
    (18, 109, 95),
    (18, 110, 40);

-- Inserção de dados para a entidade Loja
INSERT INTO Loja (id_loja, id_npc_prop, id_regiao, nome, descricao)
VALUES
    (24, 1, 1, 'Mercado do Pierre', 'Loja de sementes e suprimentos agrícolas.'),
    (25, 2, 2, 'Ranchinho da Emily', 'Loja de roupas e acessórios feitos à mão.'),
    (26, 3, 3, 'Blacksmith de Clint', 'Loja de ferramentas e melhorias para equipamentos.'),
    (27, 4, 1, 'Saloon do Gus', 'Bar e restaurante com diversas comidas e bebidas.'),
    (28, 5, 2, 'Carpintaria do Robin', 'Loja de móveis e construção.'),
    (29, 6, 3, 'Carpintaria do Maru', 'Invenções tecnológicas e gadgets para fazendeiros.'),
    (30, 7, 1, 'Hospital da Harvey', 'Cuidados médicos e tratamentos para os moradores de Pelican Town.'),
    (31, 8, 2, 'Guilda dos Aventureiros', 'Contratação de aventureiros para explorar cavernas e derrotar monstros.'),
    (32, 9, 3, 'JojaMart', 'Supermercado com uma variedade de produtos para todas as suas necessidades.'),
    (33, 10, 1, 'Casa da Evelyn e George', 'Pequena loja com antiguidades e bugigangas.');

-- Inserção de dados para a entidade Item_Estoque_Loja
INSERT INTO Item_Estoque_Loja (id_item, id_loja, preco)
VALUES
    (1, 24, 100),
    (2, 24, 150),
    (3, 25, 200),
    (4, 25, 120),
    (5, 26, 80),
    (6, 26, 130),
    (7, 27, 300),
    (8, 27, 250),
    (9, 28, 180),
    (10, 28, 220);

-- Inserção de dados para a entidade Item_Inventario
INSERT INTO Item_Inventario (id_jogador, id_item, qtdd)
VALUES
    (1, 1, 5),
    (1, 3, 2),
    (2, 2, 10),
    (2, 4, 3),
    (3, 5, 8),
    (3, 7, 1);

-- Inserção de dados para a entidade Item_Receita
INSERT INTO Item_Receita (id_artesanato, id_item, qtdd)
VALUES
    (4, 3, 2),
    (4, 5, 1),
    (5, 8, 3),
    (5, 10, 2),
    (6, 1, 1),
    (6, 6, 2),
    (7, 4, 4),
    (7, 7, 1),
    (7, 9, 3),
    (7, 10, 2);

-- Inserção de dados para a entidade Plantacao
INSERT INTO Plantacao (id_semente, dia_colheita)
VALUES
    (1, 5),
    (2, 12),
    (3, 8),
    (4, 5),
    (5, 2),
    (6, 3),
    (7, 10),
    (8, 18),
    (9, 7),
    (10, 8);

-- Inserção de dados para a entidade Semente
INSERT INTO Semente (id_semente, id_estacao, nome, descricao, valor_venda, dias_para_crescer)
VALUES
    (1, 1, 'Semente de Beterraba', 'Uma semente que floresce na primavera.', 20, 10),
    (2, 1, 'Semente de Couve-Flor', 'Semente para a estação da primavera.', 15, 6),
    (3, 2, 'Semente de Girassol', 'Semente para a estação do verão.', 30, 8),
    (4, 2, 'Semente de Lúpulo', 'Cresce melhor no verão.', 25, 9),
    (5, 3, 'Semente de Abóbora', 'Uma semente que floresce no outono.', 50, 12),
    (6, 3, 'Semente de Espinafre', 'Ótima para plantar no outono.', 40, 7),
    (7, 4, 'Semente de Inverno', 'Semente resistente que cresce no inverno.', 35, 14),
    (8, 4, 'Semente de Uva', 'Cresce melhor no inverno.', 60, 11),
    (9, 1, 'Semente de Tulipa', 'Uma semente que floresce na primavera.', 10, 5),
    (10, 2, 'Semente de Mirtilo', 'Cresce melhor no verão.', 45, 11);

-- Inserção de dados para a entidade Vestimenta
INSERT INTO Vestimenta (id_vestimenta, nome, descricao)
VALUES
    (30, 'Camisa Azul', 'Uma camisa de cor azul vibrante.'),
    (31, 'Vestido Floral', 'Um vestido com estampa floral.'),
    (32, 'Chapéu de Palha', 'Um chapéu leve e confortável.'),
    (33, 'Calças Jeans', 'Calças de denim azul clássicas.'),
    (34, 'Luvas de Couro', 'Luvas feitas de couro durável.'),
    (35, 'Tênis Esportivo', 'Tênis confortável para atividades físicas.'),
    (36, 'Véu Elegante', 'Um véu elegante para ocasiões especiais.'),
    (37, 'Casaco de Inverno', 'Um casaco quente para os dias frios.'),
    (38, 'Bota de Trabalho', 'Botas resistentes para trabalhos rurais.'),
    (39, 'Boné de Beisebol', 'Um boné casual para dias ensolarados.');


COMMIT;