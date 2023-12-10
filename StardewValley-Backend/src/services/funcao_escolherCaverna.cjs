async function escolherCaverna(jogador) {
  try {
      const cavernasRegiao = await db.any('SELECT * FROM Local_Fechado WHERE tipo_local_fechado = $1 AND id_regiao = $2', ['caverna', jogador.id_regiao]);

      console.log("Cavernas Disponíveis:");
      for (const caverna of cavernasRegiao) {
          console.log(`${caverna.id_local_fechado}. ${caverna.nome}`);
      }

      const escolhaCaverna = readlineSync.questionInt("Escolha uma caverna para minerar ou combater: ");

      await db.none('UPDATE Jogador SET id_local_fechado = $1 WHERE id_jogador = $2', [escolhaCaverna, jogador.id_jogador]);

      console.log("\n*** Explorando a Caverna ***");
      console.log(`Você entrou na caverna ${escolhaCaverna}. Preparado para mineração ou combate!\n`);

      const opcoesCaverna = ['Minerar', 'Combater', 'Sair da Caverna'];
      const escolhaOpcao = readlineSync.keyInSelect(opcoesCaverna, 'O que você deseja fazer?');

      switch (escolhaOpcao) {
          case 0:
              await minerarNaCaverna(jogador);
              break;
          case 1:
              await combaterNaCaverna(jogador);
              break;
          case 2:
              console.log("Saindo da caverna...");
              break;
          default:
              console.log("Escolha inválida. Saindo da caverna.");
      }
  } catch (error) {
      console.error('Erro durante a escolha da caverna:', error.message || error);
  }
}

const jogadorExemplo = {
  id_jogador: 1,
  id_regiao: 1,
};

escolherCaverna(jogadorExemplo);
