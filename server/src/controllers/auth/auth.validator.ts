import Joi, { ObjectSchema } from 'joi';
import { ContainerTypes, ValidatedRequestSchema } from 'express-joi-validation';

export const registerSchema = Joi.object({
    email: Joi.string().email().required(),
    password: Joi.string().required(),
    confirmPassword: Joi.string().required(),
});

export interface RegisterSchema extends ValidatedRequestSchema {
[ContainerTypes.Body]: {
    "email": string,
    "password": string,
    "confirmPassword": string
  }
}

export const loginSchema = Joi.object({
    email: Joi.string().email().required(),
    password: Joi.string().required(),
});


export interface LoginSchema extends ValidatedRequestSchema {
  [ContainerTypes.Body]: {
    "email": string,
    "password": string
  }
}
