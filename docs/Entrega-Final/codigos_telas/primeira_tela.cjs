const readlineSync = require('readline-sync');
const { Client } = require('pg');
const { exec } = require('child_process');

const connectionString = 'postgres://postgres:' + encodeURIComponent('unbPGSQL#21') + '@localhost:5432/StardewValley';
const client = new Client({
  connectionString: connectionString,
});

// Objeto para manipulação do banco de dados usando pg-promise
const pgp = require('pg-promise')();
const db = pgp(connectionString);

// Função para obter IDs de itens que começam com o jogo
async function obterItensInicioJogo() {
    try {
      const ferramentas = await db.any('SELECT id_ferramenta FROM Ferramenta WHERE comeca_jogo_com = true');
      const armas = await db.any('SELECT id_arma FROM Arma WHERE comeca_jogo_com = true');
  
      // Combine os IDs de ferramentas e armas em um único array
      const idsFerramentas = ferramentas.map((ferramenta) => ferramenta.id_ferramenta);
      const idsArmas = armas.map((arma) => arma.id_arma);
  
      return [...idsFerramentas, ...idsArmas];
    } catch (error) {
      console.error('Erro ao obter IDs de itens de início de jogo:', error.message || error);
      return [];
    }
  }
  
// Função para criar novas linhas na tabela Item_Inventario
async function criarItensInventario(idJogador, idItens) {
  try {
    const items = await db.any('SELECT * FROM Item WHERE id_item IN ($1:csv)', [idItens]);

    for (const item of items) {
      console.log(`Item ${item.id_item} adicionado ao inventário do jogador ${idJogador}`);
    }
  } catch (error) {
    console.error('Erro ao criar itens no inventário:', error.message || error);
  }
}

// Função para exibir status do jogador e inventário
async function exibirStatusEInventario(jogador, habilidade, itensInventario) {
  console.log(" \n__________________________________________");
  console.log(`|           Stardew Valley - MUD            `);
  console.log(`| Nome: ${jogador.nome}                     `);
  console.log(`| Energia: ${jogador.energia}               `);
  console.log(`| Ouro: ${jogador.qtdd_ouro}                `);
  console.log(`| Níveis de Habilidade:                     `);
  console.log(`|   Coleta: ${habilidade.nivel_coleta}      `);
  console.log(`|   Cultivo: ${habilidade.nivel_cultivo}    `);
  console.log(`|   Mineração: ${habilidade.nivel_mineracao}`);
  console.log(`|   Pesca: ${habilidade.nivel_pesca}        `);
  console.log(`|   Combate: ${habilidade.nivel_combate}    `);
  console.log("| Inventário:                               ");
  
  //await criarItensInventario(jogador.id_jogador, itensInventario);

  console.log("|__________________________________________\n");
}

// Função principal para a primeira tela
async function primeiraTela() {
    console.log("\n==================================");
    console.log("Bem-vindo ao Stardew Valley - MUD!");
    console.log("==================================\n");

  // Pede para o jogador fornecer seu nome
  const nomeJogador = readlineSync.question("Digite seu nome: ");

  try {
    // Chama a stored procedure para iniciar o jogo
    const result = await db.func('iniciar_jogo', nomeJogador);
    //console.log('Resultado da stored procedure:', result);

    // Verifica se o jogo foi iniciado com sucesso
    const jogoIniciado = result[0].jogo_iniciado;

    if (jogoIniciado) {
      console.log('\nJogo iniciado para o(a) jogador(a)', nomeJogador)
    } else {
        console.log(`\nO(A) jogador(a) ${nomeJogador} já existe. Suas informações serão recuperadas.`);
    }

    // Mostra mundos disponiveis
    const mundos = await db.any('SELECT * FROM Mundo'); 
    console.log("\nMundos disponíveis:");
    console.log("===================\n");

    for (const mundo of mundos) {
        console.log(`${mundo.id_mundo}. ${mundo.nome.trim()} - ${mundo.descricao.trim()}`);
    }

    // Pede para o jogador escolher um mundo
    const escolhaMundo = readlineSync.questionInt("\nEscolha um mundo: ");
    console.log('\nMundo escolhido:', escolhaMundo);

    // Obtém regiões existentes no mundo escolhido
    const regioesMundoEscolhido = await db.any('SELECT * FROM Regiao WHERE id_mundo = $1', [escolhaMundo]);
    console.log("\nRegiões disponíveis no mundo escolhido:");
    console.log("=======================================\n");

    for (const regiao of regioesMundoEscolhido) {
      console.log(`${regiao.id_regiao}. ${regiao.nome.trim()} - ${regiao.descricao.trim()}`);
    }

    // Pede para o jogador escolher uma região
    const escolhaRegiao = readlineSync.questionInt("\nEscolha uma regiao: ");
    console.log('\nRegião escolhida:', escolhaRegiao);

    // Obtém informações da região escolhida
    const regiaoEscolhida = await db.one('SELECT * FROM Regiao WHERE id_regiao = $1', [escolhaRegiao]);

    // Cria novas linhas na tabela Habilidade
    const jogador = await db.one('SELECT * FROM Jogador WHERE nome = $1', [nomeJogador]);
    const habilidadeData = {
        id_jogador: jogador.id_jogador,
        nivel_coleta: 1,
        nivel_cultivo: 1,
        nivel_mineracao: 1,
        nivel_pesca: 1,
        nivel_combate: 1,
      };
      const query = pgp.helpers.insert(habilidadeData, null, 'habilidade');
      await db.none(query);
      console.log('\nNíveis iniciais de Habilidades inseridos com sucesso.\n');

    // Cria linhas na tabela Item_Inventario
    const itensInventario = await obterItensInicioJogo(); // IDs dos itens que o jogador começa com eles
    await criarItensInventario(jogador.id_jogador, itensInventario);

    // Exibe status do jogador e inventário
    const habilidade = await db.one('SELECT * FROM Habilidade WHERE id_jogador = $1', [jogador.id_jogador]);
    await exibirStatusEInventario(jogador, habilidade, itensInventario);

    // Pede confirmação para ir para a nova região
    const confirmacao = readlineSync.keyInYNStrict("Deseja ir para a nova região?");

    if (confirmacao) {
      // Redireciona para a segunda tela (simulação)
      console.log("Indo para a nova região...");
    } else {
      // Encerra o jogo ou exibe mensagem de despedida (simulação)
      console.log("Jogo encerrado.");
    }
  } catch (error) {
    console.error('Erro ao executar a primeira tela:', error.message || error);
  } finally {
    // Fecha a conexão com o banco de dados
    console.log("Operações no banco de dados para fechar a conexão...");
    await client.end();
  }
}

// Chama a função principal para iniciar o jogo
primeiraTela();
