// Função para a lógica de plantação
async function plantarSementes(jogador) {
    try {
      // Mostra as sementes disponíveis no inventário
      const sementesDisponiveis = await db.any('SELECT * FROM Semente WHERE id_item IN (SELECT id_item FROM Item_Inventario WHERE id_jogador = $1)', [jogador.id_jogador]);
  
      console.log("Sementes Disponíveis para Plantar:");
      for (const semente of sementesDisponiveis) {
        console.log(`${semente.id_semente}. ${semente.nome}`);
      }
  
      // Pede ao jogador para escolher uma semente para plantar
      const escolhaSemente = readlineSync.questionInt("Escolha uma semente para plantar: ");
  
      // Obtém informações da semente escolhida
      const sementeEscolhida = await db.one('SELECT * FROM Semente WHERE id_semente = $1', [escolhaSemente]);
  
      // Inicia a dinâmica de plantação
      console.log(`Plantando ${sementeEscolhida.nome}...`);
  
      // Lógica de plantação: atualiza o inventário, habilidades, etc.
      // (Adapte de acordo com a sua lógica específica)
  
      // Exemplo: Atualiza o inventário do jogador (remove a semente plantada)
      await db.none('DELETE FROM Item_Inventario WHERE id_jogador = $1 AND id_item = $2', [jogador.id_jogador, sementeEscolhida.id_item]);
  
      // Incrementa a habilidade de cultivo
      await db.none('UPDATE Habilidade SET nivel_cultivo = nivel_cultivo + 1 WHERE id_jogador = $1', [jogador.id_jogador]);
  
      // Calcula a data de colheita (dia atual + dias para crescer da semente)
      const diaColheita = jogador.dia + sementeEscolhida.dias_para_crescer;
  
      // Registra a plantação na tabela Plantacao
      await db.none('INSERT INTO Plantacao (id_jogador, id_semente, dia_colheita) VALUES ($1, $2, $3)', [jogador.id_jogador, sementeEscolhida.id_semente, diaColheita]);
  
      // Decrementa a energia do jogador
      const novaEnergia = jogador.energia - 5;
      await db.none('UPDATE Jogador SET energia = $1 WHERE id_jogador = $2', [novaEnergia, jogador.id_jogador]);
  
      // Mostra mensagem de sucesso
      console.log(`${sementeEscolhida.nome} plantada com sucesso!\n`);
  
      // (Adapte conforme necessário para a sua dinâmica de plantação)
  
    } catch (error) {
      console.error('Erro durante a plantação:', error.message || error);
    }
  }
  
  // Exemplo de chamada da função de plantação
  const jogadorExemplo = {
    id_jogador: 1, // Substitua pelo ID do jogador
    dia: 1, // Substitua pelo dia atual do jogador
    energia: 100 // Substitua pela energia atual do jogador
  };
  
  plantarSementes(jogadorExemplo);
  