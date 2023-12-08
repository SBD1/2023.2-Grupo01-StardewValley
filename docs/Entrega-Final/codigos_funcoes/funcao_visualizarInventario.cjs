// Função para a lógica de visualização do inventário
async function visualizarInventario(jogador) {
    try {
      // Consulta SQL para obter os itens do inventário do jogador
      const query = `
        SELECT i.nome, ii.quantidade
        FROM Item_Inventario ii
        JOIN Item i ON ii.id_item = i.id_item
        WHERE ii.id_jogador = $1;
      `;
  
      // Executa a consulta
      const itensInventario = await db.any(query, [jogador.id_jogador]);
  
      if (itensInventario.length > 0) {
        console.log("Itens do Inventário:");
  
        // Exibe os itens do inventário
        for (const item of itensInventario) {
          console.log(`${item.nome}: ${item.quantidade}`);
        }
      } else {
        console.log("Seu inventário está vazio. Explore o mundo para encontrar itens!");
      }
  
    } catch (error) {
      console.error('Erro durante a visualização do inventário:', error.message || error);
    }
  }
  
  // Exemplo de chamada da função de visualização do inventário
  const jogadorExemplo = {
    id_jogador: 1, // Substitua pelo ID do jogador
  };
  
  visualizarInventario(jogadorExemplo);
  