import { Router } from 'express';
import * as commentController from '../controllers/comment_controller';

const router: Router = Router();

router.post('/create-comment', commentController.createComment);
router.get('/get-comment-by-post', commentController.getAllCommentByPost);

export default router;