module.exports = (err, req, res, _next) => {
    req.log?.error({ err, traceId: req.id }, 'Unhandled error');
    const status = err.status || 500;
    res.status(status).json({
        error: err.code || 'INTERNAL_ERROR',
        message: err.publicMessage || 'Unexpected error',
        traceId: req.id
    });
};
