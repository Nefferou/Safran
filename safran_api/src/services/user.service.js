const repo = require('../repositories/user.repository');

exports.getUsers = async () => await repo.getUsers();

exports.getUserById = async (id) => await repo.getUserById(id);

exports.createUser = async (userData) => {
    const existing = await repo.getUserByEmail(userData.email);
    if (existing) throw new Error('User with this email already exists');
    return await repo.createUser(userData);
}

exports.updateUser = async (id, userData) => await repo.updateUser(id, userData);

exports.deleteUser = async (id) => await repo.deleteUser(id);