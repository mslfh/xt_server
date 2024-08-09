import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';

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
  tableName: 'ExerciseDepartment',
  timestamps: false,
});

export default ExerciseDepartment;
