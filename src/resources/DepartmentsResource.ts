import importExportFeature from '@adminjs/import-export';
import { ActionRequest, ActionContext } from 'adminjs';

import Department from '../db/models/department.js';
import User from '../db/models/user.js';
import componentLoader from '../admin/component_loader.js';

const CreateDepartmentsResource = {
    resource: Department,
    features: [
        importExportFeature({ componentLoader }),
    ],
    options: {
        properties: {
            ID: {
                position: 1,
                isVisible: {
                    list: true, filter: true, show: true, edit: false,
                },
            },
            OrganisationID: {
                position: 2,
                reference: 'organisation',
                isVisible: true,
            },
            ShortName: {
                position: 3,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            LongName: {
                position: 4,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            IdleDefinition: {
                position: 5,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            IdleTime: {
                position: 6,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            NoIdleTime: {
                position: 7,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            MinimumTime: {
                position: 8,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            DefaultDelayInterval: {
                position: 9,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            CalorieGoal: {
                position: 10,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            CountdownDuration: {
                position: 11,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            WalkingExDelay: {
                position: 12,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            WalkingExID: {
                position: 13,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            ExitEnabled: {
                position: 14,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            WalkingExPromptText: {
                position: 15,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            NotificationDialogPromptText: {
                position: 16,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            Status: {
                position: 17,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            userList: {
                position: 18,
                isVisible: {
                    list: false,
                    filter: false,
                    edit: false,
                    show: true,
                },
                components: {
                    show: 'DepartmentUserList',
                },
            },
            exerciseList: {
                position: 19,
                isVisible: {
                    list: false,
                    filter: false,
                    edit: false,
                    show: true,
                },
                components: {
                    show: 'DepartmentExerciseList',
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
                isAccessible: ({ currentAdmin }) => currentAdmin.AdminFlag === 0,
            },
            edit: {
                isAccessible: ({ currentAdmin }) => currentAdmin.AdminFlag === 0,
            },
            delete: {
                isAccessible: ({ currentAdmin }) => currentAdmin.AdminFlag === 0,
            },
            bulkDelete: {
                actionType: 'bulk',
                isAccessible: ({ currentAdmin }) => currentAdmin.AdminFlag === 0,
            },
            list: {
                before: async (request: ActionRequest, context: ActionContext) => {
                    const user = await User.findOne({
                        where: { Email: context.currentAdmin.email },
                    });
                    if (user) {
                        if (user.AdminFlag === 0) {
                            // AdminFlag is 0, do not apply any filters
                            return request;
                        }
                        if (user.AdminFlag === 2 && user.DepartmentID) {
                            // AdminFlag is 2, filter by the same department
                            request.query = {
                                ...request.query,
                                'filters.ID': user.DepartmentID,
                            };
                        } else if (user.AdminFlag === 1 && user.DepartmentID) {
                            // AdminFlag is 1, filter by the same organization
                            const department = await Department.findByPk(user.DepartmentID);
                            if (department) {
                                const organisationID = department.OrganisationID;
                                request.query = {
                                    ...request.query,
                                    'filters.OrganisationID': organisationID,
                                };
                            }
                        } else {
                            // If DepartmentID is null, prevent the user from seeing any records
                            request.query = {
                                ...request.query,
                                'filters.ID': -1, // Assuming -1 is an invalid ID that will return no results
                            };
                        }
                    }
                    return request;
                },
            },
            move: {
                actionType: 'record',
                icon: 'Move',
                label: 'Move to Organization',
                isVisible: true,
                component: 'DepartmentMove',
                handler: async (request, response, context) => {
                    const { record, currentAdmin } = context;
                    return {
                        record: record.toJSON(currentAdmin),
                        msg: 'success',
                    };
                },
            },
            moveAll: {
                actionType: 'bulk',
                icon: 'Move',
                label: 'Move All to Organization',
                isVisible: true,
                component: 'DepartmentMove',
                handler: async (request, response, context) => {
                    const { records } = context;
                    return {
                        msg: 'success',
                        records,
                    };
                },
            },
            // ExportDepartmentList: {
            //   actionType: 'resource',
            //   icon: 'Download',
            //   label: 'Export Department List',
            //   isVisible: true
            // },

            ExportActivities: {
                actionType: 'resource',
                component: 'ExportDepartmentActivities',
            },
        },
    },
};

export default CreateDepartmentsResource;
