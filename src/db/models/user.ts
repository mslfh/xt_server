import { DataTypes, Model, Optional } from 'sequelize';
import bcrypt from 'bcryptjs';
import sequelize from '../config.js';
import Department from './department.js';

// Define the attributes for the User model
interface UserAttributes {
  ID: string;
  GivenNames?: string;
  Surname?: string;
  Username: string;
  DepartmentID?: number;
  PreferredName?: string;
  Domain?: string;
  JobTitle?: string;
  Email: string;
  Password: string;
  Passkey?: string;
  DOB?: Date;
  Gender?: 'M' | 'F' | 'O' | 'X';
  Height?: number;
  Status?: string;
  AdminFlag?: number;
  ExitEnabled?: boolean;
  IsNew?: boolean;
  CalorieGoal?: number;
}

// Define the type for creating new User instances
interface UserCreationAttributes extends Optional<UserAttributes, 'ID'> { }

// Define the User model class
class User extends Model<UserAttributes, UserCreationAttributes> implements UserAttributes {
  public ID!: string;
  public GivenNames?: string;
  public Surname?: string;
  public Username!: string;
  public DepartmentID?: number;
  public PreferredName?: string;
  public Domain?: string;
  public JobTitle?: string;
  public Email!: string;
  public Password!: string;
  public Passkey?: string;
  public DOB?: Date;
  public Gender?: 'M' | 'F' | 'O' | 'X';
  public Height?: number;
  public Status?: string;
  public AdminFlag?: number;
  public ExitEnabled?: boolean;
  public IsNew?: boolean;
  public CalorieGoal?: number;

  // Method to compare the given plain password with the hashed password
  public async validatePassword(plainPassword: string): Promise<boolean> {
    return bcrypt.compare(plainPassword, this.Password);
  }
}

// Initialize the User model
User.init({
  ID: {
    type: DataTypes.CHAR(36),
    primaryKey: true,
  },
  GivenNames: {
    type: DataTypes.STRING(50),
    allowNull: true,
    defaultValue: '',
  },
  Surname: {
    type: DataTypes.STRING(50),
    allowNull: true,
    defaultValue: '',
  },
  Username: {
    type: DataTypes.STRING(255),
    allowNull: false,  // Username cannot be null
  },
  DepartmentID: {
    type: DataTypes.INTEGER.UNSIGNED,
    allowNull: true,
    defaultValue: null,
  },
  PreferredName: {
    type: DataTypes.STRING(50),
    allowNull: true,
    defaultValue: '',
  },
  Domain: {
    type: DataTypes.STRING(255),
    allowNull: true,
    defaultValue: '',
  },
  JobTitle: {
    type: DataTypes.STRING(50),
    allowNull: true,
    defaultValue: '',
  },
  Email: {
    type: DataTypes.STRING(255),
    allowNull: false,  // Email cannot be null
  },
  Password: {
    type: DataTypes.STRING(255),
    allowNull: false,  // Password cannot be null
  },
  Passkey: {
    type: DataTypes.STRING(255), // Stores credentialID for WebAuthn
    allowNull: true,
    defaultValue: '',
  },
  DOB: {
    type: DataTypes.DATE,
    allowNull: true,
    defaultValue: null,
  },
  Gender: {
    type: DataTypes.ENUM('M', 'F', 'O', 'X'),
    allowNull: true,
    defaultValue: 'X',
  },
  Height: {
    type: DataTypes.INTEGER,
    allowNull: true,
    defaultValue: null,
  },
  Status: {
    type: DataTypes.CHAR(1),
    allowNull: true,
    defaultValue: 'A',
  },
  AdminFlag: {
    type: DataTypes.INTEGER,
    allowNull: true,
    defaultValue: 0,
  },
  ExitEnabled: {
    type: DataTypes.BOOLEAN,
    allowNull: true,
    defaultValue: false,
  },
  IsNew: {
    type: DataTypes.BOOLEAN,
    allowNull: true,
    defaultValue: true,
  },
  CalorieGoal: {
    type: DataTypes.INTEGER,
    allowNull: true,
    defaultValue: 2000,
  },
}, {
  sequelize,
  tableName: 'user',
  timestamps: false,

  // Hooks for password hashing
  hooks: {
    // Before creating a new user, hash the password
    beforeCreate: async (user: User) => {
      if (user.Password) {
        const salt = await bcrypt.genSalt(10);
        user.Password = await bcrypt.hash(user.Password, salt);
      }
    },
    // Before updating the password, check if it's changed and then hash it
    beforeUpdate: async (user: User) => {
      if (user.changed('Password')) {
        const salt = await bcrypt.genSalt(10);
        user.Password = await bcrypt.hash(user.Password, salt);
      }
    },
  },
});

// Define the association between User and Department
User.belongsTo(Department, {
  foreignKey: 'DepartmentID',
  onDelete: 'CASCADE',
  onUpdate: 'CASCADE',
});

export default User;
