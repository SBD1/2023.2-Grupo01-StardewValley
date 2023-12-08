// Função para ação na casa do jogador
async function acaoCasaJogador(jogador) {
    console.log("\n*** Em Casa ***");
  
    try {
      // Opções para o jogador em casa
      const opcoesCasa = ['Dormir', 'Sair de Casa'];
      const escolhaCasa = readlineSync.keyInSelect(opcoesCasa, 'O que você deseja fazer em casa?');
  
      switch (escolhaCasa) {
        case 0: // Dormir
          await dormir(jogador);
          break;
        case 1: // Sair de Casa
          console.log("Saindo de casa...");
          break;
        default:
          console.log("Escolha inválida. Saindo de casa.");
      }
    } catch (error) {
      console.error('Erro durante a ação na casa do jogador:', error.message || error);
    }
  }
  
  // Função para simular o ato de dormir
  async function dormir(jogador) {
    console.log("Você está indo dormir...");
  
    try {
      // Lógica para avançar o tempo, como incrementar o dia, atualizar energia, etc.
      // ...
  
      console.log("Dormindo... Bom descanso!");
    } catch (error) {
      console.error('Erro durante o ato de dormir:', error.message || error);
    }
  }
  
  // Exemplo de chamada da função para ação na casa do jogador
  const jogadorExemplo = {
    id_jogador: 1,               // Substitua pelo ID do jogador
    id_local_fechado: 'casa'  // Substitua pelo ID da casa do jogador
  };
  
  acaoCasaJogador(jogadorExemplo);
  
