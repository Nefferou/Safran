module.exports = (req, res, _next) => {
    res.status(404).json({ error: 'NOT_FOUND', path: req.originalUrl });
};
