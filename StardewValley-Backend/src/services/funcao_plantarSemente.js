import { connect } from "../db.js";
import readlineSync from "readline-sync";

export async function plantarSementes(infoRegiao, infoJogador) {
  const client = await connect();
  // console.log(infoJogador, infoRegiao)

  let plantar = await client.query(`select * from semente 
    where id_estacao=$1;`, [infoJogador.id_estacao]);

  if (plantar.rows.length === 0) {
    console.log("\n\n\n\nPooooxa =( Nao ha itens para plantar nesta regiao!!\n\n\n\n");
    return false;
  }

  plantar = plantar.rows;

  const itemPlantacao = [];
  const idItemPlantacao = [];
  plantar.map((c) => itemPlantacao.push(c.nome));
  plantar.map((c) => idItemPlantacao.push(c.id_semente));

  const escolhaPlantacao = readlineSync.keyInSelect(itemPlantacao, "O que você quer plantar?", { cancel: false });

  try {
    const result = await dinamicaPlantacao(client, infoJogador, itemPlantacao[escolhaPlantacao], idItemPlantacao[escolhaPlantacao]);
    console.log(result);
  } catch (error) {
    console.error("Erro durante a Plantacao:", error);
  }

  client.end();
}

async function dinamicaPlantacao(client, infoJogador, itemPlantacao, idItemPlantacao) {
  console.log(`id do item a ser plantado: ${idItemPlantacao}`)
  const result = await client.query(`select * from item_inventario where id_jogador=$1 and id_item=$2;`, [infoJogador.id_jogador, idItemPlantacao]);
  const itemExistente = result.rows;

  if (itemExistente.length === 0) {
    const inseirItem = await client.query(`insert into item_inventario (id_jogador, id_item, qtdd) values ($1, $2, 1) RETURNING *;`, [infoJogador.id_jogador, idItemPlantacao]);

    if (inseirItem.rows.length > 0) {
      return "\n\n\nItem inserido com sucesso!!\n\n\n";
    } else {
      return "\n\n\nNao foi possivel inserir item!!\n\n\n";
    }
  } else {
    const atualizarItem = await client.query(`UPDATE item_inventario SET qtdd = qtdd + 1 WHERE id_jogador = $1 AND id_item = $2 RETURNING *;`, [infoJogador.id_jogador, idItemPlantacao]);
    const atualizarHabilidade = await client.query(`UPDATE habilidade SET nivel_cultivo = nivel_cultivo + 1 WHERE id_jogador = $1;`, [infoJogador.id_jogador]);
    const atualizarEnergia = await client.query(`UPDATE jogador SET energia = energia - 5 WHERE id_jogador = $1;`, [infoJogador.id_jogador]);

    if (atualizarItem.rows.length > 0 && atualizarHabilidade.rowCount > 0 && atualizarEnergia.rowCount > 0) {
      return "\n\n\nItem Plantacaodo!!\n\n\n";
    } else {
      return "\n\n\nNao foi possivel plantar item!!\n\n\n";
    }
  }
}


