-- Inserção de dados na tabela Arma
INSERT INTO Arma (nome, descricao, dano, finalidade, id_item) VALUES 
('espada', 'arma balanceada', 3, 'atacar monstros', 1),
('adaga', 'arma mais rápida de curto alcance', 2, 'atacar monstros', 2),
('clava', 'arma mais lenta de longo alcance', 5, 'atacar monstros', 3),
('estilingue', 'arma de longo alcance, sem contato', 6, 'atacar monstros', 4);


-- Insercao de dados na tabela (sem especificar id_estacao)
INSERT INTO Estacao (nome, descricao) VALUES 
('Primavera', 'descrição da primavera'),
('Verão', 'descrição do verão'),
('Outono', 'descrição do outono'),
('Inverno', 'descrição do inverno');
