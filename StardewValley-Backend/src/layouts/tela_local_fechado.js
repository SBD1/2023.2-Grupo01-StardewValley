import { connect } from "../db.js";
import { mostrarStatusJogo } from "../utils/mostrarStatusJogo.js";
import { mostrarStatusJogador } from "../utils/mostrarStatusJogador.js";
import { statusJogo } from "../services/statusJogo.js";
import readlineSync from "readline-sync";
import { cavernasDisponiveis } from "../services/cavernasDisponiveis.js";
import { dinamicaCasa } from "../services/dinamicaCasa.js";

export async function localFechado() {
  const client = await connect();

  // mock idJogador

  const idJogador = 1;

  // mostra na tela status do jogo
  mostrarStatusJogo(idJogador);
  // mostra na tela status do jogador
  mostrarStatusJogador(idJogador);

  const { regiao } = await statusJogo(idJogador);
  const resultadoLocalFechadoInicial = await client.query(
    `SELECT id_local_fechado FROM jogador WHERE id_jogador = $1`,
    [idJogador]
  );

  const { id_local_fechado } = resultadoLocalFechadoInicial.rows[0];

  console.log(
    `
    Você está andando pelo(a) ${regiao}. Deseja ir para algum lugar?
    `
  );

  // logicas para aplicar em cada local fechado
  // Cabana Jogador
  if (id_local_fechado === 1) {
    await dinamicaCasa(idJogador);
  }
  // Cabana_NPC
  else if (id_local_fechado === 2) {
  }
  // Caverna
  else if (id_local_fechado === 3) {
  }
  // Loja
  else if (id_local_fechado === 4) {
  }

  client.end();
}
