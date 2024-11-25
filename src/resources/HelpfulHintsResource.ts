import { ActionRequest, ActionContext } from 'adminjs';

import HelpfulHints from '../db/models/helpfulHints.js';
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

const CreateHelpfulHintsResource = {
    resource: HelpfulHints,
    options: {
        properties: {
            ID: {
                position: 1,
                isVisible: {
                    list: true, filter: true, show: true, edit: false,
                },
            },
            Hint: {
                position: 2,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            HintOrder: {
                position: 3,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            DepartmentID: {
                position: 4,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
        },
        actions: {
            new: {
                before: async (request) => {
                    if (request.payload) {
                        delete request.payload.ID;
                    }
                    return request;
                },
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
export default CreateHelpfulHintsResource;
