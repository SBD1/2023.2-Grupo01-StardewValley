import { connect } from "../db.js";

async function cabanasNpcDisponiveis(idJogador) {
  const client = await connect();

  const query = `
    SELECT cnpc.* 
    FROM cabana_npc cnpc 
    WHERE cnpc.id_regiao = (
        SELECT j.id_regiao 
        FROM Jogador j 
        WHERE j.id_jogador = $1
    );
    `;

  const res = await client.query(query, [idJogador]);
  client.end();

  return res.rows.map((cabana_npc) => ({
    id_cabana_npc: cabana_npc.id_cabana_npc,
    nome_cabana_npc: cabana_npc.nome,
  }));
}

export { cabanasNpcDisponiveis };
