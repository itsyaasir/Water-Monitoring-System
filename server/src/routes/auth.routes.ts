import * as express from 'express';
import { validate } from 'express-validation';
import * as authValidator from '../controllers/auth/auth.validator';
import * as authController from '../controllers/auth/auth.controller';
import { createValidator } from 'express-joi-validation';

const validator = createValidator({ passError: true })

const router = express.Router();

/**  Register a new user
* @route POST /api/auth/register
* @Body email, password, confirmPassword
* @desc Register a new user
* @access Public
*/
router.post(
  '/register',
  validator.body(authValidator.registerSchema),
  authController.register,
);

/**  Login a user
 * @route POST /api/auth/login
 * @Body email, password
 * @desc Login a user
 * @access Public
 *
 * */
router.post(
  '/login',
  validator.body(authValidator.loginSchema),
  authController.login,
);

/**  Logout a user
 * @route POST /api/auth/logout
 * @desc Logout a user
 * @access Private
 *
 * */
router.post('/logout', authController.logout);

export default router;
