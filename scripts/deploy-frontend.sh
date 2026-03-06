#!/bin/bash

# Architect-AI Frontend Deployment Script
# Deploys React frontend to Vercel

set -e

echo "🚀 Starting Architect-AI Frontend Deployment..."

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "❌ Vercel CLI not found. Installing..."
    npm install -g vercel
fi

# Navigate to frontend directory
cd frontend

# Check if .env exists
if [ ! -f .env ]; then
    echo "⚠️  Warning: .env file not found. Creating from example..."
    cp .env.example .env
    echo "❗ Please update frontend/.env with your API Gateway URL before deploying!"
    exit 1
fi

echo "📦 Installing dependencies..."
npm install

echo "🔨 Building application..."
npm run build

echo "🚢 Deploying to Vercel..."
vercel --prod

echo "✅ Frontend deployment complete!"
echo ""
echo "💡 Don't forget to set environment variables in Vercel dashboard:"
echo "   VITE_API_URL=<your-api-gateway-url>"
