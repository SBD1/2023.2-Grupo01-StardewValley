async function avancarTempo(jogador, horasParaAvancar = 1) {
    try {
      const minutosPorHora = 60;
      const minutosParaAvancar = horasParaAvancar * minutosPorHora;
  
      // Atualiza a hora
      jogador.hora += minutosParaAvancar;
  
      // Verifica se passou para o próximo dia
      if (jogador.hora >= 24 * minutosPorHora) {
        jogador.hora = jogador.hora % (24 * minutosPorHora);
        jogador.dia += 1;
  
        // Verifica se passou para a próxima estação
        if (jogador.dia > 28) {
          jogador.dia = 1;
          jogador.id_estacao += 1;
  
          // Verifica se a estação foi alterada, resetando para a primeira
          if (jogador.id_estacao > 4) {
            jogador.id_estacao = 1;
          }
  
          // Lógica adicional ao mudar de estação
          // ...
  
          console.log(`Nova estação: ${jogador.id_estacao}`);
        }
  
        console.log(`Novo dia: ${jogador.dia}`);
      }
  
      console.log(`Tempo avançado. Nova hora: ${jogador.hora}`);
    } catch (error) {
      console.error('Erro durante o avanço do tempo:', error.message || error);
    }
  }
  
  // Exemplo de chamada da função
  const jogadorExemplo = {
    hora: 12,      // Substitua pela hora atual do jogador
    dia: 15,       // Substitua pelo dia atual do jogador
    id_estacao: 3, // Substitua pela estação atual do jogador
  };
  
  avancarTempo(jogadorExemplo, 2); // Avança 2 horas
  