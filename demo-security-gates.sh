#!/bin/bash

# DevSecOps Security Gates Demo
# Shows how security tools prevent vulnerable code from being committed/pushed

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo -e "${MAGENTA}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║         DevSecOps Security Gates Demo                        ║"
echo "║     Demonstrating How Security Tools Block Bad Code          ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${CYAN}Scenario: Developer tries to commit vulnerable code${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Step 1: Show current security issues
echo -e "${YELLOW}Step 1: Current Security Status${NC}"
echo -e "${GREEN}Let's check existing security issues in our code:${NC}"
echo ""
echo -e "${BLUE}$ npm run lint${NC}"
npm run lint || true
echo ""
echo -e "${RED}❌ We have 11 security issues (8 errors, 3 warnings)${NC}"
echo -e "${YELLOW}Press Enter to continue...${NC}"
read

# Step 2: Try to add more vulnerable code
echo ""
echo -e "${YELLOW}Step 2: Developer adds new vulnerable code${NC}"
echo -e "${GREEN}Creating a new file with hardcoded credentials:${NC}"
echo ""

cat > temp-vulnerable.js << 'EOF'
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
EOF

echo -e "${BLUE}$ cat temp-vulnerable.js${NC}"
cat temp-vulnerable.js
echo ""
echo -e "${YELLOW}Press Enter to continue...${NC}"
read

# Step 3: Try to commit the vulnerable code
echo ""
echo -e "${YELLOW}Step 3: Attempting to commit vulnerable code${NC}"
echo -e "${GREEN}Let's try to add and commit this file:${NC}"
echo ""
echo -e "${BLUE}$ git add temp-vulnerable.js${NC}"
git add temp-vulnerable.js
echo ""
echo -e "${BLUE}$ git commit -m 'feat: add new user functionality'${NC}"
echo ""

# This will fail due to pre-commit hooks
if git commit -m "feat: add new user functionality" 2>&1; then
    echo -e "${RED}ERROR: This shouldn't happen - hooks should block this!${NC}"
else
    echo ""
    echo -e "${RED}✋ BLOCKED: Pre-commit hook prevented the commit!${NC}"
    echo -e "${YELLOW}The security checks failed and stopped the commit.${NC}"
fi

echo ""
echo -e "${YELLOW}Press Enter to continue...${NC}"
read

# Step 4: Show what would happen without hooks
echo ""
echo -e "${YELLOW}Step 4: Demonstrating bypass (DO NOT do this in production!)${NC}"
echo -e "${GREEN}For demo purposes, let's see what happens if we bypass the hooks:${NC}"
echo ""
echo -e "${BLUE}$ git commit -m 'feat: add functionality' --no-verify${NC}"
git commit -m "feat: add functionality (DEMO ONLY)" --no-verify || true
echo ""
echo -e "${GREEN}✓ Commit succeeded when bypassing hooks${NC}"
echo -e "${RED}⚠️  WARNING: Never use --no-verify in real projects!${NC}"
echo ""
echo -e "${YELLOW}Press Enter to continue...${NC}"
read

# Step 5: GitHub Actions would catch it
echo ""
echo -e "${YELLOW}Step 5: CI/CD Pipeline as Final Gate${NC}"
echo -e "${GREEN}Even if bad code gets committed locally, GitHub Actions will catch it:${NC}"
echo ""
echo "When pushed to GitHub, the pipeline will:"
echo "  1. ❌ ESLint will fail the build"
echo "  2. ❌ Semgrep will detect vulnerabilities"
echo "  3. ❌ Gitleaks will find hardcoded secrets"
echo "  4. ❌ CodeQL will identify security issues"
echo ""
echo -e "${CYAN}The PR/push will be blocked from merging!${NC}"
echo ""
echo -e "${YELLOW}Press Enter to continue...${NC}"
read

# Step 6: Fix the issues
echo ""
echo -e "${YELLOW}Step 6: Fixing the Security Issues${NC}"
echo -e "${GREEN}Let's create a secure version:${NC}"
echo ""

cat > temp-secure.js << 'EOF'
// Secure version of the code
require('dotenv').config();

// Use environment variables for secrets
const stripeKey = process.env.STRIPE_KEY;
const adminPassword = process.env.ADMIN_PASSWORD;

// Parameterized query to prevent SQL injection
function getUser(id) {
    const query = 'SELECT * FROM users WHERE id = ?';
    return db.query(query, [id]);
}

// Safe command execution
const { execFile } = require('child_process');
function listDirectory(directory) {
    // Use execFile with specific command and arguments
    execFile('ls', [directory], (error, stdout, stderr) => {
        if (error) {
            console.error(`Error: ${error}`);
            return;
        }
        console.log(stdout);
    });
}

module.exports = { getUser, listDirectory };
EOF

echo -e "${BLUE}$ cat temp-secure.js${NC}"
cat temp-secure.js
echo ""
echo -e "${GREEN}✓ This version uses:${NC}"
echo "  • Environment variables for secrets"
echo "  • Parameterized queries"
echo "  • Safe command execution with execFile"
echo ""
echo -e "${YELLOW}Press Enter to continue...${NC}"
read

# Step 7: Clean up and summary
echo ""
echo -e "${YELLOW}Step 7: Cleanup${NC}"
git reset --soft HEAD~1 2>/dev/null || true
rm -f temp-vulnerable.js temp-secure.js
git reset HEAD temp-vulnerable.js 2>/dev/null || true
echo -e "${GREEN}✓ Cleaned up demo files${NC}"
echo ""

# Summary
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${MAGENTA}Summary: Multi-Layer Security Defense${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${GREEN}Security Gates in Order:${NC}"
echo ""
echo "1️⃣  ${YELLOW}Local Development${NC}"
echo "   • ESLint catches issues during coding"
echo "   • IDE plugins provide real-time feedback"
echo ""
echo "2️⃣  ${YELLOW}Pre-Commit Hooks${NC}"
echo "   • Blocks commits with security issues"
echo "   • Runs linting, secret scanning"
echo ""
echo "3️⃣  ${YELLOW}CI/CD Pipeline${NC}"
echo "   • GitHub Actions runs comprehensive scans"
echo "   • SAST, DAST, dependency checks"
echo "   • Blocks PR merging if issues found"
echo ""
echo "4️⃣  ${YELLOW}Production Monitoring${NC}"
echo "   • Runtime protection"
echo "   • Continuous monitoring"
echo ""
echo -e "${GREEN}✅ Result: Vulnerable code never reaches production!${NC}"
echo ""
echo -e "${CYAN}Key Takeaway:${NC}"
echo -e "${MAGENTA}\"Shift-left security means catching issues as early as possible\"${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"