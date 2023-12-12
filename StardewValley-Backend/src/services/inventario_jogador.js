import { connect } from "../db.js";

export async function obterInventarioJogador(idJogador) {
  // console.log(`Connection string: ${process.env.CONNECTION_STRING}`);
  const client = await connect();

  const result = await client.query("SELECT * FROM sp_obter_inventario_jogador($1)", [idJogador]);
            
  await client.end();

  // retorna objeto de status do jogador(energia, ouro e nivel de habilidades)
  return result;
}

export async function exibirInventarioJogador(jogadorInventario) {
    console.log(" \n____________________________________________________________");
    console.log(`|               Inventário - Stardew Valley               `);
    console.log(`|               ===========================               `);
    console.log(`| Itens:                                                  `);
    let j = 0;
    //console.log(jogadorInventario);
    for (const  item of jogadorInventario.rows) {
        console.log(`| ${j + 1}. ${item.nome.trim()} - ${item.descricao.trim()} - ${item.qtdd}`);
        j = j + 1;
    }
    console.log("|____________________________________________________________\n");
  }
  


  