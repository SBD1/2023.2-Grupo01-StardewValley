import pg from "pg";

const { Pool } = pg;

async function connect() {
  if (global.connection) return global.connection.connect();

  console.log(`Connection string: ${process.env.CONNECTION_STRING}`);

  const pool = new Pool({
    connectionString: process.env.CONNECTION_STRING,
  });


  const client = await pool.connect();
  console.log("Criou pool de conexões no PostgreSQL!");

  const res = await client.query("SELECT NOW()");
  console.log(res.rows[0]);
  client.release();

  //guardando para usar sempre o mesmo
  global.connection = pool;
  return pool.connect();
}

export { connect };
