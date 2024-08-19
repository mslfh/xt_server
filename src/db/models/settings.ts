import { DataTypes } from 'sequelize';
import sequelize from '../config.js';

const Settings = sequelize.define('Settings', {
  SettingKey: {
    type: DataTypes.STRING(250),
    primaryKey: true,
    allowNull: false,
  },
  SettingValue: {
    type: DataTypes.STRING(250),
    allowNull: true,
  },
}, {
  tableName: 'Settings', 
  timestamps: false,
});

export default Settings;
