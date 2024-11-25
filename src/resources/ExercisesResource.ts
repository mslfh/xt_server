import { ActionRequest, ActionContext } from 'adminjs';

import User from '../db/models/user.js';
import Exercise from '../db/models/exercise.js';

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

const CreateExercisesResource = {
    resource: Exercise,
    options: {
        properties: {
            ID: {
                isVisible: {
                    list: true, filter: true, show: true, edit: false,
                },
                position: 1,
            },
            Type: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 2,
            },
            Caption: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 3,
            },
            Image: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 4,
            },
            VideoURL: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 5,
            },
            Duration: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 6,
            },
            Kilojoules: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 7,
            },
            CalculationType: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 8,
            },
            ExerciseDelayID: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 9,
            },
            Status: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 10,
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
            ActivateAll: {
                actionType: 'bulk',
                component: false,
                icon: 'CheckCircle',
                handler: async (request, response, context) => {
                    const { records, currentAdmin } = context;
                    return {
                        msg: 'success',
                        redirectUrl:
                            `/admin/resources/exercise?t=${new Date().getTime()}`,
                        records: await Promise.all(
                            records.map((record) => {
                                record.update({ Status: 'A' }, currentAdmin);
                                return record;
                            }),
                        ),
                    };
                },
                isAccessible: ({ currentAdmin }) => currentAdmin.AdminFlag === 0,
            },
            InactivateAll: {
                actionType: 'bulk',
                component: false,
                icon: 'Ban',
                handler: async (request, response, context) => {
                    const { records, currentAdmin } = context;
                    return {
                        msg: 'success',
                        redirectUrl:
                            `/admin/resources/exercise?t=${new Date().getTime()}`,
                        records: await Promise.all(
                            records.map((record) => {
                                record.update({ Status: 'I' }, currentAdmin);
                                return record;
                            }),
                        ),
                    };
                },
                isAccessible: ({ currentAdmin }) => currentAdmin.AdminFlag === 0,
            },
            Activate: {
                actionType: 'record',
                component: false,
                icon: 'CheckCircle',
                isVisible: (context) => context.record.params.Status !== 'A',
                handler: async (request, response, context) => {
                    const { record, currentAdmin } = context;
                    try {
                        await record.update({ Status: 'A' }, currentAdmin);
                        const updatedRecord = await record.reload();
                        return {
                            record: updatedRecord.toJSON(currentAdmin),
                            msg: 'success',
                            redirectUrl:
                                `/admin/resources/exercise?t=${new Date().getTime()}`,
                        };
                    } catch (error) {
                        return {
                            record: record.toJSON(currentAdmin),
                            msg: 'error',
                            redirectUrl:
                                `/admin/resources/exercise?t=${new Date().getTime()}`,
                        };
                    }
                },
                isAccessible: ({ currentAdmin }) => currentAdmin.AdminFlag === 0,
            },
            Inactivate: {
                actionType: 'record',
                component: false,
                icon: 'Ban',
                isVisible: (context) => context.record.params.Status !== 'I',
                handler: async (request, response, context) => {
                    const { record, currentAdmin } = context;
                    try {
                        await record.update({ Status: 'I' }, currentAdmin);
                        const updatedRecord = await record.reload();
                        return {
                            record: updatedRecord.toJSON(currentAdmin),
                            msg: 'success',
                            redirectUrl:
                                `/admin/resources/exercise?t=${new Date().getTime()}`,
                        };
                    } catch (error) {
                        return {
                            record: record.toJSON(currentAdmin),
                            msg: 'error',
                            redirectUrl:
                                `/admin/resources/exercise?t=${new Date().getTime()}`,
                        };
                    }
                },
                isAccessible: ({ currentAdmin }) => currentAdmin.AdminFlag === 0,
            },
            Export: {
                actionType: 'resource',
                icon: 'Download',
                label: 'Export',
                isVisible: true,
                handler: async (request, response, context) =>
                // Implement your export logic here
                ({
                    record: context.record.toJSON(),
                })
                ,
            },
            Import: {
                actionType: 'resource',
                icon: 'Upload',
                label: 'Import',
                isVisible: true,
                handler: async (request, response, context) =>
                // Implement your import logic here
                ({
                    record: context.record.toJSON(),
                })
                ,
                isAccessible: ({ currentAdmin }) => currentAdmin.AdminFlag === 0,
            },
        },
    },
};

export default CreateExercisesResource;
