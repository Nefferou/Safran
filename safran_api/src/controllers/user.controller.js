const asyncHandler = require('../utils/async_handler');
const userService = require('../services/user.service');

exports.getUsers = asyncHandler(async (req, res) => {
    const users = await userService.getUsers();
    res.status(200).json(users);
});

exports.getUserById = asyncHandler(async (req, res) => {
    const user = await userService.getUserById(req.params.id);
    res.status(200).json(user);
});

exports.createUser = asyncHandler(async (req, res) => {
    const newUser = await userService.createUser(req.body);
    res.status(201).json(newUser);
});

exports.updateUser = asyncHandler(async (req, res) => {
    const updatedUser = await userService.updateUser(req.params.id, req.body);
    res.status(200).json(updatedUser);
});

exports.deleteUser = asyncHandler(async (req, res) => {
    const result = await userService.deleteUser(req.params.id);
    res.status(204).json(result);
});