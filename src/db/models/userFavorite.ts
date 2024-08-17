import { DataTypes } from 'sequelize';
import sequelize from '../config.js';

const UserFavourite = sequelize.define('UserFavourite', {
  ID: {
    type: DataTypes.INTEGER.UNSIGNED,
    autoIncrement: true,
    primaryKey: true,
    allowNull: false,
  },
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
        model: 'Exercise',
        key: 'ID',
      },
    },
    CreatedAt: {
      type: DataTypes.DATE,
      allowNull: true,
    },
  }, {
<<<<<<< HEAD:src/db/models/userFavorite.ts
    tableName: 'user_favorite',
=======
    tableName: 'FavouriteExercises',
>>>>>>> 1fbc1d23c968f30629b3c5e5b1151ba8c75f6c3b:src/db/models/favouriteExercises.ts
    timestamps: false,
  });
  
  export default UserFavourite;