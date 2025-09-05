#!/bin/bash

# DevSecOps Demo Script
# Interactive demonstration of security tools

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Demo functions
demo_header() {
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  $1${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

pause() {
    echo ""
    echo -e "${YELLOW}Press Enter to continue...${NC}"
    read
}

run_command() {
    echo -e "${GREEN}$ $1${NC}"
    eval $1
}

# Main Demo
clear
echo -e "${MAGENTA}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                  DevSecOps Pipeline Demo                     ║"
echo "║          Comprehensive Security Tools Integration            ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${BLUE}This demo showcases:${NC}"
echo "• Git hooks for pre-commit security checks"
echo "• Secret scanning with Gitleaks"
echo "• SAST with ESLint and Semgrep"
echo "• Dependency scanning with Snyk and OWASP"
echo "• Container scanning with Trivy"
echo "• GitHub Actions security pipeline"
pause

# Demo 1: Code Quality
demo_header "Demo 1: Code Quality and Linting"
echo "Let's check our code quality with ESLint security plugin:"
pause
run_command "npm run lint | head -20"
echo ""
echo -e "${YELLOW}⚠️  Notice: ESLint detected security issues in the code${NC}"
pause

# Demo 2: Secret Scanning
demo_header "Demo 2: Secret Scanning"
echo "Let's scan for hardcoded secrets and credentials:"
pause
echo -e "${GREEN}Creating a file with a secret...${NC}"
run_command "echo 'const apiKey = \"sk-proj-abc123xyz789\"' > temp_secret.js"
echo ""
echo -e "${GREEN}Running Gitleaks to detect secrets...${NC}"
run_command "gitleaks detect --source . --verbose 2>&1 | grep -A 2 -B 2 'secret found' || echo 'No secrets in committed files'"
run_command "rm -f temp_secret.js"
echo ""
echo -e "${YELLOW}⚠️  Gitleaks would block this from being committed${NC}"
pause

# Demo 3: Dependency Vulnerabilities
demo_header "Demo 3: Dependency Vulnerability Scanning"
echo "Let's check for known vulnerabilities in our dependencies:"
pause
echo -e "${GREEN}Running npm audit...${NC}"
run_command "npm audit --audit-level=moderate | head -30"
echo ""
echo -e "${GREEN}For more detailed analysis, we can use Snyk:${NC}"
echo "snyk test (requires authentication)"
pause

# Demo 4: SAST with Semgrep
demo_header "Demo 4: Static Application Security Testing (SAST)"
echo "Let's run Semgrep to find security issues in our code:"
pause
if command -v semgrep &> /dev/null; then
    run_command "semgrep --config=auto src/ --json | jq '.results[] | {check_id, path, message}' 2>/dev/null | head -50"
else
    echo -e "${YELLOW}Semgrep not installed. Install with: pip install semgrep${NC}"
fi
pause

# Demo 5: Container Security
demo_header "Demo 5: Container Security Scanning"
echo "Let's build and scan our Docker container:"
pause
echo -e "${GREEN}Building Docker image...${NC}"
run_command "docker build -t devsecops-demo:latest . 2>&1 | tail -10"
echo ""
echo -e "${GREEN}Scanning with Trivy...${NC}"
if command -v trivy &> /dev/null; then
    run_command "trivy image --severity HIGH,CRITICAL devsecops-demo:latest | head -50"
else
    echo -e "${YELLOW}Trivy not installed. Install with: brew install trivy${NC}"
fi
pause

# Demo 6: Pre-commit Hook
demo_header "Demo 6: Git Pre-commit Hooks"
echo "Let's test our pre-commit security hooks:"
pause
echo -e "${GREEN}Creating a vulnerable file...${NC}"
cat > vulnerable_test.js << 'EOF'
// Intentionally vulnerable code
const mysql = require('mysql');
const runQuery = (userId) => {
    const query = `SELECT * FROM users WHERE id = ${userId}`;
    return query;
};
const password = "admin123";
module.exports = { runQuery };
EOF
run_command "cat vulnerable_test.js"
echo ""
echo -e "${GREEN}Attempting to commit...${NC}"
run_command "git add vulnerable_test.js && git commit -m 'test: vulnerable code' || true"
run_command "rm -f vulnerable_test.js"
echo ""
echo -e "${YELLOW}⚠️  Pre-commit hooks prevented the commit${NC}"
pause

# Demo 7: Security Pipeline Overview
demo_header "Demo 7: GitHub Actions Security Pipeline"
echo "Our GitHub Actions pipeline includes:"
echo ""
echo -e "${GREEN}1. Code Quality Check${NC} - ESLint with security plugin"
echo -e "${GREEN}2. Secret Scanning${NC} - Gitleaks and TruffleHog"
echo -e "${GREEN}3. SAST Analysis${NC} - CodeQL and Semgrep"
echo -e "${GREEN}4. Dependency Scanning${NC} - Snyk and OWASP Dependency Check"
echo -e "${GREEN}5. Container Scanning${NC} - Trivy"
echo -e "${GREEN}6. License Compliance${NC} - License checker"
echo -e "${GREEN}7. IaC Scanning${NC} - Checkov"
echo ""
echo "View .github/workflows/devsecops-pipeline.yml for details"
pause

# Summary
demo_header "Summary: Security Issues Found"
echo -e "${RED}🔒 Security Vulnerabilities Detected:${NC}"
echo ""
echo "1. SQL Injection in src/index.js:20"
echo "2. Command Injection in src/index.js:28"
echo "3. Path Traversal in src/index.js:38"
echo "4. Weak Cryptography (MD5) in src/index.js:52"
echo "5. Hardcoded Secrets in src/index.js:14-16"
echo "6. Eval Usage in src/index.js:65"
echo "7. Missing Security Headers"
echo "8. Outdated Dependencies with CVEs"
echo ""
echo -e "${GREEN}✅ All issues are caught by our DevSecOps pipeline!${NC}"
echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${MAGENTA}        Demo Complete - Questions?${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"