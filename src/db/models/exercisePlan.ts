import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';
import Organisation from './organisation.js';
import Department from './department.js';

class ExercisePlan extends Model {}

ExercisePlan.init({
  ID: {
    type: DataTypes.INTEGER.UNSIGNED,
    autoIncrement: true,
    primaryKey: true,
    allowNull: false,
  },
  Subject: {
    type: DataTypes.STRING(255),
    allowNull: false,  // 确认 Subject 是否应该允许为空
  },
  ContentType: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  Content: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  OrganisationID: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  DepartmentID: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  Status: {
    type: DataTypes.STRING(32),
    allowNull: true,
  },
  Type: {
    type: DataTypes.STRING(32),
    allowNull: true,
  },
  Frequency: {
    type: DataTypes.STRING(48),
    allowNull: true,
  },
  CustomFrequency: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  IsAllDay: {
    type: DataTypes.BOOLEAN,
    allowNull: true,
  },
  Intervals: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  StartTimeZone: {
    type: DataTypes.STRING(32),
    allowNull: true,
  },
  StartDateTime: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  EndTimeZone: {
    type: DataTypes.STRING(32),
    allowNull: true,
  },
  EndDateTime: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  Priority: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  Attendees: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  Remark: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  CreatedAt: {
    type: DataTypes.DATE,
    allowNull: true,
    defaultValue: DataTypes.NOW,
  },
}, {
  sequelize,
  modelName: 'ExercisePlan',
  tableName: 'exercise_plan',
  timestamps: false,
});

ExercisePlan.belongsTo(Organisation, {
  foreignKey: 'OrganisationID',
  onDelete: 'CASCADE',
  onUpdate: 'CASCADE',
});

ExercisePlan.belongsTo(Department, {
  foreignKey: 'DepartmentID',
  onDelete: 'CASCADE',
  onUpdate: 'CASCADE',
});

export default ExercisePlan;
