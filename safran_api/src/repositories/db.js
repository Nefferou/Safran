const mysql = require('mysql2/promise');
const env = require('../config/env');

const pool = mysql.createPool({
    host: env.dbHost,
    port: env.dbPort,
    user: env.dbUser,
    password: env.dbPassword,
    database: env.dbName,
    waitForConnections: true,
    connectionLimit: env.dbConnLimit,
    queueLimit: 0,
    namedPlaceholders: true
});

module.exports = { pool };
