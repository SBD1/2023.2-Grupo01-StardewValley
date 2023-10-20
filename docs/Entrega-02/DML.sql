-- ----------------------------------------------------------------- 
-- Data Criacao ...........: 16/10/2023 
-- Autor(es) ..............: Zenilda Vieira 
-- Versao ..............: 1.0 
-- Banco de Dados .........: PostgreSQL 
-- Descricao .........: Carga de todas as tabelas do banco de dados. 
-- ------------------------------------------------------------------------------ 
-- | Atualizacao : 16/10/2023 | Autor(es): Zenilda Vieira | Descricao: Inclusão das linhas de INSERT INTO | 
-- | Atualizacao : xx/xx/2023 | Autor(es):                | Descricao:                                    | 
-- ------------------------------------------------------------------------------ 


-- Tabela Arma 

INSERT INTO Arma (id-arma, nome, descricao, dano, finalidade) VALUES (1, 'espada', 'arma balanceada', 3, 'atacar monstros');
INSERT INTO Arma (id-arma, nome, descricao, dano, finalidade) VALUES (2, 'adaga', 'arma mais rápida de curto alcance', 2, 'atacar monstros');
INSERT INTO Arma (id-arma, nome, descricao, dano, finalidade) VALUES (3, 'clava', 'arma mais lenta de longo alcance', 5, 'atacar montros');
INSERT INTO Arma (id-arma, nome, descricao, dano, finalidade) VALUES (4, 'estilingue', 'arma de longo alcance, sem contato', 6, 'atacar montros');

-- Tabela Artesanato 

INSERT INTO Artesanato (id-artesanato, nome, descricao) VALUES (1, nome, descricao);
INSERT INTO Artesanato (id-artesanato, nome, descricao) VALUES (2, nome, descricao);
INSERT INTO Artesanato (id-artesanato, nome, descricao) VALUES (3, nome, descricao);
INSERT INTO Artesanato (id-artesanato, nome, descricao) VALUES (4, nome, descricao);
INSERT INTO Artesanato (id-artesanato, nome, descricao) VALUES (5, nome, descricao);

-- Tabela Cabana-Jogador 

INSERT INTO Cabana-Jogador (id-cabana-jog, jogador, regiao, nome, descricao) VALUES (1, 'Edilberto', regiao, nome, descricao);
INSERT INTO Cabana-Jogador (id-cabana-jog, jogador, regiao, nome, descricao) VALUES (2, 'Marcus', regiao, nome, descricao);
INSERT INTO Cabana-Jogador (id-cabana-jog, jogador, regiao, nome, descricao) VALUES (3, 'Matheus', regiao, nome, descricao);
INSERT INTO Cabana-Jogador (id-cabana-jog, jogador, regiao, nome, descricao) VALUES (4, 'Zenilda', regiao, nome, descricao);

-- Tabela Cabana-NPC 

INSERT INTO Cabana-NPC (id-cabana-npc, npc, regiao, nome, descricao) VALUES (1, npc, regiao, nome, descricao);
INSERT INTO Cabana-NPC (id-cabana-npc, npc, regiao, nome, descricao) VALUES (2, npc, regiao, nome, descricao);
INSERT INTO Cabana-NPC (id-cabana-npc, npc, regiao, nome, descricao) VALUES (3, npc, regiao, nome, descricao);
INSERT INTO Cabana-NPC (id-cabana-npc, npc, regiao, nome, descricao) VALUES (4, npc, regiao, nome, descricao);
INSERT INTO Cabana-NPC (id-cabana-npc, npc, regiao, nome, descricao) VALUES (5, npc, regiao, nome, descricao);

-- Tabela Caverna 

INSERT INTO Caverna (id-caverna, regiao, nome, descricao) VALUES (1, regiao, nome, descricao);
INSERT INTO Caverna (id-caverna, regiao, nome, descricao) VALUES (2, regiao, nome, descricao);
INSERT INTO Caverna (id-caverna, regiao, nome, descricao) VALUES (3, regiao, nome, descricao);

-- Tabela Consumível 

