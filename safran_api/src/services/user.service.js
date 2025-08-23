const repo = require('../repositories/user.repository');
const HttpError = require("../utils/http_errors");
const { metrics } = require('../instrumentation/metrics');
const {userExistsError} = require("../utils/error_constants");

exports.getUsers = async () => await repo.getUsers();

exports.getUserById = async (id) => await repo.getUserById(id);

exports.createUser = async (userData) => {
    const existing = await repo.getUserByEmail(userData.email);
    if (existing) throw new HttpError(userExistsError.status, userExistsError.code, userExistsError.message);
    const {hashPassword} = require('../utils/password_handler');
    userData.password = await hashPassword(userData.password);
    metrics.usersCreatedTotal.inc();
    return await repo.createUser(userData);
}

exports.updateUser = async (id, userData) => await repo.updateUser(id, userData);

exports.deleteUser = async (id) => await repo.deleteUser(id);