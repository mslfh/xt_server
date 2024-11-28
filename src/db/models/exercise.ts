import { DataTypes, Model } from 'sequelize';

import sequelize from '../config.js';
import Department from './department.js';
import User from './user.js';

class Exercise extends Model { }

Exercise.init(
  {
    ID: {
      type: DataTypes.INTEGER.UNSIGNED,
      autoIncrement: true,
      primaryKey: true,
      allowNull: false,
    },
    Caption: {
      type: DataTypes.STRING(50),
      allowNull: false,
    },
    Status: {
      type: DataTypes.ENUM('A', 'I', 'D'),
      allowNull: false,
    },
    Type: {
      type: DataTypes.STRING(50),
      allowNull: true,
    },
    CategoryID: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: true,
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
      type: DataTypes.DATE,
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
    DepartmentID: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: true,
      references: {
        model: Department,
        key: 'ID',
      },
      onDelete: 'CASCADE',
      onUpdate: 'CASCADE',
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
