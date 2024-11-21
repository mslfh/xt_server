import uploadFeature from '@adminjs/upload';

import File from '../db/models/file.js';
import componentLoader from '../admin/component-loader.js';
import CustomLocalProvider from '../admin/custom-local-provider.js';

const localProvider = new CustomLocalProvider('public/files', { baseUrl: '/files' });

const CreateVideoUploadResource = {
  resource: File,
  options: {
    properties: {
      id: {
        isVisible: {
          list: true, filter: true, show: true, edit: false,
        },
      },
      s3Key: {
        isVisible: {
          list: false, filter: false, show: true, edit: false,
        },
      },
      bucket: {
        isVisible: {
          list: false, filter: false, show: true, edit: false,
        },
      },
      mime: {
        isVisible: {
          list: false, filter: false, show: true, edit: false,
        },
      },
      comment: {
        isVisible: {
          list: false, filter: false, show: true, edit: false,
        },
      },
      file: {
        isVisible: {
          list: false, filter: false, show: true, edit: true,
        },
      },
    },
  },
  features: [
    uploadFeature({
      componentLoader,
      provider: { local: localProvider },
      validation: {
        mimeTypes: ['video/mp4', 'video/avi', 'video/mkv'],
        maxSize: 500 * 1024 * 1024, // Set the max file size to 500MB
      },
      properties: {
        key: 's3Key',
        bucket: 'bucket',
        mimeType: 'mime',
        file: 'file',
      },
    }),
  ],
};

export default CreateVideoUploadResource;
