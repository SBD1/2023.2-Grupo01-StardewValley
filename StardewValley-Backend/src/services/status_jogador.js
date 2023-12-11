import { connect } from "../db.js";

export async function statusJogador(idJogador) {
  const client = await connect();

  const query = `SELECT j.nome, j.energia, j.qtdd_ouro, h.nivel_coleta, h.nivel_cultivo, h.nivel_mineracao, h.nivel_pesca, h.nivel_combate FROM jogador j 

  join Habilidade h on h.id_jogador = j.id_jogador
  where j.id_jogador = $1`;

  const result = await client.query(query, [idJogador]);

  await client.end();

  // retorna objeto de status do jogador(energia, ouro e nivel de habilidades)
  return result.rows[0];
}

export async function exibirStatusJogador(jogadorHabilidade) {
    console.log(" \n________________________________________________");
    console.log(`|           Stardew Valley - MUD                   `);
    console.log(`|           ====================                   `);
    console.log(`| Nome: ${jogadorHabilidade.nome}                  `);
    console.log(`| Energia: ${jogadorHabilidade.energia}            `);
    console.log(`| Ouro: ${jogadorHabilidade.qtdd_ouro}             `);
    console.log(`| Níveis de Habilidade:                            `);
    console.log(`|   Coleta: ${jogadorHabilidade.nivel_coleta}      `);
    console.log(`|   Cultivo: ${jogadorHabilidade.nivel_cultivo}    `);
    console.log(`|   Mineração: ${jogadorHabilidade.nivel_mineracao}`);
    console.log(`|   Pesca: ${jogadorHabilidade.nivel_pesca}        `);
    console.log(`|   Combate: ${jogadorHabilidade.nivel_combate}    `);
    console.log("|________________________________________________\n");
  }
  
