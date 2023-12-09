async function dinamicaComerItem(jogador) {
    try {
      // Mostra os itens consumíveis disponíveis com seus efeitos
      const consumiveis = await db.any('SELECT * FROM Consumivel JOIN Efeito ON Consumivel.id_consumivel = Efeito.id_consumivel');
      
      console.log('Itens Consumíveis Disponíveis:');
      consumiveis.forEach((item, index) => {
        console.log(`${index + 1}. ${item.nome} - Efeito: ${item.descricao_efeito}`);
      });
  
      // Pede para o jogador escolher um item consumível
      const escolha = readlineSync.questionInt('Escolha o número do item que deseja consumir: ');
  
      // Verifica se a escolha é válida
      if (escolha < 1 || escolha > consumiveis.length) {
        console.log('Escolha inválida. Tente novamente.');
        return;
      }
  
      const itemEscolhido = consumiveis[escolha - 1];
  
      // Atualiza a energia do jogador com base no efeito do item consumível
      jogador.energia += itemEscolhido.valor_efeito;
  
      // Verifica se a energia ultrapassou 100% e ajusta para 100%
      if (jogador.energia > 100) {
        jogador.energia = 100;
      }
  
      console.log(`Você consumiu ${itemEscolhido.nome}. Sua energia foi atualizada para ${jogador.energia}.`);
    } catch (error) {
      console.error('Erro durante a dinâmica de consumir item:', error.message || error);
    }
  }
  
  // Exemplo de chamada da função
  const jogadorExemplo = {
    energia: 50,      // Substitua pela energia atual do jogador
  };
  
  await dinamicaComerItem(jogadorExemplo);
  