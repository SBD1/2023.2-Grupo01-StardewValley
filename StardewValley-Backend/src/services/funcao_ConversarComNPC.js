// Função para a lógica de conversa com NPC
async function conversarComNPC(jogador) {
    try {
      // Mostra os NPCs disponíveis na região
      const npcsRegiao = await db.any('SELECT * FROM NPC WHERE id_regiao = $1', [jogador.id_regiao]);
      
      console.log("NPCs Disponíveis para Conversa:");
      for (const npc of npcsRegiao) {
        console.log(`${npc.id_npc}. ${npc.nome}`);
      }
  
      // Pede ao jogador para escolher um NPC
      const escolhaNPC = readlineSync.questionInt("Escolha um NPC para conversar: ");
  
      // Obtém informações do NPC escolhido
      const npcEscolhido = await db.one('SELECT * FROM NPC WHERE id_npc = $1', [escolhaNPC]);
  
      // Mostra a fala do NPC
      console.log(`${npcEscolhido.nome}: ${npcEscolhido.fala}\n`);
  
      // (Adapte conforme necessário para a sua dinâmica de conversa)
  
    } catch (error) {
      console.error('Erro durante a conversa com NPC:', error.message || error);
    }
  }
  
  // Exemplo de chamada da função de conversa com NPC
  const jogadorExemplo = {
    id_regiao: 1, // Substitua pelo ID da região do jogador
  };
  
  conversarComNPC(jogadorExemplo);
  