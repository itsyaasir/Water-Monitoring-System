import logger from '../../utils/logger';
import { errorResponse, successResponse } from '../../utils';
// Import the pump model
const { Pumps } = require('../../db/models');

// Import the pump service
export const toggleWaterPump = async (req, res) => {
  logger.info('Toggling water pump');
  try {
    // Get the pump
    const pump = await Pumps.findOne({ where: { userId: req.user.id } });

    //   If it doesn't exist, create it
    if (!pump) {
      const newPump = await Pumps.create({ userId: req.user.id });
      newPump.waterStatus = !newPump.waterStatus;
      await newPump.save();
      return successResponse(req, res, 'Pump toggled successfully', 200);
    }

    // Toggle the pump
    pump.waterStatus = !pump.waterStatus;

    // Save the pump
    await pump.save();

    return successResponse(req, res, 'Pump toggled successfully', 200);
  } catch (error) {
    logger.error(error);
    return errorResponse(req, res, error.message, 'Failed', 500);
  }
};

export const toggleTreatmentPump = async (req, res) => {
  logger.info('Toggling treatment pump');
  try {
    // Get the pump
    const pump = await Pumps.findOne({ where: { userId: req.user.id } });

    //   If it doesn't exist, create it
    if (!pump) {
      const newPump = await Pumps.create({ userId: req.user.id });
      newPump.treatmentStatus = !newPump.treatmentStatus;
      await newPump.save();
      return successResponse(req, res, 'Pump toggled successfully', 200);
    }

    // Toggle the pump
    pump.treatmentStatus = !pump.treatmentStatus;

    // Save the pump
    await pump.save();

    return successResponse(req, res, 'Pump toggled successfully', 200);
  } catch (error) {
    logger.error(error);
    return errorResponse(req, res, error.message, 'Failed', 500);
  }
};

export const getWaterPumpStatus = async (req, res) => {
  logger.info('Getting water pump status');
  try {
    // Get the pump
    const pump = await Pumps.findOne({ where: { userId: req.user.id } });

    return successResponse(req, res, pump.waterStatus, 200);
  } catch (error) {
    logger.error(error);
    return errorResponse(req, res, error.message, 'Failed', 500);
  }
};

export const getTreatmentPumpStatus = async (req, res) => {
  logger.info('Getting treatment pump status');
  try {
    // Get the pump
    const pump = await Pumps.findOne({ where: { userId: req.user.id } });

    return successResponse(req, res, pump.treatmentStatus, 200);
  } catch (error) {
    logger.error(error);
    return errorResponse(req, res, error.message, 'Failed', 500);
  }
};
