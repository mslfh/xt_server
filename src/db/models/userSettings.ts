import { DataTypes } from 'sequelize';
import sequelize from '../config.js';

const UserSetting = sequelize.define('UserSetting', {
  ID: {
    type: DataTypes.INTEGER.UNSIGNED,
    autoIncrement: true,
    primaryKey: true,
    allowNull: false,
  },
  UserID: {
    type: DataTypes.CHAR(36),
    allowNull: false,
  },
  Content: {
    type: DataTypes.TEXT,
    primaryKey: true,
    allowNull: false,
  },
  Value: {
    type: DataTypes.TEXT,
    allowNull: true,
  },
}, {
  tableName: 'user_setting',
  timestamps: false,
});

export default UserSetting;