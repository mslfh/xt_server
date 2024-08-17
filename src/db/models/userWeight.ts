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
<<<<<<< HEAD
  tableName: 'user_weight',
=======
  tableName: 'userWeight',
>>>>>>> 1fbc1d23c968f30629b3c5e5b1151ba8c75f6c3b
  timestamps: false,
});

export default UserWeight;
