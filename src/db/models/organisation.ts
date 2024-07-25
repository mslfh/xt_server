// models/organisation.ts
'use strict';

import { DataTypes, Model } from 'sequelize';

import sequelize from '../config.js'

class Organisation extends Model {
    public ID!: string;
    public ShortName!: string;
    public LongName!: string;
    public CountdownDuration?: number;
    public WalkingExDelay?: number;
}

Organisation.init(
    {
        ID: {
            type: DataTypes.CHAR(36),
            primaryKey: true,
        },
        ShortName: {
            type: DataTypes.STRING(50),
            allowNull: false,
        },
        LongName: {
            type: DataTypes.TEXT,
            allowNull: false,
        },
        CountdownDuration: {
            type: DataTypes.INTEGER,
            allowNull: true,
        },
        WalkingExDelay: {
            type: DataTypes.INTEGER,
            allowNull: true,
        },
    },
    {
        sequelize: sequelize,
        tableName: 'organisation',
        modelName: 'Organisation',
        timestamps: false,
    }
);

export default Organisation;