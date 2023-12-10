import { connect } from "../db.js";
import segundosParaHHMM from "../utils/segundosParaHHMM.js";

export async function statusJogo(idJogador) {
  const client = await connect();
  const query = `SELECT r.nome ,  e.nome as estacao ,	j.dia, j.hora FROM Jogador j
    JOIN Estacao e ON j.id_estacao = e.id_estacao 
    JOIN Regiao r ON j.id_regiao = r.id_regiao
    WHERE j.id_jogador = $1`;

  const result = await client.query(query, [idJogador]);
  const horaFormatada = segundosParaHHMM(result.rows[0].hora);

  client.end();
  // retorna objeto de status do jogo
  console.log({
    regiao: result.rows[0].nome,
    estacao: result.rows[0].estacao,
    dia: result.rows[0].dia,
    hora: horaFormatada,
  });
}
