# 📋 Step-by-Step Guide - Push to GitHub & Deploy

Follow these steps exactly to get your project deployed.

---

## 🎯 STEP 1: Make Git Work

### Why Git Isn't Working Yet

You just installed Git, but your current terminal doesn't know about it yet.

### Fix It (Choose ONE):

**Option A: Restart Terminal (Fastest)**
1. Close this terminal window
2. Open a NEW terminal/PowerShell
3. Navigate to project: `cd C:\Users\Harry\Downloads\ArchitectAI-Clean`
4. Test Git: `git --version`
5. If you see a version number, Git works! ✅

**Option B: Restart Computer**
1. Restart your computer
2. Open terminal
3. Navigate to project: `cd C:\Users\Harry\Downloads\ArchitectAI-Clean`
4. Test Git: `git --version`
5. If you see a version number, Git works! ✅

---

## 🚀 STEP 2: Push to GitHub

Once Git is working, run this ONE command:

```bash
.\SETUP_GIT_AND_PUSH.bat
```

### What This Does:

1. ✅ Checks Git is working
2. ✅ Asks for your name and email (first time only)
3. ✅ Initializes Git repository
4. ✅ Adds all your files
5. ✅ Creates a commit
6. ✅ Pushes to https://github.com/harry1365/tech-spur

### You'll Be Asked For:

**Git Configuration (first time only):**
- Your name: `Harry` (or whatever you prefer)
- Your email: Your GitHub email

**GitHub Authentication:**
- Username: `harry1365`
- Password: 
  - **If you have 2FA enabled**: Use a Personal Access Token
    - Get it from: https://github.com/settings/tokens
    - Click "Generate new token (classic)"
    - Select `repo` scope
    - Copy the token and use it as password
  - **If no 2FA**: Use your regular GitHub password

---

## ✅ STEP 3: Verify on GitHub

1. Go to: https://github.com/harry1365/tech-spur
2. You should see all your files!
3. Check that these folders exist:
   - backend/
   - frontend/
   - infrastructure/
   - scripts/
   - docs/
   - .github/workflows/

---

## 🔧 STEP 4: Configure GitHub Secrets (For CI/CD)

Go to: https://github.com/harry1365/tech-spur/settings/secrets/actions

Click "New repository secret" and add:

### Backend Secrets:
1. **AWS_ACCESS_KEY_ID**
   - Get from AWS Console → IAM → Users → Security credentials
   
2. **AWS_SECRET_ACCESS_KEY**
   - Get from AWS Console → IAM → Users → Security credentials
   
3. **AWS_REGION**
   - Value: `us-east-1` (or your preferred region)

### Frontend Secrets:
4. **VERCEL_TOKEN**
   - Get from: https://vercel.com/account/tokens
   - Click "Create Token"
   - Copy and paste

---

## 🚀 STEP 5: Deploy Backend (AWS Lambda)

### Option A: Manual Deployment

```bash
scripts\deploy-backend.bat
```

This will:
1. Build your Flask app
2. Package it with SAM
3. Deploy to AWS Lambda
4. Give you an API Gateway URL

**Save the API Gateway URL!** You'll need it for the frontend.

### Option B: Automatic (via GitHub Actions)

Just push to main branch and GitHub Actions will deploy automatically!

---

## 🌐 STEP 6: Deploy Frontend (Vercel)

### First, Update Environment Variable:

1. Edit `frontend/.env`
2. Set: `VITE_API_URL=<your-api-gateway-url-from-step-5>`
3. Save the file

### Then Deploy:

**Option A: Manual**
```bash
scripts\deploy-frontend.bat
```

**Option B: Automatic (via GitHub Actions)**
Push to main branch and it deploys automatically!

---

## 🎉 STEP 7: Verify Everything Works

### Backend Check:
```bash
curl <your-api-gateway-url>/health
```

Should return: `{"status": "ok", "message": "Architect-AI Backend is running"}`

### Frontend Check:
1. Open your Vercel URL in browser
2. Check browser console (F12) for errors
3. Try making a query
4. Try generating a diagram

---

## 📊 Quick Reference

### Commands You'll Use:

```bash
# Push to GitHub
.\SETUP_GIT_AND_PUSH.bat

# Test locally
start.bat

# Deploy backend
scripts\deploy-backend.bat

# Deploy frontend
scripts\deploy-frontend.bat

# Check Git status
git status

# View logs
aws logs tail /aws/lambda/architect-ai-stack-ArchitectAIFunction --follow
```

---

## 🆘 Troubleshooting

### Git Not Working
→ See [GIT_NOT_WORKING.md](GIT_NOT_WORKING.md)

### Push Failed
→ Check your GitHub credentials
→ Use Personal Access Token if you have 2FA
→ See [PUSH_TO_GITHUB.md](PUSH_TO_GITHUB.md)

### Backend Deployment Failed
→ Check AWS credentials: `aws sts get-caller-identity`
→ Check CloudWatch logs
→ See [DEPLOYMENT.md](DEPLOYMENT.md)

### Frontend Deployment Failed
→ Check Vercel token
→ Test build locally: `cd frontend && npm run build`
→ See [DEPLOYMENT.md](DEPLOYMENT.md)

---

## 📚 Documentation

- **DO_THIS_NOW.md** - Quick start
- **START_HERE.md** - Complete guide
- **DEPLOYMENT.md** - Detailed deployment
- **DEPLOYMENT_CHECKLIST.md** - Checklist
- **GIT_NOT_WORKING.md** - Git troubleshooting
- **PUSH_TO_GITHUB.md** - GitHub push help

---

## ✅ Success Checklist

- [ ] Git is working (`git --version`)
- [ ] Code pushed to GitHub
- [ ] GitHub Secrets configured
- [ ] Backend deployed to AWS Lambda
- [ ] API Gateway URL obtained
- [ ] Frontend environment updated
- [ ] Frontend deployed to Vercel
- [ ] Health check passes
- [ ] Frontend loads without errors
- [ ] API calls work from frontend

---

## 🎯 Current Step

**YOU ARE HERE:** Step 1 - Make Git Work

**NEXT:** Close terminal, open new one, run `.\SETUP_GIT_AND_PUSH.bat`

---

**Let's get this deployed! 🚀**
