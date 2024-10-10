import { DataTypes, Model } from 'sequelize';
import sequelize from '../config.js';

class Credentials extends Model {
  public ID!: string;
  public UserID!: string;
  public PublicKey!: Buffer;
  public WebAuthnUserID!: string;
  public Counter!: number;
  public DeviceType?: string;
  public BackedUp!: boolean;
  public Transports?: string;
  public CreatedAt!: Date;
  public LastUsed?: Date;

  // 静态方法：Base64 转换为 Base64URL
  static base64ToBase64URL(base64: string): string {
    return base64.replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
  }
}

Credentials.init({
  ID: {
    type: DataTypes.STRING(255),  // varchar(255)
    primaryKey: true,
    allowNull: false,
    defaultValue: () => Credentials.base64ToBase64URL(Buffer.from(Math.random().toString()).toString('base64')),
  },
  UserID: {
    type: DataTypes.CHAR(255),  // char(255)
    allowNull: false,
    references: {
      model: 'user',
      key: 'ID',
    },
    onDelete: 'CASCADE',
    onUpdate: 'CASCADE',
  },
  PublicKey: {
    type: DataTypes.BLOB,  // blob
    allowNull: false,
  },
  WebAuthnUserID: {
    type: DataTypes.CHAR(255),  // char(255)
    allowNull: false,
  },
  Counter: {
    type: DataTypes.BIGINT,  // bigint
    allowNull: false,
  },
  DeviceType: {
    type: DataTypes.STRING(32),  // varchar(32)
    allowNull: true,
  },
  BackedUp: {
    type: DataTypes.TINYINT,  // tinyint(1)
    allowNull: false,
    defaultValue: 0,  // 默认未备份
  },
  Transports: {
    type: DataTypes.STRING(255),  // varchar(255)
    allowNull: true,
  },
  CreatedAt: {
    type: DataTypes.DATE,  // timestamp
    allowNull: false,
    defaultValue: DataTypes.NOW,
  },
  LastUsed: {
    type: DataTypes.DATE,  // timestamp
    allowNull: true,
    defaultValue: DataTypes.NOW,
  },
}, {
  sequelize,
  modelName: 'Credentials',
  tableName: 'credential',
  timestamps: false, 
  hooks: {
    beforeCreate: (credential: Credentials) => {

      if (!credential.ID.includes('-') && !credential.ID.includes('_')) {
        credential.ID = Credentials.base64ToBase64URL(Buffer.from(credential.ID).toString('base64'));
      }
    },
  },
});

export default Credentials;
