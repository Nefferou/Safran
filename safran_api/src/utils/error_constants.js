const userExistsError = { code: 'USER_EXISTS', message: 'User already exists', status: 400 };
const invalidCredentialsError = { code: 'INVALID_CREDENTIALS', message: 'Invalid email or password', status: 401 };
const userNotFoundError = { code: 'USER_NOT_FOUND', message: 'User not found', status: 404 };
const missingFieldsError = { code: 'MISSING_FIELDS', message: 'Required fields are missing', status: 400 };

module.exports = {
    userExistsError,
    invalidCredentialsError,
    userNotFoundError,
    missingFieldsError
}