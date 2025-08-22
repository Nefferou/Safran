const repo = require('../repositories/user.repository');
const { hashPassword, comparePassword } = require('../utils/password_handler');
const HttpError = require("../utils/http_errors");
const { generateToken } = require("../utils/jwt");
const { metrics } = require('../instrumentation/metrics');
const {userExistsError, invalidCredentialsError} = require("../utils/error_constants");

const authResponse = (user) => {
    const token = generateToken({ sub: String(user.id), email: user.email, username: user.username });
    return {
        id: user.id,
        email: user.email,
        username: user.username,
        token
    };
}

exports.register = async (userData) => {
    const { email, password, username } = userData;

    const existingUser = await repo.getUserByEmail(email);
    if (existingUser) {
        throw new HttpError(userExistsError.status, userExistsError.code, userExistsError.message);
    }

    const hashedPassword = await hashPassword(password);

    const newUser = await repo.createUser({email, password: hashedPassword, username});

    metrics.usersRegisteredTotal.inc();
    return authResponse(newUser);
}

exports.login = async (userData) => {
    const { email, password } = userData;
    metrics.usersLoginAttemptsTotal.inc();

    const user = await repo.getUserByEmail(email, true);
    if (!user) {
        metrics.usersLoginFailureTotal.inc();
        throw new HttpError(invalidCredentialsError.status, invalidCredentialsError.code, invalidCredentialsError.message);
    }

    const isPasswordValid = await comparePassword(password, user.password);
    if (!isPasswordValid) {
        metrics.usersLoginFailureTotal.inc();
        throw new HttpError(invalidCredentialsError.status, invalidCredentialsError.code, invalidCredentialsError.message);
    }

    metrics.usersLoginSuccessTotal.inc();
    return authResponse(user);
}