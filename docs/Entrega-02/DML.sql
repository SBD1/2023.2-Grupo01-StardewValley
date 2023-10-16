-- ----------------------------------------------------------------- 
-- Data Criacao ...........: 16/10/2023 
-- Autor(es) ..............: Zenilda Vieira 
-- Versao ..............: 1.0 
-- Banco de Dados .........: PostgreSQL 
-- Descricao .........: Carga de todas as tabelas do banco de dados. 
-- ------------------------------------------------------------------------------ 
-- Data Atualizacao ...........: xx/xx/2023 
-- Autor(es) ..............: 
-- Descricao .........: 
-- ------------------------------------------------------------------------------ 

-- Carga da tabela Item

insert into Item (id-item, id-tipo) 
    values  ('','ferramenta'),
            ('enxada', 'ferramenta'),

insert into Item (id-item, id-tipo) 
    values  ('semente-chirivia','semente'),
            ('semente-couve-flor', 'semente'),

insert into Item (id-item, id-tipo) 
    values  ('chirivia','consumivel'),
            ('couve-flor', 'consumivel'),

insert into Item (id-item, id-tipo) 
    values  ('','arma'),
            ('espada', 'arma'),

insert into Item (id-item, id-tipo) 
    values  ('','vestimenta'),
            ('calca','vestimenta'),

insert into Item (id-item, id-tipo) 
    values  ('','artesanato'),
            ('bau','artesanato');

