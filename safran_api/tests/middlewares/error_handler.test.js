const errorHandler = require('../../src/middlewares/error_handler');

const makeRes = () => {
  const res = { statusCode: 0 };
  res.status = (c) => { res.statusCode = c; return res; };
  res.json = (b) => { res.body = b; return res; };
  return res;
};

describe('middlewares/error_handler', () => {
  it('formats known HttpError', () => {
    const err = { status: 400, code: 'BAD', publicMessage: 'Bad' };
    const req = {};
    const res = makeRes();
    errorHandler(err, req, res);
    expect(res.statusCode).toBe(400);
    expect(res.body.error).toBe('BAD');
    expect(res.body.message).toBe('Bad');
  });

  it('defaults to 500 and INTERNAL_ERROR', () => {
    const err = {};
    const req = {};
    const res = makeRes();
    errorHandler(err, req, res);
    expect(res.statusCode).toBe(500);
    expect(res.body.error).toBe('INTERNAL_ERROR');
    expect(res.body.message).toBe('Unexpected error');
  });
}); 