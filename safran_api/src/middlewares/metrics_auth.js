const env = require('../config/env');

module.exports = function metricsAuth(req, res, next) {
    const token = env.metricsToken;

    const h = req.headers.authorization || '';
    const [scheme, value] = h.split(' ');
    if (scheme === 'Bearer' && value === token) return next();
    return res.status(401).send('Unauthorized');
};
