# Architect-AI Deployment Guide

This guide covers deploying the full-stack Architect-AI application with AWS backend and Vercel frontend.

## Architecture Overview

- **Frontend**: React + Vite → Deployed on Vercel
- **Backend**: Flask + AWS Lambda → Deployed via AWS SAM
- **Database**: Amazon OpenSearch Serverless (Vector DB)
- **AI**: Amazon Bedrock (Claude 3.5 Sonnet)
- **Storage**: Amazon S3 (Textbook PDFs)

---

## Prerequisites

### Required Tools
- Node.js 18+ and npm
- Python 3.11+
- AWS CLI configured with credentials
- AWS SAM CLI (`pip install aws-sam-cli`)
- Vercel CLI (`npm install -g vercel`)
- Git

### Required Accounts
- AWS Account with Bedrock access enabled
- Vercel Account
- GitHub Account

---

## Part 1: Backend Deployment (AWS Lambda)

### Step 1: Configure AWS Credentials

```bash
aws configure
# Enter your AWS Access Key ID
# Enter your AWS Secret Access Key
# Default region: us-east-1
# Default output format: json
```

### Step 2: Set Up Environment Variables

```bash
cd backend
cp .env.example .env
# Edit .env with your actual AWS credentials and Bedrock configuration
```

### Step 3: Deploy with SAM

```bash
cd infrastructure
sam build
sam deploy --guided
```

During the guided deployment:
- Stack Name: `architect-ai-stack`
- AWS Region: `us-east-1`
- Confirm changes: `Y`
- Allow SAM CLI IAM role creation: `Y`
- Disable rollback: `N`
- Save arguments to config: `Y`

### Step 4: Get Your API Gateway URL

After deployment completes, note the `ApiUrl` output. You'll need this for frontend configuration.

```bash
aws cloudformation describe-stacks \
  --stack-name architect-ai-stack \
  --query 'Stacks[0].Outputs[?OutputKey==`ApiUrl`].OutputValue' \
  --output text
```

---

## Part 2: Frontend Deployment (Vercel)

### Step 1: Configure Environment Variables

```bash
cd frontend
cp .env.example .env
```

Edit `.env` and set:
```
VITE_API_URL=https://your-api-gateway-url.execute-api.us-east-1.amazonaws.com/Prod
```

### Step 2: Install Dependencies

```bash
npm install
```

### Step 3: Test Build Locally

```bash
npm run build
npm run preview
```

### Step 4: Deploy to Vercel

```bash
vercel login
vercel --prod
```

Follow the prompts:
- Set up and deploy: `Y`
- Which scope: Select your account
- Link to existing project: `N`
- Project name: `architect-ai`
- Directory: `./`
- Override settings: `N`

### Step 5: Set Environment Variables in Vercel

```bash
vercel env add VITE_API_URL production
# Paste your API Gateway URL when prompted
```

Or via Vercel Dashboard:
1. Go to your project settings
2. Navigate to Environment Variables
3. Add `VITE_API_URL` with your API Gateway URL

---

## Part 3: GitHub Actions CI/CD Setup

### Step 1: Add GitHub Secrets

Go to your GitHub repository → Settings → Secrets and variables → Actions

Add the following secrets:

**For Backend Deployment:**
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION` (e.g., `us-east-1`)

**For Frontend Deployment:**
- `VERCEL_TOKEN` (Get from https://vercel.com/account/tokens)
- `VERCEL_ORG_ID` (Found in Vercel project settings)
- `VERCEL_PROJECT_ID` (Found in Vercel project settings)

### Step 2: Enable GitHub Actions

The workflows are already configured in `.github/workflows/`:
- `deploy-backend.yml` - Deploys backend on push to main
- `deploy-frontend.yml` - Deploys frontend on push to main

Push to main branch to trigger automatic deployments.

---

## Part 4: Amazon Bedrock Setup

### Step 1: Enable Bedrock Models

1. Go to AWS Console → Amazon Bedrock
2. Navigate to Model access
3. Request access to:
   - Anthropic Claude 3.5 Sonnet
   - Amazon Titan Text Embeddings

### Step 2: Create Knowledge Base (Optional)

1. Go to Amazon Bedrock → Knowledge bases
2. Create new knowledge base
3. Configure S3 data source (use the TextbookBucket from SAM deployment)
4. Select Amazon Titan Embeddings model
5. Choose OpenSearch Serverless as vector store
6. Note the Knowledge Base ID and update your backend `.env`

---

## Part 5: Local Development

### Backend (Flask)

```bash
cd backend
pip install -r requirements.txt
python app.py
# Server runs on http://localhost:5000
```

### Frontend (React + Vite)

```bash
cd frontend
npm install
npm run dev
# App runs on http://localhost:5173
```

Make sure to set `VITE_API_URL=http://localhost:5000` in `frontend/.env` for local development.

---

## Monitoring & Debugging

### CloudWatch Logs
```bash
aws logs tail /aws/lambda/architect-ai-stack-ArchitectAIFunction --follow
```

### X-Ray Tracing
View traces in AWS Console → X-Ray → Traces

### Vercel Logs
```bash
vercel logs
```

---

## Cost Optimization Tips

1. **Lambda**: Use provisioned concurrency only during peak hours
2. **Bedrock**: Cache frequent queries to reduce token usage
3. **OpenSearch**: Use minimum OCU configuration (0.5 OCU)
4. **S3**: Enable lifecycle policies to archive old textbooks

**Estimated Monthly Cost**: ~$50 for 500 active students

---

## Troubleshooting

### Backend Issues

**Lambda timeout errors:**
- Increase timeout in `infrastructure/template.yaml` (max 900s)
- Optimize Bedrock query chunking

**CORS errors:**
- Verify CORS configuration in API Gateway
- Check `FRONTEND_URL` in backend `.env`

### Frontend Issues

**API connection failed:**
- Verify `VITE_API_URL` is correct
- Check API Gateway is deployed and accessible
- Verify CORS headers in backend

**Build failures:**
- Clear node_modules: `rm -rf node_modules && npm install`
- Check Node version: `node --version` (should be 18+)

---

## Security Checklist

- [ ] AWS credentials stored in GitHub Secrets (never commit)
- [ ] S3 bucket has public access blocked
- [ ] API Gateway has throttling enabled
- [ ] Lambda has minimal IAM permissions
- [ ] Environment variables set in Vercel dashboard
- [ ] CORS restricted to your frontend domain in production

---

## Next Steps

1. Upload textbook PDFs to S3 bucket
2. Configure Bedrock Knowledge Base with your curriculum
3. Set up CloudWatch alarms for errors and latency
4. Configure custom domain for Vercel deployment
5. Enable AWS WAF for API Gateway protection

---

## Support

For issues or questions:
- Check CloudWatch logs for backend errors
- Review Vercel deployment logs for frontend issues
- Consult AWS Bedrock documentation for AI-related problems

**Project Repository**: https://github.com/harry1365/tech-spur
