const { generateToken, verifyToken } = require('../../src/utils/jwt');

describe('utils/jwt', () => {
  it('generates and verifies a token', () => {
    const token = generateToken({ sub: '1', email: 'a@b.com', username: 'a' });
    const payload = verifyToken(token);
    expect(payload.sub).toBe('1');
    expect(payload.email).toBe('a@b.com');
    expect(payload.username).toBe('a');
  });

  it('throws on invalid token', () => {
    expect(() => verifyToken('invalid.token.value')).toThrow('Invalid token');
  });
}); 