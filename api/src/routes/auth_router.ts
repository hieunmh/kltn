import { Router } from 'express';
import * as authController from '../controllers/auth_controller';

const router: Router = Router();

router.post('/register', authController.register);
router.post('/login', authController.login);
router.post('/logout', authController.logout);

export default router;