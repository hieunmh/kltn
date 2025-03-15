import { Router } from 'express';
import authRoute from './auth_route';
import userRoute from './user_route';
import postRoute from './post_route';

const router: Router = Router();

router.use('/', authRoute);
router.use('/', userRoute);
router.use('/', postRoute);

export default router;