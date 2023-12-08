// Função para avançar o tempo em qualquer tela
async function avancarTempo(jogador, horasParaAvancar = 1) {
    try {
      // Lógica para avançar o tempo, atualizar hora, dia, estação, etc.
      // ...
  
      console.log(`Tempo avançado. Novo dia: ${jogador.dia}, Nova hora: ${jogador.hora}`);
    } catch (error) {
      console.error('Erro durante o avanço do tempo:', error.message || error);
    }
  }
  
  // Função para simular a dinâmica de dormir
  async function dinamicaDormir(jogador) {
    console.log("Você está indo dormir...");
  
    try {
      // Lógica para recuperar energia, reiniciar o dia, verificar sementes, etc.
      // ...
  
      console.log("Dormindo... Bom descanso!");
    } catch (error) {
      console.error('Erro durante a dinâmica de dormir:', error.message || error);
    }
  }
  
  // Função para simular a dinâmica de comer item com efeito
  async function dinamicaComerItemComEfeito(jogador) {
    try {
      // Lógica para mostrar itens consumíveis, pedir escolha do jogador, incrementar/decrementar energia, etc.
      // ...
  
      console.log("Item consumido com efeito!");
    } catch (error) {
      console.error('Erro durante a dinâmica de comer item com efeito:', error.message || error);
    }
  }
  
  // Exemplo de chamada das funções
  const jogadorExemplo = {
    id_jogador: 1,               // Substitua pelo ID do jogador
    dia: 1,                      // Substitua pelo dia atual do jogador
    hora: 12,                    // Substitua pela hora atual do jogador
    id_estacao: 1,               // Substitua pela ID da estação atual do jogador
    energia: 70,                 // Substitua pela energia atual do jogador
  };
  
  // Exemplo de avanço do tempo e dinâmica de dormir
  avancarTempo(jogadorExemplo, 2); // Avança 2 horas
  dinamicaDormir(jogadorExemplo);  // Simula a dinâmica de dormir
  
  // Exemplo de dinâmica de comer item com efeito
  dinamicaComerItemComEfeito(jogadorExemplo);
  