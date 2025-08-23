const request = require('supertest');

const withEnvApp = async (overrides = {}) => {
  const saved = { ...process.env };
  Object.assign(process.env, { METRICS_ENABLED: 'true', SWAGGER_ENABLED: 'true', METRICS_TOKEN: 'metrics_token', ...overrides });
  jest.resetModules();
  // Mock swagger-ui-express to a lightweight handler
  jest.doMock('swagger-ui-express', () => ({
    serve: (req, _res, next) => next(),
    setup: () => (req, res) => res.status(200).send('swagger-ok'),
  }));
  // Mock docs/swagger to avoid heavy generation
  jest.doMock('../src/docs/swagger', () => ({ swaggerSpec: {} }), { virtual: true });
  const app = require('../src/app');
  Object.assign(process.env, saved);
  return app;
};

describe('app feature flags: metrics and swagger', () => {
  it('enables /metrics and metrics middleware when METRICS_ENABLED=true', async () => {
    const app = await withEnvApp({ METRICS_ENABLED: 'true' });
    const resUnauthorized = await request(app).get('/metrics');
    expect(resUnauthorized.status).toBe(401);
    const res = await request(app).get('/metrics').set('Authorization', 'Bearer metrics_token');
    expect(res.status).toBe(200);
  });

  it('enables /api-docs when SWAGGER_ENABLED=true', async () => {
    const app = await withEnvApp({ SWAGGER_ENABLED: 'true' });
    const res = await request(app).get('/api-docs');
    // our mocked swagger returns 200 with body 'swagger-ok'
    expect(res.status).toBe(200);
    expect(res.text).toBe('swagger-ok');
  });
}); 