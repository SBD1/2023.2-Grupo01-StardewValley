import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import chalk from 'chalk';
import QualquerTela from "./layouts/QualquerTela.js";
import readline from "readline";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 5000;
app.listen(PORT);
// app.listen(PORT, () => console.log(chalk.green(`Rodando em http://localhost:${PORT}`)));

// Função para receber entrada do usuário
async function getUserInput() {
    return new Promise((resolve) => {
        const rl = readline.createInterface({
            input: process.stdin,
            output: process.stdout
        });

        rl.question('Sua escolha: ', (answer) => {
            rl.close();
            resolve(answer);
        });
    });
}

// Função principal assíncrona
async function main() {
    while (true) {
        console.clear();
        let estacaoAtual = "Inverno"
        let diaAtual = 2
        let regiaoAtual = "Vila Pelicanos"
        let horaAtual = 12
        let nomeJogador = "Marcus"
        let energiaJogador = "100%"
        QualquerTela(
            estacaoAtual,
            diaAtual,
            regiaoAtual,
            horaAtual,
            nomeJogador,
            energiaJogador
        );

        // Lê uma linha de texto do usuário
        const userInput = await getUserInput();
    }
}

main();