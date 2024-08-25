import { DataTypes, Model, Optional } from 'sequelize';
import sequelize from '../config.js';
import Department from './department.js';

interface UserAttributes {
  ID: string;
  DepartmentID: number | null;
  GivenNames: string;
  Surname: string;
  PreferredName: string | null;
  Username: string;
  Domain: string | null;
  JobTitle: string | null;
  Email: string | null;
  Password: string | null;
  Passkey: string | null;
  DOB: Date | null;
  Gender: 'M' | 'F' | 'O' | 'X' | null;
  Height: number | null;
  Status: string | null;
  AdminFlag: number | null;
  ExitEnabled: boolean | null;
  IsNew: boolean | null;
  CalorieGoal: number | null;
  CreatedAt: Date;
  UpdatedAt: Date;
}

interface UserCreationAttributes extends Optional<UserAttributes, 'ID'> {}

class User extends Model<UserAttributes, UserCreationAttributes> implements UserAttributes {
  public ID!: string;
  public DepartmentID!: number | null;
  public GivenNames!: string;
  public Surname!: string;
  public PreferredName!: string | null;
  public Username!: string;
  public Domain!: string | null;
  public JobTitle!: string | null;
  public Email!: string | null;
  public Password!: string | null;
  public Passkey!: string | null;
  public DOB!: Date | null;
  public Gender!: 'M' | 'F' | 'O' | 'X' | null;
  public Height!: number | null;
  public Status!: string | null;
  public AdminFlag!: number | null;
  public ExitEnabled!: boolean | null;
  public IsNew!: boolean | null;
  public CalorieGoal!: number | null;
  public CreatedAt!: Date;
  public UpdatedAt!: Date;
}

User.init({
  ID: {
    type: DataTypes.STRING(36),
    primaryKey: true,
  },
  DepartmentID: {
    type: DataTypes.INTEGER.UNSIGNED,
    allowNull: true,
  },
  GivenNames: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  Surname: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
  PreferredName: {
    type: DataTypes.STRING(50),
    allowNull: true,
  },
  Username: {
    type: DataTypes.STRING(255),
    allowNull: false,
  },
  Domain: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  JobTitle: {
    type: DataTypes.STRING(50),
    allowNull: true,
  },
  Email: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  Password: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  Passkey: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  DOB: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  Gender: {
    type: DataTypes.ENUM('M', 'F', 'O', 'X'),
    allowNull: true,
  },
  Height: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  Status: {
    type: DataTypes.CHAR(1),
    allowNull: true,
  },
  AdminFlag: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  ExitEnabled: {
    type: DataTypes.BOOLEAN,
    allowNull: true,
  },
  IsNew: {
    type: DataTypes.BOOLEAN,
    allowNull: true,
  },
  CalorieGoal: {
    type: DataTypes.INTEGER,
    allowNull: true,
  },
  CreatedAt: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
    allowNull: false,
  },
  UpdatedAt: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
    allowNull: false,
  },
}, {
  sequelize,
  tableName: 'user',
  timestamps: false, 
});

User.belongsTo(Department, {
  foreignKey: 'DepartmentID',
  onDelete: 'CASCADE',
  onUpdate: 'CASCADE',
});

export default User;
