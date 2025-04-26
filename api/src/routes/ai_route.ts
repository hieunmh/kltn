import { Router } from 'express';
import * as aiController from '../controllers/ai_controller';

const router: Router = Router();

router.post('/ollama', aiController.ollamaModel);
router.post('/gemini_ai', aiController.geminiAI);
router.post('/open_ai', aiController.openAI);

router.post('/topic_AI', aiController.topic_AI);

router.post('/review_AI', aiController.review_AI);

router.post('/voice_AI', aiController.voice_AI);

router.post('/suggest_theme_AI', aiController.suggest_AI);
export default router;