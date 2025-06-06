import { Router } from 'express';
import * as commentController from '../controllers/comment_controller';

const router: Router = Router();

router.post('/create-comment', commentController.createComment);
router.get('/get-comment', commentController.getAllCommentByPost);
router.delete('/delete-comment', commentController.deleteComment);
router.patch('/edit-comment', commentController.editComment);

export default router;