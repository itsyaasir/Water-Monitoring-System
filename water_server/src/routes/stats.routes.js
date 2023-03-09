import express from 'express';
import { validate } from 'express-validation';

import * as statsValidator from '../controllers/stats/stats.validator';
import * as statsController from '../controllers/stats/stats.controller';
import requireAuth from '../middlewares/requireAuth';

const router = express.Router();

/**
 * @route POST /api/stats
 * @Body temperature, ph, oxygen, ec
 * @desc Create a new stats
 * @access Private
 * */
router.post(
  '/',
  validate(statsValidator.statsSchema),
  requireAuth,
  statsController.postStats,
);

/**
 * @route GET /api/stats
 * @desc Get all stats
 * @access Private
 * */
router.get('/', requireAuth, statsController.getStats);

/**
 * @route POST /api/stats/range
 * @Body start, end
 * @desc Get stats in a range
 * @access Private
 * */
router.get(
  '/range',
  validate(statsValidator.statsRangeSchema),
  requireAuth,
  statsController.getStatsRange,
);

/**
 * @route GET /api/stats/latest
 * @desc Get latest stats
 * @access Private
 * */
router.get('/latest', requireAuth, statsController.getLatestStats);

module.exports = router;
