const { hashPassword, comparePassword } = require('../../src/utils/password_handler');

describe('utils/password_handler', () => {
  it('hashes and compares password', async () => {
    const pw = 'secret';
    const hash = await hashPassword(pw);
    expect(hash).toBeTruthy();
    await expect(comparePassword(pw, hash)).resolves.toBe(true);
    await expect(comparePassword('wrong', hash)).resolves.toBe(false);
  });
}); 