import fs from 'fs';
import path from 'path';

import { Sequelize } from 'sequelize-typescript';

const basename = path.basename(__filename);
const env = process.env.NODE_ENV || 'development';
const config = require(path.join(__dirname, '..', 'config', 'config.ts'))[env];



const db:any = {};

let sequelize: any;
if (config[env].use_env_variable) {
  sequelize = new Sequelize(config[env].use_env_variable, config[env]);
} else {
  sequelize = new Sequelize(config[env].database, config[env].username, config[env].password, config[env]);
}

fs
  .readdirSync(__dirname)
  .filter((file) => (file.indexOf('.') !== 0) && (file !== basename) && (file.slice(-3) === '.js'))
  .forEach((file) => {
    const model = sequelize.import(path.join(__dirname, file));
    db[model.name] = model;
  });

Object.keys(db).forEach((modelName) => {
  if (db[modelName].associate) {
    db[modelName].associate(db);
  }
});

db.sequelize = sequelize;
db.Sequelize = Sequelize;

export default db;
