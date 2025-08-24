const { userCreateBody, userUpdateBody } = require('../../src/schemas/user.schema');

describe('schemas/user.schema', () => {
  describe('userCreateBody', () => {
    it('should validate valid user creation data', () => {
      const validData = {
        email: 'test@example.com',
        username: 'testuser',
        password: 'ValidPassword123!'
      };
      
      const result = userCreateBody.parse(validData);
      expect(result).toEqual(validData);
    });

    it('should reject invalid email', () => {
      const invalidData = {
        email: 'invalid-email',
        username: 'testuser',
        password: 'ValidPassword123!'
      };
      
      expect(() => userCreateBody.parse(invalidData)).toThrow();
    });

    it('should reject weak password', () => {
      const invalidData = {
        email: 'test@example.com',
        username: 'testuser',
        password: 'weak'
      };
      
      expect(() => userCreateBody.parse(invalidData)).toThrow();
    });

    it('should reject extra fields', () => {
      const invalidData = {
        email: 'test@example.com',
        username: 'testuser',
        password: 'ValidPassword123!',
        extra: 'field'
      };
      
      expect(() => userCreateBody.parse(invalidData)).toThrow();
    });
  });

  describe('userUpdateBody', () => {
    it('should validate valid user update data with email only', () => {
      const validData = {
        email: 'newemail@example.com'
      };
      
      const result = userUpdateBody.parse(validData);
      expect(result).toEqual(validData);
    });

    it('should validate valid user update data with username only', () => {
      const validData = {
        username: 'newusername'
      };
      
      const result = userUpdateBody.parse(validData);
      expect(result).toEqual(validData);
    });

    it('should validate valid user update data with password only', () => {
      const validData = {
        password: 'NewValidPassword123!'
      };
      
      const result = userUpdateBody.parse(validData);
      expect(result).toEqual(validData);
    });

    it('should validate valid user update data with multiple fields', () => {
      const validData = {
        email: 'newemail@example.com',
        username: 'newusername',
        password: 'NewValidPassword123!'
      };
      
      const result = userUpdateBody.parse(validData);
      expect(result).toEqual(validData);
    });

    it('should reject empty object', () => {
      const invalidData = {};
      
      expect(() => userUpdateBody.parse(invalidData)).toThrow();
    });

    it('should reject invalid email', () => {
      const invalidData = {
        email: 'invalid-email'
      };
      
      expect(() => userUpdateBody.parse(invalidData)).toThrow();
    });

    it('should reject weak password', () => {
      const invalidData = {
        password: 'weak'
      };
      
      expect(() => userUpdateBody.parse(invalidData)).toThrow();
    });

    it('should reject extra fields', () => {
      const invalidData = {
        email: 'test@example.com',
        extra: 'field'
      };
      
      expect(() => userUpdateBody.parse(invalidData)).toThrow();
    });
  });
});
