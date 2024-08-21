import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';

class UserPosition extends Model {}

UserPosition.init({
  ID: {
    type: DataTypes.INTEGER.UNSIGNED,
    primaryKey: true,
    allowNull: false,
    autoIncrement: true,
  },
  UserID: {
    type: DataTypes.CHAR(36),
    allowNull: false,
    references: {
      model: 'User',
      key: 'ID',
    },
  },
  Date: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  Position: {
    type: DataTypes.STRING(100),
    allowNull: false,
  },
}, {
  sequelize,
  modelName: 'UserPosition',
  tableName: 'user_position',
  timestamps: false,
});

export default UserPosition;