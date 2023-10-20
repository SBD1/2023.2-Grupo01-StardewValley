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

INSERT INTO Artesanato (id-artesanato, nome, descricao) VALUES (1, 'nome', 'descricao');
INSERT INTO Artesanato (id-artesanato, nome, descricao) VALUES (2, 'nome', 'descricao');
INSERT INTO Artesanato (id-artesanato, nome, descricao) VALUES (3, 'nome', 'descricao');
INSERT INTO Artesanato (id-artesanato, nome, descricao) VALUES (4, 'nome', 'descricao');
INSERT INTO Artesanato (id-artesanato, nome, descricao) VALUES (5, 'nome', 'descricao');

-- Tabela Cabana-Jogador 

INSERT INTO Cabana-Jogador (id-cabana-jog, jogador, regiao, nome, descricao) VALUES (1, 'Edilberto', 1, 'nome', 'descricao');
INSERT INTO Cabana-Jogador (id-cabana-jog, jogador, regiao, nome, descricao) VALUES (2, 'Marcus', 2, 'nome', 'descricao');
INSERT INTO Cabana-Jogador (id-cabana-jog, jogador, regiao, nome, descricao) VALUES (3, 'Matheus', 3, 'nome', 'descricao');
INSERT INTO Cabana-Jogador (id-cabana-jog, jogador, regiao, nome, descricao) VALUES (4, 'Zenilda', 4, 'nome', 'descricao');

-- Tabela Cabana-NPC 

INSERT INTO Cabana-NPC (id-cabana-npc, npc, regiao, nome, descricao) VALUES (1, 1, 1, 'nome', 'descricao');
INSERT INTO Cabana-NPC (id-cabana-npc, npc, regiao, nome, descricao) VALUES (2, 2, 2, 'nome', 'descricao');
INSERT INTO Cabana-NPC (id-cabana-npc, npc, regiao, nome, descricao) VALUES (3, 3, 3, 'nome', 'descricao');
INSERT INTO Cabana-NPC (id-cabana-npc, npc, regiao, nome, descricao) VALUES (4, 4, 4, 'nome', 'descricao');
INSERT INTO Cabana-NPC (id-cabana-npc, npc, regiao, nome, descricao) VALUES (5, 5, 1, 'nome', 'descricao');
INSERT INTO Cabana-NPC (id-cabana-npc, npc, regiao, nome, descricao) VALUES (6, 6, 2, 'nome', 'descricao');
INSERT INTO Cabana-NPC (id-cabana-npc, npc, regiao, nome, descricao) VALUES (7, 7, 3, 'nome', 'descricao');
INSERT INTO Cabana-NPC (id-cabana-npc, npc, regiao, nome, descricao) VALUES (8, 8, 4, 'nome', 'descricao');

-- Tabela Caverna 

INSERT INTO Caverna (id-caverna, regiao, nome, descricao) VALUES (1, 1, 'nome', 'descricao');
INSERT INTO Caverna (id-caverna, regiao, nome, descricao) VALUES (2, 2, 'nome', 'descricao');
INSERT INTO Caverna (id-caverna, regiao, nome, descricao) VALUES (3, 3, 'nome', 'descricao');
INSERT INTO Caverna (id-caverna, regiao, nome, descricao) VALUES (4, 4, 'nome', 'descricao');

-- Tabela Consumível 

INSERT INTO Consumível (id-consumivel, nome, descricao) VALUES (1, 'nome', 'descricao');
INSERT INTO Consumível (id-consumivel, nome, descricao) VALUES (2, 'nome', 'descricao');
INSERT INTO Consumível (id-consumivel, nome, descricao) VALUES (3, 'nome', 'descricao');
INSERT INTO Consumível (id-consumivel, nome, descricao) VALUES (4, 'nome', 'descricao');
INSERT INTO Consumível (id-consumivel, nome, descricao) VALUES (5, 'nome', 'descricao');

-- Tabela Diálogo 

INSERT INTO Diálogo (id-dialogo, npc, fala) VALUES (1, 1, 'fala');
INSERT INTO Diálogo (id-dialogo, npc, fala) VALUES (2, 2, 'fala');
INSERT INTO Diálogo (id-dialogo, npc, fala) VALUES (3, 3, 'fala');
INSERT INTO Diálogo (id-dialogo, npc, fala) VALUES (4, 4, 'fala');
INSERT INTO Diálogo (id-dialogo, npc, fala) VALUES (5, 5, 'fala');
INSERT INTO Diálogo (id-dialogo, npc, fala) VALUES (6, 6, 'fala');
INSERT INTO Diálogo (id-dialogo, npc, fala) VALUES (7, 6, 'fala');
INSERT INTO Diálogo (id-dialogo, npc, fala) VALUES (8, 6, 'fala');

-- Tabela Efeito 

