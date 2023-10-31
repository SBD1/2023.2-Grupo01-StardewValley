-- --------------------------------------------------------------------------------------
-- Data Criacao ...........: 16/10/2023                                                --
-- Autor(es) ..............: Zenilda Vieira                                            --
-- Versao ..............: 1.0                                                          --
-- Banco de Dados .........: PostgreSQL                                                --
-- Descricao .........: Carga de todas as tabelas do banco de dados.                   --
-- --------------------------------------------------------------------------------------
-- | Atualizacao : 16/10/2023 | Autor(es): Zenilda Vieira                       |      --
--                            | Descricao: Inclusão das linhas de INSERT INTO   |      --
-- | Atualizacao : 29/10/2023 | Autor(es): Edilberto Cantuaria                  |      --
--                            | Descricao: Correção das linhas de INSERT INTO   |      --
-- --------------------------------------------------------------------------------------

BEGIN TRANSACTION;

INSERT INTO Estacao (nome, descricao) VALUES
('Primavera', 'A primavera é uma estação de renovação e crescimento. As árvores florescem, as culturas começam a brotar, e é um ótimo momento para plantar suas sementes e preparar a fazenda para uma temporada produtiva.'),
('Verão', 'O verão é uma estação quente e ensolarada. As culturas crescem rapidamente e há uma abundância de frutas e vegetais maduros para colher. É a estação perfeita para nadar na praia e pescar no rio.'),
('Outono', 'O outono é uma estação de colheita e festivais. As árvores frutíferas produzem suas safras, e a cidade se prepara para o Festival do Vale da Colheita, onde os moradores se reúnem para comemorar e compartilhar suas colheitas.'),
('Inverno', 'O inverno é uma estação fria e tranquila. Muitas culturas não crescem durante esta época, e a fazenda fica coberta de neve. É um momento para se concentrar na mineração, pesca e construção de relacionamentos com os habitantes da cidade.');

INSERT INTO Tipo_Item (nome_tipo_item) VALUES 
('Semente'),
('Ferramenta'),
('Consumivel'),
('Arma'),
('Vestimenta'),
('Artesanato');

INSERT INTO Item (id_tipo_item) VALUES 
(1),
(2),
(3),
(4),
(5),
(6);

INSERT INTO Tipo_Local_Fechado (nome_tipo_local_fechado) VALUES 
('Caverna'),
('Loja'),
('Cabana-NPC'),
('Cabana-Jog');

INSERT INTO Local_Fechado (id_tipo_local_fechado) VALUES 
(1),
(2),
(3),
(4);

INSERT INTO Mundo (nome) VALUES 
('Fazenda'), ('Vale');

INSERT INTO Arma (nome, descricao, dano, finalidade) VALUES 
('Espada', 'Arma balanceada', 3, 'Atacar monstros'),
('Adaga', 'Arma mais rápida de curto alcance', 2, 'Atacar monstros'),
('Clava', 'Arma mais lenta de longo alcance', 5, 'Atacar monstros'),
('Estilingue', 'Arma de longo alcance, sem contato', 6, 'Atacar monstros');

INSERT INTO Artesanato (nome, descricao) VALUES 
('Espatantalho', 'Evita que corvos ataquem suas plantações. Tem um raio limitado (cerca de 8 espaços).'),
('Mudas de Grama', 'Ponha-o na sua fazenda para criar um novo pedaço de grama.'),
('Tear', 'Transforma lã crua em roupas finas.'),
('Piso Rustico de Tabuas', 'Coloque no chao para criar caminhos ou para decora-los.'),
('Cristalario', 'Insira uma joia de sua escolha e ele a copiara.');

INSERT INTO Consumivel (nome, descricao) VALUES 
('Omelete', 'Superfofinha.'),
('Salada', 'Uma saudável salada de jardim.'),
('Avelãs torradas', 'O processo de torra dá um rico sabor de floresta.');

INSERT INTO Ferramenta (nome, descricao, finalidade) VALUES 
('enxada', 'Usada principalmente para preparar o solo para arar o solo e para escavar os pontos de artefatos.', 'Cultivo'),
('Vara de bambu', 'Utilize na água para pegar peixes.', 'Pesca'),
('Distribuidor de feno', 'Provê acesso conveniente à forragem do silo.', 'Outros');

INSERT INTO Vestimenta (nome, descricao) VALUES 
('Chapéu de Abóbora', 'Um chapéu de abóbora assustador perfeito para o Festival do Vale da Colheita.'),
('Vestido de Baile de Inverno', 'Um elegante vestido de baile que você pode usar no Festival de Inverno da cidade.'),
('Chapéu de Pescador', 'Um chapéu prático e à prova d água, ideal para dias de pesca na praia.');

