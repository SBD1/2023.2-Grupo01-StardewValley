-- Forçar a exclusão do banco de dados, encerrando todas as sessões ativas
SELECT pg_terminate_backend (pg_stat_activity.pg_backend_pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'stardew_valley';

-- Aguarde um momento para garantir que todas as sessões sejam encerradas

-- Exclua o banco de dados
DROP DATABASE IF EXISTS stardew_valley;
