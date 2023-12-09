--CREATE USER stardew_player WITH PASSWORD '1234';


CREATE DATABASE stardew_valley
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    IS_TEMPLATE = False;

--GRANT ALL PRIVILEGES ON DATABASE stardew_valley TO stardew_player;
