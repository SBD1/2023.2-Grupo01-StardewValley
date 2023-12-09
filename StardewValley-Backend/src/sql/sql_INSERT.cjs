// carga_DDL.cjs
const { Client } = require('pg');

const connectionString = 'postgres://postgres:' + encodeURIComponent('unbPGSQL#21') + '@localhost:5432/StardewValley';
const client = new Client({
  connectionString: connectionString,
});

const fs = require('fs');

async function executarConsultas(client, arquivoSQL) {
  try {
    // Ler o conteúdo do arquivo SQL
    const consultaSQL = fs.readFileSync(arquivoSQL, 'utf-8');

    // Dividir o conteúdo em consultas individuais
    const consultas = consultaSQL.split(';').map((consulta) => consulta.trim()).filter(Boolean);

    // Adicionar o ponto e vírgula ao final de cada consulta
    const consultasComPontoEVirgula = consultas.map((consulta) => consulta + ';');

    // Executar cada consulta
    for (const consulta of consultasComPontoEVirgula) {
      await client.query(consulta);
      console.log(`Consulta executada:\n${consulta}\n`);
    }

    console.log('Dados inseridos com sucesso!');

  } catch (err) {
    console.error('Erro ao executar consultas:', err);

  }
}

// Exporta a função para que ela possa ser importada em outros arquivos
//module.exports = executarConsultas;



async function conectarBanco() {
  try {
    await client.connect();
    console.log('Conectado ao banco de dados PostgreSQL');

    // Execute suas operações no banco de dados aqui...
    await executarConsultas(client, 'DML.sql'); // Passa o client como argumento
    
  } catch (err) {
    console.error('Erro ao conectar ao banco de dados:', err);

  } finally {
    console.log('Banco de dados PostgreSQL desconectado');
    await client.end();
  }
}

conectarBanco();

