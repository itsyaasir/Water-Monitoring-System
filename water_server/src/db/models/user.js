import { UUIDV4, NOW, Model } from 'sequelize';

export default (sequelize, DataTypes) => {
  class User extends Model {
    static associate(models) {
      User.hasOne(models.Stats, {
        foreignKey: 'userId',
        as: 'stats',
      });
    }
  }

  User.init({
    id: {
      type: DataTypes.UUID,
      defaultValue: UUIDV4,
      primaryKey: true,
    },

    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    createdAt: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: NOW,
    },
    updatedAt: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: NOW,
    },

  }, {
    sequelize,
    modelName: 'User',
    tableName: 'users',
    freezeTableName: true,

  });

  return User;
};
