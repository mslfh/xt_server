import { Sequelize } from 'sequelize';

const dialect = process.env.DB_DIALECT;

if (!dialect) {
  throw new Error("DB_DIALECT environment variable is not set.");
}

const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  { 
    host: process.env.DB_HOST, 
    dialect: dialect as any 
  },
);

export default sequelize;