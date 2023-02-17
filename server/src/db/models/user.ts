import { Model } from "sequelize-typescript";
import { DataTypes } from "sequelize";
import { sequelize } from "../../config/sequelize";

export class User extends Model {
    declare public id: number;
    public email!: string;
    public password!: string;
    declare public readonly createdAt: Date;
    declare public readonly updatedAt: Date;
}

User.init(
    {
        id: {
            type: DataTypes.INTEGER.UNSIGNED,
            autoIncrement: true,
            primaryKey: true,
        },
        email: {
            type: new DataTypes.STRING(128),
            allowNull: false,
        },
        password: {
            type: new DataTypes.STRING(128),
            allowNull: false,
        },
    },
    {
        tableName: "users",
        sequelize,
    }
);

export default User;
