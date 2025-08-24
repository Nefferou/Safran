const request = require('supertest');

jest.mock('../../src/repositories/user.repository');
// Hoist password handler mock so services use it during app load
jest.mock('../../src/utils/password_handler', () => ({
  comparePassword: jest.fn(async () => true),
  hashPassword: jest.fn(async (x) => `h:${x}`),
  PASSWORD_REGEX: /^(?=.*[a-z])(?=.*[A-Z])(?=.*[^A-Za-z0-9]).{12,}$/
}));
const repo = require('../../src/repositories/user.repository');

const app = require('../../src/app');
const { generateToken } = require('../../src/utils/jwt');

describe('integration: validation', () => {
  beforeEach(() => {
    jest.clearAllMocks();
    const pw = require('../../src/utils/password_handler');
    pw.comparePassword.mockResolvedValue(true);
    pw.hashPassword.mockResolvedValue('h:ValidPassword123!');
  });

  describe('Auth validation', () => {
    describe('POST /api/v1/auth/register', () => {
      it('should accept valid registration data', async () => {
        repo.getUserByEmail.mockResolvedValue(undefined);
        repo.createUser.mockResolvedValue({ id: 1, email: 'test@example.com', username: 'testuser' });
        
        const res = await request(app)
          .post('/api/v1/auth/register')
          .send({
            email: 'test@example.com',
            username: 'testuser',
            password: 'ValidPassword123!'
          });
        
        expect(res.status).toBe(201);
        expect(res.body.data).toMatchObject({
          id: 1,
          email: 'test@example.com',
          username: 'testuser',
          token: expect.any(String)
        });
      });

      it('should reject invalid email format', async () => {
        const res = await request(app)
          .post('/api/v1/auth/register')
          .send({
            email: 'invalid-email',
            username: 'testuser',
            password: 'ValidPassword123!'
          });
        
        expect(res.status).toBe(400);
        expect(res.body.error).toBe('VALIDATION_ERROR');
                 expect(res.body.details).toEqual(
           expect.arrayContaining([
             expect.objectContaining({
               path: 'email'
             })
           ])
         );
      });

       it('should reject weak password', async () => {
         const res = await request(app)
           .post('/api/v1/auth/register')
           .send({
             email: 'test@example.com',
             username: 'testuser',
             password: 'weak'
           });
         
         expect(res.status).toBe(400);
         expect(res.body.error).toBe('VALIDATION_ERROR');
         expect(res.body.details).toEqual(
           expect.arrayContaining([
             expect.objectContaining({
               path: 'password'
             })
           ])
         );
       });

       it('should reject password without uppercase', async () => {
         const res = await request(app)
           .post('/api/v1/auth/register')
           .send({
             email: 'test@example.com',
             username: 'testuser',
             password: 'validpassword123!'
           });
         
         expect(res.status).toBe(400);
         expect(res.body.error).toBe('VALIDATION_ERROR');
         expect(res.body.details).toEqual(
           expect.arrayContaining([
             expect.objectContaining({
               path: 'password'
             })
           ])
         );
       });

       it('should reject password without lowercase', async () => {
         const res = await request(app)
           .post('/api/v1/auth/register')
           .send({
             email: 'test@example.com',
             username: 'testuser',
             password: 'VALIDPASSWORD123!'
           });
         
         expect(res.status).toBe(400);
         expect(res.body.error).toBe('VALIDATION_ERROR');
         expect(res.body.details).toEqual(
           expect.arrayContaining([
             expect.objectContaining({
               path: 'password'
             })
           ])
         );
       });

       it('should reject password without special character', async () => {
         const res = await request(app)
           .post('/api/v1/auth/register')
           .send({
             email: 'test@example.com',
             username: 'testuser',
             password: 'ValidPassword123'
           });
         
         expect(res.status).toBe(400);
         expect(res.body.error).toBe('VALIDATION_ERROR');
         expect(res.body.details).toEqual(
           expect.arrayContaining([
             expect.objectContaining({
               path: 'password'
             })
           ])
         );
       });

      it('should reject short username', async () => {
        const res = await request(app)
          .post('/api/v1/auth/register')
          .send({
            email: 'test@example.com',
            username: 'ab',
            password: 'ValidPassword123!'
          });
        
        expect(res.status).toBe(400);
        expect(res.body.error).toBe('VALIDATION_ERROR');
                 expect(res.body.details).toEqual(
           expect.arrayContaining([
             expect.objectContaining({
               path: 'username'
             })
           ])
         );
      });

      it('should reject long username', async () => {
        const res = await request(app)
          .post('/api/v1/auth/register')
          .send({
            email: 'test@example.com',
            username: 'a'.repeat(33),
            password: 'ValidPassword123!'
          });
        
        expect(res.status).toBe(400);
        expect(res.body.error).toBe('VALIDATION_ERROR');
                 expect(res.body.details).toEqual(
           expect.arrayContaining([
             expect.objectContaining({
               path: 'username'
             })
           ])
         );
      });

      it('should reject extra fields', async () => {
        const res = await request(app)
          .post('/api/v1/auth/register')
          .send({
            email: 'test@example.com',
            username: 'testuser',
            password: 'ValidPassword123!',
            extra: 'field'
          });
        
        expect(res.status).toBe(400);
        expect(res.body.error).toBe('VALIDATION_ERROR');
                 expect(res.body.details).toEqual(
           expect.arrayContaining([
             expect.objectContaining({
               path: ''
             })
           ])
         );
      });
    });

    describe('POST /api/v1/auth/login', () => {
      it('should accept valid login data', async () => {
        repo.getUserByEmail.mockResolvedValue({ 
          id: 1, 
          email: 'test@example.com', 
          username: 'testuser', 
          password: 'hashed' 
        });
        
        const res = await request(app)
          .post('/api/v1/auth/login')
          .send({
            email: 'test@example.com',
            password: 'anypassword'
          });
        
        expect(res.status).toBe(200);
        expect(res.body.data).toMatchObject({
          id: 1,
          email: 'test@example.com',
          username: 'testuser',
          token: expect.any(String)
        });
      });

      it('should reject empty password', async () => {
        const res = await request(app)
          .post('/api/v1/auth/login')
          .send({
            email: 'test@example.com',
            password: ''
          });
        
        expect(res.status).toBe(400);
        expect(res.body.error).toBe('VALIDATION_ERROR');
                 expect(res.body.details).toEqual(
           expect.arrayContaining([
             expect.objectContaining({
               path: 'password'
             })
           ])
         );
      });
    });
  });

  describe('User validation', () => {
    const authHeader = () => ({ Authorization: `Bearer ${generateToken({ sub: '1' })}` });

    describe('POST /api/v1/users', () => {
      it('should accept valid user creation data', async () => {
        repo.getUserByEmail.mockResolvedValue(undefined);
        repo.createUser.mockResolvedValue({ id: 2, email: 'new@example.com', username: 'newuser' });
        
        const res = await request(app)
          .post('/api/v1/users')
          .set(authHeader())
          .send({
            email: 'new@example.com',
            username: 'newuser',
            password: 'ValidPassword123!'
          });
        
        expect(res.status).toBe(201);
        expect(res.body.data).toMatchObject({
          id: 2,
          email: 'new@example.com',
          username: 'newuser'
        });
      });

      it('should reject invalid user data', async () => {
        const res = await request(app)
          .post('/api/v1/users')
          .set(authHeader())
          .send({
            email: 'invalid-email',
            username: 'ab',
            password: 'weak'
          });
        
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
      it('should accept valid update data', async () => {
        repo.updateUser.mockResolvedValue({ id: 1, email: 'updated@example.com' });
        
        const res = await request(app)
          .patch('/api/v1/users/1')
          .set(authHeader())
          .send({
            email: 'updated@example.com'
          });
        
        expect(res.status).toBe(200);
        expect(res.body.data).toMatchObject({
          id: 1,
          email: 'updated@example.com'
        });
      });

      it('should reject empty update object', async () => {
        const res = await request(app)
          .patch('/api/v1/users/1')
          .set(authHeader())
          .send({});
        
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

      it('should accept partial updates', async () => {
        repo.updateUser.mockResolvedValue({ id: 1, username: 'newusername' });
        
        const res = await request(app)
          .patch('/api/v1/users/1')
          .set(authHeader())
          .send({
            username: 'newusername'
          });
        
        expect(res.status).toBe(200);
        expect(res.body.data).toMatchObject({
          id: 1,
          username: 'newusername'
        });
      });
    });

    describe('GET /api/v1/users/:id', () => {
      it('should accept valid numeric id', async () => {
        repo.getUserById.mockResolvedValue({ id: 1, email: 'test@example.com' });
        
        const res = await request(app)
          .get('/api/v1/users/1')
          .set(authHeader());
        
        expect(res.status).toBe(200);
        expect(res.body.data).toMatchObject({
          id: 1,
          email: 'test@example.com'
        });
      });

      it('should reject non-numeric id', async () => {
        const res = await request(app)
          .get('/api/v1/users/abc')
          .set(authHeader());
        
        expect(res.status).toBe(400);
        expect(res.body.error).toBe('VALIDATION_ERROR');
                 expect(res.body.details).toEqual(
           expect.arrayContaining([
             expect.objectContaining({
               path: 'id'
             })
           ])
         );
      });

      it('should reject negative id', async () => {
        const res = await request(app)
          .get('/api/v1/users/-1')
          .set(authHeader());
        
        expect(res.status).toBe(400);
        expect(res.body.error).toBe('VALIDATION_ERROR');
        expect(res.body.details).toEqual(
          expect.arrayContaining([
            expect.objectContaining({
              path: 'id',
              message: expect.stringContaining('>0')
            })
          ])
        );
      });

      it('should reject zero id', async () => {
        const res = await request(app)
          .get('/api/v1/users/0')
          .set(authHeader());
        
        expect(res.status).toBe(400);
        expect(res.body.error).toBe('VALIDATION_ERROR');
        expect(res.body.details).toEqual(
          expect.arrayContaining([
            expect.objectContaining({
              path: 'id',
              message: expect.stringContaining('>0')
            })
          ])
        );
      });
    });
  });
});
