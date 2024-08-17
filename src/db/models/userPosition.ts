import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';

class UserPosition extends Model {}

UserPosition.init({
  ID: {
    type: DataTypes.CHAR(36),
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
<<<<<<< HEAD
  tableName: 'user_position',
=======
  tableName: 'UserPosition',
>>>>>>> 1fbc1d23c968f30629b3c5e5b1151ba8c75f6c3b
  timestamps: false,
});

export default UserPosition;