import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';
import Department from './department.js';

class ExerciseDepartment extends Model {}

ExerciseDepartment.init({
  ExerciseID: {
    type: DataTypes.INTEGER.UNSIGNED,
    allowNull: false,
    primaryKey: true,
  },
  DepartmentID: {
    type: DataTypes.INTEGER.UNSIGNED,
    allowNull: false,
    primaryKey: true,
  },
}, {
  sequelize,
  modelName: 'ExerciseDepartment',
  tableName: 'exercise_department',
  timestamps: false,
});

ExerciseDepartment.belongsTo(Department, {
  foreignKey: 'DepartmentID',
  onDelete: 'CASCADE',
  onUpdate: 'CASCADE',
});

export default ExerciseDepartment;
