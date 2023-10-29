import { db } from "../database/db.connection.js"

export function getUserByEmailDB(email) {
    return db.query(`SELECT * FROM users WHERE email=$1;`, [email])
}

export function getCompleteUserDB(userId) {
    return db.query(`
        SELECT users.id, users.name, SUM(urls."visitCount") AS "visitCount", 
                JSON_AGG(
                    JSON_BUILD_OBJECT('id', urls.id, 'url', urls.url, 'shortUrl', urls."shortUrl", 'visitCount', urls."visitCount")
                ) AS "shortenedUrls"
            FROM users 
            JOIN urls ON users.id = urls."userId"
            WHERE users.id=$1
            GROUP BY users.id, users.name;`,
        [userId]
    )
}

export function getRankingDB() {
    return db.query(`
        SELECT users.id, users.name, COUNT(urls.id) "linksCount", COALESCE(SUM(urls."visitCount"), 0) AS "visitCount"
            FROM users 
            LEFT JOIN urls ON users.id = urls."userId"
            GROUP BY users.id, users.name
            ORDER BY "visitCount" DESC, "linksCount" DESC
            LIMIT 10;
    `)
}

export function createUserDB(name, email, password) {
    return db.query(
        `INSERT INTO users (name, email, password) VALUES ($1, $2, $3);`,
        [name, email, password]
    )
}
