import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';

class Exercise extends Model {}

Exercise.init({
  ID: {
    type: DataTypes.CHAR(36),
    primaryKey: true,
    allowNull: false,
  },
  Type: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  Caption: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  Image: {
    type: DataTypes.BLOB,
    allowNull: true,
  },
  VideoURL: {
    type: DataTypes.TEXT,
    allowNull: true,
  },
  Duration: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  Status: {
    type: DataTypes.ENUM('A', 'I', 'D'),
    allowNull: true,
  },
  Kilojoules: {
    type: DataTypes.FLOAT,
    allowNull: true,
  },
  CalculationType: {
    type: DataTypes.ENUM('C', 'M', 'O'),
    allowNull: true,
  },
  ExerciseDelayID: {
    type: DataTypes.CHAR(36),
    allowNull: true,
    references: {
      model: 'ExerciseDelay',
      key: 'ID',
    },
  },
}, {
  sequelize,
  modelName: 'Exercise',
  tableName: 'Exercise',
  timestamps: false,
});

export default Exercise;
