const express = require('express');
const cors = require('cors');
const routes = require('./routes');
const authRoutes = require('./routes/v1/auth.routes');
const notFound = require('./middlewares/not_found');
const errorHandler = require('./middlewares/error_handler');
const authJwt = require('./middlewares/auth_jwt');
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

// API v1 routes
app.use('/api/v1/auth', authRoutes);
app.use(authJwt);
app.use('/api', routes);

// 404 & Error Handling
app.use(notFound);
app.use(errorHandler);

module.exports = app;
