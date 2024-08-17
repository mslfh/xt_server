import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';

class ExerciseLogQuestion extends Model {}

ExerciseLogQuestion.init({
  ExerciseLogID: {
    type: DataTypes.INTEGER.UNSIGNED,
    allowNull: false,
    primaryKey: true,
    references: {
      model: 'exerciseLog',
      key: 'ID',
    },
  },
  QuestionID: {
    type: DataTypes.CHAR(36),
    allowNull: false,
    primaryKey: true,
    references: {
      model: 'questions',
      key: 'ID',
    },
  },
  Response: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
}, {
  sequelize,
  modelName: 'ExerciseLogQuestion',
<<<<<<< HEAD
  tableName: 'exercise_log_question',
=======
  tableName: 'ExerciseLogQuestion',
>>>>>>> 1fbc1d23c968f30629b3c5e5b1151ba8c75f6c3b
  timestamps: false,
});

export default ExerciseLogQuestion;