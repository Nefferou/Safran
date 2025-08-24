const HttpError = require('../../src/utils/http_errors');

describe('utils/http_errors', () => {
  it('sets status, code, and publicMessage', () => {
    const err = new HttpError(400, 'BAD', 'Bad');
    expect(err).toBeInstanceOf(Error);
    expect(err.status).toBe(400);
    expect(err.code).toBe('BAD');
    expect(err.publicMessage).toBe('Bad');
    expect(err.message).toBe('Bad');
  });
}); 