INSERT INTO Consumível (id-consumivel, nome, descricao) VALUES (1, nome, descricao);
INSERT INTO Consumível (id-consumivel, nome, descricao) VALUES (2, nome, descricao);
INSERT INTO Consumível (id-consumivel, nome, descricao) VALUES (3, nome, descricao);
INSERT INTO Consumível (id-consumivel, nome, descricao) VALUES (4, nome, descricao);
INSERT INTO Consumível (id-consumivel, nome, descricao) VALUES (5, nome, descricao);

-- Tabela Diálogo 

INSERT INTO Diálogo (id-dialogo, npc, fala) VALUES (1, npc, fala);
INSERT INTO Diálogo (id-dialogo, npc, fala) VALUES (2, npc, fala);
INSERT INTO Diálogo (id-dialogo, npc, fala) VALUES (3, npc, fala);
INSERT INTO Diálogo (id-dialogo, npc, fala) VALUES (4, npc, fala);
INSERT INTO Diálogo (id-dialogo, npc, fala) VALUES (5, npc, fala);

-- Tabela Efeito 

INSERT INTO Efeito (id-efeito, item, valor, tipo) VALUES (1, item, valor, tipo);
INSERT INTO Efeito (id-efeito, item, valor, tipo) VALUES (2, item, valor, tipo);
INSERT INTO Efeito (id-efeito, item, valor, tipo) VALUES (3, item, valor, tipo);
INSERT INTO Efeito (id-efeito, item, valor, tipo) VALUES (4, item, valor, tipo);
INSERT INTO Efeito (id-efeito, item, valor, tipo) VALUES (5, item, valor, tipo);

-- Tabela Estação 

INSERT INTO Estação (id-estacao, nome, descricao) VALUES (1, 'Primavera', descricao);
INSERT INTO Estação (id-estacao, nome, descricao) VALUES (2, 'Verão', descricao);
INSERT INTO Estação (id-estacao, nome, descricao) VALUES (3, 'Outono', descricao);
INSERT INTO Estação (id-estacao, nome, descricao) VALUES (4, 'Inverno', descricao);

-- Tabela Ferramenta 

INSERT INTO Ferramenta (id-ferramenta, nome, descricao, finalidade) VALUES (1, nome, descricao, finalidade);
INSERT INTO Ferramenta (id-ferramenta, nome, descricao, finalidade) VALUES (2, nome, descricao, finalidade);
INSERT INTO Ferramenta (id-ferramenta, nome, descricao, finalidade) VALUES (3, nome, descricao, finalidade);
INSERT INTO Ferramenta (id-ferramenta, nome, descricao, finalidade) VALUES (4, nome, descricao, finalidade);
INSERT INTO Ferramenta (id-ferramenta, nome, descricao, finalidade) VALUES (5, nome, descricao, finalidade);

-- Tabela Habilidade 

INSERT INTO Habilidade (jogador, nivel-coleta, nivel-cultivo, nivel-mineracao, nivel-pesca, nivel-combate) VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO Habilidade (jogador, nivel-coleta, nivel-cultivo, nivel-mineracao, nivel-pesca, nivel-combate) VALUES (2, 0, 0, 0, 0, 0);
INSERT INTO Habilidade (jogador, nivel-coleta, nivel-cultivo, nivel-mineracao, nivel-pesca, nivel-combate) VALUES (3, 0, 0, 0, 0, 0);
INSERT INTO Habilidade (jogador, nivel-coleta, nivel-cultivo, nivel-mineracao, nivel-pesca, nivel-combate) VALUES (4, 0, 0, 0, 0, 0);

-- Tabela Instancia-Monstro 

INSERT INTO Instancia-Monstro (caverna, monstro, saude) VALUES (caverna, monstro, saude);
INSERT INTO Instancia-Monstro (caverna, monstro, saude) VALUES (caverna, monstro, saude);
INSERT INTO Instancia-Monstro (caverna, monstro, saude) VALUES (caverna, monstro, saude);
INSERT INTO Instancia-Monstro (caverna, monstro, saude) VALUES (caverna, monstro, saude);
INSERT INTO Instancia-Monstro (caverna, monstro, saude) VALUES (caverna, monstro, saude);

