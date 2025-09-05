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
        // Security rules
        'security/detect-non-literal-fs-filename': 'error',
        'security/detect-eval-with-expression': 'error',
        'security/detect-no-csrf-before-method-override': 'error',
        'security/detect-buffer-noassert': 'error',
        'security/detect-child-process': 'warn',
        'security/detect-disable-mustache-escape': 'error',
        'security/detect-new-buffer': 'error',
        'security/detect-object-injection': 'warn',
        'security/detect-possible-timing-attacks': 'warn',
        'security/detect-pseudoRandomBytes': 'error',
        'security/detect-unsafe-regex': 'error',
        
        // Code quality rules
        'no-console': 'warn',
        'no-unused-vars': 'error',
        'no-eval': 'error',
        'no-implied-eval': 'error',
        'no-new-func': 'error',
        'no-script-url': 'error',
        'no-with': 'error',
        'prefer-const': 'error',
        'no-var': 'error'
    }
};