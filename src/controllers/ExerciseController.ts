import { Request, Response } from 'express';

import Exercise from '../db/models/exercise.js';
import User from '../db/models/user.js';

export const createExercise = async (req: Request, res: Response) => {
    const { userId } = req.params;
    const {
        Caption,
        Status,
        Type,
        CategoryID,
        Image,
        VideoURL,
        Duration,
        Kilojoules,
        CalculationType,
        ExerciseDelayID,
        DepartmentID,
    } = req.body;
    if (!userId) {
        return res.status(400).json({
            status: 'failed',
            message: 'User ID is required',
        });
    }
    try {
        const user = await User.findByPk(userId);
        if (!user) {
            return res.status(404).json({
                status: 'failed',
                message: `User with ID ${userId} not found`,
            });
        }
        const exercise = await Exercise.create({
            Caption,
            Status,
            Type,
            CategoryID,
            Image,
            VideoURL,
            Duration,
            Kilojoules,
            CalculationType,
            ExerciseDelayID,
            DepartmentID,
            userId,
        });
        return res.status(201).json({
            status: 'ok',
            message: 'Exercise created successfully',
            data: exercise,
        });
    } catch (error) {
        return res.status(500).json({
            status: 'failed',
            message: 'Error creating exercise',
            error: error.message,
        });
    }
};

export const getExercisesForUser = async (req: Request, res: Response) => {
    const { userId } = req.params;
    if (!userId) {
        return res.status(400).json({
            status: 'failed',
            message: 'User ID is required',
        });
    }
    try {
        const exercises = await Exercise.findAll({
            where: {
                UserId: userId,
            },
        });
        if (!exercises || exercises.length === 0) {
            return res.status(404).json({
                status: 'failed',
                message: `No exercises found for user ${userId}`,
            });
        }
        return res.status(200).json({
            status: 'ok',
            message: 'Exercises retrieved successfully',
            data: exercises,
        });
    } catch (error) {
        return res.status(500).json({
            status: 'failed',
            message: 'Error retrieving exercises',
            error: error.message,
        });
    }
};

export const updateExercise = async (req: Request, res: Response) => {
    const { userId, exerciseId } = req.body;
    const {
        Caption,
        Status,
        Type,
        CategoryID,
        Image,
        VideoURL,
        Duration,
        Kilojoules,
        CalculationType,
        ExerciseDelayID,
        DepartmentID,
    } = req.body;

    if (!userId || !exerciseId) {
        return res.status(400).json({
            status: 'failed',
            message: 'User ID and Exercise ID are both required',
        });
    }

    if (!Caption || !Status) {
        return res.status(400).json({
            status: 'failed',
            message: 'Caption and Status are both required',
        });
    }

    try {
        const exercise = await Exercise.findOne({
            where: {
                ID: exerciseId,
                UserID: userId,
            },
        });
        if (!exercise) {
            return res.status(404).json({
                status: 'failed',
                message: `Exercise with ID ${exerciseId} not found for user with ID ${userId}`,
            });
        }
        await exercise.update({
            Caption,
            Status,
            Type,
            CategoryID,
            Image,
            VideoURL,
            Duration,
            Kilojoules,
            CalculationType,
            ExerciseDelayID,
            DepartmentID,
        });
        return res.status(200).json({
            status: 'ok',
            message: 'Exercise updated successfully',
            data: exercise,
        });
    } catch (error) {
        return res.status(500).json({
            status: 'failed',
            message: 'Error updating exercise',
            error: error.message,
        });
    }
};

export const deleteExcercise = async (req: Request, res: Response) => {
    const { userId, exerciseId } = req.params;
    if (!userId || !exerciseId) {
        return res.status(400).json({
            status: 'failed',
            message: 'User ID and Exercise ID are both required',
        });
    }
    try {
        const exercise = await Exercise.findOne({
            where: {
                UserId: userId,
                ID: exerciseId,
            },
        });
        if (!exercise) {
            return res.status(404).json({
                status: 'failed',
                message: `Exercise with ID ${exerciseId} not found for user with ID ${userId}`,
            });
        }
        await exercise.destroy();
        return res.status(200).json({
            status: 'ok',
            message: 'Exercise deleted successfully',
        });
    } catch (error) {
        return res.status(500).json({
            status: 'failed',
            message: 'Error deleting exercise',
            error: error.message,
        });
    }
};
