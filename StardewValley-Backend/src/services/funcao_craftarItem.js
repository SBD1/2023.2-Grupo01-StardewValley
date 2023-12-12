async function craftarItem(jogador) {
  try {
      const receitas = await db.any('SELECT * FROM Artesanato JOIN Item_Receita ON Artesanato.id_artesanato = Item_Receita.id_artesanato JOIN Item ON Item_Receita.id_item = Item.id_item');

      console.log("Receitas Disponíveis para Crafting:");
      for (const receita of receitas) {
          console.log(`${receita.id_artesanato}. ${receita.nome} - Materiais necessários: ${receita.materiais}`);
      }

      const escolhaReceita = readlineSync.questionInt("Escolha uma receita para craftar: ");

      const receitaEscolhida = await db.one('SELECT * FROM Artesanato WHERE id_artesanato = $1', [escolhaReceita]);

      const materiaisNecessarios = receitaEscolhida.materiais.split(',').map(Number);
      const itensInventario = await db.any('SELECT id_item FROM Item_Inventario WHERE id_jogador = $1 AND id_item IN ($2:csv)', [jogador.id_jogador, materiaisNecessarios]);

      if (itensInventario.length !== materiaisNecessarios.length) {
          console.log("Você não possui todos os itens necessários para esta receita.");
          return;
      }

      console.log(`Craftando ${receitaEscolhida.nome}...`);

      for (const itemInventario of itensInventario) {
          await db.none('DELETE FROM Item_Inventario WHERE id_jogador = $1 AND id_item = $2', [jogador.id_jogador, itemInventario.id_item]);
      }

      await db.none('INSERT INTO Item_Inventario (id_jogador, id_item) VALUES ($1, $2)', [jogador.id_jogador, receitaEscolhida.id_item_craftado]);

      console.log(`${receitaEscolhida.nome} craftado com sucesso!\n`);

  } catch (error) {
      console.error('Erro durante o crafting:', error.message || error);
  }
}

const jogadorExemplo = {
  id_jogador: 1,
};

craftarItem(jogadorExemplo);
