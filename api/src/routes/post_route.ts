import { Router } from "express";
import { isAuth } from "../middleware/auth";
import * as postController from '../controllers/post_controller';

const router: Router = Router();


router.post('/create-post', isAuth, postController.createPost);
router.get('/get-all-post', isAuth, postController.getAllPost);
router.get('/get-post-by-condition', isAuth, postController.getPostByCondition);

export default router;