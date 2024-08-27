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
  Weight: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
}, {
  sequelize,
  modelName: 'UserWeight',
  tableName: 'user_weight',
  timestamps: false,
});

export default UserWeight;
