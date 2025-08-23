const { verifyToken } = require('../utils/jwt');

module.exports = (req, res, next) => {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({ error: 'Unauthorized' });
    }

    const token = authHeader.split(' ')[1];

    try {
        req.user = verifyToken(token);
        next();
    } catch (error) {
        return res.status(401).json({ error: 'Invalid token' });
    }
}