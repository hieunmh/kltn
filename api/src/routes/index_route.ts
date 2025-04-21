import { Router } from 'express';
import authRoute from './auth_route';
import userRoute from './user_route';
import postRoute from './post_route';
import aiRoute from './ai_route';
import chatRoute from './chat_route';
import messageRoute from './message_route';
import commentRoute from './comment_route';

const router: Router = Router();

router.use('/auth', authRoute);
router.use('/user', userRoute);
router.use('/post', postRoute);
router.use('/', aiRoute);
router.use('/', chatRoute);
router.use('/', messageRoute);
router.use('/', commentRoute);

export default router;