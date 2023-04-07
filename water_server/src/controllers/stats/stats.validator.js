import { Joi } from 'express-validation';

export const statsSchema = {
  body: Joi.object({
    temperature: Joi.number().required(),
    ph: Joi.number().required(),
    turb: Joi.number().required(),
    waterLevel: Joi.number().required(),
    token: Joi.string().required(),
  }),
};

export const statsRangeSchema = {
  query: Joi.object({
    start: Joi.string().required(),
    end: Joi.string().required(),
  }),
};
