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
    allowNull: false,
  },
  StartTime: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  EndTime: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  Type: {
    type: DataTypes.ENUM('MC', 'TEXT', 'RATING'),
    allowNull: false,
  },
}, {
  sequelize,
  modelName: 'Question',
  tableName: 'question',
  timestamps: false,
});

export default Question;
