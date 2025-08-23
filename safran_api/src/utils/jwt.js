const jwt = require('jsonwebtoken');
const env = require('../config/env');

exports.generateToken = (payload) => {
    return jwt.sign(payload, env.jwtSecret, {
        expiresIn: env.jwtExpiration,
        issuer: env.jwtIssuer,
        audience: env.jwtAudience,
    });
};

exports.verifyToken = (token) => {
    try {
        return jwt.verify(token, env.jwtSecret, {
            issuer: env.jwtIssuer,
            audience: env.jwtAudience,
        });
    } catch (error) {
        throw new Error('Invalid token');
    }
};

