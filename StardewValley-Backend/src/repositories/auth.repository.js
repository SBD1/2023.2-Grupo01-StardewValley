import { db } from "../database/db.connection.js"

export function createSessionDB(userId, token) {
    return db.query(
        `INSERT INTO sessions ("userId", token) VALUES ($1, $2);`,
        [userId, token]
    )
}

export function findSessionDB(token) {
    return db.query(`SELECT "userId" FROM sessions WHERE token=$1;`, [token])
}