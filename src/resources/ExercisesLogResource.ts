import { ActionRequest, ActionContext } from 'adminjs';
import ExerciseLog from '../db/models/exerciseLog.js';
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

const CreateExercisesLogResource = {
    resource: ExerciseLog,
    options: {
        properties: {
            ID: {
                isVisible: {
                    list: true, filter: true, show: true, edit: false,
                },
                position: 1,
            },
            ExerciseID: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 2,
            },
            UserID: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 3,
            },
            Repetitions: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 4,
            },
            Duration: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 5,
            },
            Source: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 6,
            },
            StartDateTime: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 7,
            },
            EndDateTime: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 8,
            },
            StandStartDateTime: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 9,
            },
            StandEndDateTime: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 10,
            },
        },
        actions: {
            list: {
                isAccessible: getAdminAccessibility,
            },
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
        },
    },
};

export default CreateExercisesLogResource;
