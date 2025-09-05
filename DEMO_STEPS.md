# 🚀 DevSecOps Demo - Quick Start Guide

## Setup (5 minutes)
```bash
# 1. Run setup script
./setup.sh

# 2. Initialize git repository
git init
git add .
git commit -m "Initial commit: DevSecOps demo"

# 3. Create GitHub repository and push
git remote add origin https://github.com/YOUR_USERNAME/devsecops-demo.git
git push -u origin main
```

## Live Demo Flow (15-20 minutes)

### 1️⃣ Show the Vulnerable Application (2 min)
```bash
# Display the intentionally vulnerable code
cat src/index.js

# Point out: SQL injection, hardcoded secrets, weak crypto
```

### 2️⃣ Local Security Checks (3 min)
```bash
# Run ESLint
npm run lint

# Scan for secrets
gitleaks detect --verbose

# Check dependencies
npm audit
```

### 3️⃣ Pre-commit Hook Demo (3 min)
```bash
# Try to commit vulnerable code
echo "const password = 'secret123'" >> bad.js
git add bad.js
git commit -m "bad commit"  # Will be blocked!
```

### 4️⃣ Container Security (3 min)
```bash
# Build and scan container
docker build -t demo .
trivy image demo
```

### 5️⃣ SAST Analysis (3 min)
```bash
# Run Semgrep
semgrep --config=auto src/

# Show security issues found
```

### 6️⃣ GitHub Actions Pipeline (5 min)
- Push code to GitHub
- Show Actions tab
- Walk through each security job:
  - CodeQL scanning
  - Snyk dependency check
  - Secret detection
  - Container scanning
  - Security report generation

## Key Talking Points

### 🔒 Security Tools Coverage:
- **Secrets**: Gitleaks, TruffleHog
- **SAST**: CodeQL, Semgrep, ESLint
- **Dependencies**: Snyk, OWASP Dependency Check
- **Containers**: Trivy
- **IaC**: Checkov

### 📊 Metrics to Highlight:
- Number of vulnerabilities detected
- Time to detection (shift-left)
- Automation percentage
- False positive rate

### 🎯 Business Value:
- Prevent security breaches early
- Reduce remediation costs
- Maintain compliance
- Build security culture

## Interactive Elements

### Let Audience Try:
1. "Can you spot the SQL injection?"
2. "What's wrong with this crypto implementation?"
3. "How would you fix this secret management?"

### Live Fixes:
```bash
# Fix SQL injection
# Change: `SELECT * FROM users WHERE id = ${userId}`
# To: Use parameterized queries

# Fix secrets
# Use environment variables instead of hardcoded values
```

## Troubleshooting

### If Tools Not Installed:
```bash
# Quick install commands
brew install gitleaks trivy
npm install -g snyk
pip install semgrep
```

### If GitHub Actions Fail:
- Check secrets are configured
- Verify branch protection rules
- Review workflow syntax

## Closing

### Summary Slide Topics:
✅ All vulnerabilities detected automatically
✅ Security integrated into developer workflow
✅ No manual security gates
✅ Fast feedback loops
✅ Comprehensive coverage

### Call to Action:
"Start with one tool, then gradually add more"
"Security is everyone's responsibility"
"Automate everything you can"

## Resources
- GitHub repo: [your-repo-url]
- Slides: DevSecOps_Introduction_Presentation.pptx
- Documentation: README.md
- Support: #devsecops-cop channel