import { statusJogo } from "../services/statusJogo.js";

export async function mostrarStatusJogo(idJogador) {
  const status = await statusJogo(idJogador);
  console.log("------------------------------------");
  console.log("Status do jogo:");
  console.log(`Região: ${status.regiao}`);
  console.log(`Estação: ${status.estacao}`);
  console.log(`Dia: ${status.dia}`);
  console.log(`Hora: ${status.hora}`);
  console.log("------------------------------------");
}
