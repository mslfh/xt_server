import { DataTypes, Model } from 'sequelize';

import sequelize from '../config.js';

import Department from './department.js';

class Exercise extends Model { }

Exercise.init(
  {
    ID: {
      type: DataTypes.UUID,
      primaryKey: true,
      allowNull: false,
    },
    Type: {
      type: DataTypes.STRING(50),
      allowNull: true,
    },
    Caption: {
      type: DataTypes.STRING(50),
      allowNull: false,
    },
    Status: {
      type: DataTypes.ENUM('A', 'I', 'D'),
      allowNull: false,
    },
    Image: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    VideoURL: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    Duration: {
      type: DataTypes.INTEGER.UNSIGNED,
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
    S3key: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    Bucket: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    Mime: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    Comment: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
  },
  {
    sequelize,
    tableName: 'exercise',
    modelName: 'Exercise',
    timestamps: false,
  },
);

export default Exercise;
