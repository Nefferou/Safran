const http = require('http');
const env = require('./config/env');
const app = require('./app');

const server = http.createServer(app);

server.listen(env.port, () => {
    console.log(`[safran] API listening on :${env.port} (${env.nodeEnv})`);
});
