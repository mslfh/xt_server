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
  tableName: 'exercise_log_question',
  timestamps: false,
});

export default ExerciseLogQuestion;