const request = require('supertest');
const { registerBody, loginBody } = require('../../src/schemas/auth.schema');
const { userCreateBody, userUpdateBody } = require('../../src/schemas/user.schema');
const { idParamSchema } = require('../../src/schemas/common.schema');

// Mock the app without database dependencies
jest.mock('../../src/repositories/user.repository');
jest.mock('../../src/utils/password_handler', () => ({
  comparePassword: jest.fn(async () => true),
  hashPassword: jest.fn(async (x) => `h:${x}`),
}));

const app = require('../../src/app');
const { generateToken } = require('../../src/utils/jwt');

describe('middlewares/validate: integration', () => {
  const authHeader = () => ({ Authorization: `Bearer ${generateToken({ sub: '1' })}` });

  describe('Auth routes validation', () => {
    describe('POST /api/v1/auth/register', () => {
      it('should validate with registerBody schema', async () => {
        // Test that the route uses the correct schema
        const validData = {
          email: 'test@example.com',
          username: 'testuser',
          password: 'ValidPassword123!'
        };

        // Verify the schema works independently
        const parsed = registerBody.parse(validData);
        expect(parsed).toEqual(validData);

        // Test that the route accepts the same data
        const res = await request(app)
          .post('/api/v1/auth/register')
          .send(validData);

        // Should pass validation (even if other errors occur)
        expect(res.status).not.toBe(400);
        expect(res.body.error).not.toBe('VALIDATION_ERROR');
      });

      it('should reject data that fails registerBody schema', async () => {
        const invalidData = {
          email: 'invalid-email',
          username: 'ab',
          password: 'weak'
        };

        // Verify the schema rejects the data
        expect(() => registerBody.parse(invalidData)).toThrow();

        // Test that the route rejects the same data
        const res = await request(app)
          .post('/api/v1/auth/register')
          .send(invalidData);

        expect(res.status).toBe(400);
        expect(res.body.error).toBe('VALIDATION_ERROR');
        expect(res.body.details).toEqual(
          expect.arrayContaining([
            expect.objectContaining({ path: 'email' }),
            expect.objectContaining({ path: 'username' }),
            expect.objectContaining({ path: 'password' })
          ])
        );
      });
    });

    describe('POST /api/v1/auth/login', () => {
      it('should validate with loginBody schema', async () => {
        const validData = {
          email: 'test@example.com',
          password: 'anypassword'
        };

        // Verify the schema works independently
        const parsed = loginBody.parse(validData);
        expect(parsed).toEqual(validData);

        // Test that the route accepts the same data
        const res = await request(app)
          .post('/api/v1/auth/login')
          .send(validData);

        // Should pass validation (even if other errors occur)
        expect(res.status).not.toBe(400);
        expect(res.body.error).not.toBe('VALIDATION_ERROR');
      });

      it('should reject data that fails loginBody schema', async () => {
        const invalidData = {
          email: 'invalid-email',
          password: ''
        };

        // Verify the schema rejects the data
        expect(() => loginBody.parse(invalidData)).toThrow();

        // Test that the route rejects the same data
        const res = await request(app)
          .post('/api/v1/auth/login')
          .send(invalidData);

        expect(res.status).toBe(400);
        expect(res.body.error).toBe('VALIDATION_ERROR');
        expect(res.body.details).toEqual(
          expect.arrayContaining([
            expect.objectContaining({ path: 'email' }),
            expect.objectContaining({ path: 'password' })
          ])
        );
      });
    });
  });

  describe('User routes validation', () => {
    describe('POST /api/v1/users', () => {
      it('should validate with userCreateBody schema', async () => {
        const validData = {
          email: 'test@example.com',
          username: 'testuser',
          password: 'ValidPassword123!'
        };

        // Verify the schema works independently
        const parsed = userCreateBody.parse(validData);
        expect(parsed).toEqual(validData);

        // Test that the route accepts the same data
        const res = await request(app)
          .post('/api/v1/users')
          .set(authHeader())
          .send(validData);

        // Should pass validation (even if other errors occur)
        expect(res.status).not.toBe(400);
        expect(res.body.error).not.toBe('VALIDATION_ERROR');
      });

      it('should reject data that fails userCreateBody schema', async () => {
        const invalidData = {
          email: 'invalid-email',
          username: 'ab',
          password: 'weak'
        };

        // Verify the schema rejects the data
        expect(() => userCreateBody.parse(invalidData)).toThrow();

        // Test that the route rejects the same data
        const res = await request(app)
          .post('/api/v1/users')
          .set(authHeader())
          .send(invalidData);

        expect(res.status).toBe(400);
        expect(res.body.error).toBe('VALIDATION_ERROR');
        expect(res.body.details).toEqual(
          expect.arrayContaining([
            expect.objectContaining({ path: 'email' }),
            expect.objectContaining({ path: 'username' }),
            expect.objectContaining({ path: 'password' })
          ])
        );
      });
    });

    describe('PATCH /api/v1/users/:id', () => {
      it('should validate body with userUpdateBody schema', async () => {
        const validData = {
          email: 'updated@example.com'
        };

        // Verify the schema works independently
        const parsed = userUpdateBody.parse(validData);
        expect(parsed).toEqual(validData);

        // Test that the route accepts the same data
        const res = await request(app)
          .patch('/api/v1/users/1')
          .set(authHeader())
          .send(validData);

        // Should pass validation (even if other errors occur)
        expect(res.status).not.toBe(400);
        expect(res.body.error).not.toBe('VALIDATION_ERROR');
      });

      it('should validate params with idParamSchema', async () => {
        const validParams = { id: 1 };

        // Verify the schema works independently
        const parsed = idParamSchema.parse(validParams);
        expect(parsed).toEqual(validParams);

        // Test that the route accepts the same params
        const res = await request(app)
          .patch('/api/v1/users/1')
          .set(authHeader())
          .send({ email: 'test@example.com' });

        // Should pass validation (even if other errors occur)
        expect(res.status).not.toBe(400);
        expect(res.body.error).not.toBe('VALIDATION_ERROR');
      });

      it('should reject invalid params', async () => {
        const invalidParams = { id: 'abc' };

        // Verify the schema rejects the data
        expect(() => idParamSchema.parse(invalidParams)).toThrow();

        // Test that the route rejects the same data
        const res = await request(app)
          .patch('/api/v1/users/abc')
          .set(authHeader())
          .send({ email: 'test@example.com' });

        expect(res.status).toBe(400);
        expect(res.body.error).toBe('VALIDATION_ERROR');
        expect(res.body.details).toEqual(
          expect.arrayContaining([
            expect.objectContaining({ path: 'id' })
          ])
        );
      });

      it('should reject empty update object', async () => {
        const invalidData = {};

        // Verify the schema rejects the data
        expect(() => userUpdateBody.parse(invalidData)).toThrow();

        // Test that the route rejects the same data
        const res = await request(app)
          .patch('/api/v1/users/1')
          .set(authHeader())
          .send(invalidData);

        expect(res.status).toBe(400);
        expect(res.body.error).toBe('VALIDATION_ERROR');
        expect(res.body.details).toEqual(
          expect.arrayContaining([
            expect.objectContaining({
              message: expect.stringContaining('At least one field must be provided')
            })
          ])
        );
      });
    });

    describe('GET /api/v1/users/:id', () => {
      it('should validate params with idParamSchema', async () => {
        const validParams = { id: 1 };

        // Verify the schema works independently
        const parsed = idParamSchema.parse(validParams);
        expect(parsed).toEqual(validParams);

        // Test that the route accepts the same params
        const res = await request(app)
          .get('/api/v1/users/1')
          .set(authHeader());

        // Should pass validation (even if other errors occur)
        expect(res.status).not.toBe(400);
        expect(res.body.error).not.toBe('VALIDATION_ERROR');
      });

      it('should reject invalid params', async () => {
        const invalidParams = { id: 'abc' };

        // Verify the schema rejects the data
        expect(() => idParamSchema.parse(invalidParams)).toThrow();

        // Test that the route rejects the same data
        const res = await request(app)
          .get('/api/v1/users/abc')
          .set(authHeader());

        expect(res.status).toBe(400);
        expect(res.body.error).toBe('VALIDATION_ERROR');
        expect(res.body.details).toEqual(
          expect.arrayContaining([
            expect.objectContaining({ path: 'id' })
          ])
        );
      });
    });

    describe('DELETE /api/v1/users/:id', () => {
      it('should validate params with idParamSchema', async () => {
        const validParams = { id: 1 };

        // Verify the schema works independently
        const parsed = idParamSchema.parse(validParams);
        expect(parsed).toEqual(validParams);

        // Test that the route accepts the same params
        const res = await request(app)
          .delete('/api/v1/users/1')
          .set(authHeader());

        // Should pass validation (even if other errors occur)
        expect(res.status).not.toBe(400);
        expect(res.body.error).not.toBe('VALIDATION_ERROR');
      });

      it('should reject invalid params', async () => {
        const invalidParams = { id: 'abc' };

        // Verify the schema rejects the data
        expect(() => idParamSchema.parse(invalidParams)).toThrow();

        // Test that the route rejects the same data
        const res = await request(app)
          .delete('/api/v1/users/abc')
          .set(authHeader());

        expect(res.status).toBe(400);
        expect(res.body.error).toBe('VALIDATION_ERROR');
        expect(res.body.details).toEqual(
          expect.arrayContaining([
            expect.objectContaining({ path: 'id' })
          ])
        );
      });
    });
  });
});
