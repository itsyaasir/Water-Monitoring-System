import chalk from 'chalk';
import Sequelize from 'sequelize';
import config from './config';

const env = process.env.NODE_ENV || 'development';

const sequelize = new Sequelize({
  ...config[env],
  models: [`${__dirname}../db/models`],
  logging: (msg) => console.log(chalk.green(msg)),
});

sequelize
  .authenticate()
  .then(() => {
    console.log(
      chalk.greenBright('Connection has been established successfully.')
    );
  })
  .catch((err) => {
    console.error(chalk.red('Unable to connect to the database:', err));
  });

module.exports = sequelize;
