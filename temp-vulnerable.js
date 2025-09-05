// New vulnerable code with multiple security issues
const stripe_key = 'sk_live_1234567890abcdef';  // Hardcoded secret
const admin_password = 'admin123';               // Weak password

// SQL Injection vulnerability
function getUser(id) {
    const query = `SELECT * FROM users WHERE id = ${id}`;
    return db.query(query);
}

// Command injection
const { exec } = require('child_process');
function runCommand(userInput) {
    exec(`ls ${userInput}`);  // Dangerous!
}

module.exports = { getUser, runCommand };
