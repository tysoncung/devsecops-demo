// Demo ESLint configuration - shows warnings instead of errors for demo purposes
module.exports = {
    env: {
        browser: true,
        es2021: true,
        node: true
    },
    extends: [
        'eslint:recommended'
    ],
    plugins: [
        'security'
    ],
    parserOptions: {
        ecmaVersion: 12,
        sourceType: 'module'
    },
    rules: {
        // Security rules - set to warn for demo
        'security/detect-non-literal-fs-filename': 'warn',
        'security/detect-eval-with-expression': 'warn',
        'security/detect-child-process': 'warn',
        'security/detect-object-injection': 'warn',
        
        // Code quality - warnings for demo
        'no-console': 'warn',
        'no-unused-vars': 'warn',
        'no-eval': 'warn'
    }
};