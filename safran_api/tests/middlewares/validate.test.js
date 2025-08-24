const { z } = require('zod');
const validate = require('../../src/middlewares/validate');

describe('middlewares/validate', () => {
  const mockNext = jest.fn();
  let req;

  beforeEach(() => {
    jest.clearAllMocks();
    req = {
      body: {},
      params: {},
      query: {}
    };
  });

  describe('body validation', () => {
    const bodySchema = z.object({
      email: z.string().email(),
      name: z.string().min(1)
    });

    it('should pass validation for valid body', () => {
      req.body = { email: 'test@example.com', name: 'Test User' };
      
      const middleware = validate({ body: bodySchema });
      middleware(req, {}, mockNext);

      expect(mockNext).toHaveBeenCalledWith();
      expect(req.body).toEqual({ email: 'test@example.com', name: 'Test User' });
    });

    it('should call next with validation error for invalid body', () => {
      req.body = { email: 'invalid-email', name: '' };
      
      const middleware = validate({ body: bodySchema });
      middleware(req, {}, mockNext);

      expect(mockNext).toHaveBeenCalledWith({
        status: 400,
        type: 'validation_error',
        message: 'Invalid request',
        details: expect.arrayContaining([
          expect.objectContaining({
            path: 'email',
            message: expect.any(String),
            code: expect.any(String)
          }),
          expect.objectContaining({
            path: 'name',
            message: expect.any(String),
            code: expect.any(String)
          })
        ])
      });
    });
  });

  describe('params validation', () => {
    const paramsSchema = z.object({
      id: z.coerce.number().int().positive()
    });

    it('should pass validation for valid params', () => {
      req.params = { id: '123' };
      
      const middleware = validate({ params: paramsSchema });
      middleware(req, {}, mockNext);

      expect(mockNext).toHaveBeenCalledWith();
      expect(req.params).toEqual({ id: 123 });
    });

    it('should call next with validation error for invalid params', () => {
      req.params = { id: 'abc' };
      
      const middleware = validate({ params: paramsSchema });
      middleware(req, {}, mockNext);

      expect(mockNext).toHaveBeenCalledWith({
        status: 400,
        type: 'validation_error',
        message: 'Invalid request',
        details: expect.arrayContaining([
          expect.objectContaining({
            path: 'id',
            message: expect.any(String),
            code: expect.any(String)
          })
        ])
      });
    });
  });

  describe('query validation', () => {
    const querySchema = z.object({
      page: z.coerce.number().int().positive().optional(),
      limit: z.coerce.number().int().positive().optional()
    });

    it('should pass validation for valid query', () => {
      req.query = { page: '1', limit: '10' };
      
      const middleware = validate({ query: querySchema });
      middleware(req, {}, mockNext);

      expect(mockNext).toHaveBeenCalledWith();
      expect(req.query).toEqual({ page: 1, limit: 10 });
    });

    it('should call next with validation error for invalid query', () => {
      req.query = { page: '-1', limit: 'abc' };
      
      const middleware = validate({ query: querySchema });
      middleware(req, {}, mockNext);

      expect(mockNext).toHaveBeenCalledWith({
        status: 400,
        type: 'validation_error',
        message: 'Invalid request',
        details: expect.arrayContaining([
          expect.objectContaining({
            path: 'page',
            message: expect.any(String),
            code: expect.any(String)
          }),
          expect.objectContaining({
            path: 'limit',
            message: expect.any(String),
            code: expect.any(String)
          })
        ])
      });
    });
  });

  describe('multiple validations', () => {
    const bodySchema = z.object({ email: z.string().email() });
    const paramsSchema = z.object({ id: z.coerce.number().int().positive() });

    it('should validate both body and params', () => {
      req.body = { email: 'test@example.com' };
      req.params = { id: '123' };
      
      const middleware = validate({ body: bodySchema, params: paramsSchema });
      middleware(req, {}, mockNext);

      expect(mockNext).toHaveBeenCalledWith();
      expect(req.body).toEqual({ email: 'test@example.com' });
      expect(req.params).toEqual({ id: 123 });
    });

    it('should fail if any validation fails', () => {
      req.body = { email: 'invalid-email' };
      req.params = { id: '123' };
      
      const middleware = validate({ body: bodySchema, params: paramsSchema });
      middleware(req, {}, mockNext);

      expect(mockNext).toHaveBeenCalledWith({
        status: 400,
        type: 'validation_error',
        message: 'Invalid request',
        details: expect.arrayContaining([
          expect.objectContaining({
            path: 'email',
            message: expect.any(String),
            code: expect.any(String)
          })
        ])
      });
    });
  });

  describe('non-Zod errors', () => {
    it('should pass through non-Zod errors', () => {
      const customError = new Error('Custom error');
      
      // Mock a schema that throws a non-Zod error
      const bodySchema = {
        parse: jest.fn().mockImplementation(() => {
          throw customError;
        })
      };
      
      const middleware = validate({ body: bodySchema });
      middleware(req, {}, mockNext);

      expect(mockNext).toHaveBeenCalledWith(customError);
    });
  });

  describe('no schemas provided', () => {
    it('should call next without validation', () => {
      const middleware = validate();
      middleware(req, {}, mockNext);

      expect(mockNext).toHaveBeenCalledWith();
    });
  });
});
