import { connect } from "../db.js";

async function lojasDisponiveis(idJogador) {
  const client = await connect();

  const query = `
    SELECT l.* 
    FROM loja l 
    WHERE l.id_regiao = (
        SELECT j.id_regiao 
        FROM Jogador j 
        WHERE j.id_jogador = $1
    );
    `;

  const res = await client.query(query, [idJogador]);
  client.end();

  return res.rows.map((loja) => ({
    id_loja: loja.id_loja,
    nome_loja: loja.nome,
  }));
}

export { lojasDisponiveis };
