// Simple healthcheck for Docker container
const http = require('http');

const options = {
    hostname: 'localhost',
    port: 3000,
    path: '/',
    timeout: 2000
};

const req = http.get(options, (res) => {
    console.log(`Health check status: ${res.statusCode}`);
    process.exit(res.statusCode === 200 ? 0 : 1);
});

req.on('error', (err) => {
    console.error('Health check failed:', err);
    process.exit(1);
});

req.end();