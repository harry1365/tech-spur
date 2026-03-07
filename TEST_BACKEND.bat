@echo off
echo ========================================
echo   Testing Backend Only
echo ========================================
echo.

cd backend

REM Create virtual environment if it doesn't exist
if not exist venv (
    echo Creating Python virtual environment...
    python -m venv venv
)

REM Activate and install dependencies
echo Installing dependencies...
call venv\Scripts\activate.bat
pip install -r requirements.txt

REM Start the backend
echo.
echo ========================================
echo   Backend Server Starting!
echo ========================================
echo.
echo Backend API: http://localhost:5000
echo.
echo Test it by opening a browser and going to:
echo   http://localhost:5000/health
echo.
echo You should see: {"status": "ok", "message": "Architect-AI Backend is running"}
echo.
echo Press Ctrl+C to stop the server
echo.

python app.py

pause