-- Tabela Item-Estoque-Loja 

INSERT INTO Item-Estoque-Loja (produto, loja, preço) VALUES (produto, loja, preço);
INSERT INTO Item-Estoque-Loja (produto, loja, preço) VALUES (produto, loja, preço);
INSERT INTO Item-Estoque-Loja (produto, loja, preço) VALUES (produto, loja, preço);
INSERT INTO Item-Estoque-Loja (produto, loja, preço) VALUES (produto, loja, preço);
INSERT INTO Item-Estoque-Loja (produto, loja, preço) VALUES (produto, loja, preço);

-- Tabela Item-Inventário 

INSERT INTO Item-Inventário (jogador, item, qtdd) VALUES (1, item, qtdd);
INSERT INTO Item-Inventário (jogador, item, qtdd) VALUES (2, item, qtdd);
INSERT INTO Item-Inventário (jogador, item, qtdd) VALUES (3, item, qtdd);
INSERT INTO Item-Inventário (jogador, item, qtdd) VALUES (4, item, qtdd);

-- Tabela Item-Receita 

INSERT INTO Item-Receita (artesanato, item, qtdd) VALUES (artesanato, item, qtdd);
INSERT INTO Item-Receita (artesanato, item, qtdd) VALUES (artesanato, item, qtdd);
INSERT INTO Item-Receita (artesanato, item, qtdd) VALUES (artesanato, item, qtdd);
INSERT INTO Item-Receita (artesanato, item, qtdd) VALUES (artesanato, item, qtdd);
INSERT INTO Item-Receita (artesanato, item, qtdd) VALUES (artesanato, item, qtdd);

-- Tabela Item 

INSERT INTO Item (id-item, id-tipo) VALUES (semente-couve-flor, semente);
INSERT INTO Item (id-item, id-tipo) VALUES (enxada, ferramenta);
INSERT INTO Item (id-item, id-tipo) VALUES (couve-flor, consumivel);
INSERT INTO Item (id-item, id-tipo) VALUES (espada, arma);
INSERT INTO Item (id-item, id-tipo) VALUES (calca, vestimenta);
INSERT INTO Item (id-item, id-tipo) VALUES (bau, artesanato);

-- Tabela Jogador 

INSERT INTO Jogador (id-jogador, local, regiao, estacao-atual, missao-atual, nome, saude, energia, dia, qtdd-ouro) VALUES (1, local, regiao, estacao-atual, missao-atual, nome, saude, energia, dia, qtdd-ouro);
INSERT INTO Jogador (id-jogador, local, regiao, estacao-atual, missao-atual, nome, saude, energia, dia, qtdd-ouro) VALUES (2, local, regiao, estacao-atual, missao-atual, nome, saude, energia, dia, qtdd-ouro);
INSERT INTO Jogador (id-jogador, local, regiao, estacao-atual, missao-atual, nome, saude, energia, dia, qtdd-ouro) VALUES (3, local, regiao, estacao-atual, missao-atual, nome, saude, energia, dia, qtdd-ouro);
INSERT INTO Jogador (id-jogador, local, regiao, estacao-atual, missao-atual, nome, saude, energia, dia, qtdd-ouro) VALUES (4, local, regiao, estacao-atual, missao-atual, nome, saude, energia, dia, qtdd-ouro);

-- Tabela Local-Fechado 

INSERT INTO Local-Fechado (id-local-fechado, id-tipo) VALUES (1, 'caverna');
INSERT INTO Local-Fechado (id-local-fechado, id-tipo) VALUES (2, 'loja');
INSERT INTO Local-Fechado (id-local-fechado, id-tipo) VALUES (3, 'cabana-NPC');
INSERT INTO Local-Fechado (id-local-fechado, id-tipo) VALUES (4, 'cabana-Jog');

-- Tabela Loja 

INSERT INTO Loja (id-loja, proprietario, regiao, nome, descricao) VALUES (1, proprietario, regiao, nome, descricao);

-- Tabela Missao 

