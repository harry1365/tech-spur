# Git Not Working? Quick Fix Guide

## Problem

You installed Git but it's not recognized in the terminal.

## Solution

### Option 1: Restart Terminal (Easiest)

1. Close this terminal/PowerShell window
2. Open a NEW terminal window
3. Run: `git --version`
4. If it works, run: `SETUP_GIT_AND_PUSH.bat`

### Option 2: Restart Computer

1. Restart your computer
2. Open terminal
3. Run: `git --version`
4. If it works, run: `SETUP_GIT_AND_PUSH.bat`

### Option 3: Add Git to PATH Manually

1. Find where Git is installed (usually `C:\Program Files\Git\cmd`)
2. Right-click "This PC" → Properties
3. Click "Advanced system settings"
4. Click "Environment Variables"
5. Under "System variables", find "Path"
6. Click "Edit"
7. Click "New"
8. Add: `C:\Program Files\Git\cmd`
9. Click OK on all windows
10. Close and reopen terminal
11. Run: `git --version`
12. If it works, run: `SETUP_GIT_AND_PUSH.bat`

---

## Quick Test

Open a NEW terminal and run:

```bash
git --version
```

If you see a version number (like `git version 2.x.x`), Git is working!

---

## Once Git Works

Run this command to push everything to GitHub:

```bash
SETUP_GIT_AND_PUSH.bat
```

This script will:
1. ✅ Configure Git with your name and email
2. ✅ Initialize the repository
3. ✅ Add all files
4. ✅ Create a commit
5. ✅ Push to https://github.com/harry1365/tech-spur

---

## Manual Steps (If Script Doesn't Work)

If the batch script doesn't work, do it manually:

### 1. Configure Git
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 2. Initialize Repository
```bash
git init
```

### 3. Add Remote
```bash
git remote add origin https://github.com/harry1365/tech-spur.git
```

### 4. Add Files
```bash
git add .
```

### 5. Commit
```bash
git commit -m "feat: Complete deployment setup"
```

### 6. Push
```bash
git branch -M main
git push -u origin main
```

---

## GitHub Authentication

### If You Have 2FA Enabled

You CANNOT use your password. You need a Personal Access Token:

1. Go to: https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Give it a name: "Architect-AI Deployment"
4. Select scopes: `repo` (all)
5. Click "Generate token"
6. COPY THE TOKEN (you won't see it again!)
7. When pushing, use the token as your password

### If You Don't Have 2FA

Use your regular GitHub username and password when prompted.

---

## Troubleshooting

### "fatal: not a git repository"
```bash
git init
```

### "remote origin already exists"
```bash
git remote remove origin
git remote add origin https://github.com/harry1365/tech-spur.git
```

### "failed to push some refs"
```bash
git pull origin main --rebase
git push origin main
```

### Authentication keeps failing
- Use Personal Access Token instead of password
- Make sure you're using the correct GitHub username
- Check your internet connection

---

## Need More Help?

1. Check [PUSH_TO_GITHUB.md](PUSH_TO_GITHUB.md) for detailed instructions
2. Check [START_HERE.md](START_HERE.md) for the complete guide
3. Open an issue on GitHub (after you get access)

---

## Quick Reference

```bash
# Check Git is working
git --version

# Run automated setup
SETUP_GIT_AND_PUSH.bat

# Or do it manually
git init
git remote add origin https://github.com/harry1365/tech-spur.git
git add .
git commit -m "feat: Complete deployment setup"
git branch -M main
git push -u origin main
```

---

**Once Git works, run `SETUP_GIT_AND_PUSH.bat` and you're done!** 🚀
