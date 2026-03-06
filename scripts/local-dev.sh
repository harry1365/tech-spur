#!/bin/bash

# Architect-AI Local Development Script
# Runs both frontend and backend locally

set -e

echo "🚀 Starting Architect-AI Local Development Environment..."

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 not found. Please install Python 3.11+"
    exit 1
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js not found. Please install Node.js 18+"
    exit 1
fi

# Setup backend
echo "📦 Setting up backend..."
cd backend
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi
source venv/bin/activate
pip install -r requirements.txt

# Check for backend .env
if [ ! -f .env ]; then
    echo "⚠️  Creating backend/.env from example..."
    cp .env.example .env
fi

# Setup frontend
echo "📦 Setting up frontend..."
cd ../frontend
if [ ! -d "node_modules" ]; then
    npm install
fi

# Check for frontend .env
if [ ! -f .env ]; then
    echo "⚠️  Creating frontend/.env from example..."
    cp .env.example .env
    echo "VITE_API_URL=http://localhost:5000" > .env
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "🎯 Starting services..."
echo "   Backend: http://localhost:5000"
echo "   Frontend: http://localhost:5173"
echo ""

# Start backend in background
cd ../backend
python app.py &
BACKEND_PID=$!

# Start frontend
cd ../frontend
npm run dev

# Cleanup on exit
trap "kill $BACKEND_PID" EXIT
