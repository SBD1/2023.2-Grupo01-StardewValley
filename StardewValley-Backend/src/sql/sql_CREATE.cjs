const { Client } = require('pg');
const fs = require('fs');

const connectionString = 'postgres://postgres:unbPGSQL#21@localhost:5432/StardewValley';
const client = new Client({
  connectionString: connectionString,
});

// Conectar ao banco de dados
client.connect()
  .then(() => {
    console.log('Conectado ao banco de dados PostgreSQL');
    // Aqui você pode realizar operações no banco de dados
  })
  .catch((err) => {
    console.error('Erro ao conectar ao banco de dados:', err);
  })
  .finally(() => {
    // Certifique-se de sempre encerrar a conexão quando não precisar mais
    client.end();
  });

async function executarConsultas(arquivoSQL) {
  try {
    await client.connect();

    // Ler o conteúdo do arquivo SQL
    const consultaSQL = fs.readFileSync(arquivoSQL, 'utf-8');

    // Dividir o conteúdo em consultas individuais
    const consultas = consultaSQL.split(';').map((consulta) => consulta.trim()).filter(Boolean);

    // Executar cada consulta
    for (const consulta of consultas) {
      await client.query(consulta);
      console.log(`Consulta executada:\n${consulta}\n`);
    }

    console.log('Tabelas criadas com sucesso!');

  } catch (err) {
    console.error('Erro ao executar consultas:', err);

  } finally {
    await client.end();
  }
}

executarConsultas('DDL.sql');
