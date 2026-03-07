@echo off
echo ========================================
echo   Architect-AI Local Setup
echo ========================================
echo.

REM Check Python
echo Checking Python...
python --version
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Python not found!
    echo Please install Python 3.11+ from https://www.python.org/downloads/
    pause
    exit /b 1
)
echo Python found!
echo.

REM Check Node.js
echo Checking Node.js...
node --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo WARNING: Node.js not found!
    echo.
    echo To run the full application, you need Node.js 18+
    echo Download from: https://nodejs.org/
    echo.
    echo For now, I'll start ONLY the backend (API server)
    echo.
    pause
    goto BACKEND_ONLY
)
echo Node.js found!
echo.

REM Full setup with both backend and frontend
echo ========================================
echo   Starting Full Application
echo ========================================
echo.

REM Setup Backend
echo [1/4] Setting up backend...
cd backend
if not exist venv (
    echo Creating Python virtual environment...
    python -m venv venv
)

echo [2/4] Installing backend dependencies...
call venv\Scripts\activate.bat
pip install -r requirements.txt

echo [3/4] Starting backend server...
start "Architect-AI Backend" cmd /k "cd /d %CD% && venv\Scripts\activate.bat && python app.py"
cd ..

REM Setup Frontend
echo [4/4] Setting up frontend...
cd frontend
if not exist node_modules (
    echo Installing frontend dependencies...
    npm install
)

echo Starting frontend...
echo.
echo ========================================
echo   Application Starting!
echo ========================================
echo.
echo Backend:  http://localhost:5000
echo Frontend: http://localhost:5173
echo.
echo Press Ctrl+C to stop the frontend
echo (Backend runs in separate window)
echo.

npm run dev
goto END

:BACKEND_ONLY
echo ========================================
echo   Starting Backend Only
echo ========================================
echo.

cd backend
if not exist venv (
    echo Creating Python virtual environment...
    python -m venv venv
)

echo Installing dependencies...
call venv\Scripts\activate.bat
pip install -r requirements.txt

echo.
echo ========================================
echo   Backend Server Starting!
echo ========================================
echo.
echo Backend API: http://localhost:5000
echo Health Check: http://localhost:5000/health
echo.
echo Press Ctrl+C to stop
echo.

python app.py

:END
