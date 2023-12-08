import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import chalk from 'chalk';
import router from "./routes/index.routes.js";

dotenv.config()

const app = express()
app.use(cors())
app.use(express.json())
app.use(router)

const PORT = process.env.PORT || 5000
app.listen(PORT, () => console.log(chalk.green(`Rodando em http://localhost:${PORT}`)))

