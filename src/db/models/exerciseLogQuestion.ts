import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';
import ExerciseLog from './exerciseLog.js';
import Question from './question.js';

class ExerciseLogQuestion extends Model {}

ExerciseLogQuestion.init({
  ExerciseLogID: {
    type: DataTypes.INTEGER.UNSIGNED,
    allowNull: false,
    primaryKey: true,
  },
  QuestionID: {
    type: DataTypes.CHAR(36),
    allowNull: false,
    primaryKey: true,
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

ExerciseLogQuestion.belongsTo(ExerciseLog, {
  foreignKey: 'ExerciseLogID',
  onDelete: 'CASCADE',
  onUpdate: 'CASCADE',
});

ExerciseLogQuestion.belongsTo(Question, {
  foreignKey: 'QuestionID',
  onDelete: 'CASCADE',
  onUpdate: 'CASCADE',
});

export default ExerciseLogQuestion;