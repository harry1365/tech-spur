@echo off
echo ========================================
echo   Architect-AI Git Setup and Push
echo ========================================
echo.

REM Check if Git is available
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Git is not found in PATH
    echo.
    echo Please do ONE of the following:
    echo 1. Close this terminal and open a NEW terminal window
    echo 2. OR restart your computer
    echo 3. OR manually add Git to PATH:
    echo    - Right-click "This PC" ^> Properties
    echo    - Advanced system settings ^> Environment Variables
    echo    - Edit PATH and add: C:\Program Files\Git\cmd
    echo.
    pause
    exit /b 1
)

echo Git found! Version:
git --version
echo.

REM Configure Git if not already configured
git config --global user.email >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Setting up Git configuration...
    set /p email="Enter your email for Git: "
    set /p name="Enter your name for Git: "
    git config --global user.email "%email%"
    git config --global user.name "%name%"
    echo Git configured!
    echo.
)

echo Current Git user:
git config --global user.name
git config --global user.email
echo.

REM Initialize Git repository
echo Initializing Git repository...
git init
echo.

REM Add remote
echo Adding GitHub remote...
git remote remove origin 2>nul
git remote add origin https://github.com/harry1365/tech-spur.git
echo.

REM Check status
echo Checking repository status...
git status
echo.

REM Add all files
echo Adding all files...
git add .
echo.

REM Commit
echo Creating commit...
git commit -m "feat: Complete deployment setup with AWS Lambda + Vercel - Add AWS SAM infrastructure templates - Add GitHub Actions CI/CD workflows - Add deployment scripts for Windows and Linux - Add comprehensive documentation - Configure Vercel deployment - Add environment variable templates - Update README with deployment instructions - Add security and monitoring configurations"
echo.

REM Push to GitHub
echo.
echo ========================================
echo   Ready to Push to GitHub!
echo ========================================
echo.
echo Repository: https://github.com/harry1365/tech-spur
echo.
echo You will be prompted for your GitHub credentials.
echo.
echo IMPORTANT: If you have 2FA enabled, you need to use a Personal Access Token instead of your password.
echo Get token from: https://github.com/settings/tokens
echo.
pause

echo Pushing to GitHub...
git branch -M main
git push -u origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo   SUCCESS! Code pushed to GitHub!
    echo ========================================
    echo.
    echo Next steps:
    echo 1. Go to https://github.com/harry1365/tech-spur
    echo 2. Verify all files are there
    echo 3. Follow DEPLOYMENT.md to deploy to production
    echo.
) else (
    echo.
    echo ========================================
    echo   Push failed!
    echo ========================================
    echo.
    echo Common issues:
    echo 1. Authentication failed - Use Personal Access Token if you have 2FA
    echo 2. Repository already exists - Try: git pull origin main --rebase
    echo 3. Network issues - Check your internet connection
    echo.
    echo For help, see PUSH_TO_GITHUB.md
    echo.
)

pause
