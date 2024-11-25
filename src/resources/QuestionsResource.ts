import { ActionRequest, ActionContext } from 'adminjs';

import Question from '../db/models/question.js';
import User from '../db/models/user.js';

const getAdminAccessibility = async (context: ActionContext) => {
    const user = await User.findOne({
        where: {
            Email: context.currentAdmin.email,
        },
    });
    if (!user) {
        return false;
    }
    if (user.AdminFlag === 0) {
        return true;
    }
    return false;
};
const CreateQuestionsResource = {

    resource: Question,
    options: {
        properties: {
            ID: {
                isVisible: {
                    list: true, filter: true, show: true, edit: false,
                },
            },
            Type: { isVisible: true },
            EndTime: { isVisible: true },
            StartTime: { isVisible: true },
            Status: { isVisible: true },
            Caption: { isVisible: true },
            MaxCaption: { isVisible: true },
            MinCaption: { isVisible: true },
            Order: { isVisible: true },
        },
        actions: {
            new: {
                before: async (request) => request,
                isAccessible: getAdminAccessibility,
            },
            edit: {
                isAccessible: getAdminAccessibility,
            },
            delete: {
                isAccessible: getAdminAccessibility,
            },
            bulkDelete: {
                actionType: 'bulk',
                isAccessible: getAdminAccessibility,
            },
        },
    },

};

export default CreateQuestionsResource;
