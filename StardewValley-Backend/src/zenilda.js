const readlineSync = require('readline-sync');
const pgp = require('pg-promise')();

// Configurações de conexão com o banco de dados
// const dbConfig = {
//   host: 'localhost',
//   port: 5432,
//   database: 'seu_banco_de_dados',
//   user: 'seu_usuario',
//   password: 'sua_senha',
// };

// Inicializa o objeto de conexão
const db = pgp(dbConfig);

// Função para criar novas linhas na tabela Item_Inventario
async function criarItensInventario(idJogador, idItens) {
  try {
    const items = await db.any('SELECT * FROM Item WHERE id_item IN ($1:csv)', [idItens]);

    for (const item of items) {
      console.log(`Item ${item.nome} adicionado ao inventário do jogador ${idJogador}`);
    }
  } catch (error) {
    console.error('Erro ao criar itens no inventário:', error.message || error);
  }
}

// Função para exibir status do jogador e inventário
async function exibirStatusEInventario(jogador, habilidade, itensInventario) {
  console.log(" __________________________________________");
  console.log(`|           Stardew Valley - MUD           |`);
  console.log(`| Nome: ${jogador.nome}                      |`);
  console.log(`| Energia: ${jogador.energia}/${habilidade.nivel_energia}                         |`);
  console.log(`| Ouro: ${jogador.qtdd_ouro}                              |`);
  console.log(`| Níveis de Habilidade:                    |`);
  console.log(`|   Coleta: ${habilidade.nivel_coleta}                 |`);
  console.log(`|   Cultivo: ${habilidade.nivel_cultivo}                |`);
  console.log(`|   Mineração: ${habilidade.nivel_mineracao}             |`);
  console.log(`|   Pesca: ${habilidade.nivel_pesca}                  |`);
  console.log(`|   Combate: ${habilidade.nivel_combate}                |`);
  console.log("| Inventário:                             |");
  
  await criarItensInventario(jogador.id_jogador, itensInventario);

  console.log("|__________________________________________|\n");
}

// Função principal para a primeira tela
async function primeiraTela() {
  console.log("Bem-vindo ao Stardew Valley - MUD!\n");

  // Pede para o jogador fornecer seu nome
  const nomeJogador = readlineSync.question("Digite seu nome: ");

  try {
    // Chama a stored procedure para iniciar o jogo
    const result = await db.func('iniciar_jogo', nomeJogador);

    // Verifica se o jogo foi iniciado com sucesso
    if (result[0].iniciar_jogo) {
      console.log(result[0].iniciar_jogo);
    } else {
      console.log('Não foi possível iniciar o jogo.');
      return;
    }

    // Recupera informações da região escolhida pelo jogador
    const regioes = await db.any('SELECT * FROM Regiao WHERE id_mundo = $1', [1]); // Substitua o valor de 1 pelo mundo escolhido
    console.log("\nRegiões disponíveis:");

    for (const regiao of regioes) {
      console.log(`${regiao.id_regiao}. ${regiao.nome}`);
    }

    // Pede para o jogador escolher uma região
    const escolhaRegiao = readlineSync.questionInt("Escolha uma região: ");

    // Obtém informações da região escolhida
    const regiaoEscolhida = await db.one('SELECT * FROM Regiao WHERE id_regiao = $1', [escolhaRegiao]);

    // Cria novas linhas nas tabelas Jogador e Habilidade
    const jogador = await db.one('SELECT * FROM Jogador WHERE nome = $1', [nomeJogador]);

    // Cria linhas na tabela Item_Inventario
    const itensInventario = [1, 2, 3, 4, 5, 6]; // IDs dos itens que o jogador começa com eles
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
    pgp.end();
  }
}

// Chama a função principal para iniciar o jogo
primeiraTela();
