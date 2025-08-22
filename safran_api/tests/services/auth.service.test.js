jest.mock('../../src/repositories/user.repository');
jest.mock('../../src/utils/password_handler');
jest.mock('../../src/utils/jwt');

const repo = require('../../src/repositories/user.repository');
const pw = require('../../src/utils/password_handler');
const jwt = require('../../src/utils/jwt');

// Metrics are mapped to mocks via moduleNameMapper
const { metrics } = require('../../src/instrumentation/metrics');

const service = require('../../src/services/auth.service');
const HttpError = require('../../src/utils/http_errors');

beforeEach(() => {
  jest.resetAllMocks();
});

describe('services/auth.service register', () => {
  it('throws if user exists', async () => {
    repo.getUserByEmail.mockResolvedValue({ id: 1 });
    await expect(service.register({ email: 'a', password: 'p', username: 'u' }))
      .rejects.toBeInstanceOf(HttpError);
  });

  it('creates and returns auth response', async () => {
    repo.getUserByEmail.mockResolvedValue(undefined);
    pw.hashPassword.mockResolvedValue('hashed');
    repo.createUser.mockResolvedValue({ id: 2, email: 'a', username: 'u' });
    jwt.generateToken.mockReturnValue('token');

    const res = await service.register({ email: 'a', password: 'p', username: 'u' });
    expect(res).toEqual({ id: 2, email: 'a', username: 'u', token: 'token' });
  });
});

describe('services/auth.service login', () => {
  it('throws if user not found', async () => {
    repo.getUserByEmail.mockResolvedValue(undefined);
    await expect(service.login({ email: 'a', password: 'p' }))
      .rejects.toBeInstanceOf(HttpError);
  });

  it('throws if password invalid', async () => {
    repo.getUserByEmail.mockResolvedValue({ id: 1, email: 'a', username: 'u', password: 'h' });
    pw.comparePassword.mockResolvedValue(false);
    await expect(service.login({ email: 'a', password: 'p' }))
      .rejects.toBeInstanceOf(HttpError);
  });

  it('returns auth response on success', async () => {
    repo.getUserByEmail.mockResolvedValue({ id: 1, email: 'a', username: 'u', password: 'h' });
    pw.comparePassword.mockResolvedValue(true);
    jwt.generateToken.mockReturnValue('t');
    const res = await service.login({ email: 'a', password: 'p' });
    expect(res).toEqual({ id: 1, email: 'a', username: 'u', token: 't' });
  });
}); 