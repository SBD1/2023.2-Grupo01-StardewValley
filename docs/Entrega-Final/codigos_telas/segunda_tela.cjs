const readlineSync = require('readline-sync');
const pgp = require('pg-promise')();

// ... (código de configuração do banco de dados)

// Inicializa o objeto de conexão
const db = pgp(dbConfig);

// ... (código das funções de coleta, plantação, pesca, etc.)

// Função principal para a segunda tela
async function segundaTela(jogador) {
  console.log("\nSegunda Tela - Tela de Região");

  try {
    // Exibe status do jogo: região, estação, dia e hora
    console.log(`Região: ${jogador.id_regiao}`);
    console.log(`Estação: ${jogador.id_estacao}`);
    console.log(`Dia: ${jogador.dia}`);
    console.log(`Hora: ${jogador.hora}`);

    // Exibe status do Jogador: energia, qtdd-ouro, níveis de habilidade
    const habilidade = await db.one('SELECT * FROM Habilidade WHERE id_jogador = $1', [jogador.id_jogador]);
    console.log(`Energia: ${jogador.energia}/${habilidade.nivel_energia}`);
    console.log(`Ouro: ${jogador.qtdd_ouro}`);
    console.log("Níveis de Habilidade:");
    console.log(`Coleta: ${habilidade.nivel_coleta}`);
    console.log(`Cultivo: ${habilidade.nivel_cultivo}`);
    console.log(`Mineração: ${habilidade.nivel_mineracao}`);
    console.log(`Pesca: ${habilidade.nivel_pesca}`);
    console.log(`Combate: ${habilidade.nivel_combate}`);

    // Exibe a descrição da região atual e os locais fechados que ela tem
    const query = `
      SELECT r.descricao, lf.nome AS local_fechado
      FROM Regiao r
      JOIN Local_Fechado lf ON r.id_regiao = lf.id_regiao
      JOIN Jogador j ON j.id_regiao = r.id_regiao
      WHERE r.id_regiao = $1;
    `;
    const result = await db.one(query, [jogador.id_regiao]);
    console.log(`Descrição da Região: ${result.descricao}`);
    console.log(`Locais Fechados: ${result.local_fechado}`);

    // Pergunta ao jogador o que ele quer fazer
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

    // Executa a ação correspondente à escolha do jogador
    switch (escolha) {
      case 0: // Coletar
        await coletarItens(jogador);
        break;
      case 1: // Plantar
        await plantarSemente(jogador);
        break;
      case 2: // Pescar
        if (jogador.id_local_fechado === "praia") {
          await pescarItens(jogador);
        } else {
          console.log("Você só pode pescar se estiver na praia.");
        }
        break;
      case 3: // Craftar
        await craftarItem(jogador);
        break;
      case 4: // Conversar com NPC
        await ConversaComNPC(jogador);
        break;
      case 5: // Minerar ou Combater
        await mineracaoOuCombate(jogador);
        break;
      case 6: // Ir a um Local Fechado
        await irAumLocalFechado(jogador);
        break;
      case 7: // Mudar de Região
        await mudarDeRegiao(jogador);
        break;
      case 8: // Ver Itens do Inventário
        await visualizarInventario(jogador);
        break;
      default:
        console.log("Escolha inválida.");
    }
  } catch (error) {
    console.error('Erro durante a execução da segunda tela:', error.message || error);
  }
}

// Exemplo de chamada da função principal para iniciar a segunda tela
const jogadorExemplo = {
  id_jogador: 1, // Substitua pelo ID do jogador
  id_regiao: 1,   // Substitua pelo ID da região
  id_estacao: 1,  // Substitua pelo ID da estação
  dia: 1,         // Substitua pelo dia atual
  hora: 360,      // Substitua pela hora atual
  energia: 100,   // Substitua pela energia atual
  qtdd_ouro: 500, // Substitua pela quantidade de ouro atual
};

segundaTela(jogadorExemplo);
