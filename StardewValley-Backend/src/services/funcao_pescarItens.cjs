async function pescarItens(jogador) {
  try {
      const localPraia = await db.oneOrNone('SELECT * FROM Local_Fechado WHERE id_local_fechado = $1 AND id_regiao = $2', [1, jogador.id_regiao]);

      if (!localPraia) {
          console.log("Você não está em uma região com acesso à praia para pescar.");
          return;
      }

      const itensPescaveis = await db.any('SELECT * FROM Consumivel WHERE id_item IN (SELECT id_item FROM Item WHERE local_fechado = $1)', ['praia']);

      console.log("Itens Pescáveis na Praia:");
      for (const itemPescavel of itensPescaveis) {
          console.log(`${itemPescavel.id_item}. ${itemPescavel.nome}`);
      }

      const escolhaItemPescavel = readlineSync.questionInt("Escolha um item para pescar: ");

      const itemPescavelEscolhido = await db.one('SELECT * FROM Consumivel WHERE id_item = $1', [escolhaItemPescavel]);

      console.log(`Pescando ${itemPescavelEscolhido.nome}...`);

      await db.none('INSERT INTO Item_Inventario (id_jogador, id_item) VALUES ($1, $2)', [jogador.id_jogador, itemPescavelEscolhido.id_item]);

      await db.none('UPDATE Habilidade SET nivel_pesca = nivel_pesca + 1 WHERE id_jogador = $1', [jogador.id_jogador]);

      const novaEnergia = jogador.energia - 5;
      await db.none('UPDATE Jogador SET energia = $1 WHERE id_jogador = $2', [novaEnergia, jogador.id_jogador]);

      console.log(`${itemPescavelEscolhido.nome} pescado com sucesso!\n`);

  } catch (error) {
      console.error('Erro durante a pesca:', error.message || error);
  }
}

const jogadorExemplo = {
  id_jogador: 1,
  id_regiao: 1,
  energia: 100
};

pescarItens(jogadorExemplo);
