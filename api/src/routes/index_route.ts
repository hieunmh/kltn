import { Router } from 'express';
import authRoute from './auth_route';
import userRoute from './user_route';
import postRoute from './post_route';
import aiRoute from './ai_route';
import chatRoute from './chat_route';
import messageRoute from './message_route';

const router: Router = Router();

router.use('/', authRoute);
router.use('/', userRoute);
router.use('/', postRoute);
router.use('/', aiRoute);
router.use('/', chatRoute);
router.use('/', messageRoute);

export default router;