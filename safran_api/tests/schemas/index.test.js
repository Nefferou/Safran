const authSchemas = require('../../src/schemas/auth.schema');
const userSchemas = require('../../src/schemas/user.schema');
const commonSchemas = require('../../src/schemas/common.schema');

describe('schemas: exports', () => {
  describe('auth.schema', () => {
    it('should export registerBody schema', () => {
      expect(authSchemas.registerBody).toBeDefined();
      expect(typeof authSchemas.registerBody.parse).toBe('function');
    });

    it('should export loginBody schema', () => {
      expect(authSchemas.loginBody).toBeDefined();
      expect(typeof authSchemas.loginBody.parse).toBe('function');
    });
  });

  describe('user.schema', () => {
    it('should export userCreateBody schema', () => {
      expect(userSchemas.userCreateBody).toBeDefined();
      expect(typeof userSchemas.userCreateBody.parse).toBe('function');
    });

    it('should export userUpdateBody schema', () => {
      expect(userSchemas.userUpdateBody).toBeDefined();
      expect(typeof userSchemas.userUpdateBody.parse).toBe('function');
    });
  });

  describe('common.schema', () => {
    it('should export passwordSchema', () => {
      expect(commonSchemas.passwordSchema).toBeDefined();
      expect(typeof commonSchemas.passwordSchema.parse).toBe('function');
    });

    it('should export emailSchema', () => {
      expect(commonSchemas.emailSchema).toBeDefined();
      expect(typeof commonSchemas.emailSchema.parse).toBe('function');
    });

    it('should export usernameSchema', () => {
      expect(commonSchemas.usernameSchema).toBeDefined();
      expect(typeof commonSchemas.usernameSchema.parse).toBe('function');
    });

    it('should export idParamSchema', () => {
      expect(commonSchemas.idParamSchema).toBeDefined();
      expect(typeof commonSchemas.idParamSchema.parse).toBe('function');
    });

    it('should export emailParamSchema', () => {
      expect(commonSchemas.emailParamSchema).toBeDefined();
      expect(typeof commonSchemas.emailParamSchema.parse).toBe('function');
    });
  });

  describe('schema consistency', () => {
    it('should use same password validation across schemas', () => {
      const validPassword = 'ValidPassword123!';
      const invalidPassword = 'weak';

      // All schemas should accept the same valid password
      expect(() => authSchemas.registerBody.parse({ 
        email: 'test@example.com', 
        username: 'testuser', 
        password: validPassword 
      })).not.toThrow();

      expect(() => userSchemas.userCreateBody.parse({ 
        email: 'test@example.com', 
        username: 'testuser', 
        password: validPassword 
      })).not.toThrow();

      // All schemas should reject the same invalid password
      expect(() => authSchemas.registerBody.parse({ 
        email: 'test@example.com', 
        username: 'testuser', 
        password: invalidPassword 
      })).toThrow();

      expect(() => userSchemas.userCreateBody.parse({ 
        email: 'test@example.com', 
        username: 'testuser', 
        password: invalidPassword 
      })).toThrow();
    });

    it('should use same email validation across schemas', () => {
      const validEmail = 'test@example.com';
      const invalidEmail = 'invalid-email';

      // All schemas should accept the same valid email
      expect(() => authSchemas.registerBody.parse({ 
        email: validEmail, 
        username: 'testuser', 
        password: 'ValidPassword123!' 
      })).not.toThrow();

      expect(() => userSchemas.userCreateBody.parse({ 
        email: validEmail, 
        username: 'testuser', 
        password: 'ValidPassword123!' 
      })).not.toThrow();

      // All schemas should reject the same invalid email
      expect(() => authSchemas.registerBody.parse({ 
        email: invalidEmail, 
        username: 'testuser', 
        password: 'ValidPassword123!' 
      })).toThrow();

      expect(() => userSchemas.userCreateBody.parse({ 
        email: invalidEmail, 
        username: 'testuser', 
        password: 'ValidPassword123!' 
      })).toThrow();
    });

    it('should use same username validation across schemas', () => {
      const validUsername = 'testuser';
      const invalidUsername = 'ab';

      // All schemas should accept the same valid username
      expect(() => authSchemas.registerBody.parse({ 
        email: 'test@example.com', 
        username: validUsername, 
        password: 'ValidPassword123!' 
      })).not.toThrow();

      expect(() => userSchemas.userCreateBody.parse({ 
        email: 'test@example.com', 
        username: validUsername, 
        password: 'ValidPassword123!' 
      })).not.toThrow();

      // All schemas should reject the same invalid username
      expect(() => authSchemas.registerBody.parse({ 
        email: 'test@example.com', 
        username: invalidUsername, 
        password: 'ValidPassword123!' 
      })).toThrow();

      expect(() => userSchemas.userCreateBody.parse({ 
        email: 'test@example.com', 
        username: invalidUsername, 
        password: 'ValidPassword123!' 
      })).toThrow();
    });
  });
});
