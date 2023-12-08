// Função para a lógica de pesca
async function pescarItens(jogador) {
    try {
      // Verifica se o jogador está em uma região com local fechado "praia"
      const localPraia = await db.oneOrNone('SELECT * FROM Local_Fechado WHERE id_local_fechado = $1 AND id_regiao = $2', [1, jogador.id_regiao]);
  
      if (!localPraia) {
        console.log("Você não está em uma região com acesso à praia para pescar.");
        return;
      }
  
      // Mostra os itens que podem ser pescados na praia
      const itensPescaveis = await db.any('SELECT * FROM Consumivel WHERE id_item IN (SELECT id_item FROM Item WHERE local_fechado = $1)', ['praia']);
  
      console.log("Itens Pescáveis na Praia:");
      for (const itemPescavel of itensPescaveis) {
        console.log(`${itemPescavel.id_item}. ${itemPescavel.nome}`);
      }
  
      // Pede ao jogador para escolher um item para pescar
      const escolhaItemPescavel = readlineSync.questionInt("Escolha um item para pescar: ");
  
      // Obtém informações do item escolhido
      const itemPescavelEscolhido = await db.one('SELECT * FROM Consumivel WHERE id_item = $1', [escolhaItemPescavel]);
  
      // Inicia a dinâmica de pesca
      console.log(`Pescando ${itemPescavelEscolhido.nome}...`);
  
      // Lógica de pesca: atualiza o inventário do jogador, habilidades, etc.
      // (Adapte de acordo com a sua lógica específica)
  
      // Exemplo: Adiciona o item pescado ao inventário do jogador
      await db.none('INSERT INTO Item_Inventario (id_jogador, id_item) VALUES ($1, $2)', [jogador.id_jogador, itemPescavelEscolhido.id_item]);
  
      // Incrementa a habilidade de pesca
      await db.none('UPDATE Habilidade SET nivel_pesca = nivel_pesca + 1 WHERE id_jogador = $1', [jogador.id_jogador]);
  
      // Decrementa a energia do jogador
      const novaEnergia = jogador.energia - 5;
      await db.none('UPDATE Jogador SET energia = $1 WHERE id_jogador = $2', [novaEnergia, jogador.id_jogador]);
  
      // Mostra mensagem de sucesso
      console.log(`${itemPescavelEscolhido.nome} pescado com sucesso!\n`);
  
      // (Adapte conforme necessário para a sua dinâmica de pesca)
  
    } catch (error) {
      console.error('Erro durante a pesca:', error.message || error);
    }
  }
  
  // Exemplo de chamada da função de pesca
  const jogadorExemplo = {
    id_jogador: 1, // Substitua pelo ID do jogador
    id_regiao: 1, // Substitua pelo ID da região atual do jogador
    energia: 100 // Substitua pela energia atual do jogador
  };
  
  pescarItens(jogadorExemplo);
  