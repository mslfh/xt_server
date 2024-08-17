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
    defaultValue: false, 
  },
  Transports: {
    type: DataTypes.STRING(255),
  }
}, {
  sequelize,
  modelName: 'Credentials',
<<<<<<< HEAD
  tableName: 'credential',
=======
  tableName: 'Credentials',
>>>>>>> 1fbc1d23c968f30629b3c5e5b1151ba8c75f6c3b
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
