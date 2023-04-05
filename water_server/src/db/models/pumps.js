import { UUIDV4, NOW, Model } from 'sequelize';

export default (sequelize, DataTypes) => {
  class Pumps extends Model {
    static associate(models) {
      Pumps.belongsTo(models.User, {
        foreignKey: 'userId',
        onDelete: 'CASCADE',
        as: 'user',
      });
    }
  }

  Pumps.init(
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: UUIDV4,
        primaryKey: true,
      },
      userId: {
        type: DataTypes.UUID,
        allowNull: false,
        references: {
          model: 'User',
          key: 'id',
        },
      },
      waterStatus: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: false,
      },
      treatmentStatus: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: false,
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
    },
    {
      sequelize,
      modelName: 'Pumps',
      tableName: 'pumps',
      freezeTableName: true,
    }
  );

  return Pumps;
};
