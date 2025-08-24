const request = require('supertest');

jest.mock('../../src/repositories/user.repository');
// Hoist password handler mock so services use it during app load
jest.mock('../../src/utils/password_handler', () => ({
  comparePassword: jest.fn(async () => true),
  hashPassword: jest.fn(async (x) => `h:${x}`),
  PASSWORD_REGEX: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9\s]).{12,}$/
}));
const repo = require('../../src/repositories/user.repository');

const app = require('../../src/app');
const { generateToken } = require('../../src/utils/jwt');

describe('integration: app routes', () => {
  beforeEach(() => {
    jest.clearAllMocks();
    const pw = require('../../src/utils/password_handler');
    pw.comparePassword.mockResolvedValue(true);
    pw.hashPassword.mockResolvedValue('h:ValidPassword123!');
  });

  it('GET /healthz returns ok', async () => {
    const res = await request(app).get('/healthz');
    expect(res.status).toBe(200);
    expect(res.body).toEqual({ status: 'ok' });
  });

  describe('Auth', () => {
    it('POST /api/v1/auth/register returns 201', async () => {
      repo.getUserByEmail.mockResolvedValue(undefined);
      repo.createUser.mockResolvedValue({ id: 1, email: 'a@example.com', username: 'user' });
      const res = await request(app)
        .post('/api/v1/auth/register')
        .send({ email: 'a@example.com', password: 'ValidPassword123!', username: 'user' });
      expect(res.status).toBe(201);
      expect(res.body).toMatchObject({ data: { id: 1, email: 'a@example.com', username: 'user', token: expect.any(String) } });
    });

    it('POST /api/v1/auth/register returns 400 for invalid email', async () => {
      const res = await request(app)
        .post('/api/v1/auth/register')
        .send({ email: 'invalid-email', password: 'ValidPassword123!', username: 'user' });
      expect(res.status).toBe(400);
      expect(res.body.error).toBe('VALIDATION_ERROR');
      expect(res.body.details).toEqual(
        expect.arrayContaining([
          expect.objectContaining({
            path: 'email',
            message: expect.any(String)
          })
        ])
      );
    });

    it('POST /api/v1/auth/register returns 400 for weak password', async () => {
      const res = await request(app)
        .post('/api/v1/auth/register')
        .send({ email: 'a@example.com', password: 'weak', username: 'user' });
      expect(res.status).toBe(400);
      expect(res.body.error).toBe('VALIDATION_ERROR');
      expect(res.body.details).toEqual(
        expect.arrayContaining([
          expect.objectContaining({
            path: 'password',
            message: expect.any(String)
          })
        ])
      );
    });

    it('POST /api/v1/auth/register returns 400 for password without uppercase', async () => {
      const res = await request(app)
        .post('/api/v1/auth/register')
        .send({ email: 'a@example.com', password: 'validpassword123!', username: 'user' });
      expect(res.status).toBe(400);
      expect(res.body.error).toBe('VALIDATION_ERROR');
      expect(res.body.details).toEqual(
        expect.arrayContaining([
          expect.objectContaining({
            path: 'password',
            message: expect.any(String)
          })
        ])
      );
    });

    it('POST /api/v1/auth/register returns 400 for password without lowercase', async () => {
      const res = await request(app)
        .post('/api/v1/auth/register')
        .send({ email: 'a@example.com', password: 'VALIDPASSWORD123!', username: 'user' });
      expect(res.status).toBe(400);
      expect(res.body.error).toBe('VALIDATION_ERROR');
      expect(res.body.details).toEqual(
        expect.arrayContaining([
          expect.objectContaining({
            path: 'password',
            message: expect.any(String)
          })
        ])
      );
    });

    it('POST /api/v1/auth/register returns 400 for password without special character', async () => {
      const res = await request(app)
        .post('/api/v1/auth/register')
        .send({ email: 'a@example.com', password: 'ValidPassword123', username: 'user' });
      expect(res.status).toBe(400);
      expect(res.body.error).toBe('VALIDATION_ERROR');
      expect(res.body.details).toEqual(
        expect.arrayContaining([
          expect.objectContaining({
            path: 'password',
            message: expect.any(String)
          })
        ])
      );
    });

    it('POST /api/v1/auth/register returns 400 for short username', async () => {
      const res = await request(app)
        .post('/api/v1/auth/register')
        .send({ email: 'a@example.com', password: 'ValidPassword123!', username: 'ab' });
      expect(res.status).toBe(400);
      expect(res.body.error).toBe('VALIDATION_ERROR');
      expect(res.body.details).toEqual(
        expect.arrayContaining([
          expect.objectContaining({
            path: 'username',
            message: expect.any(String)
          })
        ])
      );
    });

    it('POST /api/v1/auth/login returns 200 with token', async () => {
      repo.getUserByEmail.mockResolvedValue({ id: 1, email: 'a@example.com', username: 'u', password: 'h' });
      const res = await request(app)
        .post('/api/v1/auth/login')
        .send({ email: 'a@example.com', password: 'p' });
      expect(res.status).toBe(200);
      expect(res.body.data).toMatchObject({ id: 1, email: 'a@example.com', username: 'u', token: expect.any(String) });
    });

    it('POST /api/v1/auth/login returns 400 for invalid email', async () => {
      const res = await request(app)
        .post('/api/v1/auth/login')
        .send({ email: 'invalid-email', password: 'p' });
      expect(res.status).toBe(400);
      expect(res.body.error).toBe('VALIDATION_ERROR');
      expect(res.body.details).toEqual(
        expect.arrayContaining([
          expect.objectContaining({
            path: 'email',
            message: expect.any(String)
          })
        ])
      );
    });

    it('POST /api/v1/auth/login returns 400 for empty password', async () => {
      const res = await request(app)
        .post('/api/v1/auth/login')
        .send({ email: 'a@example.com', password: '' });
      expect(res.status).toBe(400);
      expect(res.body.error).toBe('VALIDATION_ERROR');
      expect(res.body.details).toEqual(
        expect.arrayContaining([
          expect.objectContaining({
            path: 'password',
            message: expect.any(String)
          })
        ])
      );
    });
  });

  describe('Users', () => {
    const authHeader = () => ({ Authorization: `Bearer ${generateToken({ sub: '1' })}` });

    it('GET /api/v1/users returns list', async () => {
      repo.getUsers.mockResolvedValue([{ id: 1 }]);
      const res = await request(app).get('/api/v1/users').set(authHeader());
      expect(res.status).toBe(200);
      expect(res.body).toEqual({ data: [{ id: 1 }] });
    });

    it('GET /api/v1/users/:id returns user', async () => {
      repo.getUserById.mockResolvedValue({ id: 1 });
      const res = await request(app).get('/api/v1/users/1').set(authHeader());
      expect(res.status).toBe(200);
      expect(res.body).toEqual({ data: { id: 1 } });
    });

    it('POST /api/v1/users creates user', async () => {
      repo.getUserByEmail.mockResolvedValue(undefined);
      repo.createUser.mockResolvedValue({ id: 2, email: 'a@example.com', username: 'user' });
      const res = await request(app)
        .post('/api/v1/users')
        .set(authHeader())
        .send({ email: 'a@example.com', password: 'ValidPassword123!', username: 'user' });
      expect(res.status).toBe(201);
      expect(res.body).toEqual({ data: { id: 2, email: 'a@example.com', username: 'user' } });
    });

    it('POST /api/v1/users returns 400 for invalid data', async () => {
      const res = await request(app)
        .post('/api/v1/users')
        .set(authHeader())
        .send({ email: 'invalid-email', password: 'weak', username: 'ab' });
      expect(res.status).toBe(400);
      expect(res.body.error).toBe('VALIDATION_ERROR');
      expect(res.body.details).toEqual(
        expect.arrayContaining([
          expect.objectContaining({ path: 'email' }),
          expect.objectContaining({ path: 'password' }),
          expect.objectContaining({ path: 'username' })
        ])
      );
    });

    it('PATCH /api/v1/users/:id updates user', async () => {
      repo.updateUser.mockResolvedValue({ id: 1, email: 'b@example.com' });
      const res = await request(app)
        .patch('/api/v1/users/1')
        .set(authHeader())
        .send({ email: 'b@example.com' });
      expect(res.status).toBe(200);
      expect(res.body).toEqual({ data: { id: 1, email: 'b@example.com' } });
    });

    it('PATCH /api/v1/users/:id returns 400 for invalid data', async () => {
      const res = await request(app)
        .patch('/api/v1/users/1')
        .set(authHeader())
        .send({ email: 'invalid-email' });
      expect(res.status).toBe(400);
      expect(res.body.error).toBe('VALIDATION_ERROR');
      expect(res.body.details).toEqual(
        expect.arrayContaining([
          expect.objectContaining({ path: 'email' })
        ])
      );
    });

    it('PATCH /api/v1/users/:id returns 400 for empty update object', async () => {
      const res = await request(app)
        .patch('/api/v1/users/1')
        .set(authHeader())
        .send({});
      expect(res.status).toBe(400);
      expect(res.body.error).toBe('VALIDATION_ERROR');
    });

    it('GET /api/v1/users/:id returns 400 for invalid id', async () => {
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

    it('DELETE /api/v1/users/:id returns 400 for invalid id', async () => {
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

    it('DELETE /api/v1/users/:id deletes user', async () => {
      repo.deleteUser.mockResolvedValue({ message: 'ok' });
      const res = await request(app)
        .delete('/api/v1/users/1')
        .set(authHeader());
      expect(res.status).toBe(204);
      // 204 responses typically have no body; just assert status
    });

    it('401 on users routes without token', async () => {
      const res = await request(app).get('/api/v1/users');
      expect(res.status).toBe(401);
    });
  });

  it('404 handler returns JSON', async () => {
    const token = generateToken({ sub: '1' });
    const res = await request(app).get('/nope').set('Authorization', `Bearer ${token}`);
    expect(res.status).toBe(404);
    expect(res.body).toMatchObject({ error: 'NOT_FOUND' });
  });
}); 