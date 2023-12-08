import { getJogadorByNome, getJogadores } from "../repositories/jogador.repository.js"

export async function jogador(req, res) {
    console.log("controller")
    const { id } = req.params
    try {
        const { rows: jogador } = await getJogadorByNome(id)
        if (jogador.rowCount === 0) return res.status(404).send({ message: "Jogador não existe!" })

        console.log(jogador.nome);
        res.send({ jogador })

    } catch (e) {
        res.status(500).send(e.message)
    }
}

export async function pegarTodosJogadores(req, res) {

    try {
        const { rows: jogadores } = await getJogadores()
        // if (jogadores.rowCount === 0) return res.status(404).send({ message: "Jogador não existe!" })

        res.send(jogadores)

    } catch (e) {
        res.status(500).send(e.message)
    }

}

