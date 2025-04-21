import { Router } from 'express';
import * as userController from '../controllers/user_controller';
import { isAuth } from '../middleware/auth';
import upload from '../config/upload';

const router: Router = Router();


router.get('/get-info', isAuth, userController.getUser);
router.post('/upload-image', isAuth, upload.single('user_image'), userController.uploadUserImage);
router.patch('/update-info', isAuth, userController.updateUserInfo);
router.patch('/change-password', isAuth, userController.changePassword);


export default router;