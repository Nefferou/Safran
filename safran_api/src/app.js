const express = require('express');
const cors = require('cors');
const routes = require('./routes');
const notFound = require('./middlewares/not_found');
const errorHandler = require('./middlewares/error_handler');
const env = require('./config/env');
const { metricsRouter } = require('./instrumentation/metrics');

const app = express();

app.use(express.json());
app.use(cors());

// Metrics
if (env.metricsEnabled) {
    app.use('/metrics', metricsRouter);
}

// Health
app.get('/healthz', (req, res) => res.status(200).json({ status: 'ok' }));

// API v1
app.use('/api', routes);

// 404 & Error Handling
app.use(notFound);
app.use(errorHandler);

module.exports = app;
