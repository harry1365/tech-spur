@echo off
REM Architect-AI Backend Deployment Script for Windows
REM Deploys Flask backend to AWS Lambda using SAM

echo Starting Architect-AI Backend Deployment...

REM Check if AWS CLI is installed
where aws >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo AWS CLI not found. Please install it first.
    exit /b 1
)

REM Check if SAM CLI is installed
where sam >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo SAM CLI not found. Installing...
    pip install aws-sam-cli
)

REM Navigate to infrastructure directory
cd infrastructure

echo Building SAM application...
call sam build

echo Deploying to AWS...
call sam deploy --no-confirm-changeset --no-fail-on-empty-changeset

echo Backend deployment complete!

REM Get API Gateway URL
echo.
echo Your API Gateway URL:
aws cloudformation describe-stacks --stack-name architect-ai-stack --query "Stacks[0].Outputs[?OutputKey=='ApiUrl'].OutputValue" --output text

echo.
echo Next steps:
echo 1. Copy the API URL above
echo 2. Update frontend/.env with VITE_API_URL=^<your-api-url^>
echo 3. Deploy frontend with: npm run deploy:frontend

cd ..
