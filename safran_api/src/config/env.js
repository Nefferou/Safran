require('dotenv').config();

const env = {
    nodeEnv: process.env.NODE_ENV || 'development',
    port: Number(process.env.PORT || 3000),
    metricsEnabled: String(process.env.METRICS_ENABLED || 'true') === 'true',

    // Database configuration
    dbHost: process.env.DB_HOST || 'localhost',
    dbPort: Number(process.env.DB_PORT || 3306),
    dbUser: process.env.DB_USER || 'root',
    dbPassword: process.env.DB_PASSWORD || '',
    dbName: process.env.DB_NAME || 'safran',
    dbConnLimit: Number(process.env.DB_CONN_LIMIT || 10),
};

module.exports = env;
