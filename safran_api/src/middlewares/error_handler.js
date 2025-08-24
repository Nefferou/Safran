module.exports = (err, req, res, _next) => {
    req.log?.error({ err, traceId: req.id }, 'Unhandled error');

    if (err.type === 'validation_error') {
        return res.status(400).json({
            error: 'VALIDATION_ERROR',
            message: err.message,
            details: err.details,
            traceId: req.id
        });
    }

    const status = err.status || 500;
    res.status(status).json({
        error: err.code || 'INTERNAL_ERROR',
        message: err.publicMessage || 'Unexpected error',
        traceId: req.id
    });
};
