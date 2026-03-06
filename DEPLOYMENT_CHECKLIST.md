# Architect-AI Deployment Checklist

Use this checklist to ensure successful deployment of Architect-AI to production.

## Pre-Deployment Setup

### 1. Local Development Environment
- [ ] Node.js 18+ installed
- [ ] Python 3.11+ installed
- [ ] Git installed and configured
- [ ] Project cloned from GitHub
- [ ] Local development tested (`start.bat` or `scripts/local-dev.sh`)

### 2. AWS Account Setup
- [ ] AWS account created
- [ ] IAM user created with programmatic access
- [ ] IAM permissions configured:
  - [ ] CloudFormation (full access)
  - [ ] Lambda (full access)
  - [ ] API Gateway (full access)
  - [ ] S3 (full access)
  - [ ] Bedrock (InvokeModel, RetrieveAndGenerate)
  - [ ] CloudWatch Logs (full access)
  - [ ] IAM (role creation)
- [ ] AWS CLI installed and configured (`aws configure`)
- [ ] AWS SAM CLI installed (`pip install aws-sam-cli`)

### 3. Amazon Bedrock Setup
- [ ] Bedrock access enabled in your AWS region
- [ ] Claude 3.5 Sonnet model access requested and approved
- [ ] Amazon Titan Embeddings model access requested and approved
- [ ] Knowledge Base created (optional for MVP)
- [ ] S3 bucket for textbooks created (optional for MVP)

