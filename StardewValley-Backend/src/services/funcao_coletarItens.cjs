async function coletarItens(jogador) {
  try {
      const itensColetaveis = await db.any('SELECT * FROM Consumivel WHERE local_fechado IS NULL AND id_regiao = $1', [jogador.id_regiao]);

      console.log("Itens Disponíveis para Coleta:");
      for (const item of itensColetaveis) {
          console.log(`${item.id_item}. ${item.nome}`);
      }

      const escolhaItem = readlineSync.questionInt("Escolha um item para coletar: ");

      const itemEscolhido = await db.one('SELECT * FROM Consumivel WHERE id_item = $1', [escolhaItem]);

      console.log(`Coletando ${itemEscolhido.nome}...`);

      await db.none('INSERT INTO Item_Inventario (id_jogador, id_item) VALUES ($1, $2)', [jogador.id_jogador, escolhaItem]);

      await db.none('UPDATE Habilidade SET nivel_coleta = nivel_coleta + 1 WHERE id_jogador = $1', [jogador.id_jogador]);

      const novaEnergia = jogador.energia - 5;
      await db.none('UPDATE Jogador SET energia = $1 WHERE id_jogador = $2', [novaEnergia, jogador.id_jogador]);

      console.log(`${itemEscolhido.nome} coletado com sucesso!\n`);

  } catch (error) {
      console.error('Erro durante a coleta:', error.message || error);
  }
}

const jogadorExemplo = {
  id_jogador: 1,
  id_regiao: 1
};

coletarItens(jogadorExemplo);
