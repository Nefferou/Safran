require('dotenv').config();

const env = {
    nodeEnv: process.env.NODE_ENV || 'development',
    port: Number(process.env.PORT || 3000),
    metricsEnabled: String(process.env.METRICS_ENABLED || 'true') === 'true'
};

module.exports = env;