INSERT INTO Monstro ( nome, descricao, dano, id_drop, defesa, saude_maxima) VALUES 
('Carangejo-pedra', 'Caranguejo-Pedra é um inimigo encontrado em As Minas.', 5, 1, 1, 30),
('Fantasma', 'Fantasmas são inimigos encontrado em nas Minas.', 10, 2, 3, 96),
('Serpente', 'Serpente é um inimigo encontrado Caverna da Caveira.', 10, 3, 0, 150);

INSERT INTO Informacao_Semente (id_semente, nome, descricao, valor_venda, dias_para_crescer) VALUES 
(1, 'Semente de Couve-flor','Plante-as na primavera. Demora 12 dias para produzir uma couve-flor grande.',40, 12),
(2, 'Semente de Milho','Plante-as no verão ou outono. Demoram 14 dias para crescerem, e continuam a produção após a primeira colheita.',75, 14),
(3, 'Semente de Alcachofra','Plante-as no outono. Demoram 8 dias para crescer.',15, 8),    
(4, 'Semente de Beringela','Plante-as na Estufa ou em um Vaso de Jardim em um ambiente interno.',10, 5);    

INSERT INTO Semente (id_info_semente, id_estacao) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4); 

INSERT INTO Missao (id_estacao , nome, descricao) VALUES 
(1, 'Plantando as Sementes','O prefeito Lewis pede a você para plantar 10 sementes de parsnip. Ele lhe dará as sementes necessárias e recompensará você por concluí-la.'),
(2, 'A Coleta do Colecionador','Gunther, o curador do museu, pede que você dobre artefatos e minerais para expandir a coleção do museu. Essas missões estão disponíveis ao longo do ano.'),
(3, 'Pescaria na Feira de Outono','Para o evento da Feira de Outono, você deve pegar um peixe lendário. Você recebe uma vara de pescar especial para essa missão.'),
(4, 'Oferenda para o Serpentário','Em uma determinada noite de inverno, você pode deixar uma oferenda no Serpentário para obter um presente misterioso do Serpentário, um ser mitológico do jogo.');

INSERT INTO Regiao (mundo, nome) VALUES 
(1, 'Estufa'), 
(1, 'Caverna'), 
(1, 'Casa da Fazenda'), 
(1, 'Lavouras'),
(2, 'Vila Pelicanos'), 
(2, 'Floresta Cinzaseiva'), 
(2, 'Praia'), 
(2, 'Montanha');

INSERT INTO NPC (id_regiao, id_local_fechado, nome, profissao) VALUES
(2, 1, 'Marlon', 'Aventureiro'),
(2, 1, 'Krobus', 'Mercador das Cavernas'),
(5, 2, 'Willy', 'Pescador'),
(6, 3, 'Linus', 'Ermitão');

INSERT INTO Caverna (id_regiao, nome, descricao) VALUES
(2, 'Caverna das Minhocas', 'Uma caverna cheia de minhocas que podem ser usadas como iscas de pesca.'),
(6, 'Caverna das Fadas', 'Uma caverna mágica onde você pode encontrar frutos de fadas e outros itens especiais.'),
(8, 'Caverna do Cristal', 'Uma caverna brilhante cheia de cristais e minerais preciosos.');

INSERT INTO Cabana_NPC (id_npc, id_regiao, nome, descricao) VALUES
(1, 1, 'Cabana do Eremita', 'Uma cabana aconchegante no meio da floresta onde Linus vive.'),
(2, 5, 'Cabana de Pesquisa da Maru', 'Uma cabana próxima à fazenda onde Maru conduz suas pesquisas científicas.'),
(3, 3, 'Cabana de Robin', 'Uma cabana próxima à Casa da Fazenda onde Robin passa seu tempo livre.'),
(4, 4, 'Cabana da Haley', 'Uma cabana na Lavoura onde Haley gasta seu tempo tirando fotos e relaxando.');

INSERT INTO Loja (id_loja, id_npc, id_regiao, nome, descricao) VALUES
(1, 1, 2, 'Aventureiros do Abismo', 'Uma loja que vende equipamentos e suprimentos para aventureiros da Caverna.'),
(2, 2, 2, 'Mercadoria das Profundezas', 'Uma loja misteriosa na Caverna operada por Krobus, que vende itens exclusivos.'),
(3, 3, 5, 'Loja de Pesca do Willy', 'Uma loja de artigos de pesca à beira da Vila Pelicanos, operada por Willy.'),
(4, 4, 6, 'Loja de Linus', 'Uma modesta loja de suprimentos na cabana de Linus na Floresta Cinzaseiva.');

