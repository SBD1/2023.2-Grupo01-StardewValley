import { Router } from "express"
import { getCurrentUser, getUserRanking } from "../controllers/user.controllers.js"
import { validateAuth } from "../middlewares/validateAuth.js"

const userRouter = Router()

userRouter.get("/users/me", validateAuth, getCurrentUser)
userRouter.get("/ranking", getUserRanking)

export default userRouter