import { DataTypes } from 'sequelize';
import sequelize from '../config.js';

const FavouriteExercises = sequelize.define('FavouriteExercises', {
    UserID: {
      type: DataTypes.CHAR(36),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'User',
        key: 'ID',
      },
    },
    ExerciseID: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'exercises',
        key: 'ID',
      },
    },
  }, {
    tableName: 'favouriteExercises',
    timestamps: false,
  });
  
  export default FavouriteExercises;