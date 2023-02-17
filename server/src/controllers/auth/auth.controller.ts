
import { type Request, type Response, type NextFunction } from 'express'
import { ValidatedRequest } from 'express-joi-validation'
import logger from '../../utils/logger'
import { LoginSchema, RegisterSchema } from './auth.validator';
import User  from '../../db/models/user';
import Password from '../../services/password';
import { errorResponse, successResponse } from '../../utils';
import jwt, { Secret } from 'jsonwebtoken';

export const register = async (req: ValidatedRequest<RegisterSchema>, res: Response, next: NextFunction) => {
  logger.info('Registering user')

  try {
    const { email, password, confirmPassword } = req.body

    // Check if passwords match
    if (password !== confirmPassword) {
      throw new Error('Passwords do not match')
    }

    // Check if user already exists
    const user = await User.findOne({ where: { email } })

    if (user) {
      throw new Error('User already exists')
    }
    
    // Hash password
    const hashedPassword = await Password.toHash(password);

    // Create user
    try {
      await User.create({ email, password: hashedPassword })
    } catch (error) {
      throw new Error('Error creating user')
    }


  const data = {
    user: {
      email,
    },
  }

 return successResponse(req, res, 'User created successfully', data)

  } catch (error) {
    logger.error(error)
    return  errorResponse(req, res, error.message, 400)
  }

}

export const login = async (req: ValidatedRequest<LoginSchema>, res: Response, next: NextFunction) => {
  logger.info('Logging in user')
  try {
    const { email, password } = req.body

    // Check if user exists
    const user = await User.findOne({ where: { email } })

    if (!user) {
      throw new Error('User does not exist')
    }

    // Check if password is correct
    const isPasswordCorrect = await Password.compare(user.password, password)

    if (!isPasswordCorrect) {
      throw new Error('Incorrect password')
    }

    // Generate token
    let secret: Secret = process.env.JWT_SECRET || 'secret'
    const token = jwt.sign({ id: user.id, email: user.email, createdAt: new Date()}, secret, { expiresIn: '1h' })

    const data = {
      token,
      user: {
        id: user.id,
        email: user.email,
      },
    }

    return successResponse(req, res, 'User logged in successfully', data)
  } catch (error) {
    logger.error(error)
    return errorResponse(req, res, error.message, 400)
  }
}

export const logout = async (req: Request, res: Response) => {
  logger.info('Logging out user')
  try {
    req.headers = {}
    return successResponse(req, res, 'User logged out successfully', null)
  } catch (error) {
    logger.error(error)
    return errorResponse(req, res, error.message, 400)
  }
}
