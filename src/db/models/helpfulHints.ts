import { DataTypes, Model } from 'sequelize';

import sequelize from '../config.js';

const HelpfulHints = sequelize.define('HelpfulHints', {
  ID: {
    type: DataTypes.INTEGER.UNSIGNED,
    autoIncrement: true,
    primaryKey: true,
  },
  Hint: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  HintOrder: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  DepartmentID: {
    type: DataTypes.INTEGER.UNSIGNED,
    allowNull: true,
    references: {
      model: 'department',
      key: 'ID',
    },
    onDelete: 'CASCADE',
    onUpdate: 'CASCADE',
  },
}, {
  tableName: 'helpful_hint',
  timestamps: false,
});
export default HelpfulHints;
