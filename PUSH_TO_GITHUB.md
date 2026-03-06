# Push Architect-AI to GitHub

Follow these steps to push your deployment-ready code to the tech-spur repository.

## Step 1: Initialize Git (if not already done)

```bash
git init
```

## Step 2: Add Remote Repository

```bash
git remote add origin https://github.com/harry1365/tech-spur.git
```

If you already have a remote, verify it:
```bash
git remote -v
```

If you need to update it:
```bash
git remote set-url origin https://github.com/harry1365/tech-spur.git
```

## Step 3: Check Current Status

```bash
git status
```

This shows all the new files that will be committed.

## Step 4: Add All Files

```bash
git add .
```

## Step 5: Commit Changes

```bash
git commit -m "feat: Complete deployment setup with AWS Lambda + Vercel

- Add AWS SAM infrastructure templates
- Add GitHub Actions CI/CD workflows
- Add deployment scripts for Windows and Linux
- Add comprehensive documentation
- Configure Vercel deployment
- Add environment variable templates
- Update README with deployment instructions
- Add security and monitoring configurations"
```

## Step 6: Push to GitHub

### If this is the first push:
```bash
git branch -M main
git push -u origin main
```

### If the repository already exists:
```bash
git pull origin main --rebase
git push origin main
```

### If you encounter conflicts:
```bash
# Resolve conflicts manually, then:
git add .
git rebase --continue
git push origin main
```

## Step 7: Verify on GitHub

1. Go to https://github.com/harry1365/tech-spur
2. Verify all files are present
3. Check that GitHub Actions workflows are visible in the "Actions" tab

## Step 8: Configure GitHub Secrets

Now that code is pushed, configure secrets for CI/CD:

Go to: https://github.com/harry1365/tech-spur/settings/secrets/actions

Add these secrets:

### Backend (AWS) Secrets:
- `AWS_ACCESS_KEY_ID` - Your AWS access key
- `AWS_SECRET_ACCESS_KEY` - Your AWS secret key
- `AWS_REGION` - e.g., `us-east-1`

### Frontend (Vercel) Secrets:
- `VERCEL_TOKEN` - Get from https://vercel.com/account/tokens

## Step 9: Enable GitHub Actions

1. Go to https://github.com/harry1365/tech-spur/actions
2. If prompted, click "I understand my workflows, go ahead and enable them"

## Step 10: Test Deployment

Make a small change and push to trigger deployments:

```bash
echo "# Deployment test" >> README.md
git add README.md
git commit -m "test: Trigger deployment"
git push origin main
```

Watch the Actions tab to see deployments run!

## Troubleshooting

### Authentication Failed
If you get authentication errors:

**Option 1: Use Personal Access Token**
1. Go to GitHub Settings → Developer settings → Personal access tokens
2. Generate new token with `repo` scope
3. Use token as password when pushing

**Option 2: Use SSH**
```bash
git remote set-url origin git@github.com:harry1365/tech-spur.git
```

### Large Files Warning
If you get warnings about large files:
```bash
# Check file sizes
git ls-files | xargs ls -lh | sort -k5 -h

# Remove large files from staging
git rm --cached path/to/large/file
```

### Already Exists Error
If the repository already has content:
```bash
git pull origin main --allow-unrelated-histories
# Resolve any conflicts
git push origin main
```

## Next Steps

After pushing to GitHub:

1. ✅ Configure GitHub Secrets (Step 8)
2. ✅ Enable GitHub Actions (Step 9)
3. ✅ Follow [DEPLOYMENT.md](DEPLOYMENT.md) to deploy
4. ✅ Use [DEPLOYMENT_CHECKLIST.md](DEPLOYMENT_CHECKLIST.md) to track progress

## Quick Reference

```bash
# Check status
git status

# Add files
git add .

# Commit
git commit -m "Your message"

# Push
git push origin main

# Pull latest
git pull origin main

# View remotes
git remote -v

# View commit history
git log --oneline
```

## Success!

Once pushed, your repository will have:
- ✅ Complete deployment infrastructure
- ✅ CI/CD pipelines
- ✅ Comprehensive documentation
- ✅ Deployment scripts
- ✅ Security configurations
- ✅ Monitoring setup

Ready to deploy to production! 🚀
