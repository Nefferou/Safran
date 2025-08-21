const { Router } = require('express');
const users = require('./users.routes');
const auth = require('./auth.routes');

const router = Router();
router.use('/users', users);
router.use('/auth', auth);

module.exports = router;
