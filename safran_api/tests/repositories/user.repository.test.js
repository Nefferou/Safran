jest.mock('../../src/repositories/db', () => require('../mocks/db'));

const { pool, __reset } = require('../mocks/db');
const repo = require('../../src/repositories/user.repository');
const HttpError = require('../../src/utils/http_errors');

beforeEach(() => {
  __reset();
});

describe('repositories/user.repository', () => {
  it('getUsers returns rows', async () => {
    pool.query.resolves([[{ id: 1 }]]);
    const rows = await repo.getUsers();
    expect(rows).toEqual([{ id: 1 }]);
  });

  it('getUserById returns user', async () => {
    pool.query.resolves([[{ id: 2 }]]);
    const user = await repo.getUserById(2);
    expect(user).toEqual({ id: 2 });
  });

  it('getUserById throws when not found', async () => {
    pool.query.resolves([[]]);
    await expect(repo.getUserById(3)).rejects.toBeInstanceOf(HttpError);
  });

  it('getUserById withPassword=true includes password in SQL', async () => {
    pool.query.resolves([[{ id: 4, email: 'e', username: 'u', password: 'p' }]]);
    const user = await repo.getUserById(4, true);
    expect(user).toEqual({ id: 4, email: 'e', username: 'u', password: 'p' });
    expect(pool.query.getCall(0).args[0]).toMatch(/password/);
  });

  it('getUserByEmail returns first row or undefined', async () => {
    pool.query.resolves([[{ id: 1 }]]);
    await expect(repo.getUserByEmail('a')).resolves.toEqual({ id: 1 });
    pool.query.resolves([[]]);
    await expect(repo.getUserByEmail('b')).resolves.toBeUndefined();
  });

  it('getUserByEmail withPassword=true includes password in SQL', async () => {
    pool.query.resolves([[{ id: 5, email: 'e', username: 'u', password: 'p' }]]);
    const user = await repo.getUserByEmail('e', true);
    expect(user).toEqual({ id: 5, email: 'e', username: 'u', password: 'p' });
    expect(pool.query.getCall(0).args[0]).toMatch(/password/);
  });

  it('createUser validates fields', async () => {
    await expect(repo.createUser({})).rejects.toBeInstanceOf(HttpError);
  });

  it('createUser inserts and returns user', async () => {
    pool.query.resolves([{ insertId: 10 }]);
    const res = await repo.createUser({ email: 'a', username: 'u', password: 'h' });
    expect(res).toEqual({ id: 10, email: 'a', username: 'u' });
  });

  it('updateUser validates fields', async () => {
    await expect(repo.updateUser(1, {})).rejects.toBeInstanceOf(HttpError);
  });

  it('updateUser updates and returns user', async () => {
    pool.query.resolves([{ affectedRows: 1 }]);
    const res = await repo.updateUser(1, { email: 'b' });
    expect(res).toEqual({ id: 1, email: 'b', username: undefined });
  });

  it('updateUser updates username branch', async () => {
    pool.query.resolves([{ affectedRows: 1 }]);
    const res = await repo.updateUser(1, { username: 'newname' });
    expect(res).toEqual({ id: 1, email: undefined, username: 'newname' });
  });

  it('updateUser updates password branch', async () => {
    pool.query.resolves([{ affectedRows: 1 }]);
    const res = await repo.updateUser(1, { password: 'hashed' });
    expect(res).toEqual({ id: 1, email: undefined, username: undefined });
  });

  it('updateUser throws when no rows affected', async () => {
    pool.query.resolves([{ affectedRows: 0 }]);
    await expect(repo.updateUser(999, { email: 'b' })).rejects.toBeInstanceOf(HttpError);
  });

  it('deleteUser deletes or throws', async () => {
    pool.query.resolves([{ affectedRows: 1 }]);
    await expect(repo.deleteUser(1)).resolves.toEqual({ message: 'User with ID 1 deleted successfully' });
    pool.query.resolves([{ affectedRows: 0 }]);
    await expect(repo.deleteUser(2)).rejects.toBeInstanceOf(HttpError);
  });
}); 