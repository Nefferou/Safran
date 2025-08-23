const bcrypt = require('bcrypt');
const env = require('../config/env');
const HttpError = require('./http_errors');
const { invalidPasswordError } = require('./error_constants');

exports.PASSWORD_REGEX = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[^A-Za-z0-9]).{12,}$/;

exports.hashPassword = async (password) => {
    if (!password || !password.match(PASSWORD_REGEX)) {
        throw new HttpError(invalidPasswordError.status, invalidPasswordError.code, invalidPasswordError.message);
    }
    const saltRounds = env.bcryptRounds;
    return await bcrypt.hash(password, saltRounds);
}

exports.comparePassword = async (password, hash) => {
    return await bcrypt.compare(password, hash);
}