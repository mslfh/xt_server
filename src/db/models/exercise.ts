import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';

class Exercise extends Model {}

<<<<<<< HEAD
Exercise.init(
    {
        ID: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primaryKey: true,
            allowNull: false,
        },
        Type: {
            type: DataTypes.STRING(50),
            allowNull: false,
        },
        CategoryID: {
            type: DataTypes.INTEGER,
            allowNull: true,
        },
        Caption: {
            type: DataTypes.STRING(50),
            allowNull: true,
        },
        Duration: {
            type: DataTypes.DATE,
            allowNull: false,
        },
        Status: {
            type: DataTypes.ENUM('A', 'I', 'D'),
            allowNull: false,
        },
        Image: {
            type: DataTypes.TEXT,
            allowNull: true,
        },
        VideoURL: {
            type: DataTypes.TEXT,
            allowNull: true,
        },
        Kilojoules: {
            type: DataTypes.FLOAT,
            allowNull: true,
        },
        CalculationType: {
            type: DataTypes.ENUM('C', 'M', 'O'),
            allowNull: true,
        },
        ExerciseDelayID: {
            type: DataTypes.CHAR(36),
            allowNull: false,
        },
        DepartmentID: {
            type: DataTypes.CHAR(36),
            allowNull: false,
        },
    },
    {
        sequelize,
        tableName: 'exercise',
        modelName: 'Exercise',
        timestamps: false,
    }
);
=======
Exercise.init({
  ID: {
    type: DataTypes.CHAR(36),
    primaryKey: true,
    allowNull: false,
  },
  Type: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  Caption: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  Image: {
    type: DataTypes.BLOB,
    allowNull: true,
  },
  VideoURL: {
    type: DataTypes.TEXT,
    allowNull: true,
  },
  Duration: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  Status: {
    type: DataTypes.ENUM('A', 'I', 'D'),
    allowNull: true,
  },
  Kilojoules: {
    type: DataTypes.FLOAT,
    allowNull: true,
  },
  CalculationType: {
    type: DataTypes.ENUM('C', 'M', 'O'),
    allowNull: true,
  },
  ExerciseDelayID: {
    type: DataTypes.CHAR(36),
    allowNull: true,
    references: {
      model: 'ExerciseDelay',
      key: 'ID',
    },
  },
}, {
  sequelize,
  modelName: 'Exercise',
  tableName: 'Exercise',
  timestamps: false,
});
>>>>>>> 1fbc1d23c968f30629b3c5e5b1151ba8c75f6c3b

export default Exercise;
