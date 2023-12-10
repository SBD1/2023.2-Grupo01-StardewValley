import { connect } from "../db.js";

async function avancarTempo(jogador, minutosParaAvancar = 1) {
  const client = await connect();

  try {
    const minutosPorDia = 1440; // Total de minutos em um dia

    // Incrementa o tempo
    jogador.hora += minutosParaAvancar;

    // Reseta para 00:00 se for 24:00
    if (jogador.hora >= minutosPorDia) {
      jogador.hora = 0;
      jogador.dia += 1;

      // Verifica se a estação acabou 28
      if (jogador.dia > 28) {
        jogador.dia = 1;

        // Aumenta o ID da estação e reseta para 1 se ultrapassar 4
        jogador.id_estacao += 1;
        if (jogador.id_estacao > 4) {
          jogador.id_estacao = 1;
        }
      }
    }

    // Notifica se está ficando tarde
    if (jogador.hora >= minutosPorDia - minutosNoite) {
      console.log("Já está ficando tarde...");
    }

    // Atualiza o banco de dados com o novo tempo e dia
    const updateQuery = `
      UPDATE Jogador
      SET dia = $1, hora = $2, id_estacao = $3
      WHERE id_jogador = $4;
    `;

    await client.query(updateQuery, [jogador.dia, jogador.hora, jogador.id_estacao, jogador.id_jogador]);

    // console.log(`Tempo avançado. Nova hora: ${Math.floor(jogador.hora / minutosPorHora)}:${jogador.hora % minutosPorHora}, Estação: ${jogador.id_estacao}`);
  } catch (error) {
    console.error("Erro ao avançar o tempo:", error.message || error);
  } finally {
    await client.end();
  }
}

export { avancarTempo };
