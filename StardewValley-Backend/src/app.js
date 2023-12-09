import dotenv from "dotenv";
import { primeiraTela } from "./layouts/primeira_tela.js";

dotenv.config();

async function start() {
    await primeiraTela();
}

start();
