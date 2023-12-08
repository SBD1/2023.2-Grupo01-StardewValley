async function explorarCaverna(jogador) {
    try {
      // Mostra as opções disponíveis na caverna
      console.log('Opções disponíveis na caverna:');
      console.log('1. Minerar');
      console.log('2. Combater');
      console.log('3. Sair da caverna');
  
      // Pede para o jogador escolher uma opção
      const escolha = readlineSync.questionInt('Escolha o número da opção desejada: ');
  
      switch (escolha) {
        case 1:
          // Dinâmica de mineração
          await dinamicaMineracao(jogador);
          break;
        case 2:
          // Dinâmica de combate
          await dinamicaCombate(jogador);
          break;
        case 3:
          // Sair da caverna
          console.log('Você saiu da caverna.');
          break;
        default:
          console.log('Opção inválida. Tente novamente.');
      }
    } catch (error) {
      console.error('Erro durante a exploração da caverna:', error.message || error);
    }
  }
  
  async function dinamicaMineracao(jogador) {
    try {
      // Mostra os itens que podem ser minerados
      const itensMineraveis = await db.any('SELECT * FROM Consumivel WHERE local_fechado = $1', ['caverna']);
  
      console.log('Itens que podem ser minerados:');
      itensMineraveis.forEach((item, index) => {
        console.log(`${index + 1}. ${item.nome}`);
      });
  
      // Pede para o jogador escolher um item para minerar
      const escolha = readlineSync.questionInt('Escolha o número do item que deseja minerar: ');
  
      // Verifica se a escolha é válida
      if (escolha < 1 || escolha > itensMineraveis.length) {
        console.log('Escolha inválida. Tente novamente.');
        return;
      }
  
      const itemMinerado = itensMineraveis[escolha - 1];
  
      // Atualiza o inventário do jogador com o item minerado
      await db.none('INSERT INTO Item_Inventario(id_jogador, id_item) VALUES ($1, $2)', [jogador.id_jogador, itemMinerado.id_item]);
  
      console.log(`Você minerou ${itemMinerado.nome} e adicionou ao seu inventário.`);
    } catch (error) {
      console.error('Erro durante a dinâmica de mineração:', error.message || error);
    }
  }
  
  async function dinamicaCombate(jogador) {
    try {
      // Mostra instâncias de monstros disponíveis na caverna
      const monstros = await db.any('SELECT * FROM Instancia_Monstro WHERE id_caverna = $1', [jogador.id_local_fechado]);
  
      console.log('Monstros disponíveis para combate:');
      monstros.forEach((monstro, index) => {
        console.log(`${index + 1}. ${monstro.nome} - Dano: ${monstro.dano} | Energia: ${monstro.energia}`);
      });
  
      // Pede para o jogador escolher um monstro para combater
      const escolha = readlineSync.questionInt('Escolha o número do monstro que deseja combater: ');
  
      // Verifica se a escolha é válida
      if (escolha < 1 || escolha > monstros.length) {
        console.log('Escolha inválida. Tente novamente.');
        return;
      }
  
      const monstroEscolhido = monstros[escolha - 1];
  
      // Dinâmica de combate
      await dinamicaCombateMonstro(jogador, monstroEscolhido);
    } catch (error) {
      console.error('Erro durante a dinâmica de combate:', error.message || error);
    }
  }
  
  async function dinamicaCombateMonstro(jogador, monstro) {
    try {
      // Exibir informações iniciais do combate
      console.log(`Você entrou em combate com ${monstro.nome}!`);
      console.log(`Seu HP: ${jogador.energia} | ${monstro.nome} HP: ${monstro.energia}`);
  
      // Dinâmica de combate
      while (jogador.energia > 0 && monstro.energia > 0) {
        // Pede para o jogador escolher uma ação
        console.log('Escolha sua ação:');
        console.log('1. Atacar');
        console.log('2. Defender');
  
        const escolhaAcao = readlineSync.questionInt('Escolha o número da ação desejada: ');
  
        switch (escolhaAcao) {
          case 1:
            // Ataque
            const danoJogador = Math.floor(Math.random() * 10) + 1; // Simulação de dano aleatório do jogador
            const danoMonstro = Math.floor(Math.random() * 10) + 1; // Simulação de dano aleatório do monstro
  
            jogador.energia -= danoMonstro;
            monstro.energia -= danoJogador;
  
            console.log(`Você causou ${danoJogador} de dano a ${monstro.nome}.`);
            console.log(`${monstro.nome} causou ${danoMonstro} de dano a você.`);
  
            break;
          case 2:
            // Defesa
            const defesaJogador = Math.floor(Math.random() * 5) + 1; // Simulação de defesa aleatória do jogador
            const defesaMonstro = Math.floor(Math.random() * 5) + 1; // Simulação de defesa aleatória do monstro
  
            jogador.energia -= defesaMonstro;
            monstro.energia -= defesaJogador;
  
            console.log(`Você se defendeu e recebeu ${defesaMonstro} de dano de ${monstro.nome}.`);
            console.log(`${monstro.nome} se defendeu e recebeu ${defesaJogador} de dano.`);
  
            break;
          default:
            console.log('Escolha inválida. Tente novamente.');
        }
  
        console.log(`Seu HP: ${jogador.energia} | ${monstro.nome} HP: ${monstro.energia}`);
      }
  
      // Verifica o resultado do combate
      if (jogador.energia <= 0) {
        console.log(`Você foi derrotado por ${monstro.nome}.`);
      } else {
        console.log(`Você derrotou ${monstro.nome}!`);
  
        // Atualizações após a vitória
        await db.none('DELETE FROM Instancia_Monstro WHERE id_monstro = $1', [monstro.id_monstro]);
        console.log(`${monstro.nome} foi removido da caverna.`);
  
        // Adiciona item dropado ao inventário do jogador
        const itemDropado = await db.one('SELECT * FROM Item WHERE id_item = $1', [monstro.id_item_dropado]);
        await db.none('INSERT INTO Item_Inventario(id_jogador, id_item) VALUES ($1, $2)', [jogador.id_jogador, itemDropado.id_item]);
        console.log(`Você recebeu ${itemDropado.nome} como recompensa!`);
      }
    } catch (error) {
      console.error('Erro durante a dinâmica de combate com monstro:', error.message || error);
    }
  }
  
  // Exemplo de chamada da função
  const jogadorExemplo = {
    id_jogador: 1,      // Substitua pelo ID do jogador atual
    id_local_fechado: 1 // Substitua pelo ID da caverna atual
  };
  
  await explorarCaverna(jogadorExemplo);
  