import { connect } from "../db.js";
import readlineSync from "readline-sync";


async function coletarItens(infoRegiao) {

  const client = await connect();
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
  //console.log(itensColeta)

  const escolhaColeta = readlineSync.keyInSelect(itensColeta, "O que você quer coletar?");


  // retorna objeto de status do jogador(energia, ouro e nivel de habilidades)
  client.end();
}

export { coletarItens }