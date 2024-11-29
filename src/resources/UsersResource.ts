import importExportFeature from '@adminjs/import-export';
import { ActionRequest, ActionContext } from 'adminjs';

import Department from '../db/models/department.js';
import User from '../db/models/user.js';
import componentLoader from '../admin/component_loader.js';

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

const CreateUsersResource = {
    resource: User,
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
            Username: {
                position: 2,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            Email: {
                position: 3,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            JobTitle: {
                position: 4,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            Status: {
                position: 5,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            DepartmentID: {
                position: 6,
                reference: 'department',
                isVisible: true,
            },

            GivenNames: {
                position: 7,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            Surname: {
                position: 8,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            PreferredName: {
                position: 9,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            Domain: {
                position: 10,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            Password: {
                position: 11,
                isVisible: {
                    list: false, filter: false, show: false, edit: true,
                },
            },
            Passkey: {
                position: 12,
                isVisible: {
                    list: false, filter: false, show: false, edit: false,
                },
            },
            DOB: {
                position: 13,
                isVisible: {
                    list: false, filter: false, show: false, edit: false,
                },
            },
            Gender: {
                position: 14,
                isVisible: {
                    list: false, filter: false, show: false, edit: false,
                },
            },
            Height: {
                position: 15,
                isVisible: {
                    list: false, filter: false, show: false, edit: false,
                },
            },
            AdminFlag: {
                position: 16,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            ExitEnabled: {
                position: 17,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            IsNew: {
                position: 18,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            CalorieGoal: {
                position: 19,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            CreatedAt: {
                position: 20,
                isVisible: {
                    list: false, filter: true, show: true, edit: false,
                },
            },
            UpdatedAt: {
                position: 21,
                isVisible: {
                    list: false, filter: true, show: true, edit: false,
                },
            },
            customShow: {
                position: 22,
                isVisible: {
                    list: false,
                    filter: false,
                    edit: false,
                    show: true,
                },
                components: {
                    show: 'UserDetail',
                },
            },
        },
        actions: {
            list: {
                before: async (request: ActionContext, context: ActionContext) => {
                    const user = await User.findOne({
                        where: {
                            Email: context.currentAdmin.email,
                        },
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
                                'filters.DepartmentID': user.DepartmentID,
                            };
                        } else if (user.AdminFlag === 1 && user.DepartmentID) {
                            // AdminFlag is 1, filter by the same organization
                            const department = await Department.findByPk(user.DepartmentID);
                            if (department) {
                                const organisationID = department.OrganisationID;
                                const departments = await Department.findAll({
                                    where: { OrganisationID: organisationID },
                                    attributes: ['ID'],
                                });
                                const departmentIDs = departments.map((dep) => dep.ID);
                                request.query = {
                                    ...request.query,
                                    'filters.DepartmentID': departmentIDs,
                                };
                            }
                        } else {
                            // If no valid filter criteria, prevent the user from seeing any records
                            request.query = {
                                ...request.query,
                                'filters.ID': -1, // Assuming -1 is an invalid ID that will return no results
                            };
                        }
                    }
                    return request;
                },

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
            bulkDelete: {
                actionType: 'bulk',
                isAccessible: getAdminAccessibility,
            },
            EnableAll: {
                actionType: 'bulk',
                component: false,
                handler: async (request, response, context) => {
                    const { records, currentAdmin } = context;
                    return {
                        msg: 'success',
                        redirectUrl: `/admin/resources/user?t=${new Date().getTime()}`,
                        records: await Promise.all(
                            records.map((record) => {
                                record.update({ Status: true }, currentAdmin);
                                return record;
                            }),
                        ),
                    };
                },
                isAccessible: getAdminAccessibility,
            },
            DisableAll: {
                actionType: 'bulk',
                component: false,
                handler: async (request, response, context) => {
                    const { records, currentAdmin } = context;
                    return {
                        msg: 'success',
                        redirectUrl: `/admin/resources/user?t=${new Date().getTime()}`,
                        records: await Promise.all(
                            records.map((record) => {
                                record.update({ Status: false }, currentAdmin);
                                return record;
                            }),
                        ),
                    };
                },
                isAccessible: getAdminAccessibility,
            },
            ExportActivities: {
                actionType: 'resource',
                component: 'ExportUserActivities',
            },
        },
    },

};

export default CreateUsersResource;
