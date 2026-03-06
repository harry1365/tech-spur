# GitHub Repository Setup Guide

This guide helps you set up the tech-spur repository with all necessary configurations for automated deployments.

## Step 1: Push Code to GitHub

```bash
# Initialize git (if not already done)
git init

# Add remote repository
git remote add origin https://github.com/harry1365/tech-spur.git

# Add all files
git add .

# Commit changes
git commit -m "Initial commit: Full deployment setup"

# Push to main branch
git push -u origin main
```

## Step 2: Configure GitHub Secrets

Go to your repository on GitHub:
`https://github.com/harry1365/tech-spur/settings/secrets/actions`

### Add the following secrets:

#### For Backend Deployment (AWS)
1. **AWS_ACCESS_KEY_ID**
   - Your AWS access key
   - Get from AWS Console → IAM → Users → Security credentials

2. **AWS_SECRET_ACCESS_KEY**
   - Your AWS secret key
   - Get from AWS Console → IAM → Users → Security credentials

3. **AWS_REGION**
   - Example: `us-east-1`
   - Choose the region where you want to deploy

#### For Frontend Deployment (Vercel)
1. **VERCEL_TOKEN**
   - Get from: https://vercel.com/account/tokens
   - Click "Create Token"
   - Give it a name like "GitHub Actions"
   - Copy the token

2. **VERCEL_ORG_ID** (Optional but recommended)
   - Found in Vercel project settings
   - Or run: `vercel whoami` after logging in

3. **VERCEL_PROJECT_ID** (Optional but recommended)
   - Found in Vercel project settings → General
   - Or in `.vercel/project.json` after first deployment

## Step 3: Enable GitHub Actions

1. Go to your repository
2. Click on "Actions" tab
3. If prompted, click "I understand my workflows, go ahead and enable them"

## Step 4: Configure Branch Protection (Optional)

For production safety:

1. Go to Settings → Branches
2. Add rule for `main` branch
3. Enable:
   - Require pull request reviews before merging
   - Require status checks to pass before merging
   - Require branches to be up to date before merging

## Step 5: First Deployment

### Option A: Automatic (via GitHub Actions)
Simply push to main branch:
```bash
git push origin main
```

GitHub Actions will automatically:
- Deploy backend to AWS Lambda
- Deploy frontend to Vercel

### Option B: Manual Deployment

**Backend:**
```bash
# Windows
scripts\deploy-backend.bat

# Linux/Mac
bash scripts/deploy-backend.sh
```

**Frontend:**
```bash
# Windows
scripts\deploy-frontend.bat

# Linux/Mac
bash scripts/deploy-frontend.sh
```

## Step 6: Verify Deployments

### Check Backend Deployment
1. Go to AWS Console → CloudFormation
2. Find stack: `architect-ai-stack`
3. Check Outputs tab for API Gateway URL

### Check Frontend Deployment
1. Go to Vercel Dashboard
2. Find project: `architect-ai`
3. Check deployment status and URL

## Step 7: Update Environment Variables

After backend deployment, update frontend environment:

1. Get API Gateway URL from AWS CloudFormation outputs
2. Go to Vercel Dashboard → Project Settings → Environment Variables
3. Add/Update: `VITE_API_URL` = `<your-api-gateway-url>`
4. Redeploy frontend

## Troubleshooting

### GitHub Actions Failing

**AWS Deployment Issues:**
- Verify AWS credentials are correct in GitHub Secrets
- Check IAM permissions include CloudFormation, Lambda, API Gateway, S3
- Review CloudWatch logs for Lambda errors

**Vercel Deployment Issues:**
- Verify VERCEL_TOKEN is valid
- Check build logs in GitHub Actions
- Ensure frontend builds locally: `cd frontend && npm run build`

### Manual Deployment Issues

**SAM Build Fails:**
```bash
# Install SAM CLI
pip install aws-sam-cli

# Verify AWS credentials
aws sts get-caller-identity
```

**Vercel Deploy Fails:**
```bash
# Login to Vercel
vercel login

# Link project
cd frontend
vercel link
```

## Monitoring Deployments

### GitHub Actions
- View workflow runs: `https://github.com/harry1365/tech-spur/actions`
- Check logs for each deployment
- Set up notifications for failed deployments

### AWS CloudWatch
```bash
# View Lambda logs
aws logs tail /aws/lambda/architect-ai-stack-ArchitectAIFunction --follow
```

### Vercel Logs
```bash
vercel logs
```

## Next Steps

1. Set up custom domain for frontend
2. Configure AWS CloudWatch alarms
3. Set up monitoring dashboards
4. Configure backup strategies
5. Implement staging environment

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [AWS SAM Documentation](https://docs.aws.amazon.com/serverless-application-model/)
- [Vercel Documentation](https://vercel.com/docs)
- [Project Deployment Guide](../DEPLOYMENT.md)

## Support

For issues:
1. Check GitHub Actions logs
2. Review AWS CloudWatch logs
3. Check Vercel deployment logs
4. Open an issue on GitHub
