import { Router } from 'express';
import authRouter from './auth_router';
import userRouter from './user_router';

const router: Router = Router();

router.use('/', authRouter);
router.use('/', userRouter);

export default router;