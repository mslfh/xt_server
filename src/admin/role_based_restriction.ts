import { ActionContext, ActionRequest } from 'adminjs';
import { NextFunction } from 'express';

import User from '../db/models/user.js';

const adminOnly = async (context: ActionContext, next: NextFunction) => {
    const { currentAdmin } = context.currentAdmin;
    const user = await User.findOne({ where: { Email: currentAdmin.email } });
    if (!user) {
        return {
            message: 'User not found',
            type: 'error',
        };
    }
    if (user.AdminFlag !== 0) {
        return {
            message: 'You are not authorized to perform this action',
            type: 'error',
        };
    }
    next();
};

export default adminOnly;
