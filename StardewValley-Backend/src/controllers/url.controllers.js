import { customAlphabet } from 'nanoid'
import { createShortUrlDB, deleteUrlDB, getUrlByIdDB, getUrlByNameDB, getUrlUserById, increaseViewsDB } from '../repositories/url.repository.js'
const nanoid = customAlphabet('1234567890abcdef', 8)

export async function shortenUrl(req, res) {
    const { url } = req.body
    const { userId } = res.locals
    const shortUrl = nanoid()

    try {
        const { rows: [result] } = await createShortUrlDB(url, shortUrl, userId)
        res.status(201).send(result)
    } catch (err) {
        res.status(500).send(err.message)
    }

}

export async function getUrl(req, res) {
    const { id } = req.params
    try {
        const url = await getUrlByIdDB(id)
        if (url.rowCount === 0) return res.status(404).send({ message: "URL não existe!" })

        res.send(url.rows[0])
    } catch (err) {
        res.status(500).send(err.message)
    }
}

export async function openUrl(req, res) {
    const { shortUrl } = req.params
    try {
        const url = await getUrlByNameDB(shortUrl)
        if (url.rowCount === 0) return res.status(404).send({ message: "URL não existe!" })

        await increaseViewsDB(shortUrl)

        res.redirect(url.rows[0].url)
    } catch (err) {
        res.status(500).send(err.message)
    }
}

export async function deleteUrl(req, res) {
    const { id } = req.params
    const { userId } = res.locals

    try {
        const url = await getUrlUserById(id)
        if (url.rowCount === 0) return res.status(404).send({ message: "URL não existe!" })
        if (url.rows[0].userId !== userId) return res.status(401).send({ message: "Você só pode deletar os itens criados por você!" })

        await deleteUrlDB(id)
        res.sendStatus(204)

    } catch (err) {
        res.status(500).send(err.message)
    }
}

