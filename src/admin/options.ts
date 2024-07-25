import { AdminJSOptions } from 'adminjs';

import componentLoader from './component-loader.js';
import Organisation from '../db/models/organisation.js';
const options: AdminJSOptions = {
  componentLoader,
  rootPath: '/admin',
  resources: [
    { resource: Organisation, options: {} },
  ],
  databases: [],
};

export default options;
