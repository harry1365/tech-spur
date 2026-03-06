# 🚀 START HERE - Architect-AI Deployment Guide

Welcome! This guide will help you deploy Architect-AI to production in the correct order.

## 📋 What You Have Now

Your project is now **100% deployment-ready** with:

✅ AWS Lambda backend infrastructure  
✅ Vercel frontend configuration  
✅ GitHub Actions CI/CD pipelines  
✅ Deployment scripts (Windows & Linux)  
✅ Comprehensive documentation  
✅ Security configurations  
✅ Monitoring setup  

## 🎯 Deployment Path

Choose your deployment approach:

### Option A: Automated (Recommended)
Push to GitHub → GitHub Actions deploys everything automatically

### Option B: Manual
Run deployment scripts locally for more control

---

## 📍 Step-by-Step Guide

### STEP 1: Install Prerequisites

**Required Tools:**
- [ ] Git - [Download](https://git-scm.com/downloads)
- [ ] Node.js 18+ - [Download](https://nodejs.org/)
- [ ] Python 3.11+ - [Download](https://www.python.org/downloads/)
- [ ] AWS CLI - [Install Guide](https://aws.amazon.com/cli/)
- [ ] AWS SAM CLI - Run: `pip install aws-sam-cli`
- [ ] Vercel CLI - Run: `npm install -g vercel`

**Verify installations:**
```bash
git --version
node --version
python --version
aws --version
sam --version
vercel --version
```

### STEP 2: Test Locally (Optional but Recommended)

**Windows:**
```bash
start.bat
```

**Linux/Mac:**
```bash
bash scripts/local-dev.sh
```

This ensures everything works before deploying to production.

- Frontend: http://localhost:5173
- Backend: http://localhost:5000

### STEP 3: Set Up AWS

1. **Create AWS Account** (if you don't have one)
   - Go to https://aws.amazon.com
   - Sign up for free tier

2. **Configure AWS CLI**
   ```bash
   aws configure
   ```
   Enter:
   - AWS Access Key ID
   - AWS Secret Access Key
   - Default region: `us-east-1`
   - Default output format: `json`

3. **Enable Bedrock Access**
   - Go to AWS Console → Amazon Bedrock
   - Request access to Claude 3.5 Sonnet
   - Request access to Amazon Titan Embeddings

### STEP 4: Set Up Vercel

1. **Create Vercel Account**
   - Go to https://vercel.com
   - Sign up (free tier is fine)

2. **Login to Vercel CLI**
   ```bash
   vercel login
   ```

3. **Generate Token for CI/CD**
   - Go to https://vercel.com/account/tokens
   - Create new token
   - Save it for later (GitHub Secrets)

### STEP 5: Push to GitHub

Follow the guide in [PUSH_TO_GITHUB.md](PUSH_TO_GITHUB.md)

**Quick version:**
```bash
git init
git remote add origin https://github.com/harry1365/tech-spur.git
git add .
git commit -m "feat: Complete deployment setup"
git branch -M main
git push -u origin main
```

### STEP 6: Configure GitHub Secrets

Go to: https://github.com/harry1365/tech-spur/settings/secrets/actions

**Add these secrets:**

| Secret Name | Value | Where to Get It |
|-------------|-------|-----------------|
| `AWS_ACCESS_KEY_ID` | Your AWS key | AWS Console → IAM → Users |
| `AWS_SECRET_ACCESS_KEY` | Your AWS secret | AWS Console → IAM → Users |
| `AWS_REGION` | `us-east-1` | Your preferred region |
| `VERCEL_TOKEN` | Your token | https://vercel.com/account/tokens |

### STEP 7: Deploy Backend (AWS Lambda)

**Option A: Automatic (via GitHub Actions)**
- Push to main branch
- GitHub Actions will deploy automatically
- Check Actions tab for progress

**Option B: Manual**

Windows:
```bash
scripts\deploy-backend.bat
```

Linux/Mac:
```bash
bash scripts/deploy-backend.sh
```

**Save the API Gateway URL** from the output!

### STEP 8: Deploy Frontend (Vercel)

**Update environment variable first:**
1. Edit `frontend/.env`
2. Set `VITE_API_URL=<your-api-gateway-url>`

**Option A: Automatic (via GitHub Actions)**
- Push to main branch
- GitHub Actions will deploy automatically

**Option B: Manual**

Windows:
```bash
scripts\deploy-frontend.bat
```

Linux/Mac:
```bash
bash scripts/deploy-frontend.sh
```

### STEP 9: Configure Vercel Environment

1. Go to Vercel Dashboard
2. Select your project
3. Go to Settings → Environment Variables
4. Add: `VITE_API_URL` = `<your-api-gateway-url>`
5. Redeploy

### STEP 10: Verify Deployment

**Backend:**
```bash
curl <your-api-gateway-url>/health
```

Should return: `{"status": "ok", "message": "Architect-AI Backend is running"}`

**Frontend:**
- Open your Vercel URL in browser
- Check browser console for errors
- Test query functionality
- Test diagram generation

### STEP 11: Monitor

**CloudWatch Logs:**
```bash
aws logs tail /aws/lambda/architect-ai-stack-ArchitectAIFunction --follow
```

**Vercel Logs:**
```bash
vercel logs
```

---

## 📚 Documentation Reference

| Document | Purpose |
|----------|---------|
| [README.md](README.md) | Project overview |
| [QUICKSTART.md](QUICKSTART.md) | 5-minute local setup |
| [DEPLOYMENT.md](DEPLOYMENT.md) | Detailed deployment guide |
| [DEPLOYMENT_CHECKLIST.md](DEPLOYMENT_CHECKLIST.md) | Step-by-step checklist |
| [PUSH_TO_GITHUB.md](PUSH_TO_GITHUB.md) | GitHub push instructions |
| [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) | Complete project summary |
| [CONTRIBUTING.md](CONTRIBUTING.md) | How to contribute |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | System architecture |
| [docs/GITHUB_SETUP.md](docs/GITHUB_SETUP.md) | GitHub configuration |
| [docs/DESIGN.md](docs/DESIGN.md) | Technical design |
| [docs/API_SPEC.md](docs/API_SPEC.md) | API documentation |

---

## 🎯 Quick Decision Tree

**Want to test locally first?**
→ Run `start.bat` or `scripts/local-dev.sh`

**Ready to deploy?**
→ Follow Steps 1-11 above

**Want automated deployments?**
→ Push to GitHub (Steps 5-6), then GitHub Actions handles it

**Want manual control?**
→ Use deployment scripts (Steps 7-8, Option B)

**Need help?**
→ Check [DEPLOYMENT.md](DEPLOYMENT.md) or open a GitHub issue

---

## ⚡ Quick Commands Reference

```bash
# Local development
start.bat                          # Windows
bash scripts/local-dev.sh          # Linux/Mac

# Deploy backend
scripts\deploy-backend.bat         # Windows
bash scripts/deploy-backend.sh     # Linux/Mac

# Deploy frontend
scripts\deploy-frontend.bat        # Windows
bash scripts/deploy-frontend.sh    # Linux/Mac

# Push to GitHub
git add .
git commit -m "Your message"
git push origin main

# View logs
aws logs tail /aws/lambda/architect-ai-stack-ArchitectAIFunction --follow
vercel logs
```

---

## ✅ Success Criteria

Your deployment is successful when:

- ✅ Backend API responds to health check
- ✅ Frontend loads without errors
- ✅ API calls from frontend work
- ✅ Diagrams render correctly
- ✅ No errors in CloudWatch logs
- ✅ GitHub Actions workflows pass

---

## 🆘 Need Help?

1. Check the relevant documentation above
2. Review CloudWatch logs for backend issues
3. Review Vercel logs for frontend issues
4. Open an issue on GitHub
5. Check [DEPLOYMENT.md](DEPLOYMENT.md) troubleshooting section

---

## 🎉 What's Next?

After successful deployment:

1. Upload textbook PDFs to S3
2. Configure Bedrock Knowledge Base
3. Set up CloudWatch alarms
4. Configure custom domains
5. Enable user authentication
6. Add analytics

See [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) for the full roadmap!

---

**Ready to deploy? Start with Step 1! 🚀**
