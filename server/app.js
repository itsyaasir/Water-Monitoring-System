import authRoutes from './src/routes/auth.routes';
import logger from './src/utils/logger';
import errorHandler from './src/middlewares/errorHandler';
import { errorResponse } from './src/utils';

const express = require('express');
const morgan = require('morgan');
const chalk = require('chalk');

const dotenv = require('dotenv');

const cors = require('cors');

const rTracer = require('cls-rtracer');

const app = express();

dotenv.config();

require('./src/config/sequelize');

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

app.use(errorHandler);

app.all('*', (req, res) => {
  logger.info(chalk.bgYellow('Route not found'));
  errorResponse(req, res, 'Route not found', 404);
});

module.exports = app;
