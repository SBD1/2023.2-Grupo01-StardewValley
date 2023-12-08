// Função para a lógica de mineração ou combate
async function minerarOuCombater(jogador) {
    try {
      // Mostra as cavernas disponíveis na região
      const cavernasRegiao = await db.any('SELECT * FROM Local_Fechado WHERE tipo_local_fechado = $1 AND id_regiao = $2', ['caverna', jogador.id_regiao]);
  
      console.log("Cavernas Disponíveis:");
      for (const caverna of cavernasRegiao) {
        console.log(`${caverna.id_local_fechado}. ${caverna.nome}`);
      }
  
      // Pede ao jogador para escolher uma caverna
      const escolhaCaverna = readlineSync.questionInt("Escolha uma caverna para minerar ou combater: ");
  
      // Atualiza o local fechado na tabela Jogador
      await db.none('UPDATE Jogador SET id_local_fechado = $1 WHERE id_jogador = $2', [escolhaCaverna, jogador.id_jogador]);
  
      console.log(`Você entrou na caverna ${escolhaCaverna}. Preparado para mineração ou combate!\n`);
  
      // (Adapte conforme necessário para a sua dinâmica de mineração ou combate)
  
    } catch (error) {
      console.error('Erro durante a escolha da caverna:', error.message || error);
    }
  }
  
  // Exemplo de chamada da função de mineração ou combate
  const jogadorExemplo = {
    id_jogador: 1, // Substitua pelo ID do jogador
    id_regiao: 1, // Substitua pelo ID da região do jogador
  };
  
  minerarOuCombater(jogadorExemplo);
  