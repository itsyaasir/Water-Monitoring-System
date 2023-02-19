import User from '../db/models';
import { errorResponse } from '../utils';

const jwt = require('jsonwebtoken');

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
    req.user = decoded.user;
    const user = await User.findOne({
      where: { id: req.user.userId },
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
      'Invalid token provided.',
      401,
    );
  }
};

export default requireAuth;
