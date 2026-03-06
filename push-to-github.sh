#!/bin/bash

echo "========================================"
echo "  Architect-AI Git Setup and Push"
echo "========================================"
echo ""

# Navigate to project directory
cd /c/Users/Harry/Downloads/ArchitectAI-Clean

# Configure Git if not already configured
if [ -z "$(git config --global user.email)" ]; then
    echo "Setting up Git configuration..."
    read -p "Enter your email for Git: " email
    read -p "Enter your name for Git: " name
    git config --global user.email "$email"
    git config --global user.name "$name"
    echo "Git configured!"
    echo ""
fi

echo "Current Git user:"
git config --global user.name
git config --global user.email
echo ""

# Initialize Git repository
echo "Initializing Git repository..."
git init
echo ""

# Add remote
echo "Adding GitHub remote..."
git remote remove origin 2>/dev/null
git remote add origin https://github.com/harry1365/tech-spur.git
echo ""

# Check status
echo "Checking repository status..."
git status
echo ""

# Add all files
echo "Adding all files..."
git add .
echo ""

# Commit
echo "Creating commit..."
git commit -m "feat: Complete deployment setup with AWS Lambda + Vercel

- Add AWS SAM infrastructure templates
- Add GitHub Actions CI/CD workflows
- Add deployment scripts for Windows and Linux
- Add comprehensive documentation
- Configure Vercel deployment
- Add environment variable templates
- Update README with deployment instructions
- Add security and monitoring configurations"
echo ""

# Push to GitHub
echo ""
echo "========================================"
echo "  Ready to Push to GitHub!"
echo "========================================"
echo ""
echo "Repository: https://github.com/harry1365/tech-spur"
echo ""
echo "You will be prompted for your GitHub credentials."
echo ""
echo "IMPORTANT: If you have 2FA enabled, use a Personal Access Token instead of password."
echo "Get token from: https://github.com/settings/tokens"
echo ""
read -p "Press Enter to continue..."

echo "Pushing to GitHub..."
git branch -M main
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "========================================"
    echo "  SUCCESS! Code pushed to GitHub!"
    echo "========================================"
    echo ""
    echo "Next steps:"
    echo "1. Go to https://github.com/harry1365/tech-spur"
    echo "2. Verify all files are there"
    echo "3. Follow DEPLOYMENT.md to deploy to production"
    echo ""
else
    echo ""
    echo "========================================"
    echo "  Push failed!"
    echo "========================================"
    echo ""
    echo "Common issues:"
    echo "1. Authentication failed - Use Personal Access Token if you have 2FA"
    echo "2. Repository already exists - Try: git pull origin main --rebase"
    echo "3. Network issues - Check your internet connection"
    echo ""
    echo "For help, see PUSH_TO_GITHUB.md"
    echo ""
fi
