// src/db/models/file.ts
import { Model, DataTypes } from 'sequelize';

import sequelize from '../config.js';

class FileModel extends Model {
    public id!: number;
    public s3Key?: string;
    public bucket?: string;
    public mime?: string;
    public comment?: string;
}

FileModel.init(
  {
    id: {
      type: DataTypes.INTEGER.UNSIGNED,
      autoIncrement: true,
      primaryKey: true,
      allowNull: false,
    },
    s3Key: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    bucket: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    mime: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    comment: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
  },
  {
    sequelize,
    modelName: 'FileModel',
    tableName: 'files',
  },
);

export default FileModel;
