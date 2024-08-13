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
    tableName: 'user_favorite',
    timestamps: false,
  });
  
  export default UserFavourite;