import { DataTypes } from 'sequelize';
import sequelize from '../config.js';

const ExerciseCategory = sequelize.define('ExerciseCategory', {
  ID: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
    allowNull: false,
  },
  PID: {
    type:DataTypes.INTEGER,
    allowNull: true,
  },
  Title: {
    type: DataTypes.TEXT,
    allowNull: true,
  },
  Status: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
}, {
  tableName: 'exercise_category',
  timestamps: false,
});

export default ExerciseCategory;