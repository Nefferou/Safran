jest.mock('../../src/repositories/user.repository');

const repo = require('../../src/repositories/user.repository');
const service = require('../../src/services/user.service');

jest.mock('../../src/utils/password_handler', () => ({
  hashPassword: jest.fn(async (pw) => `hashed:${pw}`),
}));

beforeEach(() => {
  jest.resetAllMocks();
});

describe('services/user.service', () => {
  it('getUsers proxies to repo', async () => {
    repo.getUsers.mockResolvedValue([{ id: 1 }]);
    const res = await service.getUsers();
    expect(res).toEqual([{ id: 1 }]);
  });

  it('getUserById proxies to repo', async () => {
    repo.getUserById.mockResolvedValue({ id: 1 });
    const res = await service.getUserById(1);
    expect(res).toEqual({ id: 1 });
  });

  it('createUser hashes password and creates user', async () => {
    repo.getUserByEmail.mockResolvedValue(undefined);
    repo.createUser.mockResolvedValue({ id: 2, email: 'a', username: 'u' });
    const res = await service.createUser({ email: 'a', password: 'p', username: 'u' });
    expect(repo.createUser).toHaveBeenCalledWith({ email: 'a', password: 'hashed:p', username: 'u' });
    expect(res).toEqual({ id: 2, email: 'a', username: 'u' });
  });

  it('createUser throws if email exists', async () => {
    repo.getUserByEmail.mockResolvedValue({ id: 1 });
    await expect(service.createUser({ email: 'a', password: 'p', username: 'u' })).rejects.toBeInstanceOf(Error);
  });

  it('updateUser proxies to repo', async () => {
    repo.updateUser.mockResolvedValue({ id: 1, email: 'b' });
    const res = await service.updateUser(1, { email: 'b' });
    expect(res).toEqual({ id: 1, email: 'b' });
  });

  it('deleteUser proxies to repo', async () => {
    repo.deleteUser.mockResolvedValue({ message: 'ok' });
    const res = await service.deleteUser(1);
    expect(res).toEqual({ message: 'ok' });
  });
}); 