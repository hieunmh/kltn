import { Router } from 'express';
import * as messageController from '../controllers/message_controller';
import { isAuth } from '../middleware/auth';

const router: Router = Router();

router.post('/create-message', isAuth, messageController.createMessage);
router.get('/get-all-message', isAuth, messageController.getAllMessage);

export default router;