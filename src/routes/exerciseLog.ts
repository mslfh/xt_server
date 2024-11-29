import { Router } from 'express';
import ExerciseLogController from '../controllers/exerciseLogController.js';

const router = Router();

router.get('/user/:userId', ExerciseLogController.getExerciseLogsByUser);

export default router;
