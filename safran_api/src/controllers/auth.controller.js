const asyncHandler = require('../utils/async_handler');
const authService = require('../services/auth.service');

exports.register = asyncHandler(async (req, res) => {
    const newUser = await authService.register(req.body);
    res.status(201).json({ data: newUser });
});

exports.login = asyncHandler(async (req, res) => {
    const result = await authService.login(req.body);
    res.status(200).json({ data: result });
});