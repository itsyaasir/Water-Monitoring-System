export const successResponse = (_req, res, data, code = 200) => {
  res.status(code).send({
    code,
    data,
    success: true,
  });
};

export const errorResponse = (
  _req,
  res,
  error = {},
  message = 'Something went wrong',
  code = 500,
) => {
  res.status(code).json({
    code,
    message,
    error,
    success: false,
    data: null,
  });
};