INSERT INTO Efeito (id-efeito, item, valor, tipo) VALUES (1, item, valor, tipo);
INSERT INTO Efeito (id-efeito, item, valor, tipo) VALUES (2, item, valor, tipo);
INSERT INTO Efeito (id-efeito, item, valor, tipo) VALUES (3, item, valor, tipo);
INSERT INTO Efeito (id-efeito, item, valor, tipo) VALUES (4, item, valor, tipo);
INSERT INTO Efeito (id-efeito, item, valor, tipo) VALUES (5, item, valor, tipo);

-- Tabela Estação 

INSERT INTO Estação (id-estacao, nome, descricao) VALUES (1, 'Primavera', 'descricao');
INSERT INTO Estação (id-estacao, nome, descricao) VALUES (2, 'Verão', 'descricao');
INSERT INTO Estação (id-estacao, nome, descricao) VALUES (3, 'Outono', 'descricao');
INSERT INTO Estação (id-estacao, nome, descricao) VALUES (4, 'Inverno', 'descricao');

-- Tabela Ferramenta 

INSERT INTO Ferramenta (id-ferramenta, nome, descricao, finalidade) VALUES (1, 'nome', 'descricao', 'finalidade');
INSERT INTO Ferramenta (id-ferramenta, nome, descricao, finalidade) VALUES (2, 'nome', 'descricao', 'finalidade');
INSERT INTO Ferramenta (id-ferramenta, nome, descricao, finalidade) VALUES (3, 'nome', 'descricao', 'finalidade');
INSERT INTO Ferramenta (id-ferramenta, nome, descricao, finalidade) VALUES (4, 'nome', 'descricao', 'finalidade');
INSERT INTO Ferramenta (id-ferramenta, nome, descricao, finalidade) VALUES (5, 'nome', 'descricao', 'finalidade');

-- Tabela Habilidade 

INSERT INTO Habilidade (jogador, nivel-coleta, nivel-cultivo, nivel-mineracao, nivel-pesca, nivel-combate) VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO Habilidade (jogador, nivel-coleta, nivel-cultivo, nivel-mineracao, nivel-pesca, nivel-combate) VALUES (2, 0, 0, 0, 0, 0);
INSERT INTO Habilidade (jogador, nivel-coleta, nivel-cultivo, nivel-mineracao, nivel-pesca, nivel-combate) VALUES (3, 0, 0, 0, 0, 0);
INSERT INTO Habilidade (jogador, nivel-coleta, nivel-cultivo, nivel-mineracao, nivel-pesca, nivel-combate) VALUES (4, 0, 0, 0, 0, 0);

-- Tabela Instancia-Monstro 

INSERT INTO Instancia-Monstro (caverna, monstro, saude) VALUES (1, monstro, 100);
INSERT INTO Instancia-Monstro (caverna, monstro, saude) VALUES (2, monstro, 100);
INSERT INTO Instancia-Monstro (caverna, monstro, saude) VALUES (1, monstro, 100);
INSERT INTO Instancia-Monstro (caverna, monstro, saude) VALUES (2, monstro, 100);
INSERT INTO Instancia-Monstro (caverna, monstro, saude) VALUES (1, monstro, 100);
INSERT INTO Instancia-Monstro (caverna, monstro, saude) VALUES (2, monstro, 100);

-- Tabela Item-Estoque-Loja 

INSERT INTO Item-Estoque-Loja (produto, loja, preço) VALUES (produto, loja, preço);
INSERT INTO Item-Estoque-Loja (produto, loja, preço) VALUES (produto, loja, preço);
INSERT INTO Item-Estoque-Loja (produto, loja, preço) VALUES (produto, loja, preço);
INSERT INTO Item-Estoque-Loja (produto, loja, preço) VALUES (produto, loja, preço);
INSERT INTO Item-Estoque-Loja (produto, loja, preço) VALUES (produto, loja, preço);

-- Tabela Item-Inventário 

INSERT INTO Item-Inventário (jogador, item, qtdd) VALUES (1, item, 10);
INSERT INTO Item-Inventário (jogador, item, qtdd) VALUES (2, item, 10);
INSERT INTO Item-Inventário (jogador, item, qtdd) VALUES (3, item, 10);
INSERT INTO Item-Inventário (jogador, item, qtdd) VALUES (4, item, 10);

-- Tabela Item-Receita 

INSERT INTO Item-Receita (artesanato, item, qtdd) VALUES (artesanato, item, 10);
INSERT INTO Item-Receita (artesanato, item, qtdd) VALUES (artesanato, item, 10);
INSERT INTO Item-Receita (artesanato, item, qtdd) VALUES (artesanato, item, 10);
INSERT INTO Item-Receita (artesanato, item, qtdd) VALUES (artesanato, item, 10);
INSERT INTO Item-Receita (artesanato, item, qtdd) VALUES (artesanato, item, 10);

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

INSERT INTO Loja (id-loja, proprietario, regiao, nome, descricao) VALUES (1, 1, 1, 'nome', 'descricao');
INSERT INTO Loja (id-loja, proprietario, regiao, nome, descricao) VALUES (2, 2, 2, 'nome', 'descricao');