### 4. Vercel Account Setup
- [ ] Vercel account created (https://vercel.com)
- [ ] Vercel CLI installed (`npm install -g vercel`)
- [ ] Vercel CLI authenticated (`vercel login`)
- [ ] Vercel token generated for CI/CD

### 5. GitHub Repository Setup
- [ ] Repository created: https://github.com/harry1365/tech-spur
- [ ] Local code pushed to GitHub
- [ ] GitHub Actions enabled

## Backend Deployment (AWS Lambda)

### 6. Configure Backend Environment
- [ ] Copy `backend/.env.example` to `backend/.env`
- [ ] Set `AWS_REGION` in `.env`
- [ ] Set `AWS_ACCESS_KEY_ID` in `.env`
- [ ] Set `AWS_SECRET_ACCESS_KEY` in `.env`
- [ ] Set `BEDROCK_MODEL_ID` in `.env`
- [ ] Set `BEDROCK_KB_ID` in `.env` (if using Knowledge Base)

### 7. Deploy Backend
- [ ] Navigate to `infrastructure/` directory
- [ ] Run `sam build`
- [ ] Run `sam deploy --guided`
- [ ] Note the API Gateway URL from outputs
- [ ] Test health endpoint: `curl <api-url>/health`
- [ ] Test query endpoint with sample request

### 8. Verify Backend Deployment
- [ ] CloudFormation stack created successfully
- [ ] Lambda function deployed
- [ ] API Gateway endpoint accessible
- [ ] CloudWatch logs showing function executions
- [ ] No errors in CloudWatch logs

## Frontend Deployment (Vercel)

### 9. Configure Frontend Environment
- [ ] Copy `frontend/.env.example` to `frontend/.env`
- [ ] Set `VITE_API_URL` to your API Gateway URL
- [ ] Test build locally: `cd frontend && npm run build`

### 10. Deploy Frontend
- [ ] Navigate to `frontend/` directory
- [ ] Run `vercel --prod`
- [ ] Follow prompts to link/create project
- [ ] Note the deployment URL

### 11. Configure Vercel Environment Variables
- [ ] Go to Vercel Dashboard → Project Settings
- [ ] Add environment variable: `VITE_API_URL` = `<your-api-gateway-url>`
- [ ] Redeploy to apply environment variables

### 12. Verify Frontend Deployment
- [ ] Frontend accessible at Vercel URL
- [ ] No console errors in browser
- [ ] API calls working (check Network tab)
- [ ] Diagrams rendering correctly
- [ ] Responsive design working on mobile

## GitHub Actions CI/CD Setup

### 13. Configure GitHub Secrets
Go to: `https://github.com/harry1365/tech-spur/settings/secrets/actions`

**Backend Secrets:**
- [ ] `AWS_ACCESS_KEY_ID`
- [ ] `AWS_SECRET_ACCESS_KEY`
- [ ] `AWS_REGION`

**Frontend Secrets:**
- [ ] `VERCEL_TOKEN`
- [ ] `VERCEL_ORG_ID` (optional)
- [ ] `VERCEL_PROJECT_ID` (optional)

### 14. Test GitHub Actions
- [ ] Make a small change to backend code
- [ ] Push to main branch
- [ ] Verify backend workflow runs successfully
- [ ] Make a small change to frontend code
- [ ] Push to main branch
- [ ] Verify frontend workflow runs successfully

## Post-Deployment Configuration

### 15. Security Hardening
- [ ] Update CORS in backend to specific frontend domain
- [ ] Enable API Gateway throttling
- [ ] Configure API Gateway API keys (optional)
- [ ] Set up AWS WAF rules (optional)
- [ ] Enable CloudWatch alarms for errors

### 16. Monitoring Setup
- [ ] CloudWatch dashboard created
- [ ] Alarms configured:
  - [ ] Lambda errors > 5%
  - [ ] API Gateway 5xx errors
  - [ ] Lambda duration > 25s
  - [ ] Bedrock throttling
- [ ] SNS topic for alarm notifications
- [ ] Email subscriptions configured

### 17. Cost Optimization
- [ ] Review AWS Cost Explorer
- [ ] Set up billing alarms
- [ ] Configure Lambda reserved concurrency (if needed)
- [ ] Review OpenSearch OCU usage
- [ ] Enable S3 lifecycle policies

### 18. Documentation
- [ ] Update README.md with production URLs
- [ ] Document any custom configurations
- [ ] Create runbook for common issues
- [ ] Document backup/restore procedures

## Testing & Validation

### 19. End-to-End Testing
- [ ] User can access frontend
- [ ] Query endpoint returns valid responses
- [ ] Diagram endpoint generates Mermaid code
- [ ] Diagrams render correctly in browser
- [ ] Error handling works correctly
- [ ] CORS configured properly

### 20. Performance Testing
- [ ] API response time < 3 seconds
- [ ] Frontend loads in < 2 seconds
- [ ] No memory leaks in Lambda
- [ ] CloudWatch metrics look healthy

### 21. Load Testing (Optional)
- [ ] Simulate 100 concurrent users
- [ ] Monitor Lambda scaling
- [ ] Check for throttling errors
- [ ] Verify auto-scaling works

## Production Readiness

### 22. Final Checks
- [ ] All environment variables set correctly
- [ ] No hardcoded credentials in code
- [ ] `.env` files in `.gitignore`
- [ ] All secrets stored securely
- [ ] Backup strategy documented
- [ ] Disaster recovery plan documented

### 23. Launch Preparation
- [ ] Staging environment tested (if applicable)
- [ ] Production deployment scheduled
- [ ] Team notified of deployment
- [ ] Rollback plan prepared
- [ ] Support team briefed

### 24. Post-Launch
- [ ] Monitor CloudWatch logs for 24 hours
- [ ] Check error rates
- [ ] Verify user feedback
- [ ] Document any issues
- [ ] Plan next iteration

## Optional Enhancements

### 25. Advanced Features
- [ ] Custom domain for frontend (Vercel)
- [ ] Custom domain for API (API Gateway)
- [ ] SSL certificates configured
- [ ] CDN optimization
- [ ] Database for user data (DynamoDB)
- [ ] Authentication (Cognito)
- [ ] Rate limiting per user
- [ ] Analytics integration

### 26. Blockchain Integration
- [ ] Antigravity node configured
- [ ] Smart contracts deployed
- [ ] Proof of Learning integration
- [ ] Wallet integration

## Troubleshooting Resources

If you encounter issues:
- [ ] Check [DEPLOYMENT.md](DEPLOYMENT.md) for detailed instructions
- [ ] Review [docs/GITHUB_SETUP.md](docs/GITHUB_SETUP.md) for CI/CD help
- [ ] Check CloudWatch logs for backend errors
- [ ] Check Vercel logs for frontend errors
- [ ] Review [QUICKSTART.md](QUICKSTART.md) for local testing
- [ ] Open GitHub issue for support

## Success Criteria

✅ Deployment is successful when:
- Backend API is accessible and responding
- Frontend is deployed and loading
- API calls from frontend to backend work
- No errors in CloudWatch logs
- GitHub Actions workflows passing
- Monitoring and alarms configured
- Documentation updated

---

**Deployment Date**: _____________

**Deployed By**: _____________

**Production URLs**:
- Frontend: _____________
- Backend API: _____________

**Notes**:
_____________________________________________
_____________________________________________
_____________________________________________
