import importExportFeature from '@adminjs/import-export';
import { ActionRequest, ActionContext } from 'adminjs';

import Organisation from '../db/models/organisation.js';
import User from '../db/models/user.js';
import Department from '../db/models/department.js';
import componentLoader from '../admin/component_loader.js';

const getCurrentUser = async (context: ActionContext) => {
    const { currentAdmin } = context; // contains two keys: email and role
    const user = await User.findOne(
        {
            where: {
                Email: currentAdmin.email,
            },
        },
    );
    return user;
};

const getAdminAccessibility = async (context: ActionContext) => {
    const user = await getCurrentUser(context);
    if (!user) {
        return false;
    }
    if (user.AdminFlag === 0) {
        return true;
    }
    return false;
};

const getViewerAccessibility = async (context: ActionContext) => {
    const user = await getCurrentUser(context);
    if (!user) {
        return false;
    }
    if (user.AdminFlag < 2) {
        return true;
    }
    return false;
};

const CreateOrganisationsResource = {
    resource: Organisation,
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
            ShortName: {
                position: 2,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            LongName: {
                position: 3,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            CountdownDuration: {
                position: 4,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            WalkingExDelay: {
                position: 5,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            Status: {
                position: 6,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            customShow: {
                position: 7,
                isVisible: {
                    list: false,
                    filter: false,
                    edit: false,
                    show: true,
                },
                components: {
                    show: 'OrganisationDetail',
                },
            },
        },
        actions: {
            new: {
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
            list: {
                before: async (request: ActionRequest, context: ActionContext) => {
                    const user = await getCurrentUser(context);
                    console.log('<=====UserID:', user.ID, '=====>');
                    if (user) {
                        if (user.AdminFlag === 0) {
                            // AdminFlag is 0, do not apply any filters
                            return request;
                        }
                        if (user.DepartmentID) {
                            const department = await Department.findByPk(user.DepartmentID);
                            if (department) {
                                request.query = {
                                    ...request.query,
                                    'filters.ID': department.OrganisationID,
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
                isAccessible: getViewerAccessibility,
            },
            show: {
                isAccessible: getViewerAccessibility,
            },
            EnableAll: {
                actionType: 'bulk',
                component: false,
                handler: async (request: ActionRequest, response, context: ActionContext) => {
                    const { records } = context;
                    return {
                        msg: 'success',
                        redirectUrl:
                            `/admin/resources/organisation?t=${new Date().getTime()}`,
                        records: await Promise.all(
                            records.map((record) => {
                                record.update({ Status: true });
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
                        redirectUrl:
                            `/admin/resources/organisation?t=${new Date().getTime()}`,
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
                component: 'ExportOrganisationActivities',
            },
        },
    },
};

export default CreateOrganisationsResource;
