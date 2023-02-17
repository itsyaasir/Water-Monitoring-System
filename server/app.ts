import express from 'express';
import rTracer from 'cls-rtracer';
import cors from 'cors';
import morgan from 'morgan';
import chalk from 'chalk';
import bodyParser from 'body-parser';
import { errorResponse } from './src/utils';
import errorHandler from './src/middlewares/errorHandler';
import authRoutes from './src/routes/auth.routes';
import logger from './src/utils/logger';
import './src/config/sequelize';
import dotenv from 'dotenv';


const app = express();

dotenv.config();

// Tracer
app.use(rTracer.expressMiddleware());

// cors
app.use(cors());

// logging
if (process.env.NODE_ENV === 'development') {
  app.use(morgan('combined'));
}

app.use(express.json());

app.use('/api/v1/auth', authRoutes);

app.all('*', (req, res) => {
  logger.info(chalk.bgYellow('Route not found'));
  errorResponse(req, res, 'Route not found', 404);
});

app.use(errorHandler);

export default app;
