const bcrypt = require('bcrypt');
const env = require('../config/env');

exports.hashPassword = async (password) => {
    const saltRounds = env.bcryptRounds;
    return await bcrypt.hash(password, saltRounds);
}

exports.comparePassword = async (password, hash) => {
    return await bcrypt.compare(password, hash);
}