async function dinamicaDormir(jogador) {
    try {
      // Pergunta ao jogador se quer ir para a cabana ou continuar jogando
      const opcao = readlineSync.keyInSelect(['Ir para a cabana', 'Continuar jogando'], 'O que deseja fazer?');
  
      if (opcao === 0) {
        // Jogador escolheu ir para a cabana
        console.log('Você foi para a cabana.');
        // Implemente lógica específica da cabana, se necessário
      } else {
        // Jogador escolheu continuar jogando
        console.log('Você decidiu continuar jogando.');
  
        // Se energia estiver baixa, oferece opção de dormir novamente
        if (jogador.energia <= 5) {
          console.log('Sua energia está muito baixa. Você deve ir dormir em breve.');
          const continuarJogando = readlineSync.keyInYNStrict('Deseja continuar jogando?');
  
          if (!continuarJogando) {
            console.log('Você decidiu ir dormir.');
            await dinamicaDormir(jogador); // Chama recursivamente a dinâmica de dormir
          }
        }
  
        // Atualiza a energia do jogador para 100%
        jogador.energia = 100;
        console.log('Sua energia foi completamente recuperada.');
  
        // Incrementa +1 no dia
        jogador.dia += 1;
  
        // Verifica se chegou ao final do mês
        if (jogador.dia > 28) {
          jogador.dia = 1;
  
          // Incrementa para a próxima estação
          jogador.id_estacao += 1;
  
          // Se chegou ao final do ano, reinicia a estação
          if (jogador.id_estacao > 4) {
            jogador.id_estacao = 1;
          }
  
          console.log(`Nova estação: ${jogador.id_estacao}`);
        }
  
        console.log(`Novo dia: ${jogador.dia}`);
      }
    } catch (error) {
      console.error('Erro durante a dinâmica de dormir:', error.message || error);
    }
  }
  
  // Exemplo de chamada da função
  const jogadorExemplo = {
    energia: 20,      // Substitua pela energia atual do jogador
    dia: 15,          // Substitua pelo dia atual do jogador
    id_estacao: 3,    // Substitua pela estação atual do jogador
  };
  
  await dinamicaDormir(jogadorExemplo);
  