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
<<<<<<< HEAD
  tableName: 'exercise_department',
=======
  tableName: 'ExerciseDepartment',
>>>>>>> 1fbc1d23c968f30629b3c5e5b1151ba8c75f6c3b
  timestamps: false,
});

export default ExerciseDepartment;
