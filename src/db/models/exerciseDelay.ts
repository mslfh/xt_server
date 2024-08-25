import { DataTypes } from 'sequelize';
import sequelize from '../config.js';

const ExerciseDelay = sequelize.define('ExerciseDelay', {
  ID: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
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
    onDelete: 'CASCADE',
    onUpdate: 'CASCADE',
  },
  ExerciseID: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'Exercise', 
      key: 'ID',
    },
  },
  DateTime: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  Duration: {
    type: DataTypes.FLOAT,
    allowNull: true,
  },
}, {
  tableName: 'exercise_delay',
  timestamps: false,
});



export default ExerciseDelay;