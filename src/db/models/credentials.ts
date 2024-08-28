import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';

class Credentials extends Model {
  public ID!: string;
  public UserId!: string;
  public PublicKey!: Buffer;
  public WebAuthnUserID!: string;
  public Counter!: number;
  public DeviceType!: string;
  public BackedUp!: boolean;
  public Transports?: string;
}

Credentials.init({
  ID: {
    type: DataTypes.CHAR(36),
    primaryKey: true,
    allowNull: false,
  },
  UserID: {
    type: DataTypes.CHAR(36),
    allowNull: false,
    references: {
      model: 'user',
      key: 'ID',
    },
    onDelete: 'CASCADE',
    onUpdate: 'CASCADE',
  },
  PublicKey: {
    type: DataTypes.BLOB,
    allowNull: true,
  },
  WebAuthnUserID: {
    type: DataTypes.CHAR(36),
    allowNull: false,
  },
  Counter: {
    type: DataTypes.BIGINT,
    allowNull: false,
  },
  DeviceType: {
    type: DataTypes.STRING(32),
  },
  BackedUp: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
  },
  Transports: {
    type: DataTypes.STRING(255),
  }
}, {
  sequelize,
  modelName: 'Credentials',
  tableName: 'credential',
  timestamps: false,
  indexes: [
    {
      name: 'idx_webauthn_user_id',
      fields: ['WebAuthnUserID'],
    },
    {
      unique: true,
      fields: ['WebAuthnUserID', 'UserId'],
    },
  ],
});

export default Credentials;
