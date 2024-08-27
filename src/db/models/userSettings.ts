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
    references: {
      model: 'User',
      key: 'ID',
    },
    onDelete: 'CASCADE',
    onUpdate: 'CASCADE',
  },
  Content: {
    type: DataTypes.STRING(255),  
    allowNull: false,
  },
  Value: {
    type: DataTypes.STRING(255), 
    allowNull: true,
  },
}, {
  tableName: 'user_setting',
  timestamps: false,
});

export default UserSetting;
