import {
  Model,
} from 'sequelize';

export default (sequelize, DataTypes) => {
  class Stats extends Model {
    static associate(models) {
      // define association here
      Stats.belongsTo(models.User, {
        foreignKey: 'userId',
        onDelete: 'CASCADE',
        as: 'user',
      });
    }
  }
  Stats.init({
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    userId: {
      type: DataTypes.UUID,
      allowNull: false,
      references: {
        model: 'User',
        key: 'id',
      },
    },
    waterLevel: { type: DataTypes.FLOAT, allowNull: false },
    ph: DataTypes.FLOAT,
    turb: DataTypes.FLOAT,
    createdAt: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,

    },
    updatedAt: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
  }, {
    sequelize,
    modelName: 'Stats',
    tableName: 'stats',
    freezeTableName: true,
  });
  return Stats;
};
