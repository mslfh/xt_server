import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';

class Credentials extends Model {}

Credentials.init({
  ID: {
    type: DataTypes.CHAR(36),
    primaryKey: true,
    allowNull: false,
  },
  UserId: {
    type: DataTypes.CHAR(36),
    allowNull: false,
  },
  PublicKey: {
    type: DataTypes.BLOB,
    allowNull: false,
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