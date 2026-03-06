#!/bin/bash

# Architect-AI Backend Deployment Script
# Deploys Flask backend to AWS Lambda using SAM

set -e

echo "🚀 Starting Architect-AI Backend Deployment..."

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI not found. Please install it first."
    exit 1
fi

# Check if SAM CLI is installed
if ! command -v sam &> /dev/null; then
    echo "❌ SAM CLI not found. Installing..."
    pip install aws-sam-cli
fi

# Navigate to infrastructure directory
cd infrastructure

echo "📦 Building SAM application..."
sam build

echo "🚢 Deploying to AWS..."
sam deploy --no-confirm-changeset --no-fail-on-empty-changeset

echo "✅ Backend deployment complete!"

# Get API Gateway URL
echo ""
echo "📋 Your API Gateway URL:"
aws cloudformation describe-stacks \
  --stack-name architect-ai-stack \
  --query 'Stacks[0].Outputs[?OutputKey==`ApiUrl`].OutputValue' \
  --output text

echo ""
echo "💡 Next steps:"
echo "1. Copy the API URL above"
echo "2. Update frontend/.env with VITE_API_URL=<your-api-url>"
echo "3. Deploy frontend with: npm run deploy:frontend"