-- Tabela Missao 

INSERT INTO Missao (id-missao, estacao, nome, descricao) VALUES (1, 1, 'nome', 'descricao');
INSERT INTO Missao (id-missao, estacao, nome, descricao) VALUES (2, 2, 'nome', 'descricao');
INSERT INTO Missao (id-missao, estacao, nome, descricao) VALUES (3, 3, 'nome', 'descricao');
INSERT INTO Missao (id-missao, estacao, nome, descricao) VALUES (4, 4, 'nome', 'descricao');

-- Tabela Monstro 

INSERT INTO Monstro (id-monstro, drop, nome, descricao, dano, defesa, saude-maxima) VALUES (1, drop, 'nome', 'descricao', dano, defesa, saude-maxima);
INSERT INTO Monstro (id-monstro, drop, nome, descricao, dano, defesa, saude-maxima) VALUES (2, drop, 'nome', 'descricao', dano, defesa, saude-maxima);
INSERT INTO Monstro (id-monstro, drop, nome, descricao, dano, defesa, saude-maxima) VALUES (3, drop, 'nome', 'descricao', dano, defesa, saude-maxima);
INSERT INTO Monstro (id-monstro, drop, nome, descricao, dano, defesa, saude-maxima) VALUES (4, drop, 'nome', 'descricao', dano, defesa, saude-maxima);
INSERT INTO Monstro (id-monstro, drop, nome, descricao, dano, defesa, saude-maxima) VALUES (5, drop, 'nome', 'descricao', dano, defesa, saude-maxima);

-- Tabela Mundo 

INSERT INTO Mundo (id-mundo, nome) VALUES (1, 'nome');
INSERT INTO Mundo (id-mundo, nome) VALUES (2, 'nome');

-- Tabela NPC 

INSERT INTO NPC (id-npc, regiao, local, nome, profissao) VALUES (1, 1, local, 'nome', 'profissao');
INSERT INTO NPC (id-npc, regiao, local, nome, profissao) VALUES (2, 1, local, 'nome', 'profissao');
INSERT INTO NPC (id-npc, regiao, local, nome, profissao) VALUES (3, 1, local, 'nome', 'profissao');
INSERT INTO NPC (id-npc, regiao, local, nome, profissao) VALUES (4, 2, local, 'nome', 'profissao');
INSERT INTO NPC (id-npc, regiao, local, nome, profissao) VALUES (5, 2, local, 'nome', 'profissao');
INSERT INTO NPC (id-npc, regiao, local, nome, profissao) VALUES (5, 2, local, 'nome', 'profissao');

-- Tabela Região 

INSERT INTO Região (id-regiao, mundo, nome) VALUES (1, 1, 'nome');
INSERT INTO Região (id-regiao, mundo, nome) VALUES (2, 1, 'nome');
INSERT INTO Região (id-regiao, mundo, nome) VALUES (3, 2, 'nome');
INSERT INTO Região (id-regiao, mundo, nome) VALUES (4, 2, 'nome');

-- Tabela Semente 

INSERT INTO Semente (id-semente, estacao, nome, descricao, valor-venda, dias-para-crescer) VALUES (1, 1, 'nome', 'descricao', valor-venda, dias-para-crescer);
INSERT INTO Semente (id-semente, estacao, nome, descricao, valor-venda, dias-para-crescer) VALUES (2, 1, 'nome', 'descricao', valor-venda, dias-para-crescer);
INSERT INTO Semente (id-semente, estacao, nome, descricao, valor-venda, dias-para-crescer) VALUES (3, 2, 'nome', 'descricao', valor-venda, dias-para-crescer);
INSERT INTO Semente (id-semente, estacao, nome, descricao, valor-venda, dias-para-crescer) VALUES (4, 2, 'nome', 'descricao', valor-venda, dias-para-crescer);
INSERT INTO Semente (id-semente, estacao, nome, descricao, valor-venda, dias-para-crescer) VALUES (5, 3, 'nome', 'descricao', valor-venda, dias-para-crescer);
INSERT INTO Semente (id-semente, estacao, nome, descricao, valor-venda, dias-para-crescer) VALUES (6, 3, 'nome', 'descricao', valor-venda, dias-para-crescer);

-- Tabela Vestimenta 

INSERT INTO Vestimenta (id-vestimenta, nome, descricao) VALUES (1, 'nome', 'descricao');
INSERT INTO Vestimenta (id-vestimenta, nome, descricao) VALUES (2, 'nome', 'descricao');
INSERT INTO Vestimenta (id-vestimenta, nome, descricao) VALUES (3, 'nome', 'descricao');
INSERT INTO Vestimenta (id-vestimenta, nome, descricao) VALUES (4, 'nome', 'descricao');
INSERT INTO Vestimenta (id-vestimenta, nome, descricao) VALUES (5, 'nome', 'descricao');
