import { connect } from "../db";

async function coletarItens(jogador) {
  console.log(jogador)
  console.log(`Connection string: ${process.env.CONNECTION_STRING}`);
  const client = await connect();

  const query = `SELECT c.id_consumivel, c.id_regiao, c.id_local_fechado, c.id_ferramenta, c.nome, c.descricao FROM consumivel c
  where c.id_regiao = $1`;

  
  const result = await client.query(query, [jogador]);

  // retorna objeto de status do jogador(energia, ouro e nivel de habilidades)
  return result.rows[0];
}

