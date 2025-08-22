const authJwt = require('../../src/middlewares/auth_jwt');
const { generateToken } = require('../../src/utils/jwt');

const makeRes = () => {
  const res = { statusCode: 0 };
  res.status = (c) => { res.statusCode = c; return res; };
  res.json = (b) => { res.body = b; return res; };
  return res;
};

describe('middlewares/auth_jwt', () => {
  it('returns 401 when missing header', () => {
    const req = { headers: {} };
    const res = makeRes();
    const next = jest.fn();
    authJwt(req, res, next);
    expect(res.statusCode).toBe(401);
    expect(res.body).toEqual({ error: 'Unauthorized' });
    expect(next).not.toHaveBeenCalled();
  });

  it('returns 401 when invalid token', () => {
    const req = { headers: { authorization: 'Bearer invalid' } };
    const res = makeRes();
    const next = jest.fn();
    authJwt(req, res, next);
    expect(res.statusCode).toBe(401);
    expect(res.body).toEqual({ error: 'Invalid token' });
    expect(next).not.toHaveBeenCalled();
  });

  it('calls next when valid token', () => {
    const token = generateToken({ sub: '1' });
    const req = { headers: { authorization: `Bearer ${token}` } };
    const res = makeRes();
    const next = jest.fn();
    authJwt(req, res, next);
    expect(res.statusCode).toBe(0);
    expect(req.user.sub).toBe('1');
    expect(next).toHaveBeenCalled();
  });
}); 