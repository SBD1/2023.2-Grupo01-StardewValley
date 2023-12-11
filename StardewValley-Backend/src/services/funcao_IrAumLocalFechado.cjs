async function irAumLocalFechado(jogador) {
  try {
      const locaisFechadosRegiao = await db.any('SELECT * FROM Local_Fechado WHERE id_regiao = $1', [jogador.id_regiao]);

      console.log("Locais Fechados Disponíveis:");
      for (const localFechado of locaisFechadosRegiao) {
          console.log(`${localFechado.id_local_fechado}. ${localFechado.nome}`);
      }

      const escolhaLocalFechado = readlineSync.questionInt("Escolha um local fechado para visitar: ");

      await db.none('UPDATE Jogador SET id_local_fechado = $1 WHERE id_jogador = $2', [escolhaLocalFechado, jogador.id_jogador]);

      console.log(`Você entrou no local fechado ${escolhaLocalFechado}. Explore e aproveite a visita!\n`);

      // (Adapte conforme necessário para a dinâmica do local fechado)

  } catch (error) {
      console.error('Erro durante a escolha do local fechado:', error.message || error);
  }
}

const jogadorExemplo = {
  id_jogador: 1,
  id_regiao: 1,
};

irAumLocalFechado(jogadorExemplo);
