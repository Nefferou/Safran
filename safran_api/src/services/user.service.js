const repo = require('../repositories/user.repository');
const HttpError = require("../utils/http_errors");

exports.getUsers = async () => await repo.getUsers();

exports.getUserById = async (id) => await repo.getUserById(id);

exports.createUser = async (userData) => {
    const existing = await repo.getUserByEmail(userData.email);
    if (existing) throw new HttpError(400, 'USER_EXISTS', 'User with this email already exists');
    const {hashPassword} = require('../utils/password_handler');
    userData.password = await hashPassword(userData.password);
    return await repo.createUser(userData);
}

exports.updateUser = async (id, userData) => await repo.updateUser(id, userData);

exports.deleteUser = async (id) => await repo.deleteUser(id);