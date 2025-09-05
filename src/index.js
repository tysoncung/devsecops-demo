const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const crypto = require('crypto');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// VULNERABILITY 1: Hardcoded credentials (will be detected by secret scanning)
const API_KEY = 'sk-1234567890abcdef';
const DB_PASSWORD = 'admin123';
const AWS_SECRET = 'AKIAIOSFODNN7EXAMPLE';

// VULNERABILITY 2: SQL Injection vulnerability
app.get('/user', (req, res) => {
    const userId = req.query.id;
    // Vulnerable to SQL injection
    const query = `SELECT * FROM users WHERE id = ${userId}`;
    console.log('Executing query:', query);
    res.send({ message: 'User query executed', query });
});

// VULNERABILITY 3: Command Injection
app.post('/ping', (req, res) => {
    const { host } = req.body;
    // Vulnerable to command injection
    const exec = require('child_process').exec;
    exec(`ping -c 4 ${host}`, (error, stdout, stderr) => {
        res.send({ output: stdout });
    });
});

// VULNERABILITY 4: Path Traversal
app.get('/file', (req, res) => {
    const filename = req.query.name;
    // Vulnerable to path traversal
    const filepath = path.join(__dirname, 'files', filename);
    fs.readFile(filepath, 'utf8', (err, data) => {
        if (err) {
            res.status(404).send('File not found');
        } else {
            res.send(data);
        }
    });
});

// VULNERABILITY 5: Weak Cryptography
app.post('/hash', (req, res) => {
    const { password } = req.body;
    // Using weak MD5 hash
    const hash = crypto.createHash('md5').update(password).digest('hex');
    res.send({ hash });
});

// VULNERABILITY 6: Missing Security Headers
app.get('/', (req, res) => {
    res.send('<h1>DevSecOps Demo App</h1><script>alert("XSS")</script>');
});

// VULNERABILITY 7: Eval usage (code injection)
app.post('/calculate', (req, res) => {
    const { expression } = req.body;
    // Dangerous eval usage
    try {
        const result = eval(expression);
        res.send({ result });
    } catch (error) {
        res.status(400).send({ error: 'Invalid expression' });
    }
});

// VULNERABILITY 8: NoSQL Injection (if using MongoDB)
app.post('/login', (req, res) => {
    const { username, password } = req.body;
    // Vulnerable to NoSQL injection if not sanitized
    const query = { username, password };
    res.send({ message: 'Login attempted', query });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});