const readlineSync = require('readline-sync');
const pgp = require('pg-promise')();

// ... (código de configuração do banco de dados)

// Inicializa o objeto de conexão
const db = pgp(dbConfig);

// ... (código das funções de compra, mineração, combate, etc.)

// Função principal para a tela de local fechado
async function localFechado(jogador) {
  console.log("\nTela de um Local Fechado");

  try {
    iniciarAvancoTempo(dadosJogador);
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

    // Exibe a descrição da região atual e do local fechado que o jogador está
    const query = `
      SELECT r.descricao AS regiao_descricao, lf.descricao AS local_fechado_descricao
      FROM Regiao r
      JOIN Local_Fechado lf ON r.id_regiao = lf.id_regiao
      JOIN Jogador j ON j.id_regiao = r.id_regiao
      WHERE r.id_regiao = $1 AND lf.id_local_fechado = $2;
    `;
    const result = await db.one(query, [jogador.id_regiao, jogador.id_local_fechado]);
    console.log(`Descrição da Região: ${result.regiao_descricao}`);
    console.log(`Descrição do Local Fechado: ${result.local_fechado_descricao}`);

    // Pergunta ao jogador o que ele quer fazer de acordo com o tipo de local fechado
    switch (jogador.id_local_fechado) {
      case 'loja':
        await realizarCompra(jogador);
        break;
      case 'caverna':
        await explorarCaverna(jogador);
        break;
      case 'casa_npc':
        await conversarComNPC(jogador);
        break;
      case 'casa_jogador':
        await acaoCasaJogador(jogador);
        break;
      // ... (adicionar outros casos conforme necessário)
      default:
        console.log("Local fechado não reconhecido.");
    }
  } catch (error) {
    console.error('Erro durante a execução da tela de local fechado:', error.message || error);
  }
}

// Exemplo de chamada da função principal para iniciar a tela de local fechado
const jogadorExemplo = {
  id_jogador: 1,               // Substitua pelo ID do jogador
  id_regiao: 1,                // Substitua pelo ID da região
  id_estacao: 1,               // Substitua pelo ID da estação
  dia: 1,                      // Substitua pelo dia atual
  hora: 360,                   // Substitua pela hora atual
  energia: 100,                // Substitua pela energia atual
  qtdd_ouro: 500,              // Substitua pela quantidade de ouro atual
  id_local_fechado: 'loja'     // Substitua pelo ID do local fechado atual
};

localFechado(jogadorExemplo);
