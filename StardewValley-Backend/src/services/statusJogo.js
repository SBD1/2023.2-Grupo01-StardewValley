import { connect } from "../db.js";
import segundosParaHHMM from "../utils/segundosParaHHMM.js";

export async function obterStatusJogo(idJogador) {
  const client = await connect();
  const query = `SELECT j.nome as jogador, r.nome as regiao, e.nome as estacao, j.dia, j.hora FROM Jogador j
    JOIN Estacao e ON j.id_estacao = e.id_estacao 
    JOIN Regiao r ON j.id_regiao = r.id_regiao
    WHERE j.id_jogador = $1`;

  const result = await client.query(query, [idJogador]);
  const horaFormatada = segundosParaHHMM(result.rows[0].hora);

  await client.end();
  // retorna objeto de status do jogo
  return {
    nome: result.rows[0].jogador,
    regiao: result.rows[0].regiao,
    //localFechado: result.rows[0].local,
    estacao: result.rows[0].estacao,
    dia: result.rows[0].dia,
    hora: horaFormatada,
  };
}

export async function exibirStatusJogo(dadosJogador) {
    console.log(" \n____________________________________________________________");
    console.log(`|           Status Jogo - Satrdew Valley           `);
    console.log(`|           ============================           `);
    console.log(`| Nome: ${dadosJogador.nome}                       `);
    console.log(`| Região: ${dadosJogador.regiao}                   `);
    //console.log(`| Local: ${dadosJogador.localFechado !== null ? dadosJogador.localFechado : 'local aberto'} `);
    console.log(`| Estação: ${dadosJogador.estacao}                 `);
    console.log(`| Dia: ${dadosJogador.dia}                         `);
    console.log(`| Hora: ${dadosJogador.hora}                       `);
    console.log("|____________________________________________________________\n");
}
