@echo off
REM Architect-AI Frontend Deployment Script for Windows
REM Deploys React frontend to Vercel

echo Starting Architect-AI Frontend Deployment...

REM Check if Vercel CLI is installed
where vercel >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Vercel CLI not found. Installing...
    npm install -g vercel
)

REM Navigate to frontend directory
cd frontend

REM Check if .env exists
if not exist .env (
    echo Warning: .env file not found. Creating from example...
    copy .env.example .env
    echo Please update frontend/.env with your API Gateway URL before deploying!
    exit /b 1
)

echo Installing dependencies...
call npm install

echo Building application...
call npm run build

echo Deploying to Vercel...
call vercel --prod

echo Frontend deployment complete!
echo.
echo Don't forget to set environment variables in Vercel dashboard:
echo    VITE_API_URL=^<your-api-gateway-url^>

cd ..
