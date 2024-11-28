import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';
import User from './user.js';
import Exercise from './exercise.js';

class ExerciseLog extends Model {}

ExerciseLog.init({
  ID: {
    type: DataTypes.INTEGER.UNSIGNED,
    autoIncrement: true,
    primaryKey: true,
    allowNull: false,
  },
  ExerciseID: {
    type: DataTypes.INTEGER.UNSIGNED,
    allowNull: false,
  },
  UserID: {
    type: DataTypes.CHAR(36),
    allowNull: false,
    references: {
      model: 'user',
      key: 'ID',
    },
    onDelete: 'CASCADE',
      onUpdate: 'CASCADE',
  },
  Repetitions: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  Duration: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  Source: {
    type: DataTypes.ENUM('M', 'A', 'O'),
    allowNull: true,
  },
  StartDateTime: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  EndDateTime: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  StandStartDateTime: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  StandEndDateTime: {
    type: DataTypes.DATE,
    allowNull: true,
  },
}, {
  sequelize,
  modelName: 'ExerciseLog',
  tableName: 'exercise_log',
  timestamps: false,
});

ExerciseLog.belongsTo(User, {
  foreignKey: 'UserID',
  onDelete: 'CASCADE',
  onUpdate: 'CASCADE',
});

ExerciseLog.belongsTo(Exercise, {
  foreignKey: 'ExerciseID',
  onDelete: 'CASCADE',
  onUpdate: 'CASCADE',
});

export default ExerciseLog;