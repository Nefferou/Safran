const { hashPassword, comparePassword, PASSWORD_REGEX } = require('../../src/utils/password_handler');
const { invalidPasswordError } = require('../../src/utils/error_constants');

describe('utils/password_handler', () => {
  describe('PASSWORD_REGEX', () => {
    it('should match valid passwords', () => {
      const validPasswords = [
        'ValidPassword123!',
        'StrongPass456@',
        'MySecurePass789#',
        'ComplexPassword1$'
      ];

      validPasswords.forEach(password => {
        expect(password).toMatch(PASSWORD_REGEX);
      });
    });

    it('should not match invalid passwords', () => {
      const invalidPasswords = [
        'weak',                    // Too short, no uppercase, no special char
        'weakpassword',            // No uppercase, no special char
        'WEAKPASSWORD',            // No lowercase, no special char
        'WeakPassword',            // No special char
        'weakpassword123',         // No uppercase, no special char
        'WeakPassword123',         // No special char
        'weakpassword!',           // No uppercase
        'WEAKPASSWORD!',           // No lowercase
        'WeakPass!',               // Too short
        'ValidPassword123',        // No special char
        'ValidPassword!',          // No numbers
        'Valid1!'            // Too short
      ];

      invalidPasswords.forEach(password => {
        expect(password).not.toMatch(PASSWORD_REGEX);
      });
    });
  });

  describe('hashPassword', () => {
    it('should hash valid password', async () => {
      const validPassword = 'ValidPassword123!';
      const hash = await hashPassword(validPassword);
      
      expect(hash).toBeTruthy();
      expect(typeof hash).toBe('string');
      expect(hash.length).toBeGreaterThan(0);
      expect(hash).not.toBe(validPassword);
    });

    it('should throw error for null password', async () => {
      await expect(hashPassword(null)).rejects.toThrow();
      await expect(hashPassword(null)).rejects.toMatchObject({
        status: invalidPasswordError.status,
        code: invalidPasswordError.code,
        message: invalidPasswordError.message
      });
    });

    it('should throw error for undefined password', async () => {
      await expect(hashPassword(undefined)).rejects.toThrow();
      await expect(hashPassword(undefined)).rejects.toMatchObject({
        status: invalidPasswordError.status,
        code: invalidPasswordError.code,
        message: invalidPasswordError.message
      });
    });

    it('should throw error for empty password', async () => {
      await expect(hashPassword('')).rejects.toThrow();
      await expect(hashPassword('')).rejects.toMatchObject({
        status: invalidPasswordError.status,
        code: invalidPasswordError.code,
        message: invalidPasswordError.message
      });
    });

    it('should throw error for weak password without uppercase', async () => {
      await expect(hashPassword('validpassword123!')).rejects.toThrow();
      await expect(hashPassword('validpassword123!')).rejects.toMatchObject({
        status: invalidPasswordError.status,
        code: invalidPasswordError.code,
        message: invalidPasswordError.message
      });
    });

    it('should throw error for weak password without lowercase', async () => {
      await expect(hashPassword('VALIDPASSWORD123!')).rejects.toThrow();
      await expect(hashPassword('VALIDPASSWORD123!')).rejects.toMatchObject({
        status: invalidPasswordError.status,
        code: invalidPasswordError.code,
        message: invalidPasswordError.message
      });
    });

    it('should throw error for weak password without special character', async () => {
      await expect(hashPassword('ValidPassword123')).rejects.toThrow();
      await expect(hashPassword('ValidPassword123')).rejects.toMatchObject({
        status: invalidPasswordError.status,
        code: invalidPasswordError.code,
        message: invalidPasswordError.message
      });
    });

    it('should throw error for short password', async () => {
      await expect(hashPassword('WeakPass!')).rejects.toThrow();
      await expect(hashPassword('WeakPass!')).rejects.toMatchObject({
        status: invalidPasswordError.status,
        code: invalidPasswordError.code,
        message: invalidPasswordError.message
      });
    });

    it('should use bcrypt rounds from env', async () => {
      const validPassword = 'ValidPassword123!';
      const hash = await hashPassword(validPassword);
      
      // Verify it's a bcrypt hash (starts with $2b$)
      expect(hash).toMatch(/^\$2b\$/);
    });
  });

  describe('comparePassword', () => {
    it('should return true for matching password and hash', async () => {
      const password = 'ValidPassword123!';
      const hash = await hashPassword(password);
      
      const result = await comparePassword(password, hash);
      expect(result).toBe(true);
    });

    it('should return false for non-matching password', async () => {
      const password = 'ValidPassword123!';
      const hash = await hashPassword(password);
      
      const result = await comparePassword('WrongPassword123!', hash);
      expect(result).toBe(false);
    });

    it('should return false for empty password', async () => {
      const password = 'ValidPassword123!';
      const hash = await hashPassword(password);
      
      const result = await comparePassword('', hash);
      expect(result).toBe(false);
    });

    it('should handle invalid hash gracefully', async () => {
      const result = await comparePassword('ValidPassword123!', 'invalid_hash');
      expect(result).toBe(false);
    });
  });

  describe('integration', () => {
    it('should hash and compare password correctly', async () => {
      const password = 'ValidPassword123!';
      const hash = await hashPassword(password);
      
      expect(hash).toBeTruthy();
      await expect(comparePassword(password, hash)).resolves.toBe(true);
      await expect(comparePassword('wrong', hash)).resolves.toBe(false);
    });

    it('should work with different valid passwords', async () => {
      const passwords = [
        'ValidPassword123!',
        'StrongPass456@',
        'MySecurePass789#'
      ];

      for (const password of passwords) {
        const hash = await hashPassword(password);
        expect(hash).toBeTruthy();
        await expect(comparePassword(password, hash)).resolves.toBe(true);
        await expect(comparePassword('wrong', hash)).resolves.toBe(false);
      }
    });
  });
}); 