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

  it('login returns 200 with { result } payload', async () => {
    const fakeResult = { id: 1, email: 'a', username: 'u', token: 't' };
    authService.login.mockResolvedValue(fakeResult);

    const req = { body: { email: 'a', password: 'p' } };
    const res = makeRes();

    await controller.login(req, res);

    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual({ result: fakeResult });
    expect(authService.login).toHaveBeenCalledWith({ email: 'a', password: 'p' });
  });
}); 