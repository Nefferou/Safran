process.env.NODE_ENV = 'test';
process.env.JWT_SECRET = 'test_secret';
process.env.JWT_ISSUER = 'test_issuer';
process.env.JWT_AUDIENCE = 'test_audience';
process.env.JWT_EXPIRATION = '1h';
process.env.BCRYPT_ROUNDS = '1';
process.env.METRICS_ENABLED = 'false';
process.env.SWAGGER_ENABLED = 'false';
process.env.METRICS_TOKEN = 'metrics_token';
process.env.DB_HOST = 'localhost';
process.env.DB_USER = 'root';
process.env.DB_PASSWORD = '';
process.env.DB_NAME = 'test_db';
process.env.DB_PORT = '3306';
process.env.DB_CONN_LIMIT = '1';

// Bruteforce configuration for tests
process.env.LOGIN_BRUTE_WINDOW_MS = '900000'; // 15 minutes
process.env.LOGIN_BRUTE_THRESHOLD = '5';
process.env.LOGIN_BRUTE_BASE_DELAY_MS = '1000';
process.env.LOGIN_BRUTE_MAX_DELAY_MS = '60000';
process.env.LOGIN_BRUTE_BAN_MS = '900000'; // 15 minutes 