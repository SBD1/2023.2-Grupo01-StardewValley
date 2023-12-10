import { connect } from "../db.js";
import readlineSync from "readline-sync";

async function comerItem(jogador) {
  const client = await connect();

  try {
    // Consulta para obter os itens consumíveis com seus efeitos
    const query = `
      SELECT ci.id_item_inventario, i.id_item, i.nome_tipo_item, iqtdd.qtdd, c.nome, e.valor, e.tipo
      FROM Item_Inventario iqtdd
      JOIN Item i ON iqtdd.id_item = i.id_item
      JOIN Consumivel c ON i.id_item = c.id_item
      JOIN Efeito e ON c.id_item = e.id_item
      WHERE iqtdd.id_jogador = $1;
    `;

    const result = await client.query(query, [jogador.id_jogador]);

    if (result.rows.length === 0) {
      console.log("Você não possui itens consumíveis no inventário.");
      return;
    }

    console.log("Itens Consumíveis Disponíveis:");
    console.log("| ID | Nome do Item | Tipo | Quantidade | Efeito | Valor |");

    for (const row of result.rows) {
      console.log(
        `| ${row.id_item_inventario} | ${row.nome} | ${row.nome_tipo_item} | ${row.qtdd} | ${row.tipo} | ${row.valor} |`
      );
    }

    // Solicita ao jogador que escolha um item para consumir
    const escolhaItem = readlineSync.questionInt("Escolha o ID do item que deseja consumir: ");

    // Verifica se o ID do item escolhido é válido
    const chosenItem = result.rows.find((item) => item.id_item_inventario === escolhaItem);

    if (!chosenItem) {
      console.log("Escolha inválida. Tente novamente.");
      return;
    }

    // Aplica o efeito na energia do jogador
    jogador.energia += chosenItem.valor;

    // Remove uma unidade do item ou remove o item se for o único
    if (chosenItem.qtdd > 1) {
      await client.query("UPDATE Item_Inventario SET qtdd = $1 WHERE id_item_inventario = $2", [
        chosenItem.qtdd - 1,
        escolhaItem,
      ]);
    } else {
      await client.query("DELETE FROM Item_Inventario WHERE id_item_inventario = $1", [escolhaItem]);
    }

    // Atualiza os dados do jogador no banco de dados
    await client.query(
      "UPDATE Jogador SET energia = $1 WHERE id_jogador = $2",
      [jogador.energia, jogador.id_jogador]
    );

    console.log(`Você consumiu ${chosenItem.nome} e sua energia foi ajustada para ${jogador.energia}.`);
  } catch (error) {
    console.error("Erro ao consumir item:", error.message || error);
  } finally {
    await client.end();
  }
}

export { comerItem };
