-- Verifique se o banco de dados já existe
DO $$ 
BEGIN 
  IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'stardew_valley') THEN 
    -- Crie o banco de dados se ele não existir
    CREATE DATABASE stardew_valley;
  END IF;
END $$;


-- Conecte-se ao banco de dados
\c stardew_valley;