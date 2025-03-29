import { Router } from 'express';
import * as uploadController from '../controllers/upload_controller';
import { isAuth } from '../middleware/auth';
import upload from '../config/upload';

const router: Router = Router();

router.post('/upload-user-image', isAuth, upload.single('userimage'),  uploadController.uploadUserImage);

export default router;