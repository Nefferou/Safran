require('dotenv').config();

const env = {
    nodeEnv: process.env.NODE_ENV || 'development',
    port: Number(process.env.PORT || 3000),
    metricsEnabled: String(process.env.METRICS_ENABLED || 'true') === 'true',
    swaggerEnabled: String(process.env.SWAGGER_ENABLED || 'true') === 'true',

    // Database configuration
    dbHost: process.env.DB_HOST || 'localhost',
    dbPort: Number(process.env.DB_PORT || 3306),
    dbUser: process.env.DB_USER || 'root',
    dbPassword: process.env.DB_PASSWORD || '',
    dbName: process.env.DB_NAME || 'safran',
    dbConnLimit: Number(process.env.DB_CONN_LIMIT || 10),

    // JWT configuration
    bcryptRounds: Number(process.env.BCRYPT_ROUNDS || 10),
    jwtSecret: process.env.JWT_SECRET|| 'default_secret',
    jwtExpiration: process.env.JWT_EXPIRATION || '1h',
    jwtIssuer: process.env.JWT_ISSUER || 'safran_api',
    jwtAudience: process.env.JWT_AUDIENCE || 'safran_users',

    // Metrics
    metricsToken: process.env.METRICS_TOKEN || 'metrics_token',
};

module.exports = env;
