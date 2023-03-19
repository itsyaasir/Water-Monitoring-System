import { errorResponse } from '../utils';

/// Error handler middleware, handles all errors thrown in the application
const errorHandler = (err, req, res) => {
  if (err && err.name === 'ValidationError') {
    let messages = err.details.body.map((e) => e.message);
    if (messages.length && messages.length > 1) {
      messages = `${messages.join(', ')} are required fields`;
    } else {
      messages = `${messages.join(', ')} is required field`;
    }
    return errorResponse(req, res, messages, 400);
  }
  return errorResponse(req, res, err.message, 500);
};

export default errorHandler;
