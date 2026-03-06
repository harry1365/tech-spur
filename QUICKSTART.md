# Architect-AI Quick Start Guide

Get Architect-AI running locally in 5 minutes!

## Prerequisites

- Node.js 18+ ([Download](https://nodejs.org/))
- Python 3.11+ ([Download](https://www.python.org/downloads/))
- Git

## Step 1: Clone the Repository

```bash
git clone https://github.com/harry1365/tech-spur.git
cd tech-spur
```

## Step 2: Run Local Development

### Windows
```bash
scripts\local-dev.bat
```

### Linux/Mac
```bash
bash scripts/local-dev.sh
```

This script will:
- Install all dependencies
- Set up environment files
- Start both backend and frontend servers

## Step 3: Access the Application

- **Frontend**: http://localhost:5173
- **Backend API**: http://localhost:5000
- **Health Check**: http://localhost:5000/health

## What's Running?

### Backend (Flask)
- Python Flask API on port 5000
- Mock AI services (no AWS required for local dev)
- CORS enabled for frontend

### Frontend (React + Vite)
- React application on port 5173
- Hot module replacement enabled
- Tailwind CSS for styling

## Testing the API

```bash
# Health check
curl http://localhost:5000/health

# Query endpoint
curl -X POST http://localhost:5000/api/v1/query \
  -H "Content-Type: application/json" \
  -d '{"question": "What is a linked list?"}'

# Diagram endpoint
curl -X POST http://localhost:5000/api/v1/diagram \
  -H "Content-Type: application/json" \
  -d '{"topic": "Binary Search Tree"}'
```

## Next Steps

1. **Explore the Code**: Check out the project structure in README.md
2. **Deploy to Production**: Follow [DEPLOYMENT.md](DEPLOYMENT.md)
3. **Contribute**: See [CONTRIBUTING.md](CONTRIBUTING.md)

## Troubleshooting

### Port Already in Use
If port 5000 or 5173 is already in use:
- Stop the conflicting process
- Or modify the port in `backend/app.py` and `frontend/vite.config.js`

### Python Dependencies Fail
```bash
cd backend
python -m pip install --upgrade pip
pip install -r requirements.txt
```

### Node Dependencies Fail
```bash
cd frontend
rm -rf node_modules package-lock.json
npm install
```

### Backend Not Connecting
- Check if backend is running on http://localhost:5000/health
- Verify `VITE_API_URL` in `frontend/.env` is set to `http://localhost:5000`

## Need Help?

- Check [DEPLOYMENT.md](DEPLOYMENT.md) for detailed setup
- Open an issue on GitHub
- Review the [docs/](docs/) folder for technical details

Happy coding! 🚀
