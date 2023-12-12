// Função para a lógica de mudança de região
async function mudarDeRegiao(jogador) {
    try {
      // Mostra as regiões disponíveis
      const regioesDisponiveis = await db.any('SELECT * FROM Regiao');
  
      console.log("Regiões Disponíveis:");
      for (const regiao of regioesDisponiveis) {
        console.log(`${regiao.id_regiao}. ${regiao.nome}`);
      }
  
      // Pede ao jogador para escolher uma região
      const escolhaRegiao = readlineSync.questionInt("Escolha uma região para explorar: ");
  
      // Atualiza a região na tabela Jogador
      await db.none('UPDATE Jogador SET id_regiao = $1 WHERE id_jogador = $2', [escolhaRegiao, jogador.id_jogador]);
  
      console.log(`Você se mudou para a região ${escolhaRegiao}. Prepare-se para novas aventuras!\n`);
  
      // Reinicia a tela com a nova região escolhida
      await primeiraTela();
  
    } catch (error) {
      console.error('Erro durante a mudança de região:', error.message || error);
    }
  }
  
  // Exemplo de chamada da função de mudança de região
  const jogadorExemplo = {
    id_jogador: 1, // Substitua pelo ID do jogador
    id_regiao: 1, // Substitua pelo ID da região atual do jogador
  };
  
  mudarDeRegiao(jogadorExemplo);
  