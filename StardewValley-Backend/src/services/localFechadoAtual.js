import { connect } from "../db.js";

export async function localFechadoAtual(idJogador) {
  const client = await connect();

  const query = `SELECT DISTINCT tlc.nome_tipo_local_fechado FROM Jogador j
  JOIN Regiao r ON j.id_regiao = r.id_regiao 
  LEFT JOIN Local_fechado lf ON j.id_local_fechado = lf.id_tipo_local_fechado
  LEFT JOIN tipo_local_fechado tlc ON j.id_local_fechado = tlc.id_tipo_local_fechado
  WHERE j.id_jogador = $1`;

  const result = await client.query(query, [idJogador]);

  client.end();
  return result.rows[0].nome_tipo_local_fechado;
}
