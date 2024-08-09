import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';

class SurveyResponse extends Model {}

SurveyResponse.init({
  ID: {
    type: DataTypes.INTEGER.UNSIGNED,
    primaryKey: true,
    autoIncrement: true,
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
    allowNull: true,
  },
  DaysWorked: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  HoursWorked: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  PercentSitting: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  PercentStanding: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  PercentWalking: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  PercentHeavy: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
}, {
  sequelize,
  modelName: 'SurveyResponse',
  tableName: 'SurveyResponse',
  timestamps: false,
});

export default SurveyResponse;