import { Router } from 'express';
import * as chatController from '../controllers/chat_controller';
import { isAuth } from '../middleware/auth';

const router: Router = Router();

router.post('/create-chat', isAuth, chatController.createChat);
router.patch('/update-chat', isAuth, chatController.updateChat);
router.get('/get-all-chat', isAuth, chatController.getAllChatByUser);
router.get('/get-chat-by-id', isAuth, chatController.getChatbyId);
router.delete('/delete-chat', isAuth, chatController.deleteChat);

export default router;