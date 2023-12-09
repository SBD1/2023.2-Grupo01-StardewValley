import { connect } from "../db.js";
import readlineSync from "readline-sync";

async function consultarTiposNoInventario(idJogador) {
  const client = await connect();
  try {
    const query = `
      SELECT DISTINCT ti.nome_tipo_item
      FROM Item_Inventario ii
      JOIN Item i ON ii.id_item = i.id_item
      JOIN Tipo_Item ti ON i.id_tipo_item = ti.id_tipo_item
      WHERE ii.id_jogador = $1;
    `;

    const resultado = await client.query(query, [idJogador]);

    // Processa os resultados
    for (const linha of resultado.rows) {
      console.log("|  ", linha.nome_tipo_item);
    }
  } catch (error) {
    console.error(
      "Erro ao consultar tipos de itens no inventário:",
      error.message || error
    );
  }
}

// Função para obter IDs de itens que começam com o jogo
async function obterItensInicioJogo() {
  const client = await connect();
  try {
    const ferramentas = await client.query(
      "SELECT id_ferramenta FROM Ferramenta WHERE comeca_jogo_com = true"
    );

    const armas = await client.query(
      "SELECT id_arma FROM Arma WHERE comeca_jogo_com = true"
    );

    // Combine os IDs de ferramentas e armas em um único array
    const idsFerramentas = ferramentas.rows.map(
      (ferramenta) => ferramenta.id_ferramenta
    );
    const idsArmas = armas.rows.map((arma) => arma.id_arma);

    return [...idsFerramentas, ...idsArmas];
  } catch (error) {
    console.error(
      "Erro ao obter IDs de itens de início de jogo:",
      error.message || error
    );
    return [];
  }
}

