import { Database, Resource } from '@adminjs/sequelize';
import AdminJS from 'adminjs';
import sequelize from './config.js';
import Organisation from './models/organisation.js';
import Department from './models/department.js';  

AdminJS.registerAdapter({
  Database,
  Resource,
});

const initialize = async () => {
  try {
    await sequelize.authenticate();
    console.log('Connection has been established successfully.');


    await sequelize.sync();

    return { sequelize };
  } catch (error) {
    console.error('Unable to connect to the database:', error);
    return {};
  }
};

export default initialize;
