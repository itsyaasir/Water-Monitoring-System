import { errorResponse } from '../utils';

const jwt = require('jsonwebtoken');
const { User } = require('../db/models');

/// Middleware to check if user is authenticated, if not, return error
const requireAuth = async (req, res, next) => {
  if (!(req.headers && req.headers['x-token'])) {
    return errorResponse(
      req,
      res,
      'Token is not provided.',
      401,
    );
  }
  const token = req.headers['x-token'];
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    const timeSinceEpoch = new Date().getTime() / 1000;
    if (decoded.exp < timeSinceEpoch) {
      return errorResponse(
        req,
        res,
        'Token has expired.',
        401,
      );
    }

    req.user = decoded;
    const user = await User.findOne({
      where: { id: req.user.id },
    });

    if (!user) {
      return errorResponse(
        req,
        res,
        'User not found.',
        401,
      );
    }

    const reqUser = { ...user.get() };
    reqUser.userId = user.id;
    req.user = reqUser;
    return next();
  } catch (e) {
    return errorResponse(
      req,
      res,
      `Invalid token provided. ${e}`,
      401,
    );
  }
};

export default requireAuth;