INSERT INTO Missao (id-missao, estacao, nome, descricao) VALUES (1, estacao, nome, descricao);
INSERT INTO Missao (id-missao, estacao, nome, descricao) VALUES (2, estacao, nome, descricao);
INSERT INTO Missao (id-missao, estacao, nome, descricao) VALUES (3, estacao, nome, descricao);

-- Tabela Monstro 

INSERT INTO Monstro (id-monstro, drop, nome, descricao, dano, defesa, saude-maxima) VALUES (1, drop, nome, descricao, dano, defesa, saude-maxima);
INSERT INTO Monstro (id-monstro, drop, nome, descricao, dano, defesa, saude-maxima) VALUES (2, drop, nome, descricao, dano, defesa, saude-maxima);
INSERT INTO Monstro (id-monstro, drop, nome, descricao, dano, defesa, saude-maxima) VALUES (3, drop, nome, descricao, dano, defesa, saude-maxima);
INSERT INTO Monstro (id-monstro, drop, nome, descricao, dano, defesa, saude-maxima) VALUES (4, drop, nome, descricao, dano, defesa, saude-maxima);
INSERT INTO Monstro (id-monstro, drop, nome, descricao, dano, defesa, saude-maxima) VALUES (5, drop, nome, descricao, dano, defesa, saude-maxima);

-- Tabela Mundo 

INSERT INTO Mundo (id-mundo, nome) VALUES (1, nome);
INSERT INTO Mundo (id-mundo, nome) VALUES (2, nome);

-- Tabela NPC 

INSERT INTO NPC (id-npc, regiao, local, nome, profissao) VALUES (1, regiao, local, nome, profissao);
INSERT INTO NPC (id-npc, regiao, local, nome, profissao) VALUES (2, regiao, local, nome, profissao);
INSERT INTO NPC (id-npc, regiao, local, nome, profissao) VALUES (3, regiao, local, nome, profissao);
INSERT INTO NPC (id-npc, regiao, local, nome, profissao) VALUES (4, regiao, local, nome, profissao);
INSERT INTO NPC (id-npc, regiao, local, nome, profissao) VALUES (5, regiao, local, nome, profissao);

-- Tabela Região 

INSERT INTO Região (id-regiao, mundo, nome) VALUES (1, 1, nome);
INSERT INTO Região (id-regiao, mundo, nome) VALUES (2, 1, nome);
INSERT INTO Região (id-regiao, mundo, nome) VALUES (3, 2, nome);
INSERT INTO Região (id-regiao, mundo, nome) VALUES (4, 2, nome);

-- Tabela Semente 

INSERT INTO Semente (id-semente, estacao, nome, descricao, valor-venda, dias-para-crescer) VALUES (1, estacao, nome, descricao, valor-venda, dias-para-crescer);
INSERT INTO Semente (id-semente, estacao, nome, descricao, valor-venda, dias-para-crescer) VALUES (2, estacao, nome, descricao, valor-venda, dias-para-crescer);
INSERT INTO Semente (id-semente, estacao, nome, descricao, valor-venda, dias-para-crescer) VALUES (3, estacao, nome, descricao, valor-venda, dias-para-crescer);
INSERT INTO Semente (id-semente, estacao, nome, descricao, valor-venda, dias-para-crescer) VALUES (4, estacao, nome, descricao, valor-venda, dias-para-crescer);
INSERT INTO Semente (id-semente, estacao, nome, descricao, valor-venda, dias-para-crescer) VALUES (5, estacao, nome, descricao, valor-venda, dias-para-crescer);

-- Tabela Vestimenta 

INSERT INTO Vestimenta (id-vestimenta, nome, descricao) VALUES (1, nome, descricao);
INSERT INTO Vestimenta (id-vestimenta, nome, descricao) VALUES (2, nome, descricao);
INSERT INTO Vestimenta (id-vestimenta, nome, descricao) VALUES (3, nome, descricao);
INSERT INTO Vestimenta (id-vestimenta, nome, descricao) VALUES (4, nome, descricao);
INSERT INTO Vestimenta (id-vestimenta, nome, descricao) VALUES (5, nome, descricao);
