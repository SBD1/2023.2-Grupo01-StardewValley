import { connect } from "../db.js";
import readlineSync from "readline-sync";

export async function pescar(infoRegiao, infoJogador) {
  const client = await connect();

  let pescar = await client.query(`select * from jogador where id_jogador=$1 and id_regiao=$2;`, [infoJogador.id_jogador, infoRegiao.id_regiao]);
  if (pescar.rows.length === 0) {
    console.log("\n\n\n\nPooooxa =( Nao é possível pescar nessa regiao!!\n\n\n\n");
    return false;
  }

  pescar = pescar.rows;

  // const itemColeta = [];
  // const idItemColeta = [];
  // pescar.map((c) => itemColeta.push(c.nome));
  // pescar.map((c) => idItemColeta.push(c.id_consumivel));
  // const escolhaColeta = readlineSync.keyInSelect(itemColeta, "O que você quer pescar?", { cancel: false });

  try {
    const result = await dinamicaPesca(client, infoJogador);
    console.log(result);
  } catch (error) {
    console.error("Erro durante a pesca:", error);
  }

  client.end();
}

async function dinamicaPesca(client, infoJogador) {
  const result = await client.query(`
  SELECT * FROM consumivel c
  JOIN ferramenta f ON c.id_consumivel = f.id_ferramenta
  WHERE c.id_consumivel = $1 AND f.id_ferramenta = $2;
`, [3, 17]);



  const itemExistente = result.rows;
  console.log(itemExistente)
  console.log(`Obaa! Você vai utilizar a ${itemExistente[0].nome} e ${itemExistente[1].nome}!! Boa pesca!!`)

  if (itemExistente.length === 0) {
    const inseirItem = await client.query(`insert into item_inventario (id_jogador, id_item, qtdd) values ($1, $2, 1) RETURNING *;`, [infoJogador.id_jogador, 17]);

    if (inseirItem.rows.length > 0) {
      return "\n\n\nItem inserido com sucesso!!\n\n\n";
    } else {
      return "\n\n\nNao foi possivel inserir item!!\n\n\n";
    }
  } else {
    const atualizarItem = await client.query(`UPDATE item_inventario SET qtdd = qtdd + 1 WHERE id_jogador = $1 AND id_item = $2 RETURNING *;`, [infoJogador.id_jogador, idItemColeta]);
    const atualizarHabilidade = await client.query(`UPDATE habilidade SET nivel_pesca = nivel_pesca + 1 WHERE id_jogador = $1;`, [infoJogador.id_jogador]);
    const atualizarEnergia = await client.query(`UPDATE jogador SET energia = energia - 5 WHERE id_jogador = $1;`, [infoJogador.id_jogador]);

    if (atualizarItem.rows.length > 0 && atualizarHabilidade.rowCount > 0 && atualizarEnergia.rowCount > 0) {
      return "\n\n\nItem coletado!!\n\n\n";
    } else {
      return "\n\n\nNao foi possivel coletar item!!\n\n\n";
    }
  }


}
