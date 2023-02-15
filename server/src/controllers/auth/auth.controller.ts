
import { type Request, type Response, type NextFunction } from 'express'
import { errorResponse, successResponse, validateFields } from '../../utils'
import logger from '../../utils/logger'

export const register = async (req: Request, res: Response, next: NextFunction) => {
  logger.info('Registering user')
}

export const login = async (req: Request, res: Response, next: NextFunction) => {
  logger.info('Logging in user')
}

export const logout = async (req: Request, res: Response) => {
  logger.info('Logging out user')
}
