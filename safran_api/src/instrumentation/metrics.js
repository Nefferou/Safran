const client = require('prom-client');
const { Router } = require('express');

client.collectDefaultMetrics();

// TODO: Add custom metrics here

const metricsRouter = Router();
metricsRouter.get('/', async (_req, res) => {
    res.set('Content-Type', client.register.contentType);
    res.send(await client.register.metrics());
});

module.exports = { metricsRouter };