import { connect } from "../db.js";
import readlineSync from "readline-sync";

async function segunda_tela(nomeJogador, regiao) {

  const client = await connect();
  console.log("\nSegunda Tela - Tela de Região");


  let infoRegiao = await client.query(`SELECT * from regiao where nome=$1;`, [regiao])
  infoRegiao = infoRegiao.rows[0];

  let infoJogador = await client.query(`SELECT * from jogador where nome=$1;`, [nomeJogador])
  infoJogador = infoJogador.rows[0]

  let infoEstacao = await client.query(`SELECT * from estacao where id_estacao=$1;`, [infoJogador.id_estacao])
  infoEstacao = infoEstacao.rows[0]

  // console.log(infoRegiao);
  // console.log(infoJogador);

  try {
    // Exibe status do jogo: região, estação, dia e hora
    console.log(`Região: ${infoJogador.nome}`);
    console.log(`Estação: ${infoEstacao.nome}`);
    console.log(`Dia: ${infoJogador.dia}`);
    console.log(`Hora: ${infoJogador.hora}`);

    let habilidades = await client.query('SELECT * FROM Habilidade WHERE id_jogador = $1', [infoJogador.id_jogador]);
    habilidades = habilidades.rows[0];
    // console.log(habilidades)


    console.log(`Energia: ${infoJogador.energia}/${infoJogador.energia}`); //???????????????????????????????
    console.log(`Ouro: ${infoJogador.qtdd_ouro}`);
    console.log("\n\nNíveis de Habilidade:");
    console.log(`Coleta: ${habilidades.nivel_coleta}`);
    console.log(`Cultivo: ${habilidades.nivel_cultivo}`);
    console.log(`Mineração: ${habilidades.nivel_mineracao}`);
    console.log(`Pesca: ${habilidades.nivel_pesca}`);
    console.log(`Combate: ${habilidades.nivel_combate}`);

    // Exibe a descrição da região atual e os locais fechados que ela tem
    
    let infoLocaisFechados = await client.query(`SELECT * FROM regiao r WHERE r.id_regiao = $1;`, [infoRegiao.id_regiao])
    infoLocaisFechados = infoLocaisFechados.rows[0]
    console.log(infoLocaisFechados)

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
        await coletarItens(regiao);
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