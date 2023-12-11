import { connect } from "../db.js";

async function cabanaJogadorDisponivel(idJogador) {
  const client = await connect();

  const query = `
    SELECT cj.* 
    FROM cabana_jogador cj 
    WHERE cj.id_prop_jogador = (
        SELECT j.id_jogador 
        FROM Jogador j 
        WHERE j.id_jogador = $1
    );
    `;

  const res = await client.query(query, [idJogador]);
  client.end();

  return res.rows.map((cabana) => ({
    id_cabana_jog: cabana.id_cabana_jog,
    nome_cabana_jog: cabana.nome,
  }));
}

export { cabanaJogadorDisponivel };
