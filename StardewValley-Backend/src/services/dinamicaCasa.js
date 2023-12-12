import { connect } from "../db.js";
import readlineSync from "readline-sync";

export async function dinamicaCasa(idJogador) {
  const client = await connect();

  const options = ["Sim", "Não"];
  const escolhaCasa = readlineSync.keyInSelect(
    options,
    "O que você deseja fazer em casa?"
  );

  while (escolhaCasa !== -1) {
    if (escolhaCasa === 0) {
      const query = `
        UPDATE jogador SET energia = 100, dia = dia + 1, hora = 21600 WHERE id_jogador = $1;
        `;
      await client.query(query, [idJogador]);
      escolhaCasa = -1;
    }
    if (escolhaCasa === 1) {
      let query = `
      SELECT r.id_regiao, r.nome 
      FROM Regiao r
      JOIN Mundo m ON r.id_mundo = m.id_mundo
      WHERE m.id_mundo = (
          SELECT id_mundo 
          FROM Regiao 
          WHERE id_regiao = (
              SELECT id_regiao 
              FROM Jogador 
              WHERE id_jogador = $1
          )
      );
        `;
      const resultRegioesDisponiveis = await client.query(query, [idJogador]);
      const regioesDisponiveis = resultRegioesDisponiveis.rows.map(
        (regiao) => ({
          id_regiao: regiao.id_regiao,
          nome_regiao: regiao.nome,
        })
      );

      query = `
        UPDATE JOGADOR SET id_regiao = $1 WHERE id_jogador = $2;
      `;

      escolhaCasa = -1;
    }
  }

  client.end();
}
