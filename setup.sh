#!/bin/bash

# DevSecOps Demo Setup Script
# This script sets up the local environment with all necessary security tools

set -e

echo "🚀 DevSecOps Demo Setup Script"
echo "================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install tools based on OS
install_tool() {
    local tool=$1
    local brew_package=$2
    local apt_package=$3
    
    if ! command_exists "$tool"; then
        echo -e "${YELLOW}Installing $tool...${NC}"
        if [[ "$OSTYPE" == "darwin"* ]]; then
            brew install "$brew_package"
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sudo apt-get update && sudo apt-get install -y "$apt_package"
        else
            echo -e "${RED}Unsupported OS. Please install $tool manually.${NC}"
        fi
    else
        echo -e "${GREEN}✓ $tool is already installed${NC}"
    fi
}

echo "📦 Checking and installing required tools..."
echo ""

# Install Node.js and npm
if ! command_exists node; then
    echo -e "${YELLOW}Installing Node.js...${NC}"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install node
    else
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt-get install -y nodejs
    fi
fi

# Install Git
install_tool "git" "git" "git"

# Install Docker
if ! command_exists docker; then
    echo -e "${YELLOW}Docker is not installed. Please install Docker Desktop manually.${NC}"
    echo "Visit: https://www.docker.com/products/docker-desktop"
fi

# Install Gitleaks for secret scanning
install_tool "gitleaks" "gitleaks" "gitleaks"

# Install Trivy for container scanning
install_tool "trivy" "aquasecurity/trivy/trivy" "trivy"

# Install semgrep
if ! command_exists semgrep; then
    echo -e "${YELLOW}Installing Semgrep...${NC}"
    python3 -m pip install semgrep
fi

echo ""
echo "📦 Installing Node.js dependencies..."
npm install

echo ""
echo "🪝 Setting up Git hooks with Husky..."
npx husky install
chmod +x .husky/pre-commit

echo ""
echo "🔐 Installing additional security tools..."

# Install Snyk CLI
if ! command_exists snyk; then
    echo -e "${YELLOW}Installing Snyk CLI...${NC}"
    npm install -g snyk
    echo -e "${YELLOW}Please authenticate with Snyk: snyk auth${NC}"
fi

# Install OWASP Dependency Check
if ! command_exists dependency-check; then
    echo -e "${YELLOW}Installing OWASP Dependency Check...${NC}"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install dependency-check
    else
        wget https://github.com/jeremylong/DependencyCheck/releases/download/v7.4.4/dependency-check-7.4.4-release.zip
        unzip dependency-check-7.4.4-release.zip
        sudo mv dependency-check /opt/
        sudo ln -s /opt/dependency-check/bin/dependency-check.sh /usr/local/bin/dependency-check
        rm dependency-check-7.4.4-release.zip
    fi
fi

echo ""
echo "🏗️  Initializing Git repository..."
if [ ! -d .git ]; then
    git init
    git add .
    git commit -m "Initial commit: DevSecOps demo setup"
fi

echo ""
echo -e "${GREEN}✅ Setup complete!${NC}"
echo ""
echo "📋 Next steps:"
echo "1. Configure your GitHub repository:"
echo "   git remote add origin https://github.com/YOUR_USERNAME/devsecops-demo.git"
echo ""
echo "2. Set up GitHub Secrets for the Actions workflows:"
echo "   - SNYK_TOKEN: Get from https://snyk.io/account"
echo ""
echo "3. Push to GitHub to trigger the DevSecOps pipeline:"
echo "   git push -u origin main"
echo ""
echo "4. Run local security checks:"
echo "   npm run lint        # Run ESLint"
echo "   npm run security    # Run npm audit"
echo "   gitleaks detect     # Scan for secrets"
echo "   trivy fs .          # Scan filesystem for vulnerabilities"
echo ""
echo "🎯 Demo is ready! Check README.md for detailed instructions."