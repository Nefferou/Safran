const notFound = require('../../src/middlewares/not_found');

const makeRes = () => {
  const res = { statusCode: 0 };
  res.status = (c) => { res.statusCode = c; return res; };
  res.json = (b) => { res.body = b; return res; };
  return res;
};

describe('middlewares/not_found', () => {
  it('returns 404 with path', () => {
    const req = { originalUrl: '/x' };
    const res = makeRes();
    notFound(req, res);
    expect(res.statusCode).toBe(404);
    expect(res.body).toEqual({ error: 'NOT_FOUND', path: '/x' });
  });
}); 