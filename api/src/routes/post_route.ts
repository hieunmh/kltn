import { Router } from "express";
import { isAuth } from "../middleware/auth";
import * as postController from '../controllers/post_controller';
import upload from "../config/upload";

const router: Router = Router();


router.post('/create-post', isAuth, upload.single('post_image'), postController.createPost);
router.get('/get-all-post', isAuth, postController.getAllPost);
router.get('/get-post-by-condition', isAuth, postController.getPostByCondition);
router.delete('/delete-post', isAuth, postController.deletePost);
router.patch('/update-post', isAuth, upload.single('post_image'), postController.updatePost);

export default router;