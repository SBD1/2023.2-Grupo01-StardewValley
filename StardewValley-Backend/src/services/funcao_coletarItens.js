import { connect } from "../db.js";
import readlineSync from "readline-sync";

async function coletarItens(infoRegiao, infoJogador) {
  const client = await connect();

  let coletar = await client.query(`select * from consumivel 
    where id_local_fechado is null and id_regiao=$1;`, [infoRegiao.id_regiao]);

  if (coletar.rows.length === 0) {
    console.log("\n\n\n\nPooooxa =( Nao ha semetes para plantar nesta estação!!\n\n\n\n");
    return false;
  }

  coletar = coletar.rows;

  const itemColeta = [];
  const idItemColeta = [];
  coletar.map((c) => itemColeta.push(c.nome));
  coletar.map((c) => idItemColeta.push(c.id_consumivel));
  const escolhaColeta = readlineSync.keyInSelect(itemColeta, "O que você quer coletar?", { cancel: false });

  try {
    const result = await dinamicaColeta(client, infoJogador, itemColeta[escolhaColeta], idItemColeta[escolhaColeta]);
    console.log(result);
  } catch (error) {
    console.error("Erro durante a coleta:", error);
  }

  client.end();
}

async function dinamicaColeta(client, infoJogador, itemColeta, idItemColeta) {
  const result = await client.query(`select * from item_inventario where id_jogador=$1 and id_item=$2;`, [infoJogador.id_jogador, idItemColeta]);
  const itemExistente = result.rows;

  if (itemExistente.length === 0) {
    const inseirItem = await client.query(`insert into item_inventario (id_jogador, id_item, qtdd) values ($1, $2, 1) RETURNING *;`, [infoJogador.id_jogador, idItemColeta]);

    if (inseirItem.rows.length > 0) {
      return "\n\n\nItem inserido com sucesso!!\n\n\n";
    } else {
      return "\n\n\nNao foi possivel inserir item!!\n\n\n";
    }
  } else {
    const atualizarItem = await client.query(`UPDATE item_inventario SET qtdd = qtdd + 1 WHERE id_jogador = $1 AND id_item = $2 RETURNING *;`, [infoJogador.id_jogador, idItemColeta]);
    const atualizarHabilidade = await client.query(`UPDATE habilidade SET nivel_coleta = nivel_coleta + 1 WHERE id_jogador = $1;`, [infoJogador.id_jogador]);
    const atualizarEnergia = await client.query(`UPDATE jogador SET energia = energia - 5 WHERE id_jogador = $1;`, [infoJogador.id_jogador]);

    if (atualizarItem.rows.length > 0 && atualizarHabilidade.rowCount > 0 && atualizarEnergia.rowCount > 0) {
      return "\n\n\nItem coletado!!\n\n\n";
    } else {
      return "\n\n\nNao foi possivel coletar item!!\n\n\n";
    }
  }
}

export { coletarItens };
