@echo off
REM Architect-AI Local Development Script for Windows
REM Runs both frontend and backend locally

echo Starting Architect-AI Local Development Environment...

REM Check if Python is installed
where python >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Python not found. Please install Python 3.11+
    exit /b 1
)

REM Check if Node.js is installed
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Node.js not found. Please install Node.js 18+
    exit /b 1
)

REM Setup backend
echo Setting up backend...
cd backend
if not exist venv (
    python -m venv venv
)
call venv\Scripts\activate.bat
pip install -r requirements.txt

REM Check for backend .env
if not exist .env (
    echo Creating backend/.env from example...
    copy .env.example .env
)

REM Setup frontend
echo Setting up frontend...
cd ..\frontend
if not exist node_modules (
    npm install
)

REM Check for frontend .env
if not exist .env (
    echo Creating frontend/.env from example...
    echo VITE_API_URL=http://localhost:5000 > .env
)

echo.
echo Setup complete!
echo.
echo Starting services...
echo    Backend: http://localhost:5000
echo    Frontend: http://localhost:5173
echo.

REM Start backend in new window
cd ..\backend
start "Architect-AI Backend" cmd /k "venv\Scripts\activate.bat && python app.py"

REM Start frontend
cd ..\frontend
npm run dev
