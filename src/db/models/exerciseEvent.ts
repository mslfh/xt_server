import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';
import Exercise from './exercise.js';

class ExerciseEvent extends Model {}

ExerciseEvent.init({
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
  PlanID: {
    type: DataTypes.INTEGER.UNSIGNED,
    allowNull: false,
  },
  StartTime: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  EndTime: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  Duration: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  Weight: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  IsRepeat: {
    type: DataTypes.BOOLEAN,
    allowNull: true,
  },
  RepeatCount: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  Interval: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
}, {
  sequelize,
  modelName: 'ExerciseEvent',
  tableName: 'exercise_event',
  timestamps: false,
});

ExerciseEvent.belongsTo(Exercise, {
  foreignKey: 'ExerciseID',
  onDelete: 'CASCADE',
  onUpdate: 'CASCADE',
});

export default ExerciseEvent;
