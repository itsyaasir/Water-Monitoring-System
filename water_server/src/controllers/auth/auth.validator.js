import { Joi } from 'express-validation';
import logger from '../../utils/logger';

logger.info('Started \'authValidator\' controller');
export const registerSchema = {
  body: Joi.object({
    email: Joi.string().email().trim().required(),
    password: Joi.string().required(),
    confirmPassword: Joi.string().required(),
    firstName: Joi.string().required(),
    lastName: Joi.string().required(),
  }),
};

export const loginSchema = {
  body: Joi.object({
    email: Joi.string().email().trim().required(),
    password: Joi.string().required(),
  }),
};
