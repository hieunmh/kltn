import { Router } from 'express';
import * as userController from '../controllers/user_controller';
import { isAuth } from '../middleware/auth';
import upload from '../config/upload';

const router: Router = Router();


router.get('/user', isAuth, userController.getUser);
router.post('/user/upload-image', isAuth, upload.single('user_image'), userController.uploadUserImage);

export default router;