import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';

class Question extends Model {}

Question.init({
  ID: {
    type: DataTypes.CHAR(36),
    primaryKey: true,
    allowNull: false,
  },
  Caption: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  Order: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  MinCaption: {
    type: DataTypes.STRING(50),
    allowNull: true,
  },
  MaxCaption: {
    type: DataTypes.STRING(50),
    allowNull: true,
  },
  Status: {
    type: DataTypes.ENUM('A', 'I', 'D'),
    allowNull: true,
  },
  StartTime: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  EndTime: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  Type: {
    type: DataTypes.ENUM('MC', 'TEXT', 'RATING'),
    allowNull: true,
  },
}, {
  sequelize,
  modelName: 'Question',
  tableName: 'question',
  timestamps: false,
});

export default Question;