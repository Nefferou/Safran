jest.mock('../../src/services/user.service');

const userService = require('../../src/services/user.service');
const controller = require('../../src/controllers/user.controller');

const makeRes = () => {
  const res = { statusCode: 0, body: undefined, headersSent: false };
  res.status = (c) => { res.statusCode = c; return res; };
  res.json = (b) => { res.body = b; res.headersSent = true; return res; };
  res.send = (b) => { res.body = b; res.headersSent = true; return res; };
  res.end = () => { res.headersSent = true; return res; };
  res.sendStatus = (c) => { res.statusCode = c; res.headersSent = true; return res; };
  return res;
};

describe('controllers/user.controller', () => {
  beforeEach(() => {
    jest.resetAllMocks();
  });

  it('getUsers returns 200 with users list', async () => {
    const fakeUsers = [{ id: 1, email: 'a@example.com', username: 'u' }];
    userService.getUsers = jest.fn().mockResolvedValue(fakeUsers);

    const req = {};
    const res = makeRes();

    await controller.getUsers(req, res);

    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual({ data: fakeUsers });
    expect(userService.getUsers).toHaveBeenCalled();
  });

  it('getUserById returns 200 with user', async () => {
    const fakeUser = { id: 1, email: 'a@example.com', username: 'u' };
    userService.getUserById = jest.fn().mockResolvedValue(fakeUser);

    const req = { params: { id: 1 } };
    const res = makeRes();

    await controller.getUserById(req, res);

    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual({ data: fakeUser });
    expect(userService.getUserById).toHaveBeenCalledWith(1);
  });

  it('createUser returns 201 with created user', async () => {
    const fakeUser = { id: 2, email: 'a@example.com', username: 'u' };
    userService.createUser = jest.fn().mockResolvedValue(fakeUser);

    const req = { 
      body: { 
        email: 'a@example.com', 
        password: 'ValidPassword123!', 
        username: 'u' 
      } 
    };
    const res = makeRes();

    await controller.createUser(req, res);

    expect(res.statusCode).toBe(201);
    expect(res.body).toEqual({ data: fakeUser });
    expect(userService.createUser).toHaveBeenCalledWith({ 
      email: 'a@example.com', 
      password: 'ValidPassword123!', 
      username: 'u' 
    });
  });

  it('updateUser returns 200 with updated user', async () => {
    const fakeUser = { id: 1, email: 'b@example.com', username: 'u' };
    userService.updateUser = jest.fn().mockResolvedValue(fakeUser);

    const req = { 
      params: { id: 1 }, 
      body: { email: 'b@example.com' } 
    };
    const res = makeRes();

    await controller.updateUser(req, res);

    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual({ data: fakeUser });
    expect(userService.updateUser).toHaveBeenCalledWith(1, { email: 'b@example.com' });
  });

  it('deleteUser returns 204', async () => {
    userService.deleteUser = jest.fn().mockResolvedValue({ message: 'ok' });

    const req = { params: { id: 1 } };
    const res = makeRes();

    await controller.deleteUser(req, res);

    expect(res.statusCode).toBe(204);
    expect(userService.deleteUser).toHaveBeenCalledWith(1);
  });
});
