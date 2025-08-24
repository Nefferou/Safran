const { registerBody, loginBody } = require('../../src/schemas/auth.schema');

describe('schemas/auth.schema', () => {
  describe('registerBody', () => {
    it('should validate valid register data', () => {
      const validData = {
        email: 'test@example.com',
        username: 'testuser',
        password: 'ValidPassword123!'
      };
      
      const result = registerBody.parse(validData);
      expect(result).toEqual(validData);
    });

    it('should reject invalid email', () => {
      const invalidData = {
        email: 'invalid-email',
        username: 'testuser',
        password: 'ValidPassword123!'
      };
      
      expect(() => registerBody.parse(invalidData)).toThrow();
    });

    it('should reject short username', () => {
      const invalidData = {
        email: 'test@example.com',
        username: 'ab',
        password: 'ValidPassword123!'
      };
      
      expect(() => registerBody.parse(invalidData)).toThrow();
    });

    it('should reject long username', () => {
      const invalidData = {
        email: 'test@example.com',
        username: 'a'.repeat(33),
        password: 'ValidPassword123!'
      };
      
      expect(() => registerBody.parse(invalidData)).toThrow();
    });

    it('should reject weak password', () => {
      const invalidData = {
        email: 'test@example.com',
        username: 'testuser',
        password: 'weak'
      };
      
      expect(() => registerBody.parse(invalidData)).toThrow();
    });

    it('should reject password without uppercase', () => {
      const invalidData = {
        email: 'test@example.com',
        username: 'testuser',
        password: 'validpassword123!'
      };
      
      expect(() => registerBody.parse(invalidData)).toThrow();
    });

    it('should reject password without lowercase', () => {
      const invalidData = {
        email: 'test@example.com',
        username: 'testuser',
        password: 'VALIDPASSWORD123!'
      };
      
      expect(() => registerBody.parse(invalidData)).toThrow();
    });

    it('should reject password without special character', () => {
      const invalidData = {
        email: 'test@example.com',
        username: 'testuser',
        password: 'ValidPassword123'
      };
      
      expect(() => registerBody.parse(invalidData)).toThrow();
    });

    it('should reject extra fields', () => {
      const invalidData = {
        email: 'test@example.com',
        username: 'testuser',
        password: 'ValidPassword123!',
        extra: 'field'
      };
      
      expect(() => registerBody.parse(invalidData)).toThrow();
    });
  });

  describe('loginBody', () => {
    it('should validate valid login data', () => {
      const validData = {
        email: 'test@example.com',
        password: 'anypassword'
      };
      
      const result = loginBody.parse(validData);
      expect(result).toEqual(validData);
    });

    it('should reject invalid email', () => {
      const invalidData = {
        email: 'invalid-email',
        password: 'anypassword'
      };
      
      expect(() => loginBody.parse(invalidData)).toThrow();
    });

    it('should reject empty password', () => {
      const invalidData = {
        email: 'test@example.com',
        password: ''
      };
      
      expect(() => loginBody.parse(invalidData)).toThrow();
    });

    it('should reject extra fields', () => {
      const invalidData = {
        email: 'test@example.com',
        password: 'anypassword',
        extra: 'field'
      };
      
      expect(() => loginBody.parse(invalidData)).toThrow();
    });
  });
});
