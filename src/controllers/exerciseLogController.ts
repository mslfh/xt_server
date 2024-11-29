import { Request, Response } from 'express';
import ExerciseLog from '../db/models/exerciseLog.js';

class ExerciseLogController {
    public static async getExerciseLogsByUser(req: Request, res: Response) {
        try {
            const { userId } = req.params;
            const logs = await ExerciseLog.findAll({ where: { UserID: userId } }); // Fetch by UserID

            if (!logs.length) {
                return res.status(404).json({
                    status: 'error',
                    message: `No exercise logs found for user with ID ${userId}`,
                });
            }
            return res.status(200).json({
                status: 'ok',
                message: 'Exercise logs retrieved successfully',
                result: logs,
            });
        } catch (error) {
            return res.status(500).json({
                status: 'error',
                message: 'Internal server error',
            });
        }
    }
}

export default ExerciseLogController;