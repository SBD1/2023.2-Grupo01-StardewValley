import { getCompleteUserDB, getRankingDB } from "../repositories/user.repository.js"

export async function getCurrentUser(req, res) {
    const { userId } = res.locals

    try {
        const { rows: [user] } = await getCompleteUserDB(userId)
        res.send(user)
    } catch (err) {
        res.stats(500).send(err.message)
    }
}


export async function getUserRanking(req, res) {
    try {
        const { rows: ranking } = await getRankingDB()
        res.send(ranking)
    } catch (err) {
        res.stats(500).send(err.message)
    }
}
