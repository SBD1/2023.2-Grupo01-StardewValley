import { connect } from "../db.js";
import { obterStatusJogador, exibirStatusJogador } from "../services/status_jogador.js";
import { obterStatusJogo, exibirStatusJogo } from "../services/statusJogo.js";
import { coletarItens } from "../services/funcao_coletarItens.js";
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

    const escolha = readlineSync.keyInSelect(opcoes, "O que você quer fazer?");

    // Executa a ação correspondente à escolha do regiao
    switch (escolha) {
      case 0: // Coletar
        await coletarItens(infoRegiao, infoJogador);
        break;
      case 1: // Plantar
        await plantarSemente(regiao);
        break;
      case 2: // Pescar
        if (regiao.id_local_fechado === "praia") {
          await pescarItens(regiao);
        } else {
          console.log("Você só pode pescar se estiver na praia.");
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
  } catch (error) {
    console.error('Erro durante a execução da segunda tela:', error.message || error);
    client.end()
  }
}


export { segunda_tela }