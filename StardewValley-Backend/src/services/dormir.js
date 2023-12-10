import { connect } from "../db.js";

async function dormir(jogador) {
  const client = await connect();

  try {
    console.log("Indo dormir...");

    // Verifica se o jogador está na sua cabana
    const jogadorNaCabana = await estaNaCabana(client, jogador);

    // Verifica se é hora de dormir
    const horaAcordar = 6 * 60; // 6:00 da manhã em minutos
    const horaAtual = jogador.hora;
    const ehDia = (horaAtual >= horaAcordar && horaAtual < 1440)

    if (jogadorNaCabana) {
      // Dormir normalmente sem penalidades
      console.log("Dormindo tranquilamente...");

      // Restaurando energia para 100%
      jogador.energia = 100;

      if (ehDia) {
        // Incrementa +1 no dia
        jogador.dia += 1;

        // Verifica se dia > 28, se sim volta dia para 01 e incrementa para a próxima estação
        if (jogador.dia > 28) {
          jogador.dia = 1;
          jogador.id_estacao += 1;

          // Verifica se a id-estação não consta na tabela Estacao, se não constar volta pra primeira id-estacao = 1
          const estacaoResult = await client.query("SELECT id_estacao FROM Estacao WHERE id_estacao = $1", [jogador.id_estacao]);
          if (estacaoResult.rows.length === 0) {
            jogador.id_estacao = 1;
          }

          // Se a estação foi alterada, apaga todas as linhas da tabela Plantacao
          if (jogador.id_estacao !== estacaoResult.rows[0].id_estacao) {
            await client.query("DELETE FROM Plantacao");
          }
        }

        // Verifica se na tabela Plantacao tem alguma que já pode ser colhida (Plantacao.dia_colheita = jogador.dia)
        const colheitasResult = await client.query("SELECT * FROM Plantacao WHERE dia_colheita = $1", [jogador.dia]);

        if (colheitasResult.rows.length > 0) {
          // Se sim, incrementa inventário, mostra na tela para o jogador saber do incremento e deleta linha da tabela Plantacao
          console.log("Colheitas disponíveis:");
          for (const colheita of colheitasResult.rows) {
            console.log(`- Colheita ${colheita.id_plantacao}: Semente ${colheita.id_semente}`);
            // Incrementa o inventário e deleta a colheita
            await client.query("DELETE FROM Plantacao WHERE id_plantacao = $1", [colheita.id_plantacao]);
          }
        }
      }

      // Seta energia para 100% novamente
      jogador.energia = 100;

      // Atualiza o banco de dados com as alterações
      await atualizarJogador(client, jogador, horaAcordar);

      console.log("Você acordou revigorado às 6:00 da manhã.");
    } else {
      // Jogador está desmaiado ou dormindo na hora errada, aplicar penalidades
      console.log("Você desmaiou e foi encontrado pelo médico da Vila que cuidou de você.");

      // Penalidade: Descontar 5% do dinheiro
      const penalidadeOuro = Math.ceil(jogador.qtdd_ouro * 0.05);
      jogador.qtdd_ouro -= penalidadeOuro;

      // Move o jogador para a cabana
      await moverJogadorParaCabana(client, jogador);

      // Restaura a energia para 50%
      jogador.energia = 50;

      // Atualiza o banco de dados com as alterações
      await atualizarJogador(client, jogador, horaAcordar);

      console.log(`Você acordou na sua cabana com 50% de energia. Foi cobrado ${penalidadeOuro} de ouro na sua consulta.`);
    }
  } catch (error) {
    console.error("Erro ao dormir:", error.message || error);
  } finally {
    await client.end();
  }
}

async function estaNaCabana(client, jogador) {
  // Verifica se o jogador está na sua cabana
  const result = await client.query(`
      SELECT id_cabana_jogador
      FROM Cabana_Jogador
      WHERE id_jogador = $1 AND id_local_fechado = $2;
    `, [jogador.id_jogador, jogador.id_local_fechado]);

  return result.rows.length > 0;
}

async function moverJogadorParaCabana(client, jogador) {
  const cabana = await client.query("SELECT * FROM Cabana_Jogador WHERE id_jogador = $1", [jogador.id_jogador]);
  if (cabana.rows.length > 0) {
    jogador.id_local_fechado = cabana.rows[0].id_local_fechado;
    jogador.id_regiao = cabana.rows[0].id_regiao;
  }
}

async function atualizarJogador(client, jogador, hora) {
  await client.query(`
    UPDATE Jogador
    SET dia = $1, hora = $2, id_estacao = $3, energia = $4, qtdd_ouro = $5
    WHERE id_jogador = $6;
  `, [jogador.dia, hora, jogador.id_estacao, jogador.energia, jogador.qtdd_ouro, jogador.id_jogador]);
}

export { dormir };
