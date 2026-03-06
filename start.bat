@echo off
REM Quick start script for Architect-AI
REM For full development setup, use scripts\local-dev.bat

echo ========================================
echo   Architect-AI Quick Start
echo ========================================
echo.

REM Check if we should use the full dev script
if exist scripts\local-dev.bat (
    echo Using full development setup...
    call scripts\local-dev.bat
) else (
    echo Starting basic setup...
    
    echo Starting Backend...
    cd backend
    if not exist venv (
        python -m venv venv
    )
    call venv\Scripts\activate.bat
    pip install -r requirements.txt
    start cmd /k "venv\Scripts\activate.bat && python app.py"
    cd ..
    
    echo Starting Frontend...
    cd frontend
    if not exist node_modules (
        npm install
    )
    npm run dev
)