async function criarItensInventario(idJogador, idItens) {
  const client = await connect();
  try {
    // Verifica se os itens existem antes de adicioná-los ao inventário
    const placeholders = idItens.map((_, index) => `$${index + 1}`).join(", ");
    const verificaQuery = `SELECT id_item FROM Item WHERE id_item IN (${placeholders})`;
    const itemsVerificados = await client.query(verificaQuery, idItens);

    // Prepara a inserção na tabela Item_Inventario
    for (const item of itemsVerificados.rows) {
      const insertQuery = `
        INSERT INTO Item_Inventario (id_jogador, id_item, qtdd)
        VALUES ($1, $2, $3)
        ON CONFLICT (id_jogador, id_item) 
        DO UPDATE SET qtdd = Item_Inventario.qtdd + 1;`;

      await client.query(insertQuery, [idJogador, item.id_item, 1]);
      console.log(
        `Item ${item.id_item} adicionado ao inventário do jogador ${idJogador}`
      );
    }
  } catch (error) {
    console.error("Erro ao criar itens no inventário:", error.message || error);
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

  await consultarTiposNoInventario(jogador.id_jogador);

  console.log("|__________________________________________\n");
}

// Função principal para a primeira tela
async function primeiraTela() {
  const client = await connect();

  console.log("\n==================================");
  console.log("Bem-vindo ao Stardew Valley - MUD!");
  console.log("==================================\n");

  // Pede para o jogador fornecer seu nome
  const nomeJogador = readlineSync.question("Digite seu nome: ");

  try {
    // Chama a stored procedure para iniciar o jogo
    const result = await client.query("select iniciar_jogo($1)", [nomeJogador]);
    //console.log("Resultado da stored procedure:", result);

    // Verifica se o jogo foi iniciado com sucesso
    const jogoIniciado = result.rows[0].iniciar_jogo;

    if (jogoIniciado) {
      console.log("\nJogo iniciado para o(a) jogador(a)", nomeJogador);
    } else {
      console.log(
        `\nO(A) jogador(a) ${nomeJogador} já existe. Suas informações serão recuperadas.`
      );
    }

    // Mostra mundos disponiveis
    const mundos = await client.query("SELECT * FROM Mundo");
    console.log("\nMundos disponíveis:");
    console.log("===================\n");

    for (const mundo of mundos.rows) {
      console.log(
        `${mundo.id_mundo}. ${mundo.nome.trim()} - ${mundo.descricao.trim()}`
      );
    }

    // Pede para o jogador escolher um mundo
    const escolhaMundo = readlineSync.questionInt("\nEscolha um mundo: ");
    console.log("\nMundo escolhido:", escolhaMundo);

    // Obtém regiões existentes no mundo escolhido
    const regioesMundoEscolhido = await client.query(
      "SELECT * FROM Regiao WHERE id_mundo = $1",
      [escolhaMundo]
    );
    console.log("\nRegiões disponíveis no mundo escolhido:");
    console.log("=======================================\n");

    for (const regiao of regioesMundoEscolhido.rows) {
      console.log(
        `${
          regiao.id_regiao
        }. ${regiao.nome.trim()} - ${regiao.descricao.trim()}`
      );
    }

    // Pede para o jogador escolher uma região
    const escolhaRegiao = readlineSync.questionInt("\nEscolha uma regiao: ");
    console.log("\nRegião escolhida:", escolhaRegiao);

    // Obtém informações da região escolhida
    const regiaoEscolhida = await client.query(
      "SELECT * FROM Regiao WHERE id_regiao = $1",
      [escolhaRegiao]
    );

    // Cria novas linhas na tabela Habilidade
    const result_jogador = await client.query(
      "SELECT * FROM Jogador WHERE nome = $1",
      [nomeJogador]
    );
    const jogador = result_jogador.rows[0];

    const habilidadeData = {
      id_jogador: jogador.id_jogador,
      nivel_coleta: 1,
      nivel_cultivo: 1,
      nivel_mineracao: 1,
      nivel_pesca: 1,
      nivel_combate: 1,
    };

    const queryHabilidadesIniciais =
      "INSERT INTO habilidade (id_jogador, nivel_coleta, nivel_cultivo, nivel_mineracao, nivel_pesca, nivel_combate) VALUES ($1, $2, $3, $4, $5, $6) ON CONFLICT (id_jogador) DO NOTHING";
    await client.query(queryHabilidadesIniciais, [
      habilidadeData.id_jogador,
      habilidadeData.nivel_coleta,
      habilidadeData.nivel_cultivo,
      habilidadeData.nivel_mineracao,
      habilidadeData.nivel_pesca,
      habilidadeData.nivel_combate,
    ]);

    console.log("\nNíveis iniciais de Habilidades inseridos com sucesso.\n");

    // Cria linhas na tabela Item_Inventario
    const itensInventario = await obterItensInicioJogo(); // IDs dos itens que o jogador começa com eles
    //console.log(
    //  "IDs dos itens que o jogador começa com eles:",
    //  itensInventario
    //);
    await criarItensInventario(jogador.id_jogador, itensInventario);

    // Exibe status do jogador e inventário
    const res_habilidade = await client.query(
      "SELECT * FROM Habilidade WHERE id_jogador = $1",
      [jogador.id_jogador]
    );

    const habilidade = res_habilidade.rows[0];
    await exibirStatusEInventario(jogador, habilidade, itensInventario);

    // Pede confirmação para ir para a nova região
    const confirmacao = readlineSync.keyInYNStrict(
      "Deseja ir para a nova região?"
    );

    if (confirmacao) {
      // Redireciona para a segunda tela (simulação)
      console.log("Indo para a nova região...");
    } else {
      // Encerra o jogo ou exibe mensagem de despedida (simulação)
      console.log("Jogo encerrado.");
    }
  } catch (error) {
    console.error("Erro ao executar a primeira tela:", error.message || error);
  } finally {
    // Fecha a conexão com o banco de dados
    console.log("Operações no banco de dados para fechar a conexão...");
    client.end();
  }
}

// Chama a função principal para iniciar o jogo
export { primeiraTela };
