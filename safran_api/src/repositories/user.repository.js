const { pool } = require('./db');
const HttpError = require("../utils/http_errors");

exports.getUsers = async () => {
    const [rows] = await pool.query('SELECT id, email, username FROM users');
    return rows;
}

exports.getUserById = async (id, withPassword = false ) => {
    const fields = withPassword ? 'id, email, username, password' : 'id, email, username';
    const [rows] = await pool.query(`SELECT ${fields} FROM users WHERE id = ?`, [id]);
    if (rows.length === 0) throw new HttpError(404, 'USER_NOT_FOUND', `User with ID ${id} not found`);
    return rows[0];
}

exports.getUserByEmail = async (email, withPassword = false ) => {
    const fields = withPassword ? 'id, email, username, password' : 'id, email, username';
    const [rows] = await pool.query(`SELECT ${fields} FROM users WHERE email = ?`, [email]);
    return rows[0];
}

exports.createUser = async (userData) => {
    const { email, username, password } = userData;
    if (!email || !username || !password) throw new HttpError(
        400,
        'MISSING_FIELDS',
        'Email, username, and password are required'
    );

    const [result] = await pool.query(
        'INSERT INTO users (email, username, password) VALUES (?, ?, ?)',
        [email, username, password]
    );

    return { id: result.insertId, email, username };
}

exports.updateUser = async (id, userData) => {
    const { email, username, password } = userData;
    if (!email && !username && !password) throw new HttpError(
        400,
        'MISSING_FIELDS',
        'At least one field (email, username, password) must be provided'
    );

    const updates = [];
    const params = [];

    if (email) {
        updates.push('email = ?');
        params.push(email);
    }
    if (username) {
        updates.push('username = ?');
        params.push(username);
    }
    if (password) {
        updates.push('password = ?');
        params.push(password);
    }

    params.push(id);

    const query = `UPDATE users SET ${updates.join(', ')} WHERE id = ?`;
    const [result] = await pool.query(query, params);

    if (result.affectedRows === 0) throw new HttpError(404, 'USER_NOT_FOUND', `User with ID ${id} not found`);

    return { id, email, username };
}

exports.deleteUser = async (id) => {
    const [result] = await pool.query('DELETE FROM users WHERE id = ?', [id]);
    if (result.affectedRows === 0) throw new HttpError(404, 'USER_NOT_FOUND', `User with ID ${id} not found`);
    return { message: `User with ID ${id} deleted successfully` };
}