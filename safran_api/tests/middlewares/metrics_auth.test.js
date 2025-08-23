const metricsAuth = require('../../src/middlewares/metrics_auth');

const makeRes = () => {
  const res = { statusCode: 0 };
  res.status = (c) => { res.statusCode = c; return res; };
  res.send = (b) => { res.body = b; return res; };
  return res;
};

describe('middlewares/metrics_auth', () => {
  it('401 on missing/invalid token', () => {
    const req = { headers: {} };
    const res = makeRes();
    const next = jest.fn();
    metricsAuth(req, res, next);
    expect(res.statusCode).toBe(401);
    expect(res.body).toBe('Unauthorized');
    expect(next).not.toHaveBeenCalled();
  });

  it('passes with correct token', () => {
    const req = { headers: { authorization: 'Bearer metrics_token' } };
    const res = makeRes();
    const next = jest.fn();
    metricsAuth(req, res, next);
    expect(next).toHaveBeenCalled();
  });
}); 