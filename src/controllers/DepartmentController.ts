import { Request, Response } from 'express';

import Department from '../db/models/department.js';

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
    return res.status(200).json({
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
