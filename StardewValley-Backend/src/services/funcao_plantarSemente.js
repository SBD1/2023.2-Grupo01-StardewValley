async function plantarSementes(jogador) {
  try {
      const sementesDisponiveis = await db.any('SELECT * FROM Semente WHERE id_item IN (SELECT id_item FROM Item_Inventario WHERE id_jogador = $1)', [jogador.id_jogador]);

      console.log("Sementes Disponíveis para Plantar:");
      for (const semente of sementesDisponiveis) {
          console.log(`${semente.id_semente}. ${semente.nome}`);
      }

      const escolhaSemente = readlineSync.questionInt("Escolha uma semente para plantar: ");

      const sementeEscolhida = await db.one('SELECT * FROM Semente WHERE id_semente = $1', [escolhaSemente]);

      console.log(`Plantando ${sementeEscolhida.nome}...`);

      await db.none('DELETE FROM Item_Inventario WHERE id_jogador = $1 AND id_item = $2', [jogador.id_jogador, sementeEscolhida.id_item]);

      await db.none('UPDATE Habilidade SET nivel_cultivo = nivel_cultivo + 1 WHERE id_jogador = $1', [jogador.id_jogador]);

      const diaColheita = jogador.dia + sementeEscolhida.dias_para_crescer;

      await db.none('INSERT INTO Plantacao (id_jogador, id_semente, dia_colheita) VALUES ($1, $2, $3)', [jogador.id_jogador, sementeEscolhida.id_semente, diaColheita]);

      const novaEnergia = jogador.energia - 5;
      await db.none('UPDATE Jogador SET energia = $1 WHERE id_jogador = $2', [novaEnergia, jogador.id_jogador]);

      console.log(`${sementeEscolhida.nome} plantada com sucesso!\n`);

  } catch (error) {
      console.error('Erro durante a plantação:', error.message || error);
  }
}

const jogadorExemplo = {
  id_jogador: 1,
  dia: 1,
  energia: 100
};

plantarSementes(jogadorExemplo);
