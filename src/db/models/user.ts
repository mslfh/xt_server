import { DataTypes, Model, Optional } from 'sequelize';
import sequelize from '../config.js';

class User extends Model {}

User.init({
  ID: {
    type: DataTypes.STRING(36),
    primaryKey: true,
  },
  GivenNames: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  Surname: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  Username: {
    type: DataTypes.STRING(255),
    allowNull: false,
  },
  DepartmentID: {
    type: DataTypes.INTEGER.UNSIGNED,
    allowNull: true,
  },
  PreferredName: {
    type: DataTypes.STRING(50),
    allowNull: true,
  },
  Domain: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  JobTitle: {
    type: DataTypes.STRING(50),
    allowNull: true,
  },
  Email: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  Password: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  Passkey: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  DOB: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  Gender: {
    type: DataTypes.ENUM('M', 'F', 'O', 'X'),
    allowNull: true,
  },
  Height: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  Status: {
    type: DataTypes.CHAR(1),
    allowNull: true,
  },
  AdminFlag: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  ExitEnabled: {
    type: DataTypes.BOOLEAN,
    allowNull: true,
  },
  IsNew: {
    type: DataTypes.BOOLEAN,
    allowNull: true,
  },
  CalorieGoal: {
    type: DataTypes.INTEGER,
    allowNull: true,
  }
}, {
  sequelize,
  tableName: 'user',
});

export default User;
