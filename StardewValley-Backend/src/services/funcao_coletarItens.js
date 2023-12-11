import { connect } from "../db.js";
import readlineSync from "readline-sync";


async function coletarItens(infoRegiao, infoJogador) {
  const client = await connect();
  // console.log(`Connection string: ${process.env.CONNECTION_STRING}`);

  //console.log(infoRegiao)

  let coletar = await client.query(`select * from consumivel 
  where id_local_fechado is null and id_regiao=$1;`, [infoRegiao.id_regiao])

  if (coletar.rows.length === 0) {
    console.log("Pooooxa =( Nao ha itens para coletar nesta regiao!!")
    return client.end();
  }

  coletar = coletar.rows;
  // console.log(coletar)

  const itensColeta = []
  coletar.map(c => itensColeta.push(c.nome))
  console.log(itensColeta)

  const escolhaColeta = readlineSync.keyInSelect(itensColeta, "O que você quer coletar?");

  dinamicaColeta(infoJogador)

  client.end();
}


function dinamicaColeta(infoJogador){

 client.query(`Update * from item_iventario where id_jogador=$1 and id_item=$2
set 


  where id_local_fechado is null and id_regiao=$1;`, [infoJogador.id_jogador])


}
export { coletarItens }