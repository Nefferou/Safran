const repo = require('../repositories/user.repository');

exports.getUsers = async () => await repo.getUsers();

exports.getUserById = async (id) => {
    const existing = await repo.getUserById(id);
    if (!existing) throw new Error('User not found');
    return existing;
}

exports.createUser = async (userData) => {
    const existing = await repo.getUserByEmail(userData.email);
    if (existing) throw new Error('User with this email already exists');
    return await repo.createUser(userData);
}

exports.updateUser = async (id, userData) => {
    const updated = await repo.updateUser(id, userData);
    if (!updated) throw new Error('User not found');
    return updated;
}

exports.deleteUser = async (id) => {
    const ok = await repo.deleteUser(id);
    if (!ok) throw new Error('User not found');
}