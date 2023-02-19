import jwt from 'jsonwebtoken';
import logger from '../../utils/logger';
import User from '../../db/models';
import Password from '../../services/password';
import { errorResponse, successResponse } from '../../utils';

export const register = async (req, res) => {
  logger.info('Registering user');
  try {
    const { email, password, confirmPassword } = req.body;

    // Check if passwords match
    if (password !== confirmPassword) {
      throw new Error('Passwords do not match');
    }

    // Check if user already exists
    const user = await User.findOne({ where: { email } });

    if (user) {
      throw new Error('User already exists');
    }

    // Hash password
    const hashedPassword = await Password.toHash(password);

    // Create user
    try {
      await User.create({ email, password: hashedPassword });
    } catch (error) {
      logger.error(error);
      throw new Error('Error creating user');
    }

    return successResponse(req, res, 'User created successfully', 201);
  } catch (error) {
    logger.error(error);
    return errorResponse(req, res, error.message, 'Failed', 500);
  }
};

export const login = async (req, res) => {
  logger.info('Logging in user');
  try {
    const { email, password } = req.body;

    // Check if user exists
    const user = await User.findOne({ where: { email } });

    if (!user) {
      throw new Error('User does not exist');
    }

    // Check if password is correct
    const isPasswordCorrect = await Password.compare(user.password, password);

    if (!isPasswordCorrect) {
      throw new Error('Incorrect password');
    }

    // Generate token
    const token = jwt.sign({ id: user.id, email: user.email, createdAt: new Date() }, process.env.JWT_SECRET, { expiresIn: '30d' });

    const data = {
      token,
      user: {
        id: user.id,
        email: user.email,
      },
    };

    return successResponse(req, res, data, 200);
  } catch (error) {
    logger.error(error);
    return errorResponse(req, res, error.message, 400);
  }
};

export const logout = async (req, res) => {
  logger.info('Logging out user');
  try {
    req.headers['x-token'] = null;
    req.headers = {};
    return successResponse(req, res, 'User logged out successfully', null);
  } catch (error) {
    logger.error(error);
    return errorResponse(req, res, error.message, 400);
  }
};

export const getCurrentUser = async (req, res) => {
  logger.info('Getting current user');
  try {
    const user = await User.findOne({ where: { id: req.user.id } });
    return successResponse(req, res, user, 200);
  } catch (error) {
    logger.error(error);
    return errorResponse(req, res, error.message, 400);
  }
};
