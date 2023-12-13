import { connect } from "../db.js";
import { obterStatusJogador, exibirStatusJogador } from "../services/status_jogador.js";
import { obterStatusJogo, exibirStatusJogo } from "../services/statusJogo.js";
import { coletarItens } from "../services/funcao_coletarItens.js";
import { plantarSementes } from "../services/funcao_plantarSemente.js";
import {pescar} from "../services/funcao_pescarItens.js";
import { avancarTempo } from "../services/avancarTempo.js";
import readlineSync from "readline-sync";

async function segunda_tela(regiao, dadosJogador) {

  const client = await connect();
  console.log("\nSegunda Tela - Tela de Região");

  let infoRegiao = await client.query(`SELECT * from regiao where nome=$1;`, [regiao.nome])
  infoRegiao = infoRegiao.rows[0];

  let infoJogador = await client.query(`SELECT * from jogador where id_jogador=$1;`, [dadosJogador])
  infoJogador = infoJogador.rows[0]

  let infoEstacao = await client.query(`SELECT * from estacao where id_estacao=$1;`, [infoJogador.id_estacao])
  infoEstacao = infoEstacao.rows[0]

  // console.log(infoRegiao);
  // console.log(infoJogador);
  // console.log(infoEstacao)

  try {
    console.clear();
    iniciarAvancoTempo(dadosJogador);

    const statusJogador = await obterStatusJogador(infoJogador.id_jogador);
    await exibirStatusJogador(statusJogador);

    const statusJogo = await obterStatusJogo(infoJogador.id_jogador);
    await exibirStatusJogo(statusJogo);

    let infoLocaisFechados = await client.query(`SELECT * FROM regiao r WHERE r.id_regiao = $1;`, [infoRegiao.id_regiao])
    infoLocaisFechados = infoLocaisFechados.rows[0]
    //console.log(infoLocaisFechados)

    console.log(`\n\nDescrição da Região: ${infoLocaisFechados.descricao}`);


    //TODO
    // console.log(`Locais Fechados: ${result.local_fechado}`);

    // Pergunta ao regiao o que ele quer fazer

    let resultadoColeta = false;
    do {
      const opcaoEscolhida = await escolhaAtividade()
      resultadoColeta = await executarAtividade(opcaoEscolhida, infoRegiao, infoJogador)
    } while (!resultadoColeta)


  } catch (error) {
    console.error('Erro durante a execução da segunda tela:', error.message || error);
    client.end()
  }
}

async function escolhaAtividade() {
  const opcoes = [
    "Coletar",
    "Plantar",
    "Pescar",
    "Craftar",
    "Conversar com NPC",
    "Minerar ou Combater",
    "Ir a um Local Fechado",
    "Mudar de Região",
    "Ver Itens do Inventário"
  ];
  const opcaoEscolhida = readlineSync.keyInSelect(opcoes, "O que você quer fazer?", { cancel: false });
  return opcaoEscolhida;
}

async function executarAtividade(opcaoEscolhida, infoRegiao, infoJogador) {
  switch (opcaoEscolhida) {
    case 0: // Coletar
      let resultadoColeta = await coletarItens(infoRegiao, infoJogador);
      if (!resultadoColeta) {
        return resultadoColeta
      }

      break;
    case 1: // Plantar
    let resultadoPlantacao = await plantarSementes(infoRegiao, infoJogador);
    if (!resultadoPlantacao) {
      return resultadoPlantacao
    }
      break;
    case 2: // Pescar
    let resultadoPesca = await pescar(infoRegiao, infoJogador);
    if (!resultadoPesca) {
      return resultadoPesca
    }
      break;
    case 3: // Craftar
      await craftarItem(regiao);
      break;
    case 4: // Conversar com NPC
      await ConversaComNPC(regiao);
      break;
    case 5: // Minerar ou Combater
      await mineracaoOuCombate(regiao);
      break;
    case 6: // Ir a um Local Fechado
      await irAumLocalFechado(regiao);
      break;
    case 7: // Mudar de Região
      await mudarDeRegiao(regiao);
      break;
    case 8: // Ver Itens do Inventário
      await visualizarInventario(regiao);
      break;
    default:
      console.log("Escolha inválida.");
  }
}

// Função para iniciar o avanço de tempo em intervalos regulares
function iniciarAvancoTempo(dadosJogador) {
  const intervalo = 10 * 1000;
  setInterval(() => {
    avancarTempo(dadosJogador);
  }, intervalo);
}


export { segunda_tela }