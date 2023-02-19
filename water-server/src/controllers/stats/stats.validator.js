import { Joi } from 'express-validation';

export const statsSchema = {
  body: Joi.object({
    temperature: Joi.number().required(),
    ph: Joi.number().required(),
    turb: Joi.number().required(),
  }),
};

export const statsRangeSchema = {
  body: Joi.object({
    start: Joi.date().required(),
    end: Joi.date().required(),
  }),
};
