import { DataTypes, Model } from 'sequelize';

import sequelize from '../config.js';

import Department from './department.js';

class Registration extends Model {
    RegistrationKey!: string;

    DepartmentID: number;

    Seats: number;
}

Registration.init({
    RegistrationKey: {
        type: DataTypes.STRING(36),
        primaryKey: true,
        allowNull: false,
        defaultValue: DataTypes.UUIDV4,
    },
    DepartmentID: {
        type: DataTypes.INTEGER.UNSIGNED,
        allowNull: true,
        references: {
            model: Department,
            key: 'ID',
        },
    },
    Seats: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
}, {
    sequelize,
    modelName: 'Registration',
    tableName: 'registration',
    timestamps: false,
});

export default Registration;
