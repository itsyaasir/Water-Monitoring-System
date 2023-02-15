import express from 'express'
import { errorResponse } from './src/utils'
import rTracer from 'cls-rtracer'
import cors from 'cors'

const app = express()

// Tracer
app.use(rTracer.expressMiddleware())

// cors
app.use(cors())

app.all('*', (req, res) => { errorResponse(req, res, 'Route not found', 404) })

export default app
