import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';
import Organisation from './organisation.js';

class Department extends Model {
  public ID!: number;
  public OrganisationID!: number;
  public ShortName!: string;
  public LongName!: string;
  public IdleDefinition?: number;
  public IdleTime?: number;
  public NoIdleTime?: number;
  public MinimumTime?: number;
  public DefaultDelayInterval?: number;
  public CalorieGoal?: number;
  public CountdownDuration?: number;
  public WalkingExDelay?: number;
  public WalkingExID?: number;
  public ExitEnabled?: boolean;
  public WalkingExPromptText?: string;
  public NotificationDialogPromptText?: string;
}

Department.init(
  {
    ID: {
      type: DataTypes.INTEGER.UNSIGNED,
      autoIncrement: true,
      primaryKey: true,
    },
    OrganisationID: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      references: {
        model: Organisation,
        key: 'ID',
      },
      onDelete: 'CASCADE',
      onUpdate: 'CASCADE',
    },
    ShortName: {
      type: DataTypes.STRING(50),
      allowNull: false,
    },
    LongName: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    IdleDefinition: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    IdleTime: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    NoIdleTime: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    MinimumTime: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    DefaultDelayInterval: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    CalorieGoal: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    CountdownDuration: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    WalkingExDelay: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    WalkingExID: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: true,
    },
    ExitEnabled: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    WalkingExPromptText: {
      type: DataTypes.STRING(250),
      allowNull: true,
    },
    NotificationDialogPromptText: {
      type: DataTypes.STRING(130),
      allowNull: true,
    },
  },
  {
    sequelize,
<<<<<<< HEAD
    tableName: 'department',
=======
    tableName: 'Department',
>>>>>>> 1fbc1d23c968f30629b3c5e5b1151ba8c75f6c3b
    modelName: 'Department',
    timestamps: false,
  }
);

Department.belongsTo(Organisation, {
  foreignKey: 'OrganisationID',
  targetKey: 'ID',
  as: 'organisation',
  onDelete: 'CASCADE',
  onUpdate: 'CASCADE',
});

export default Department;
