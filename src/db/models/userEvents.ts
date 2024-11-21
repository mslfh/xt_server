import { DataTypes, Model } from 'sequelize';

import sequelize from '../config.js';

class UserEvents extends Model {}

UserEvents.init({
  ID: {
    type: DataTypes.INTEGER.UNSIGNED,
    primaryKey: true,
    autoIncrement: true,
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
  Date: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  EventType: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
}, {
  sequelize,
  modelName: 'UserEvents',
  tableName: 'user_event',
  timestamps: false,
});

export default UserEvents;
