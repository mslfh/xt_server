import { Model, DataTypes } from 'sequelize';

import sequelize from '../config.js';

class VideoUpload extends Model {
  public ID!: number;

  public S3key?: string;

  public Bucket?: string;

  public Mime?: string;

  public Comment?: string;
}

VideoUpload.init(
  {
    ID: {
      type: DataTypes.INTEGER.UNSIGNED,
      autoIncrement: true,
      primaryKey: true,
      allowNull: false,
    },
    S3key: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    Bucket: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    Mime: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    Comment: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
  },
  {
    sequelize,
    modelName: 'VideoUpload',
    tableName: 'video_upload',
  },
);

export default VideoUpload;
