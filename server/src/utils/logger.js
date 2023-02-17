import rTracer from 'cls-rtracer';
import { createLogger, format, transports } from 'winston';

const {
  combine, timestamp, label, printf,
} = format;

const myFormat = printf((info) => {
  const rid = rTracer.id();
  return rid
    ? `${info.timestamp} [request-id:${rid}]: ${info.message}`
    : `${info.timestamp}: ${info.message}`;
});

const logger = createLogger({
  format: combine(
    label({ label: 'my-app' }),
    timestamp(),
    myFormat,
  ),
  transports: [
    new transports.Console(),
    new transports.File({ filename: 'error.log', level: 'error' }),
    new transports.File({ filename: 'combined.log' }),
  ],
});

export default logger;
