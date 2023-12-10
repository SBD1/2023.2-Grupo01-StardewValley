import { connect } from "../db.js";
//import { segundaTela } from "./layouts/segunda_tela.js";
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
  await client.end();
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

    await client.end();
    return [...idsFerramentas, ...idsArmas];
  } catch (error) {
    console.error(
      "Erro ao obter IDs de itens de início de jogo:",
      error.message || error
    );
    await client.end();
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
  await client.end();
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
  console.clear();

  console.log("\n==================================");
  console.log("Bem-vindo ao Stardew Valley - MUD!");
  console.log("==================================\n");

  // Pede para o jogador fornecer seu nome
  const nomeJogador = readlineSync.question("Digite seu nome: ");

  try {
    // Obtem informações do jogador
    const dadosJogador = await client.query("SELECT * FROM Jogador WHERE nome = $1", [nomeJogador]);

    if (dadosJogador.rows.length > 0) {
        // Existe pelo menos uma linha retornada pela consulta
        console.log(`\nO(A) jogador(a) ${nomeJogador} ja existe. Suas informações serão recuperadas.`);
        // Faça algo com os dados do jogador encontrado
    } else {
        const nomeCabana = readlineSync.question("\nDê um nome para sua cabana: ");
        // Mostra mundos disponiveis
        const mundos = await client.query("SELECT * FROM Mundo");
        console.log("\nMundos disponíveis:");
        console.log("===================\n");

        // Pede para o jogador escolher um mundo
        //const opcoesMundo = mundos.rows.map(mundo => mundo.id_mundo);

        let i = 0;
        for (const mundo of mundos.rows) {
            console.log(`${i + 1}. ${mundo.nome.trim()} - ${mundo.descricao.trim()}`);
            i = i + 1;
        }
        // const escolhaMundo = readlineSync.keyInSelect(opcoesMundo, "\nEscolha um mundo: ", { cancel: false }) + 1;

        // Solicita ao jogador escolher um mundo e valida a entrada
        let escolhaMundo;
        do {
            const escolhaStr1 = readlineSync.question("\nEscolha um mundo (Digite o número): ");
            escolhaMundo = parseInt(escolhaStr1, 10);
        
            if (isNaN(escolhaMundo) || escolhaMundo < 1 || escolhaMundo > mundos.rows.length) {
                console.log("Por favor, insira um número válido.");
            }
        } while (isNaN(escolhaMundo) || escolhaMundo < 1 || escolhaMundo > mundos.rows.length);
        
        const escolhaMundoOriginal = mundos.rows[escolhaMundo-1].id_mundo;

        // Obtém informações do mundo escolhido
        const mundoEscolhido = await client.query("SELECT * FROM Mundo WHERE id_mundo = $1", [escolhaMundoOriginal]);
        console.log("\nMundo escolhido:", mundoEscolhido.rows[0].nome); 
        
        // Obtém regiões existentes no mundo escolhido
        const regioesMundoEscolhido = await client.query("SELECT * FROM Regiao WHERE id_mundo = $1", [escolhaMundoOriginal]);
        console.log("\nRegiões disponíveis no mundo escolhido:");
        console.log("=======================================\n");

        // Pede para o jogador escolher uma região
        //const opcoesMundo = mundos.rows.map(mundo => mundo.id_mundo);
        //const opcoesRegiao = regioesMundoEscolhido.rows.map(regiao => regiao.id_regiao);

        let j = 0;
        for (const  regiao of regioesMundoEscolhido.rows) {
            console.log(`${j + 1}. ${regiao.nome.trim()} - ${regiao.descricao.trim()}`);
            j = j + 1;
        }
        // const escolhaMundo = readlineSync.keyInSelect(opcoesMundo, "\nEscolha um mundo: ", { cancel: false }) + 1;
        //const escolhaRegiao = readlineSync.keyInSelect(opcoesRegiao, "\nEscolha uma regiao: ", { cancel: false }) + 1;

        // Solicita ao jogador escolher uma regiao e valida a entrada
        let escolhaRegiao;
        do {
            const escolhaStr2 = readlineSync.question("\nEscolha uma regiao (Digite o número): ");
            escolhaRegiao = parseInt(escolhaStr2, 10);
        
            if (isNaN(escolhaRegiao) || escolhaRegiao < 1 || escolhaRegiao > regioesMundoEscolhido.rows.length) {
                console.log("Por favor, insira um número válido.");
            }
        } while (isNaN(escolhaRegiao) || escolhaRegiao < 1 || escolhaRegiao > regioesMundoEscolhido.rows.length);

        const escolhaRegiaoOriginal = regioesMundoEscolhido.rows[escolhaRegiao-1].id_regiao;

        // Obtém informações da região escolhida
        const regiaoEscolhida = await client.query("SELECT * FROM Regiao WHERE id_regiao = $1", [escolhaRegiaoOriginal]);
        console.log("\nRegião escolhida:", regiaoEscolhida.rows[0].nome);

        // Chama a stored procedure para iniciar o jogo
        const result = await client.query("SELECT iniciar_jogo($1, $2, $3) AS jogo_iniciado", [nomeJogador, escolhaRegiaoOriginal, nomeCabana]);
        //console.log("Resultado da stored procedure:", result);
    
        // Verifica se o jogo foi iniciado com sucesso
        //const jogoIniciado = result.rows[0].iniciar_jogo;

        //console.log(jogoIniciado);

        //if (jogoIniciado) {
            console.log("\nJogo iniciado para o(a) jogador(a)", nomeJogador);
        //} 

    }

    // Obtem informações do jogador
    const dadosJogadorAtual = await client.query("SELECT * FROM Jogador WHERE nome = $1", [nomeJogador]);

    const regiaoAtual = await client.query(
        "SELECT nome FROM Regiao WHERE id_regiao = $1", [dadosJogadorAtual.rows[0].id_regiao]
    );
    
    const nomeCabanaJogador = await client.query(
        "SELECT nome FROM Cabana_Jogador WHERE id_prop_cab_jog = $1", [dadosJogadorAtual.rows[0].id_jogador]
    );

    console.log(`\nVocê se encontra dentro da ${nomeCabanaJogador.rows[0].nome}.`);
    const confirmacao1 = readlineSync.keyInYNStrict(`\nDeseja ir para a regiao ${regiaoAtual.rows[0].nome}?`);

      // Pede confirmaçao para ir para a nova regiao
    if (confirmacao1) {
        // Redireciona para a segunda tela (simulaçao)
        console.log(`\nIndo para a regiao ${regiaoAtual.rows[0].nome}...`);
        //segunda_tela(regiaoEscolhida.rows[0].id_regiao);
      } else {
        // Encerra o jogo ou exibe mensagem de despedida (simulaçao)
        console.log("\nJogo encerrado.");
      }

    /*
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

    const confirmacao = readlineSync.keyInYNStrict(
      "Deseja ir para a nova regiao?"
    );

*/
} catch (error) {
    console.error("\nErro ao executar a primeira tela:", error.message || error);
    console.log("----------------------------------------------------------------------\n");
  } finally {
    // Fecha a conexão com o banco de dados
    console.log("\n----------------------------------------------------------------------");
    console.log("Operações no banco de dados para fechar a conexão...");
    await client.end();
    console.log("Banco desconectado com sucesso!");
    console.log("----------------------------------------------------------------------\n");
  }
}

// Chama a função principal para iniciar o jogo
export { primeiraTela };
