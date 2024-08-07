import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';

class UserWeight extends Model {}

UserWeight.init({
  ID: {
    type: DataTypes.INTEGER.UNSIGNED,
    autoIncrement: true,
    primaryKey: true,
  },
  UserID: {
    type: DataTypes.CHAR(36),
    allowNull: false,
  },
  Date: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  Weight: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
}, {
  sequelize,
  modelName: 'UserWeight',
  tableName: 'userWeights',
  timestamps: false,
});

export default UserWeight;
