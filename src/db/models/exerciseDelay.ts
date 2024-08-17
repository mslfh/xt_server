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
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'User', 
      key: 'ID',
    },
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
<<<<<<< HEAD
  tableName: 'exercise_delay',
=======
  tableName: 'ExerciseDelay',
>>>>>>> 1fbc1d23c968f30629b3c5e5b1151ba8c75f6c3b
  timestamps: false,
});

export default ExerciseDelay;