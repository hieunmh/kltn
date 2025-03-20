import { Router } from 'express';
import * as chatController from '../controllers/chat_controller';
import { isAuth } from '../middleware/auth';

const router: Router = Router();

router.post('/create-chat', isAuth, chatController.createChat);
router.get('/get-all-chat', isAuth, chatController.getAllChatByUser);
router.get('/get-chat-by-id', isAuth, chatController.getChatbyId);


export default router;