import { DataTypes, Model, Optional } from 'sequelize';
import sequelize from '../config.js';

interface OrganisationAttributes {
    ID: number;
    ShortName: string;
    LongName: string;
    CountdownDuration?: number;
    WalkingExDelay?: number;
}

interface OrganisationCreationAttributes extends Optional<OrganisationAttributes, 'ID'> {}

class Organisation extends Model<OrganisationAttributes, OrganisationCreationAttributes>
    implements OrganisationAttributes {
    public ID!: number;
    public ShortName!: string;
    public LongName!: string;
    public CountdownDuration?: number;
    public WalkingExDelay?: number;
}

Organisation.init(
    {
        ID: {
            type: DataTypes.INTEGER.UNSIGNED,
            autoIncrement: true,
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
        sequelize,
        tableName: 'organisation',
        modelName: 'Organisation',
        timestamps: false,
    }
);

export default Organisation;
