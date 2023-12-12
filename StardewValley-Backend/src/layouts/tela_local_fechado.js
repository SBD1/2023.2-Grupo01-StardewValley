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

  iniciarAvancoTempo(dadosJogador);
  // Exibe status do jogo: região, estação, dia e hora
  console.log(`Região: ${jogador.id_regiao}`);
  console.log(`Estação: ${jogador.id_estacao}`);
  console.log(`Dia: ${jogador.dia}`);
  console.log(`Hora: ${jogador.hora}`);

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

// Exemplo de chamada da função principal para iniciar a tela de local fechado
const jogadorExemplo = {
  id_jogador: 1, // Substitua pelo ID do jogador
  id_regiao: 1, // Substitua pelo ID da região
  id_estacao: 1, // Substitua pelo ID da estação
  dia: 1, // Substitua pelo dia atual
  hora: 360, // Substitua pela hora atual
  energia: 100, // Substitua pela energia atual
  qtdd_ouro: 500, // Substitua pela quantidade de ouro atual
  id_local_fechado: "loja", // Substitua pelo ID do local fechado atual
};

// Função para iniciar o avanço de tempo em intervalos regulares
function iniciarAvancoTempo(dadosJogador) {
  const intervalo = 10 * 1000;
  setInterval(() => {
    avancarTempo(dadosJogador);
  }, intervalo);
}

localFechado(jogadorExemplo);
