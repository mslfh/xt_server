import importExportFeature from '@adminjs/import-export';
import uploadFeature, { LocalUploadOptions, UploadOptions } from '@adminjs/upload';
import { ActionRequest, ActionContext, setCurrentAdmin } from 'adminjs';

import User from '../db/models/user.js';
import Exercise from '../db/models/exercise.js';
import componentLoader from '../admin/component_loader.js';
import CustomLocalProvider from '../admin/custom-local-provider.js';

const adminOnly = async (context: ActionContext) => {
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

const localProvider = new CustomLocalProvider(
    'public/files',
    { baseUrl: '/files' },
);

const uploadConfig: UploadOptions = {
    componentLoader,
    provider: { local: localProvider },
    validation: {
        mimeTypes: ['video/mp4', 'video/avi', 'video/mkv'],
        maxSize: 500 * 1024 * 1024, // Set the max file size to 500MB
    },
    properties: {
        key: 'S3key',
        bucket: 'Bucket',
        mimeType: 'Mime',
        file: 'VideoUpload',
    },
};

const CreateExercisesResource = {
    resource: Exercise,
    features: [
        importExportFeature({ componentLoader }),
        uploadFeature(uploadConfig),
    ],
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
                    list: true, filter: true, show: false, edit: true,
                },
                position: 5,
            },
            Duration: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 6,
            },
            Status: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 7,
            },
            Kilojoules: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 8,
            },
            CalculationType: {
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
                position: 9,
            },
            S3key: {
                isVisible: {
                    list: false, filter: false, show: false, edit: false,
                },
                position: 10,
            },
            Bucket: {
                isVisible: {
                    list: false, filter: false, show: false, edit: false,
                },
                position: 11,
            },
            Mime: {
                isVisible: {
                    list: false, filter: false, show: false, edit: false,
                },
                position: 12,
            },
            VideoUpload: {
                isVisible: {
                    list: false, filter: false, show: true, edit: true,
                },
                position: 13,
            },
        },
        actions: {
            new: {
                before: async (request: ActionRequest) => {
                    if (request.payload) {
                        delete request.payload.ID;
                    }
                    return request;
                },
                isAccessible: adminOnly,
            },
            show: {
                isAccessible: adminOnly,
            },
            edit: {
                isAccessible: adminOnly,
            },
            delete: {
                isAccessible: adminOnly,
            },
            bulkDelete: {
                actionType: 'bulk',
                isAccessible: adminOnly,
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
                isAccessible: adminOnly,
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
                isAccessible: adminOnly,
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
                isAccessible: adminOnly,
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
                isAccessible: adminOnly,
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
                isAccessible: adminOnly,
            },
        },
    },
};

export default CreateExercisesResource;
