import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';

class Exercise extends Model {
    public ID!: string;
    public Type!: string;
    public Caption!: string;
    public Image!: Buffer;
    public VideoURL!: string;
    public Duration!: Date;
    public Status!: 'A' | 'I' | 'D';
    public Kilojoules!: number;
    public CalculationType!: 'C' | 'M' | 'O';
    public ExerciseDelayID!: string;
    public DepartmentID!: string; 
}

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

export default Exercise;
