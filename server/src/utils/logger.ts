import rTracer from 'cls-rtracer';
import { createLogger, format, transports } from 'winston';
const { combine, timestamp, label, printf } = format;

const myFormat = printf(({ level, message, label, timestamp }) => {
    const rid = rTracer.id();
    return `${timestamp} [${label}] ${rid} ${level}: ${message}`;
});

const logger = createLogger({
    format: combine(
        label({ label: 'my-app' }),
        timestamp(),
        myFormat
    ),
    transports: [
        new transports.Console(),
        new transports.File({ filename: 'error.log', level: 'error' }),
        new transports.File({ filename: 'combined.log' })
    ]
});


export default logger;