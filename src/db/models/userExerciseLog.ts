import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';

class UserExerciseLog extends Model {}

UserExerciseLog.init({
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
  EventID: {
    type: DataTypes.INTEGER.UNSIGNED,
    allowNull: true,
  },
  EventType: {
    type: DataTypes.TEXT,
    allowNull: true,
  },
  Duration: {
    type: DataTypes.DOUBLE,
    allowNull: true,
  },
  Status: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  CreatedAt: {
    type: DataTypes.DATE,
    allowNull: true,
  },
}, {
  sequelize,
  modelName: 'UserExerciseLog',
  tableName: 'user_exercise_log',
  timestamps: false,
});

export default UserExerciseLog;