const sinon = require('sinon');

const pool = {
  query: sinon.stub(),
};

module.exports = { pool, __reset: () => pool.query.resetHistory() }; 