<<<<<<< HEAD
# devsecops-demo
=======
# 🔒 DevSecOps Demo - Complete Security Pipeline

A comprehensive demonstration of DevSecOps practices integrating multiple security tools into the development pipeline.

## 📊 Security Tools Integrated

| Tool | Purpose | Stage | Status |
|------|---------|-------|--------|
| **Git Hooks** | Pre-commit security checks | Local Development | ✅ |
| **ESLint + Security Plugin** | Static code analysis | Local & CI | ✅ |
| **Gitleaks** | Secret scanning | Local & CI | ✅ |
| **TruffleHog** | Secret scanning (historical) | CI | ✅ |
| **CodeQL** | Advanced SAST | CI | ✅ |
| **Snyk** | Dependency vulnerability scanning | CI | ✅ |
| **OWASP Dependency Check** | Dependency analysis | CI | ✅ |
| **Trivy** | Container & filesystem scanning | CI | ✅ |
| **Semgrep** | SAST with custom rules | CI | ✅ |
| **Checkov** | Infrastructure as Code scanning | CI | ✅ |

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- Docker
- Git
- GitHub account

### Setup

1. **Clone and setup:**
```bash
cd devsecops-demo
chmod +x setup.sh
./setup.sh
```

2. **Configure GitHub repository:**
```bash
git remote add origin https://github.com/YOUR_USERNAME/devsecops-demo.git
```

3. **Set up GitHub Secrets:**
- Go to Settings → Secrets → Actions
- Add `SNYK_TOKEN` from https://snyk.io/account

## 🎭 Demo Scenarios

### Demo 1: Local Security Checks with Git Hooks

```bash
# Make a change with a security issue
echo "const password = 'admin123'" >> src/vulnerable.js

# Try to commit - pre-commit hook will catch issues
git add .
git commit -m "test: security demo"

# Output will show:
# 🔍 Running pre-commit security checks...
# 📝 Running ESLint... [WARNINGS]
# 🔐 Checking for secrets... [BLOCKED]
# 📦 Checking dependencies... [VULNERABILITIES FOUND]
```

### Demo 2: Secret Detection

```bash
# Intentionally add a secret
echo "AWS_SECRET_KEY=AKIAIOSFODNN7EXAMPLE" >> .env

# Gitleaks will detect it
gitleaks detect --source . --verbose

# Output:
# Secret found in .env
# Rule: AWS Secret Key
# Line: 1
```

### Demo 3: Dependency Vulnerability Scanning

```bash
# Check for vulnerable dependencies
npm audit

# Run Snyk scan
snyk test

# Run OWASP Dependency Check
dependency-check --project "demo" --scan .
```

### Demo 4: Container Security Scanning

```bash
# Build the container
docker build -t devsecops-demo .

# Scan with Trivy
trivy image devsecops-demo

# Output will show:
# - OS vulnerabilities
# - Application dependencies vulnerabilities
# - Misconfigurations
```

### Demo 5: Static Application Security Testing (SAST)

```bash
# Run Semgrep locally
semgrep --config=auto .

# Run ESLint with security plugin
npm run lint

# Issues detected:
# - SQL injection vulnerabilities
# - Command injection risks
# - Weak cryptography usage
# - Path traversal vulnerabilities
```

### Demo 6: GitHub Actions Pipeline

```bash
# Push to trigger full pipeline
git push origin main

# Go to GitHub Actions tab to see:
# ✅ Code Quality Check
# ✅ Secret Scanning
# ✅ CodeQL Analysis
# ✅ Snyk Security Scan
# ✅ OWASP Dependency Check
# ✅ Trivy Container Scan
# ✅ Semgrep SAST
# ✅ License Compliance
# ✅ IaC Security Scan
# ✅ Security Report Generation
```

## 🔍 Intentional Vulnerabilities (For Demo)

The application contains several intentional security issues:

1. **SQL Injection** - `/user?id=1`
2. **Command Injection** - `/ping` endpoint
3. **Path Traversal** - `/file?name=../../etc/passwd`
4. **Weak Cryptography** - MD5 hashing
5. **Hardcoded Secrets** - API keys in source
6. **Eval Usage** - Code injection risk
7. **Missing Security Headers** - XSS vulnerable
8. **NoSQL Injection** - Login endpoint

## 📈 Security Metrics Dashboard

After running the pipeline, check:

1. **GitHub Security Tab** - CodeQL alerts, Dependabot alerts
2. **Actions Tab** - Pipeline execution and artifacts
3. **Pull Requests** - Security comments and checks

## 🛠️ Local Development Commands

```bash
# Linting
npm run lint           # Run ESLint
npm run lint:fix       # Auto-fix issues

# Security Scans
npm run security       # npm audit
npm run snyk          # Snyk test
gitleaks detect       # Secret scanning
trivy fs .            # Filesystem scan
semgrep --config=auto # SAST scan

# Docker
docker build -t devsecops-demo .
docker run -p 3000:3000 devsecops-demo
trivy image devsecops-demo
```

## 🔄 CI/CD Pipeline Stages

```mermaid
graph LR
    A[Code Commit] --> B[Pre-commit Hooks]
    B --> C[GitHub Actions]
    C --> D[Linting]
    C --> E[Secret Scanning]
    C --> F[SAST - CodeQL]
    C --> G[Dependency Scan]
    C --> H[Container Scan]
    C --> I[License Check]
    C --> J[IaC Scan]
    D --> K[Security Report]
    E --> K
    F --> K
    G --> K
    H --> K
    I --> K
    J --> K
    K --> L[Deploy/Block]
```

## 📊 Security Report

The pipeline generates a comprehensive security report including:
- Vulnerability summary
- Critical/High/Medium/Low issues
- Remediation recommendations
- Compliance status
- License violations

## 🚨 Remediation Guide

### For SQL Injection:
```javascript
// Vulnerable
const query = `SELECT * FROM users WHERE id = ${userId}`;

// Secure
const query = 'SELECT * FROM users WHERE id = ?';
db.query(query, [userId]);
```

### For Secret Management:
```javascript
// Vulnerable
const API_KEY = 'sk-1234567890';

// Secure
const API_KEY = process.env.API_KEY;
// Use secret management service
```

### For Command Injection:
```javascript
// Vulnerable
exec(`ping ${host}`);

// Secure
const { execFile } = require('child_process');
execFile('ping', ['-c', '4', host]);
```

## 🎓 Learning Resources

- [OWASP DevSecOps Guideline](https://owasp.org/www-project-devsecops-guideline/)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [Snyk Learn](https://learn.snyk.io/)
- [Semgrep Rules](https://semgrep.dev/explore)

## 📝 Configuration Files

- `.eslintrc.js` - ESLint security rules
- `.gitleaks.toml` - Secret scanning patterns
- `.github/workflows/` - CI/CD pipelines
- `Dockerfile` - Secure container configuration
- `.husky/` - Git hooks configuration

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add security tests
4. Ensure all security checks pass
5. Submit a pull request

## 📄 License

MIT

## 🆘 Troubleshooting

### Issue: Gitleaks not working
```bash
brew install gitleaks  # macOS
apt install gitleaks   # Ubuntu
```

### Issue: Snyk authentication needed
```bash
snyk auth
```

### Issue: Docker not found
Install Docker Desktop from https://docker.com

## 📧 Support

For issues or questions:
- Create an issue in GitHub
- Join #devsecops-cop channel

---
**Remember:** This demo contains intentional vulnerabilities for educational purposes. Do not use in production!
>>>>>>> 3342ac5 (update devsecops demo init)
