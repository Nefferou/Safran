const { ZodError } = require('zod');

module.exports = function validate(schemas = {}) {
  return (req, _res, next) => {
    try {
      if (schemas.params) req.params = schemas.params.parse(req.params);
      if (schemas.query)  req.query  = schemas.query.parse(req.query);
      if (schemas.body)   req.body   = schemas.body.parse(req.body);
      next();
    } catch (err) {
      if (err instanceof ZodError) {
        const details = err.issues.map(i => ({
          path: i.path.join('.'),
          message: i.message,
          code: i.code
        }));
        return next({ status: 400, type: 'validation_error', message: 'Invalid request', details });
      }
      next(err);
    }
  };
};
