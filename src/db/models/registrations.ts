import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';

const Registrations = sequelize.define('Registrations', {
    RegistrationKey: {
      type: DataTypes.CHAR(36),
      allowNull: false,
      primaryKey: true,
    },
    DepartmentID: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: true,
      references: {
        model: 'departments',
        key: 'ID',
      },
      onDelete: 'CASCADE',
      onUpdate: 'CASCADE',
    },
    Seats: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
  }, {
    tableName: 'Registrations',
    timestamps: false,
  });
  
  export default Registrations;