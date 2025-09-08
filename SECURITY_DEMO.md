# DevSecOps Security Demo - Intentional Vulnerabilities

This repository contains **intentional security vulnerabilities** for DevSecOps demonstration and training purposes.

## ⚠️ WARNING
**DO NOT use this code in production!** All vulnerabilities are intentional for educational purposes.

## Detected Security Issues

### 1. Secret Detection (Gitleaks)
- **AWS Access Key**: `AKIAIOSFODNN7EXAMPLE` in src/index.js:16
- **Status**: ✅ Detected by Gitleaks
- **Purpose**: Demonstrates secret scanning capabilities

### 2. Code Vulnerabilities (ESLint & Semgrep)
- **SQL Injection**: Direct string concatenation in SQL query (line 23)
- **Command Injection**: Unsanitized user input to exec() (line 33)
- **Path Traversal**: Unvalidated file path join (line 42)
- **Weak Cryptography**: MD5 hash usage (line 56)
- **XSS Vulnerability**: Unescaped HTML output (line 62)
- **Code Injection**: eval() with user input (line 70)
- **NoSQL Injection**: Direct object passing to query (line 81)

### 3. Dependency Vulnerabilities (npm audit)
- **jsonwebtoken**: High severity - Multiple authentication bypass vulnerabilities
- **mongoose**: Critical severity - Search injection vulnerability
- **micromatch**: Moderate severity - ReDoS vulnerability
- **Total**: 4 vulnerabilities (1 critical, 1 high, 2 moderate)

### 4. Container Vulnerabilities (Trivy)
- **Base Image**: node:16-alpine3.14 (outdated with known CVEs)
- **OS Packages**: Not upgraded to preserve CVEs for demo
- **Expected CVEs**: Multiple vulnerabilities in Alpine Linux packages

## Security Tools Integration

### Pre-commit Hooks (Husky)
```bash
npm run lint          # ESLint security rules
gitleaks detect       # Secret scanning (warns but doesn't block)
npm audit            # Dependency scanning
```

### GitHub Actions Workflows

#### 1. Demo Security Pipeline (`demo-security-pipeline.yml`)
- Single job with all security checks
- Comprehensive scanning in one workflow

#### 2. DevSecOps Pipeline (`devsecops-pipeline.yml`)
- Multi-job parallel scanning
- Includes: ESLint, Gitleaks, CodeQL, Snyk, OWASP, Semgrep, Trivy
- Generates security reports

#### 3. Security Scan Simplified (`security-scan.yml`)
- Streamlined security checks
- Focus on essential scans

## Running Security Scans Locally

### Secret Detection
```bash
gitleaks detect --source . --verbose
# Expected: 1 leak found (AWS key)
```

### Code Analysis
```bash
npm run lint
# Expected: 12 problems (9 errors, 3 warnings)
```

### Dependency Audit
```bash
npm audit
# Expected: 4 vulnerabilities
```

### Container Scanning
```bash
docker build -t devsecops-demo:test .
trivy image devsecops-demo:test
# Expected: Multiple CVEs from Alpine 3.14
```

### SAST with Semgrep
```bash
semgrep --config=auto src/
# Expected: Path traversal and eval vulnerabilities
```

## Demo Scenarios

### Scenario 1: Pre-commit Security
1. Make a code change
2. Attempt to commit
3. Observe security warnings (but commit proceeds for demo)

### Scenario 2: CI/CD Pipeline Security
1. Push to GitHub
2. View Actions tab
3. See all security tools detecting issues
4. Pipeline completes with warnings (not failures)

### Scenario 3: Container Security
1. Build Docker image with old Alpine version
2. Run Trivy scan
3. Observe CVEs in base image and packages

## Security Tool Configuration

### Gitleaks Configuration (`.gitleaks.toml`)
- Detects AWS key pattern
- Allows specific demo secrets (sk-1234567890abcdef, admin123)
- Shows 1 finding to prove it's working

### ESLint Configuration (`.eslintrc.js`)
- Security plugin enabled
- Detects unsafe patterns
- Warns on security issues

### GitHub Actions
- All tools use `continue-on-error: true` for demo
- Reports are generated but don't block deployment
- Shows what production pipeline would detect

## Best Practices (For Production)

In a real production environment, you should:

1. **Never commit secrets** - Use environment variables or secret management tools
2. **Fix all ESLint errors** - Don't ignore security warnings
3. **Update dependencies** - Run `npm audit fix` regularly
4. **Use latest base images** - Keep containers updated
5. **Block on security failures** - Remove `continue-on-error` from workflows
6. **Implement least privilege** - Run containers as non-root
7. **Enable all security headers** - Prevent XSS, clickjacking, etc.
8. **Use parameterized queries** - Prevent SQL injection
9. **Validate all inputs** - Sanitize user data
10. **Use strong cryptography** - Replace MD5 with bcrypt or argon2

## Training Exercises

1. **Fix a vulnerability**: Choose one issue and create a PR to fix it
2. **Add a new security tool**: Integrate another scanner
3. **Create security policy**: Write a SECURITY.md file
4. **Implement remediation**: Automate fixing of simple issues
5. **Security metrics**: Add dashboards for tracking vulnerabilities

## Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [DevSecOps Maturity Model](https://dsomm.owasp.org/)

---

**Remember**: This is a training environment. All vulnerabilities are intentional for learning purposes.