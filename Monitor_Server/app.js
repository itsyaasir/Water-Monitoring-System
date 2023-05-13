import authRoutes from './src/routes/auth.routes';
import logger from './src/utils/logger';
import errorHandler from './src/middlewares/errorHandler';
import { errorResponse } from './src/utils';
import statsRoutes from './src/routes/stats.routes';
import pumpsRoutes from './src/routes/pumps.routes';

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
app.use('/api/v1/stats', statsRoutes);
app.use('/api/v1/pumps', pumpsRoutes);
// Health check
app.get('/health-check', (req, res) => {
  res.status(200).json({
    status: 'success',
    message: 'Server is running',
  });
});

app.use(errorHandler);

app.all('*', (req, res) => {
  logger.info(chalk.bgYellow('Route not found'));
  errorResponse(req, res, 'Route not found', 404);
});

module.exports = app;
