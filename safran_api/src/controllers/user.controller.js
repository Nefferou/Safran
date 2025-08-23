const asyncHandler = require('../utils/async_handler');
const userService = require('../services/user.service');

exports.getUsers = asyncHandler(async (req, res) => {
    const users = await userService.getUsers();
    res.status(200).json({ data: users });
});

exports.getUserById = asyncHandler(async (req, res) => {
    const user = await userService.getUserById(req.params.id);
    res.status(200).json({ data: user });
});

exports.createUser = asyncHandler(async (req, res) => {
    const newUser = await userService.createUser(req.body);
    res.status(201).json({ data: newUser });
});

exports.updateUser = asyncHandler(async (req, res) => {
    const updatedUser = await userService.updateUser(req.params.id, req.body);
    res.status(200).json({ data: updatedUser });
});

exports.deleteUser = asyncHandler(async (req, res) => {
    await userService.deleteUser(req.params.id);
    res.status(204).end();
});