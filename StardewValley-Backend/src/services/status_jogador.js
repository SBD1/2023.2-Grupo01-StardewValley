import { connect } from "../db.js";

export async function statusJogador(idJogador) {
  console.log(`Connection string: ${process.env.CONNECTION_STRING}`);
  const client = await connect();

  const query = `SELECT j.energia, j.qtdd_ouro, h.nivel_coleta, h.nivel_cultivo, h.nivel_mineracao, h.nivel_pesca, h.nivel_pesca, h.nivel_combate FROM jogador j 
  join Habilidade h on h.id_jogador = j.id_jogador
  where j.id_jogador = $1`;

  const result = await client.query(query, [idJogador]);

  // retorna objeto de status do jogador(energia, ouro e nivel de habilidades)
  return result.rows[0];
}
