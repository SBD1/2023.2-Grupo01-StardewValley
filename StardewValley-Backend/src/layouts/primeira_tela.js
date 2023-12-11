import { connect } from "../db.js";
import { segunda_tela } from "./segunda_tela.js";
import { obterStatusJogador, exibirStatusJogador } from "../services/status_jogador.js";
import { obterStatusJogo, exibirStatusJogo } from "../services/statusJogo.js";
import readlineSync from "readline-sync";

// Função principal para a primeira tela
export async function primeiraTela() {
    const client = await connect();
    process.stdout.setEncoding('utf-8');

    console.clear();

    console.log("\n==================================");
    console.log("Bem-vindo ao Stardew Valley - MUD!");
    console.log("==================================\n");

    // Pede para o jogador fornecer seu nome
    let nomeJogador;

    do {
        nomeJogador = readlineSync.question("Digite seu nome: ");
    
        if (!nomeJogador.trim()) {
            console.log("Por favor, insira um nome válido.");
        }
    } while (!nomeJogador.trim());
    
try {
        // Obtem informações do jogador
        const dadosJogador = await client.query("SELECT * FROM Jogador WHERE nome = $1", [nomeJogador]);

        if (dadosJogador.rows.length > 0) {
            // Existe pelo menos uma linha retornada pela consulta
            console.log(`\nO(A) jogador(a) ${nomeJogador} ja existe. Suas informações serão recuperadas.`);
            // Faça algo com os dados do jogador encontrado
        } else {
            let nomeCabana;

            do {
                nomeCabana = readlineSync.question("\nDê um nome para sua cabana: ");
            
                if (!nomeCabana.trim()) {
                    console.log("Por favor, insira um nome válido.");
                }
            } while (!nomeCabana.trim());
        
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

        console.log('\nPressione a barra de espaço para continuar...');
        readlineSync.keyInPause();
        console.clear();

        // Obtem informações do jogador
        const dadosJogadorAtual = await client.query("SELECT * FROM Jogador WHERE nome = $1", [nomeJogador]);

        const statusJogador = await obterStatusJogador(dadosJogadorAtual.rows[0].id_jogador);
        await exibirStatusJogador(statusJogador);

        const statusJogo = await obterStatusJogo(dadosJogadorAtual.rows[0].id_jogador);
        await exibirStatusJogo(statusJogo);

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
            segunda_tela(regiaoAtual.rows[0], dadosJogadorAtual.rows[0].id_jogador);
        } else {
            // Encerra o jogo ou exibe mensagem de despedida (simulaçao)
            console.log("\nJogo encerrado.");
        }

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
