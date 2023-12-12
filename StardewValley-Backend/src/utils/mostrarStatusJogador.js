import { statusJogador } from "../services/status_jogador.js";

export async function mostrarStatusJogador(jogadorId) {
  const status = await statusJogador(jogadorId);

  console.log("------------------------------------");
  console.log("Status do jogador:");
  console.log(`Nome: ${status.nome}`);
  console.log(`Energia: ${status.energia}`);
  console.log(`Ouro: ${status.qtdd_ouro}`);
  console.log(`Pesca: ${status.nivel_pesca}`);
  console.log(`Combate: ${status.nivel_combate}`);
  console.log(`Coleta: ${status.nivel_coleta}`);
  console.log(`Cultivo: ${status.nivel_cultivo}`);
  console.log(`Mineração: ${status.nivel_mineracao}`);
  console.log("------------------------------------");
}
