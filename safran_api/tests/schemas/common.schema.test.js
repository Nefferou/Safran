const { 
  passwordSchema, 
  emailSchema, 
  usernameSchema, 
  idParamSchema, 
  emailParamSchema 
} = require('../../src/schemas/common.schema');

describe('schemas/common.schema', () => {
  describe('passwordSchema', () => {
    it('should validate strong password', () => {
      const validPassword = 'ValidPassword123!';
      const result = passwordSchema.parse(validPassword);
      expect(result).toBe(validPassword);
    });

    it('should reject password shorter than 12 characters', () => {
      expect(() => passwordSchema.parse('Short123!')).toThrow();
    });

    it('should reject password without lowercase', () => {
      expect(() => passwordSchema.parse('VALIDPASSWORD123!')).toThrow();
    });

    it('should reject password without uppercase', () => {
      expect(() => passwordSchema.parse('validpassword123!')).toThrow();
    });

    it('should reject password without special character', () => {
      expect(() => passwordSchema.parse('ValidPassword123')).toThrow();
    });

    it('should reject password without number', () => {
      expect(() => passwordSchema.parse('ValidPassword!')).toThrow();
    });

    it('should reject password with only letters and numbers', () => {
      expect(() => passwordSchema.parse('ValidPassword123')).toThrow();
    });
  });

  describe('emailSchema', () => {
    it('should validate valid email', () => {
      const validEmail = 'test@example.com';
      const result = emailSchema.parse(validEmail);
      expect(result).toBe(validEmail);
    });

    it('should validate email with subdomain', () => {
      const validEmail = 'test@sub.example.com';
      const result = emailSchema.parse(validEmail);
      expect(result).toBe(validEmail);
    });

    it('should reject invalid email format', () => {
      expect(() => emailSchema.parse('invalid-email')).toThrow();
    });

    it('should reject email without @', () => {
      expect(() => emailSchema.parse('testexample.com')).toThrow();
    });

    it('should reject email without domain', () => {
      expect(() => emailSchema.parse('test@')).toThrow();
    });
  });

  describe('usernameSchema', () => {
    it('should validate username with 3 characters', () => {
      const validUsername = 'abc';
      const result = usernameSchema.parse(validUsername);
      expect(result).toBe(validUsername);
    });

    it('should validate username with 32 characters', () => {
      const validUsername = 'a'.repeat(32);
      const result = usernameSchema.parse(validUsername);
      expect(result).toBe(validUsername);
    });

    it('should reject username shorter than 3 characters', () => {
      expect(() => usernameSchema.parse('ab')).toThrow();
    });

    it('should reject username longer than 32 characters', () => {
      expect(() => usernameSchema.parse('a'.repeat(33))).toThrow();
    });
  });

  describe('idParamSchema', () => {
    it('should validate positive integer id', () => {
      const validId = { id: 1 };
      const result = idParamSchema.parse(validId);
      expect(result).toEqual(validId);
    });

    it('should coerce string to number', () => {
      const validId = { id: '123' };
      const result = idParamSchema.parse(validId);
      expect(result).toEqual({ id: 123 });
    });

    it('should reject zero', () => {
      expect(() => idParamSchema.parse({ id: 0 })).toThrow();
    });

    it('should reject negative number', () => {
      expect(() => idParamSchema.parse({ id: -1 })).toThrow();
    });

    it('should reject decimal number', () => {
      expect(() => idParamSchema.parse({ id: 1.5 })).toThrow();
    });

    it('should reject non-numeric string', () => {
      expect(() => idParamSchema.parse({ id: 'abc' })).toThrow();
    });
  });

  describe('emailParamSchema', () => {
    it('should validate valid email parameter', () => {
      const validEmail = { email: 'test@example.com' };
      const result = emailParamSchema.parse(validEmail);
      expect(result).toEqual(validEmail);
    });

    it('should reject invalid email parameter', () => {
      expect(() => emailParamSchema.parse({ email: 'invalid-email' })).toThrow();
    });
  });
});
