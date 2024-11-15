import { Request, Response } from 'express';
import Department from '../db/models/department.js';

function validateDepartmentRequest(request: any) {
    const { OrganisationID, ShortName, LongName } = request;
    if (!OrganisationID) {
        return {
            status: 'failed',
            message: 'OrganisationID is required',
        };
    }
    if (!ShortName) {
        return {
            status: 'failed',
            message: 'ShortName is required',
        };
    }
    if (!LongName) {
        return {
            status: 'failed',
            message: 'LongName is required',
        };
    }

    return null;
}

export const createDepartment = async (req: Request, res: Response) => {
    const {
        OrganisationID,
        ShortName,
        LongName,
        IdleDefinition,
        IdleTime,
        NoIdleTime,
        MinimumTime,
        DefaultDelayInterval,
        CalorieGoal,
        CountdownDuration,
        WalkingExDelay,
        WalkingExID,
        ExitEnabled,
        WalkingExPromptText,
        NotificationDialogPromptText,
    } = req.body;
    if (!OrganisationID || !ShortName || !LongName) {
        return res.status(400).json({
            status: 'failed',
            message: 'OrganisationID, ShortName, and LongName are required',
        });
    }
    try {
        const department = await Department.create({
            OrganisationID,
            ShortName,
            LongName,
            IdleDefinition,
            IdleTime,
            NoIdleTime,
            MinimumTime,
            DefaultDelayInterval,
            CalorieGoal,
            CountdownDuration,
            WalkingExDelay,
            WalkingExID,
            ExitEnabled,
            WalkingExPromptText,
            NotificationDialogPromptText,
        });
        return res.status(201).json({
            status: 'ok',
            message: 'Department created successfully',
            data: department,
        });
    } catch (error) {
        return res.status(500).json({
            status: 'failed',
            message: 'Error creating department',
            error: error.message,
        });
    }
};

export const getAllDepartments = async (req: Request, res: Response) => {
    try {
        const departments = await Department.findAll();
        if (!departments || departments.length === 0) {
            return res.status(404).json({
                status: 'failed',
                message: 'No departments found',
            });
        }
        return res.status(200).json({
            status: 'ok',
            message: 'Departments retrieved successfully',
            data: departments,
        });
    } catch (error) {
        return res.status(500).json({
            status: 'failed',
            message: 'Error retrieving departments',
            error: error.message,
        });
    }
};

export const updateDepartment = async (req: Request, res: Response) => {
    const { id } = req.params;
    const {
        OrganisationID,
        ShortName,
        LongName,
        IdleDefinition,
        IdleTime,
        NoIdleTime,
        MinimumTime,
        DefaultDelayInterval,
        CalorieGoal,
        CountdownDuration,
        WalkingExDelay,
        WalkingExID,
        ExitEnabled,
        WalkingExPromptText,
        NotificationDialogPromptText,
    } = req.body;
    if (!id) {
        return res.status(400).json({
            status: 'failed',
            message: 'Department ID is required',
        });
    }
    if (!OrganisationID && !ShortName && !LongName) {
        return res.status(400).json({
            status: 'failed',
            message: 'OrganisationID, ShortName, and LongName are required',
        });
    }
    try {
        const department = await Department.findByPk(id);
        if (!department) {
            return res.status(404).json({
                status: 'failed',
                message: `Department with ID ${id} not found`,
            });
        }

        await department.update({
            OrganisationID,
            ShortName,
            LongName,
            IdleDefinition,
            IdleTime,
            NoIdleTime,
            MinimumTime,
            DefaultDelayInterval,
            CalorieGoal,
            CountdownDuration,
            WalkingExDelay,
            WalkingExID,
            ExitEnabled,
            WalkingExPromptText,
            NotificationDialogPromptText,
        });

        return res.status(200).json({
            status: 'ok',
            message: 'Department updated successfully',
            data: department,
        });
    } catch (error) {
        return res.status(500).json({
            status: 'failed',
            message: 'Error updating department',
            error: error.message,
        });
    }
};

export const deleteDepartment = async (req: Request, res: Response) => {
    const { id } = req.params;
    if (!id) {
        return res.status(400).json({
            status: 'failed',
            message: 'Department ID is required',
        });
    }
    try {
        const department = await Department.findByPk(id);
        if (!department) {
            return res.status(404).json({
                status: 'failed',
                message: `Department with ID ${id} not found`,
            });
        }

        await department.destroy();

        return res.status(200).json({
            status: 'ok',
            message: 'Department deleted successfully',
        });
    } catch (error) {
        return res.status(500).json({
            status: 'failed',
            message: 'Error deleting department',
            error: error.message,
        });
    }
};
