// export const register = async (req, res) => {
//   logger.info('Registering user');
//   try {
//     const { email, password } = req.body;

//     //   Check if user already exists
//     const user = await User.findOne({ email });

//     if (user) {
//       logger.error('User already exists');
//       throw new Error('User already exists');
//     }

//     const passwordHash = await bcrypt.hash(password, 10);
//     const newUser = new User({
//       email,
//       password: passwordHash,
//     });

//     const savedUser = await newUser.save();
//     logger.info('User registered successfully');
//     return successResponse(res, 'User registered successfully', savedUser);
//   } catch (err) {
//     logger.error(err.message);
//     res.status(400).send(err.message);
//   }
// };

// Rewrite in typescript
import { Request, Response } from 'express';
import { errorResponse, successResponse, validateFields } from '../../utils';
import logger from '../../utils/logger';
export const register = async (req: Request, res: Response) => {
    logger.info('Registering user');


};



export const login = async (req: Request, res: Response) => {
};


export const logout = async (req: Request, res: Response) => {
}

