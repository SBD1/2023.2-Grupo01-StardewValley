import { Router } from "express";
import { jogador, pegarTodosJogadores } from "../controllers/jogador.controllers.js";

const jogadorRouter = Router();

console.log("Rota jogador");
jogadorRouter.get("/jogador/:id", jogador);
jogadorRouter.get("/jogadores", pegarTodosJogadores);

export default jogadorRouter;