INSERT INTO Jogador (id_local_fechado, id_regiao, id_estacao, id_missao, nome , saude, energia, dia, hora, qtdd_ouro) VALUES
(1, 1, 1, 1, 'Edilberto', 100, 100, 1, 12, 1000),
(2, 2, 3, 2, 'Marcus', 80, 90, 10, 16, 500),
(3, 5, 2, 3, 'Matheus', 90, 80, 20, 8, 2000),
(4, 7, 4, 4, 'Zenilda', 70, 70, 30, 21, 1500);

INSERT INTO Item_Receita (id_artesanato, id_item, qtdd) VALUES
(1, 1, 10), -- Receita para criar uma Espantalho
(2, 2, 5), -- Receita para criar Mudas de Grama
(3, 3, 1), -- Receita para criar um Tear
(4, 4, 4), -- Receita para criar Piso Rustico de Tabuas
(5, 5, 1); -- Receita para criar um Cristalario

INSERT INTO Item_Inventario (id_jogador, id_item, qtdd) VALUES
(1, 1, 20), -- Jogador 1 tem 20 Sementes
(1, 2, 1),  -- Jogador 1 tem 1 Ferramenta
(2, 3, 10), -- Jogador 2 tem 10 Consumíveis
(3, 6, 5),  -- Jogador 3 tem 5 Artesanatos
(4, 5, 2);  -- Jogador 4 tem 2 Vestimentas

INSERT INTO Item_Estoque_Loja (id_item, id_loja, preco) VALUES
(1, 1, 10.0), -- Aventureiros do Abismo vende Sementes por 10.0 ouros
(2, 1, 50.0), -- Aventureiros do Abismo vende Ferramentas por 50.0 ouros
(3, 2, 30.0), -- Mercadoria das Profundezas vende Consumíveis por 30.0 ouros
(4, 3, 100.0), -- Loja de Pesca do Willy vende Armas por 100.0 ouros
(5, 4, 75.0); -- Loja de Linus vende Vestimentas por 75.0 ouros

INSERT INTO Instancia_Monstro (id_caverna, id_monstro, saude) VALUES
(1, 1, 50), -- Caverna 1 contém um Caranguejo-pedra com 50 de saúde
(2, 2, 40), -- Caverna 2 contém um Fantasma com 40 de saúde
(1, 3, 60), -- Caverna 1 contém uma Serpente com 60 de saúde
(3, 1, 45); -- Caverna 3 contém um Caranguejo-pedra com 45 de saúde

INSERT INTO Habilidade (id_jogador, nivel_coleta, nivel_cultivo, nivel_mineracao, nivel_pesca, nivel_combate ) VALUES
(1, 5, 7, 3, 4, 6), -- Jogador 1 tem níveis de habilidade de coleta, cultivo, mineração, pesca e combate
(2, 4, 6, 2, 5, 5), -- Jogador 2 tem níveis de habilidade de coleta, cultivo, mineração, pesca e combate
(3, 6, 8, 4, 3, 7), -- Jogador 3 tem níveis de habilidade de coleta, cultivo, mineração, pesca e combate
(4, 3, 5, 2, 6, 4); -- Jogador 4 tem níveis de habilidade de coleta, cultivo, mineração, pesca e combate

INSERT INTO Dialogo (id_npc, fala) VALUES
(1, 'Olá, aventureiro! Você está pronto para enfrentar as profundezas da Caverna?'),
(2, 'Bem-vindo, estranho. Tenho coisas únicas para vender, se você tiver ouro suficiente.'),
(3, 'Ei, amigo! Precisa de equipamento de pesca ou dicas para pescar?'),
(4, 'A solidão da floresta é reconfortante. Ela me ensina a encontrar beleza na simplicidade.'); -- Insira aqui uma fala fictícia para Linus

INSERT INTO Cabana_Jogador (id_local_fechado, id_jogador, id_regiao, nome, descricao ) VALUES
(1, 1, 3, 'Cabana do Edilberto', 'Uma pequena cabana aconchegante na Casa da Fazenda de Edilberto.'),
(2, 2, 6, 'Refúgio de Marcus', 'Uma cabana tranquila na Floresta Cinzaseiva, onde Marcus encontra serenidade.'),
(3, 3, 8, 'Retiro de Matheus', 'Uma cabana isolada nas Montanhas, onde Matheus aprecia a solidão.'),
(4, 4, 5, 'Zenilda à Beira-Mar', 'Uma cabana pitoresca na Vila Pelicanos, onde Zenilda desfruta da vida à beira-mar.');

INSERT INTO Efeito (id_efeito, id_item, valor, tipo) VALUES 
(1, 1, 4, 'tipo1'),
(2, 2, 3, 'tipo2'),
(3, 3, 8, 'tipo3'),
(4, 4, 5, 'tipo4'),
(5, 5, 1, 'tipo5');

COMMIT;