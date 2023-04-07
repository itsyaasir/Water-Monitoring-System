import express from 'express';
import { validate } from 'express-validation';

import * as pumpsController from '../controllers/pumps/pumps.controller';
import requireAuth from '../middlewares/requireAuth';

const router = express.Router();

/**
 * @route POST /api/pumps
 * @Body waterStatus, treatmentStatus
 * @desc Create a new pump
 * @access Private
 * */
router.post('/waterStatus', requireAuth, pumpsController.toggleWaterPump);

/**
 * @route GET /api/pumps
 * @desc Get all pumps
 * @access Private
 * */
router.get('/waterStatus', requireAuth, pumpsController.getWaterPumpStatus);

/**
 * @route POST /api/pumps
 * @Body waterStatus, treatmentStatus
 * @desc Create a new pump
 * @access Private
 * */
router.post(
  '/treatmentStatus',
  requireAuth,
  pumpsController.toggleTreatmentPump
);

/**
 * @route GET /api/pumps
 * @desc Get all pumps
 * @access Private
 * */
router.get(
  '/treatmentStatus',
  requireAuth,
  pumpsController.getTreatmentPumpStatus
);

module.exports = router;
