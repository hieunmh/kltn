import { Router } from 'express';
import * as aiController from '../controllers/ai_controller';

const router: Router = Router();

router.post('/ollama', aiController.ollamaModel);
router.post('/gemini_ai', aiController.geminiAI);
router.post('/open_ai', aiController.openAI);

export default router;