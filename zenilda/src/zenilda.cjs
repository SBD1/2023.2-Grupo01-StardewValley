const readlineSync = require('readline-sync');
const pgPromise = require('pg-promise');
const pg = require('pg');
const dotenv = require('dotenv');

dotenv.config();

const pgp = pgPromise();
const { Pool } = pg;

const configDatabase = {
  connectionString: process.env.DATABASE_URL
};

if (process.env.MODE === "prod") configDatabase.ssl = true;

const db = new Pool(configDatabase);
const database = pgp(db);

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

async function primeiraTela() {
  console.log("Bem-vindo ao Stardew Valley - MUD!\n");

  let nomeJogador = readlineSync.question("Digite seu nome: ");
  if (typeof nomeJogador !== 'string') {
    console.error('O nome do jogador deve ser uma string.');
    return;
  } else {
    console.log(`Bom jogo, ${nomeJogador}`);

  }
  


try {
  console.log(typeof nomeJogador);
  const result = await database.func('iniciar_jogo', nomeJogador);
  

  if (result[0].iniciar_jogo) {
    console.log(result[0].iniciar_jogo);
  } else {
    console.log('Não foi possível iniciar o jogo.');
    return;
  }

  const regioes = await db.any('SELECT * FROM Regiao WHERE id_mundo = $1', [1]);
  console.log("\nRegiões disponíveis:");

  for (const regiao of regioes) {
    console.log(`${regiao.id_regiao}. ${regiao.nome}`);
  }

  const escolhaRegiao = readlineSync.questionInt("Escolha uma região: ");
  const regiaoEscolhida = await db.one('SELECT * FROM Regiao WHERE id_regiao = $1', [escolhaRegiao]);

  const jogador = await db.one('SELECT * FROM Jogador WHERE nome = $1', [nomeJogador]);

  const itensInventario = [1, 2, 3, 4, 5, 6];
  await criarItensInventario(jogador.id_jogador, itensInventario);

  const habilidade = await db.one('SELECT * FROM Habilidade WHERE id_jogador = $1', [jogador.id_jogador]);
  await exibirStatusEInventario(jogador, habilidade, itensInventario);

  const confirmacao = readlineSync.keyInYNStrict("Deseja ir para a nova região?");

  if (confirmacao) {
    console.log("Indo para a nova região...");
  } else {
    console.log("Jogo encerrado.");
  }
} catch (error) {
  console.error('Erro ao executar a primeira tela:', error.message || error);
} finally {
  pgp.end();
}
}

primeiraTela();
