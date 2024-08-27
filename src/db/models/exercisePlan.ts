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
  Title: {
    type: DataTypes.TEXT,
    allowNull: false,
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
    type: DataTypes.TEXT,
    allowNull: true,
  },
  Description: {
    type: DataTypes.TEXT,
    allowNull: true,
  },
  Type: {
    type: DataTypes.STRING('10'),
    allowNull: true,
  },
  Frequency: {
    type: DataTypes.STRING('48'),
    allowNull: true,
  },
  CustomFrequency: {
    type: DataTypes.TEXT,
    allowNull: true,
  },
  StartDate: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  EndDate: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  Level: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  Priority: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  CreatedAt: {
    type: DataTypes.DATE,
    allowNull: true,
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