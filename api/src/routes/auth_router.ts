import { Router } from 'express';
import * as authController from '../controllers/auth_controller';

const router: Router = Router();

router.post('/signup', authController.signup);
router.post('/signin', authController.signin);
router.post('/signout', authController.signout);

export default router;