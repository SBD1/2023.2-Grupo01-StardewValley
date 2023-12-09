// carga_DDL.cjs
const { Client } = require('pg');

const connectionString = 'postgres://postgres:' + encodeURIComponent('unbPGSQL#21') + '@localhost:5432/StardewValley';
const client = new Client({
  connectionString: connectionString,
});

const { exec } = require('child_process');

const comando = 'psql -U postgres -h localhost -a -f SP_Trig_View.sql';


async function conectarBanco() {
  try {
    await client.connect();
    console.log('Conectado ao banco de dados PostgreSQL');

    // Execute suas operações no banco de dados aqui...
    exec(comando, (erro, stdout, stderr) => {
        if (erro) {
          console.error(`Erro ao executar o comando: ${erro}`);
          return;
        }
      
        console.log(`Saída do comando:\n${stdout}`);
        console.error(`Erros do comando:\n${stderr}`);
      });
          
  } catch (err) {
    console.error('Erro ao conectar ao banco de dados:', err);

  } finally {
    console.log('Banco de dados PostgreSQL desconectado');
    await client.end();
  }
}

conectarBanco();

