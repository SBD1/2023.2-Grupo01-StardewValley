// Função para a lógica de ir a um local fechado
async function irAumLocalFechado(jogador) {
    try {
      // Mostra os locais fechados disponíveis na região
      const locaisFechadosRegiao = await db.any('SELECT * FROM Local_Fechado WHERE id_regiao = $1', [jogador.id_regiao]);
  
      console.log("Locais Fechados Disponíveis:");
      for (const localFechado of locaisFechadosRegiao) {
        console.log(`${localFechado.id_local_fechado}. ${localFechado.nome}`);
      }
  
      // Pede ao jogador para escolher um local fechado
      const escolhaLocalFechado = readlineSync.questionInt("Escolha um local fechado para visitar: ");
  
      // Atualiza o local fechado na tabela Jogador
      await db.none('UPDATE Jogador SET id_local_fechado = $1 WHERE id_jogador = $2', [escolhaLocalFechado, jogador.id_jogador]);
  
      console.log(`Você entrou no local fechado ${escolhaLocalFechado}. Explore e aproveite a visita!\n`);
  
      // (Adapte conforme necessário para a dinâmica do local fechado)
  
    } catch (error) {
      console.error('Erro durante a escolha do local fechado:', error.message || error);
    }
  }
  
  // Exemplo de chamada da função de ir a um local fechado
  const jogadorExemplo = {
    id_jogador: 1, // Substitua pelo ID do jogador
    id_regiao: 1, // Substitua pelo ID da região do jogador
  };
  
  irAumLocalFechado(jogadorExemplo);
  