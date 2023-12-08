import { db } from "../database/db.connection.js";

export function getJogadorByNome(id) {
    console.log("repository")
    return db.query(`select * FROM jogador where id_jogador=$1;`, [id]);
}

export function getJogadores() {
    console.log("repository")
    return db.query(`select * FROM jogador;`);
}
