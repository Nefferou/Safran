const repo = require('../repositories/user.repository');
const { hashPassword, comparePassword } = require('../utils/password_handler');
const HttpError = require("../utils/http_errors");
const { generateToken } = require("../utils/jwt");

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
        throw new HttpError(400, 'USER_EXISTS', 'User with this email already exists');
    }

    const hashedPassword = await hashPassword(password);

    const newUser = await repo.createUser({email, password: hashedPassword, username});

    return authResponse(newUser);
}

exports.login = async (userData) => {
    const { email, password } = userData;

    const user = await repo.getUserByEmail(email, true);
    if (!user) {
        throw new HttpError(401, 'INVALID_CREDENTIALS', 'Invalid email or password');
    }

    const isPasswordValid = await comparePassword(password, user.password);
    if (!isPasswordValid) {
        throw new HttpError(401, 'INVALID_CREDENTIALS', 'Invalid email or password');
    }

    return authResponse(user);
}