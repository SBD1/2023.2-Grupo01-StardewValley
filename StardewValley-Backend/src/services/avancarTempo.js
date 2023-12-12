import { connect } from "../db.js";

async function avancarTempo(dadosJogador, minutosParaAvancar = 10) {
  const client = await connect();

  try {
    let jogador = await client.query(`SELECT * from jogador where id_jogador=$1;`, [dadosJogador])

    const minutosPorDia = 1440; // Total de minutos em um dia

    // Incrementa o tempo
    jogador.hora += minutosParaAvancar;

    // Reseta para 00:00 se for 24:00
    if (jogador.hora >= minutosPorDia) {
      jogador.hora = 0;
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
          await client.query("DELETE FROM Plantacao WHERE id_jogador = $1", [jogador.id_jogador]);
        }
      }

      // Verifica se na tabela Plantacao tem alguma que já pode ser colhida (Plantacao.dia_colheita = jogador.dia)
      const colheitasResult = await client.query("SELECT * FROM Plantacao WHERE dia_colheita = $1", [jogador.dia]);

      if (colheitasResult.rows.length > 0) {
        // Se sim, incrementa inventário, mostra na tela para o jogador saber do incremento e deleta linha da tabela Plantacao
        console.log("Colheitas disponíveis:");
        for (const colheita of colheitasResult.rows) {
          console.log(`- Colheita ${colheita.id_plantacao}: Semente ${colheita.id_semente}`);

          // Incrementa o inventário
          const itemInventarioQuery = `
            INSERT INTO Item_Inventario (id_jogador, id_item, qtdd)
            VALUES ($1, $2, $3)
            ON CONFLICT (id_jogador, id_item)
            DO UPDATE SET qtdd = Item_Inventario.qtdd + $3
            RETURNING id_jogador, id_item, qtdd;
          `;
          const itemInventarioResult = await client.query(itemInventarioQuery, [jogador.id_jogador, colheita.id_semente]);

          // Deleta a colheita
          await client.query("DELETE FROM Plantacao WHERE id_plantacao = $1", [colheita.id_plantacao]);
        }
      }
    }

    // Notifica se está ficando tarde
    if (jogador.hora === 0) {
      console.log("Já está ficando tarde...");
    }

    // Atualiza o banco de dados com o novo tempo e dia
    const updateQuery = `
      UPDATE Jogador
      SET dia = $1, hora = $2, id_estacao = $3
      WHERE id_jogador = $4;
    `;

    await client.query(updateQuery, [jogador.dia, jogador.hora, jogador.id_estacao, jogador.id_jogador]);

    // console.log(`Tempo avançado. Nova hora: ${Math.floor(jogador.hora / 60)}:${jogador.hora % 60}, Estação: ${jogador.id_estacao}`);
  } catch (error) {
    console.error("Erro ao avançar o tempo:", error.message || error);
  } finally {
    await client.end();
  }
}

export { avancarTempo };
