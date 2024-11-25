import { DataTypes, Model, Optional } from 'sequelize';
import sequelize from '../config.js';
import User from './user.js';

// Define the attributes for the UserMicrosoftAccount model
interface UserMicrosoftAccountAttributes {
  ID?: number;           // Primary key for UserMicrosoftAccount (auto-increment)
  UserID: string;       // Foreign key linking to User model
  microsoftEmail?: string;
  oid?: string;
  sub?: string;
  isLinked?: boolean;
}

// Define the type for creating new UserMicrosoftAccount instances
interface UserMicrosoftAccountCreationAttributes extends Optional<UserMicrosoftAccountAttributes, 'ID'> { }

// Define the UserMicrosoftAccount model class
class UserMicrosoftAccount extends Model<UserMicrosoftAccountAttributes, UserMicrosoftAccountCreationAttributes> implements UserMicrosoftAccountAttributes {
  public ID!: number;
  public UserID!: string;
  public microsoftEmail?: string;
  public oid?: string;
  public sub?: string;
  public isLinked?: boolean;
  public User?: User;
}

// Initialize the UserMicrosoftAccount model
UserMicrosoftAccount.init({
  ID: {
    type: DataTypes.INTEGER.UNSIGNED,  // Use INTEGER type for auto-increment
    autoIncrement: true,  // Enable auto-increment
    primaryKey: true,  // Set as primary key
  },
  UserID: {
    type: DataTypes.CHAR(36),
    allowNull: false,
    references: {
      model: 'User',  // Reference to the 'user' table
      key: 'ID',      // Foreign key is the 'ID' field in 'user' table
    },
    onDelete: 'CASCADE',   // If user is deleted, associated microsoftAccount should also be deleted
    onUpdate: 'CASCADE',   // If user ID is updated, it should also reflect here
  },
  microsoftEmail: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  oid: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  sub: {
    type: DataTypes.STRING(255),
    allowNull: true,
  },
  isLinked: {
    type: DataTypes.BOOLEAN,
    allowNull: true,
    defaultValue: false,
  },
}, {
  sequelize,
  tableName: 'microsoft_account',
  timestamps: false,  // Disable automatic timestamps
});

// Define the association between UserMicrosoftAccount and User
UserMicrosoftAccount.belongsTo(User, {
  foreignKey: 'UserID',
  onDelete: 'CASCADE',    // When a User is deleted, associated Microsoft account data is also deleted
  onUpdate: 'CASCADE',
});

// Optionally, define the reverse association from User to UserMicrosoftAccount
User.hasOne(UserMicrosoftAccount, {
  foreignKey: 'UserID',
  onDelete: 'CASCADE',
  onUpdate: 'CASCADE',
});

export default UserMicrosoftAccount;
