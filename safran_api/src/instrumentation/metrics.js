const client = require('prom-client');
const { Router } = require('express');

client.collectDefaultMetrics();

//
// HTTP metrics
//
const httpRequestDuration = new client.Histogram({
    name: 'http_request_duration_ms',
    help: 'Durée des requêtes HTTP en millisecondes',
    labelNames: ['method', 'route', 'status_code'],
    buckets: [5, 15, 50, 100, 250, 500, 1000, 2500, 5000] // ms
});

const httpRequestsTotal = new client.Counter({
    name: 'http_requests_total',
    help: 'Total des requêtes HTTP',
    labelNames: ['method', 'route', 'status_code']
});

const httpRequestsInFlight = new client.Gauge({
    name: 'http_requests_in_flight',
    help: 'Nombre de requêtes HTTP en cours'
});

//
// Business metrics (auth/users)
//
const usersCreatedTotal = new client.Counter({
    name: 'users_created_total',
    help: 'Nombre de comptes créés (via routes /users)'
});

const usersRegisteredTotal = new client.Counter({
    name: 'users_registered_total',
    help: 'Nombre d’inscriptions (via /auth/register)'
});

const usersLoginAttemptsTotal = new client.Counter({
    name: 'users_login_attempts_total',
    help: 'Tentatives de connexion'
});

const usersLoginSuccessTotal = new client.Counter({
    name: 'users_login_success_total',
    help: 'Connexions réussies'
});

const usersLoginFailureTotal = new client.Counter({
    name: 'users_login_failure_total',
    help: 'Connexions échouées'
});

const metricsMiddleware = (req, res, next) => {
    const start = Date.now();
    httpRequestsInFlight.inc();

    res.on('finish', () => {
        const duration = Date.now() - start;
        httpRequestDuration.observe({
            method: req.method,
            route: req.route ? req.route.path : req.originalUrl,
            status_code: res.statusCode
        }, duration);
        httpRequestsTotal.inc({
            method: req.method,
            route: req.route ? req.route.path : req.originalUrl,
            status_code: res.statusCode
        });
        httpRequestsInFlight.dec();
    });

    next();
};

const metricsRouter = Router();
metricsRouter.get('/', async (_req, res) => {
    res.set('Content-Type', client.register.contentType);
    res.send(await client.register.metrics());
});

module.exports = {
    metricsRouter,
    metricsMiddleware,
    metrics: {
        usersLoginAttemptsTotal,
        usersLoginSuccessTotal,
        usersLoginFailureTotal,
        usersCreatedTotal,
        usersRegisteredTotal
    }
};