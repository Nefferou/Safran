const path = require('path');

const loadEnvModule = (overrides = {}) => {
  const saved = { ...process.env };
  const keys = [
    'NODE_ENV','PORT','METRICS_ENABLED','SWAGGER_ENABLED',
    'DB_HOST','DB_PORT','DB_USER','DB_PASSWORD','DB_NAME','DB_CONN_LIMIT',
    'BCRYPT_ROUNDS','JWT_SECRET','JWT_EXPIRATION','JWT_ISSUER','JWT_AUDIENCE',
    'METRICS_TOKEN'
  ];
  keys.forEach(k => delete process.env[k]);
  Object.assign(process.env, overrides);

  let mod;
  jest.isolateModules(() => {
    jest.doMock('dotenv', () => ({ config: jest.fn(() => ({})) }));
    mod = require('../../src/config/env');
  });

  Object.assign(process.env, saved);
  return mod;
};

describe('config/env', () => {
  it('loads defaults when env vars are not set', () => {
    const env = loadEnvModule({});
    expect(env.nodeEnv).toBe('development');
    expect(env.port).toBe(3000);
    expect(env.metricsEnabled).toBe(true);
    expect(env.swaggerEnabled).toBe(true);
    expect(env.dbHost).toBe('localhost');
    expect(env.dbPort).toBe(3306);
    expect(env.dbUser).toBe('root');
    expect(env.dbPassword).toBe('');
    expect(env.dbName).toBe('safran');
    expect(env.dbConnLimit).toBe(10);
    expect(env.bcryptRounds).toBe(10);
    expect(env.jwtSecret).toBe('default_secret');
    expect(env.jwtExpiration).toBe('1h');
    expect(env.jwtIssuer).toBe('safran_api');
    expect(env.jwtAudience).toBe('safran_users');
    expect(env.metricsToken).toBe('metrics_token');
  });

  it('loads provided env vars correctly and coerces types', () => {
    const env = loadEnvModule({
      NODE_ENV: 'test',
      PORT: '8080',
      METRICS_ENABLED: 'false',
      SWAGGER_ENABLED: 'false',
      DB_HOST: 'db',
      DB_PORT: '1234',
      DB_USER: 'u',
      DB_PASSWORD: 'p',
      DB_NAME: 'dbn',
      DB_CONN_LIMIT: '3',
      BCRYPT_ROUNDS: '5',
      JWT_SECRET: 's',
      JWT_EXPIRATION: '2h',
      JWT_ISSUER: 'iss',
      JWT_AUDIENCE: 'aud',
      METRICS_TOKEN: 'mt',
    });
    expect(env.nodeEnv).toBe('test');
    expect(env.port).toBe(8080);
    expect(env.metricsEnabled).toBe(false);
    expect(env.swaggerEnabled).toBe(false);
    expect(env.dbHost).toBe('db');
    expect(env.dbPort).toBe(1234);
    expect(env.dbUser).toBe('u');
    expect(env.dbPassword).toBe('p');
    expect(env.dbName).toBe('dbn');
    expect(env.dbConnLimit).toBe(3);
    expect(env.bcryptRounds).toBe(5);
    expect(env.jwtSecret).toBe('s');
    expect(env.jwtExpiration).toBe('2h');
    expect(env.jwtIssuer).toBe('iss');
    expect(env.jwtAudience).toBe('aud');
    expect(env.metricsToken).toBe('mt');
  });
}); 