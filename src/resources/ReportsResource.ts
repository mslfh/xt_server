import { ActionRequest, ActionContext } from 'adminjs';

import Organisation from '../db/models/organisation.js';
import Report from '../db/models/report.js';
import Department from '../db/models/department.js';

const CreateReportsResource = {
    resource: Report,
    options: {
        properties: {
            id: {
                isVisible: {
                    list: true, filter: true, show: true, edit: false,
                },
            },
            name: { type: 'string', isVisible: true },
            size: { type: 'string', isVisible: true },
            date: { type: 'date', isVisible: true },
            group: { type: 'string', isVisible: true },
            content: { type: 'richtext', isVisible: true },
            createdBy: { type: 'string', isVisible: true },
        },
        actions: {
            new: {
                isAccessible: false,
            },
            edit: {
                isAccessible: false,
            },
            delete: {
                isAccessible: ({ currentAdmin }) => currentAdmin.AdminFlag === 0,
            },
            bulkDelete: {
                actionType: 'bulk',
                isAccessible: ({ currentAdmin }) => currentAdmin.AdminFlag === 0,
            },

            GenerateOrganizationReport: {
                actionType: 'resource',
                icon: 'Download',
                label: 'Generate Organization Report',
                component: 'OrganizationReport',
                handler: async (request: ActionRequest, response, context) => {
                    const { fields, currentAdmin } = request.payload;
                    try {
                        const organization = await Organisation.findByPk(
                            fields.organizationId,
                        );

                        if (!organization) {
                            throw new Error('Organization not found');
                        }

                        const reportData = {
                            ID: organization.ID,
                            ShortName: organization.ShortName,
                            LongName: organization.LongName,
                            CountdownDuration: organization.CountdownDuration,
                            WalkingExDelay: organization.WalkingExDelay,
                        };

                        const reportContent = JSON.stringify(reportData, null, 2);

                        await Report.create({
                            name: `Organization Report - ${organization.ShortName}`,
                            size: Buffer.byteLength(reportContent, 'utf-8').toString(),
                            date: new Date(),
                            group: 'Organization',
                            content: reportContent,
                            createdBy: currentAdmin.email,
                        });

                        return {
                            redirectUrl: '/admin/resources/Report',
                            notice: {
                                message: `Report for ${organization.ShortName} generated successfully.`,
                                type: 'success',
                            },
                        };
                    } catch (error) {
                        console.error('Error generating organization report:', error);
                        throw new Error('Could not generate organization report');
                    }
                },
                isVisible: true,
            },
            GenerateDepartmentReport: {
                actionType: 'resource',
                icon: 'Download',
                label: 'Generate Department Report',
                component: 'DepartmentReport',
                handler: async (request, response, context) => {
                    const { fields, currentAdmin } = request.payload;
                    try {
                        const department = await Department.findByPk(
                            fields.departmentId,
                        );

                        if (!department) {
                            throw new Error('Department not found');
                        }

                        const reportData = {
                            ID: department.ID,
                            ShortName: department.ShortName,
                            LongName: department.LongName,
                            OrganisationID: department.OrganisationID,
                        };

                        const reportContent = JSON.stringify(reportData, null, 2);

                        // Save the report to the database
                        await Report.create({
                            name: `Department Report - ${department.ShortName}`,
                            size: Buffer.byteLength(reportContent, 'utf-8').toString(), // Convert size to string
                            date: new Date(),
                            group: 'Department',
                            content: reportContent,
                            createdBy: currentAdmin.email,
                        });

                        return {
                            redirectUrl: '/admin/resources/reports',
                            notice: {
                                message: `Report for ${department.ShortName} generated successfully.`,
                                type: 'success',
                            },
                        };
                    } catch (error) {
                        console.error('Error generating department report:', error);
                        throw new Error('Could not generate department report');
                    }
                },
                isVisible: true,
            },
            generateExerciseReport: {
                actionType: 'resource',
                icon: 'Download',
                label: 'Generate Exercise Report',
                handler: async (request, response, context) =>
                // Dummy button, no functionality
                ({
                    notice: {
                        message: 'Exercise Report generated successfully (dummy)',
                        type: 'success',
                    },
                }),
                isVisible: true,
                parent: 'More',
            },
            generateExerciseLogReport: {
                actionType: 'resource',
                icon: 'Download',
                label: 'Generate Exercise Log Report',
                handler: async (request, response, context) =>
                // Dummy button, no functionality
                ({
                    notice: {
                        message: 'Exercise Log Report generated successfully (dummy)',
                        type: 'success',
                    },
                }),
                isVisible: true,
                parent: 'More',
            },
            generateUserEventsReport: {
                actionType: 'resource',
                icon: 'Download',
                label: 'Generate User Events Report',
                handler: async (request, response, context) =>
                // Dummy button, no functionality
                ({
                    notice: {
                        message: 'User Events Report generated successfully (dummy)',
                        type: 'success',
                    },
                }),
                isVisible: true,
                parent: 'More',
            },
            generateExerciseDelayReport: {
                actionType: 'resource',
                icon: 'Download',
                label: 'Generate Exercise Delay Report',
                handler: async (request, response, context) =>
                // Dummy button, no functionality
                ({
                    notice: {
                        message:
                            'Exercise Delay Report generated successfully (dummy)',
                        type: 'success',
                    },
                }),
                isVisible: true,
                parent: 'More',
            },
            generateUserWeightReport: {
                actionType: 'resource',
                icon: 'Download',
                label: 'Generate User Weight Report',
                handler: async (request, response, context) =>
                // Dummy button, no functionality
                ({
                    notice: {
                        message: 'User Weight Report generated successfully (dummy)',
                        type: 'success',
                    },
                }),
                isVisible: true,
                parent: 'More',
            },
            generateExerciseDepartmentReport: {
                actionType: 'resource',
                icon: 'Download',
                label: 'Generate Exercise Department Report',
                handler: async (request, response, context) =>
                // Dummy button, no functionality
                ({
                    notice: {
                        message:
                            'Exercise Department Report generated successfully (dummy)',
                        type: 'success',
                    },
                }),
                isVisible: true,
                parent: 'More',
            },
        },
    },
};
export default CreateReportsResource;
