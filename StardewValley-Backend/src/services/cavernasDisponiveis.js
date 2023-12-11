import { connect } from "../db.js";

async function cavernasDisponiveis(idJogador) {
  const client = await connect();

  const query = `
    SELECT cav.* 
    FROM Caverna cav 
    WHERE cav.id_regiao = (
        SELECT j.id_regiao 
        FROM Jogador j 
        WHERE j.id_jogador = $1
    );
    `;

  const res = await client.query(query, [idJogador]);
  client.end();

  return res.rows.map((caverna) => ({
    id_caverna: caverna.id_caverna,
    nome_caverna: caverna.nome,
  }));
}

export { cavernasDisponiveis };
