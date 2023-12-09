// Função para a lógica de coleta
async function coletarItens(jogador) {
    try {
      // Mostra os itens disponíveis para coleta na região
      const itensColetaveis = await db.any('SELECT * FROM Consumivel WHERE local_fechado IS NULL AND id_regiao = $1', [jogador.id_regiao]);
  
      console.log("Itens Disponíveis para Coleta:");
      for (const item of itensColetaveis) {
        console.log(`${item.id_item}. ${item.nome}`);
      }
  
      // Pede ao jogador para escolher um item para coletar
      const escolhaItem = readlineSync.questionInt("Escolha um item para coletar: ");
  
      // Obtém informações do item escolhido
      const itemEscolhido = await db.one('SELECT * FROM Consumivel WHERE id_item = $1', [escolhaItem]);
  
      // Inicia a dinâmica de coleta
      console.log(`Coletando ${itemEscolhido.nome}...`);
  
      // Lógica de coleta: atualiza o inventário, habilidades, etc.
      // (Adapte de acordo com a sua lógica específica)
  
      // Exemplo: Atualiza o inventário do jogador
      await db.none('INSERT INTO Item_Inventario (id_jogador, id_item) VALUES ($1, $2)', [jogador.id_jogador, escolhaItem]);
  
      // Incrementa a habilidade de coleta
      await db.none('UPDATE Habilidade SET nivel_coleta = nivel_coleta + 1 WHERE id_jogador = $1', [jogador.id_jogador]);
  
      // Decrementa a energia do jogador
      const novaEnergia = jogador.energia - 5;
      await db.none('UPDATE Jogador SET energia = $1 WHERE id_jogador = $2', [novaEnergia, jogador.id_jogador]);
  
      // Mostra mensagem de sucesso
      console.log(`${itemEscolhido.nome} coletado com sucesso!\n`);
  
      // (Adapte conforme necessário para a sua dinâmica de coleta)
  
    } catch (error) {
      console.error('Erro durante a coleta:', error.message || error);
    }
  }
  
  // Exemplo de chamada da função de coleta
  const jogadorExemplo = {
    id_jogador: 1, // Substitua pelo ID do jogador
    id_regiao: 1 // Substitua pelo ID da região atual do jogador
  };
  
  coletarItens(jogadorExemplo);
  