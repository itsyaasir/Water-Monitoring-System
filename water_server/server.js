require('@babel/register');
const chalk = require('chalk');

const cluster = require('cluster');

const { cpus } = require('os');
// import dotenv from "dotenv";
const dotenv = require('dotenv');
const app = require('./app');

const PORT = process.env.PORT || 3000;

// Handle uncaught exceptions
process.on('uncaughtException', (err) => {
  console.log(chalk.red('Uncaught Exception: Shutting down...'));
  console.log('Uncaught Exception: ', err);
  console.log('Uncaught Exception Stack ', err.stack);
  process.exit(1);
});

const workers = [];

const setUpWorkerProcesses = () => {
  // Use chalk to colorize the console
  console.log(chalk.blue(`Master cluster setting up ${cpus().length} workers`));

  // Iterate on CPUs length and create a worker for each CPU
  for (let i = 0; i < cpus().length; i += 1) {
    workers.push(cluster.fork());

    // To receive messages from worker process
    workers[i].on('message', (message) => {
      console.log(message);
    });
  }

  // process is clustered on a core and process id is assigned
  cluster.on('online', (worker) => {
    console.log(`Worker ${worker.process.pid} is listening`);
  });

  // If any of the worker process dies, then start a new one by simply forking another one
  cluster.on('exit', (worker, code, signal) => {
    console.log(
      `Worker ${worker.process.pid} died with code: ${code}, and signal: ${signal}`
    );
    console.log('Starting a new worker');
    cluster.fork();
    workers.push(cluster.fork());
    const newWorker = workers[workers.length - 1];
    newWorker.on('message', (message) => {
      // use chalk
      console.log(
        chalk.bgRed(`Message from worker ${newWorker.process.pid}: ${message}`)
      );
    });
  });
};

const setUpExpress = () => {
  dotenv.config({
    path: './.env',
  });

  const server = app.listen(PORT, () => {
    console.log(chalk.greenBright(`Server is running on port ${PORT}`));
  });

  app.on('error', (appErr) => {
    console.error(chalk.bgRed(`app error: ${appErr.stack}`));
    console.error(chalk.bgRed(`on url: ${appErr.route}`));
    console.error(chalk.bgRed(`with headers: ${appErr.trace}`));
  });

  // Handle unhandled rejections
  process.on('unhandledRejection', (err) => {
    console.log(chalk.bgRed('UNHANDLED REJECTION! 💥 Shutting down...'));
    console.log('unhandledRejection Err::', err);
    console.log('unhandledRejection Stack::', JSON.stringify(err.stack));
    server.close(() => {
      process.exit(1);
    });
  });

  // Handle termination signals
  process.on('SIGTERM', () => {
    console.log(chalk.bgRed('👋 SIGTERM RECEIVED. Shutting down gracefully'));
    server.close(() => {
      console.log(chalk.bgRed('💥 Process terminated'));
      process.exit(0);
    });
  });

  // SIGABRT
  process.on('SIGABRT', () => {
    console.log(chalk.bgRed('👋 SIGABRT RECEIVED. Shutting down gracefully'));
    server.close(() => {
      console.log(chalk.bgRed('💥 Process terminated'));
      process.exit(0);
    });
  });
};
const setupServer = (isClusterRequired) => {
  // if it is a master process then call setting up worker process
  if (isClusterRequired && cluster.isMaster) {
    setUpWorkerProcesses();
  } else {
    //   Setup server config and share port address for incoming requests
    setUpExpress();
  }
};

if (process.env.NODE_ENV === 'production') {
  setupServer(true);
} else {
  setupServer(false);
}
