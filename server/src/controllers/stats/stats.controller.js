import { Op } from 'sequelize';
import Stats from '../../db/models';
import logger from '../../utils/logger';
import { errorResponse, successResponse } from '../../utils';

export const postStats = async (req, res) => {
  try {
    const {
      temperature, ph, oxygen, ec,
    } = req.body;

    //   add user id to stats

    req.body.userId = req.user.id;

    const stats = await Stats.create({
      temperature, ph, oxygen, ec,
    });
    return successResponse(req, res, stats, 'Stats created successfully', 201);
  } catch (error) {
    logger.error(error);
    return errorResponse(req, res, error.message, 'Failed', 500);
  }
};

export const getStats = async (req, res) => {
  try {
    const stats = await Stats.findAll({
      where: {
        userId: req.user.id,
      },
    });
    return successResponse(req, res, stats, 'Stats retrieved successfully', 200);
  } catch (error) {
    logger.error(error);
    return errorResponse(req, res, error.message, 'Failed', 500);
  }
};

export const getStatsRange = async (req, res) => {
  try {
    const { start, end } = req.body;

    const stats = await Stats.findAll({
      where: {
        userId: req.user.id,
        createdAt: {
          [Op.between]: [start, end],
        },
      },
    });
    return successResponse(req, res, stats, 200);
  } catch (error) {
    logger.error(error);
    return errorResponse(req, res, error.message, 'Failed', 500);
  }
};

export const getLatestStats = async (req, res) => {
  try {
    const stats = await Stats.findAll({
      where: {
        userId: req.user.id,
      },
      order: [['createdAt', 'DESC']],
      limit: 1,
    });
    return successResponse(req, res, stats, 200);
  } catch (error) {
    logger.error(error);
    return errorResponse(req, res, error.message, 'Failed', 500);
  }
};
