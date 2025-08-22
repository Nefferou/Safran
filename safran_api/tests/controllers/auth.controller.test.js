jest.mock('../../src/services/auth.service');

const authService = require('../../src/services/auth.service');
const controller = require('../../src/controllers/auth.controller');

const makeRes = () => {
  const res = { statusCode: 0 };
  res.status = (c) => { res.statusCode = c; return res; };
  res.json = (b) => { res.body = b; return res; };
  return res;
};

describe('controllers/auth.controller', () => {
  beforeEach(() => {
    jest.resetAllMocks();
  });

  it('register returns 201 with { data } payload', async () => {
    const fakeUser = { id: 1, email: 'a', username: 'u', token: 't' };
    authService.register = jest.fn().mockResolvedValue(fakeUser);

    const req = { body: { email: 'a', password: 'p', username: 'u' } };
    const res = makeRes();

    await controller.register(req, res);

    expect(res.statusCode).toBe(201);
    expect(res.body).toEqual({ data: fakeUser });
    expect(authService.register).toHaveBeenCalledWith({ email: 'a', password: 'p', username: 'u' });
  });

  it('login returns 200 with { data } payload', async () => {
    const fakeResult = { id: 1, email: 'a', username: 'u', token: 't' };
    authService.login.mockResolvedValue(fakeResult);

    const req = { body: { email: 'a', password: 'p' } };
    const res = makeRes();

    await controller.login(req, res);

    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual({ data: fakeResult });
    expect(authService.login).toHaveBeenCalledWith({ email: 'a', password: 'p' });
  });
}); 