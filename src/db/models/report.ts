import { DataTypes, Model, Optional } from 'sequelize';

import sequelize from '../config.js';

interface ReportAttributes {
    id: number;
    name: string;
    size: string;
    date: Date;
    group: string;
    content: string;
    createdBy: string;
}

type ReportCreationAttributes = Optional<ReportAttributes, 'id'>

class Report extends Model<ReportAttributes, ReportCreationAttributes> implements ReportAttributes {
    public id!: number;

    public name!: string;

    public size!: string;

    public date!: Date;

    public group!: string;

    public content!: string;

    public createdBy!: string;

    public readonly createdAt!: Date;

    public readonly updatedAt!: Date;
}

Report.init(
    {
        id: {
            type: DataTypes.INTEGER.UNSIGNED,
            autoIncrement: true,
            primaryKey: true,
        },
        name: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        size: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        date: {
            type: DataTypes.DATE,
            allowNull: false,
        },
        group: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        content: {
            type: DataTypes.TEXT,
            allowNull: false,
        },
        createdBy: {
            type: DataTypes.STRING,
            allowNull: false,
        },
    },
    {
        sequelize,
        tableName: 'reports',
        modelName: 'Report',
        timestamps: true,
    },
);

export default Report;
