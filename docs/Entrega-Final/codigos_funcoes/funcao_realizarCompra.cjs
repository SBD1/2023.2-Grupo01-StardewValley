// Função para realizar uma compra na loja
async function realizarCompra(jogador) {
    console.log("\n*** Bem-vindo à loja! ***");
  
    try {
      // Exibir estoque da loja para compras
      const estoqueQuery = `
        SELECT i.id_item, i.nome, i.preco, t.tipo_item
        FROM Item_Estoque_Loja il
        JOIN Item i ON il.id_item = i.id_item
        JOIN Tipo_Item t ON i.id_tipo_item = t.id_tipo_item
        WHERE il.id_local_fechado = $1;
      `;
      const estoqueItens = await db.any(estoqueQuery, [jogador.id_local_fechado]);
  
      console.log("\nEstoque Disponível:");
      console.log("ID | Nome | Tipo | Preço");
      estoqueItens.forEach(item => {
        console.log(`${item.id_item} | ${item.nome} | ${item.tipo_item} | ${item.preco}`);
      });
  
      // Pedir ao jogador para escolher um item e quantidade
      const escolhaItem = readlineSync.questionInt("\nEscolha o ID do item que deseja comprar: ");
      const quantidadeCompra = readlineSync.questionInt("Informe a quantidade desejada: ");
  
      // Verificar se o jogador tem ouro suficiente
      const itemEscolhido = estoqueItens.find(item => item.id_item === escolhaItem);
      const custoTotal = itemEscolhido.preco * quantidadeCompra;
  
      if (jogador.qtdd_ouro < custoTotal) {
        console.log("\nVocê não possui ouro suficiente para realizar essa compra.");
        return;
      }
  
      // Atualizar inventário do jogador e decrementar quantidade no estoque da loja
      await db.tx(async t => {
        await t.none('UPDATE Jogador SET qtdd_ouro = $1 WHERE id_jogador = $2', [jogador.qtdd_ouro - custoTotal, jogador.id_jogador]);
        await t.none('UPDATE Item_Estoque_Loja SET quantidade = quantidade - $1 WHERE id_item = $2', [quantidadeCompra, escolhaItem]);
        await t.none('INSERT INTO Item_Inventario(id_jogador, id_item, quantidade) VALUES($1, $2, $3)', [jogador.id_jogador, escolhaItem, quantidadeCompra]);
      });
  
      console.log(`\nCompra realizada com sucesso! Você comprou ${quantidadeCompra}x ${itemEscolhido.nome}.`);
    } catch (error) {
      console.error('Erro durante a realização da compra:', error.message || error);
    }
  }
  
  // Exemplo de chamada da função para realizar uma compra
  const jogadorExemplo = {
    id_jogador: 1,               // Substitua pelo ID do jogador
    qtdd_ouro: 500,              // Substitua pela quantidade de ouro atual
    id_local_fechado: 'loja'     // Substitua pelo ID do local fechado atual
  };
  
  realizarCompra(jogadorExemplo);
  