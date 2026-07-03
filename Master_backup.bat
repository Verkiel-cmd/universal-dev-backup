@echo off
cls
title Universal Project Backup Utility - Strict Guardrail System
REM ============================================================
REM   UNIVERSAL DEV BACKUP SYSTEM: With Automated Path Guardrails
REM ============================================================

:SETUP_PATHS
cls
color 0F
echo ============================================================
echo               PROJECT CONFIGURATION SETUP
echo ============================================================
echo   [1] Use Ezeki's Default PC Paths
echo   [2] Input Custom Paths (For GitHub Users / Other Projects)
echo ============================================================
echo.
set /p path_choice="Select an option (1 or 2) then press Enter: "

if "%path_choice%"=="1" (
    :: Your personal default setup
    set "PROJECT_NAME=Student Management System"
    set "PROD_SOURCE=C:\Users\ezeki\Downloads\ezeki_live-code~[student-management-system]\PRODUCTION_student-management-frontend"
    set "PROD_DEST=G:\My Drive\Universal-devs-data\PRODUCTION_student-management-frontend"
    set "LOCAL_SOURCE=C:\Users\ezeki\Downloads\ezeki_local-code~[student-management-system]\LOCALHOST_student-management-frontend"
    set "LOCAL_DEST=G:\My Drive\Universal-devs-data\LOCALHOST_student-management-frontend"
    title %PROJECT_NAME% - Strict Guardrail Backup Utility
    goto MENU
)
if "%path_choice%"=="2" goto CUSTOM_INPUT
goto SETUP_PATHS

:CUSTOM_INPUT
cls
echo ============================================================
echo              ENTER YOUR PROJECT ENVIRONMENT INFO
echo ============================================================
echo.
set /p PROJECT_NAME="1. Enter your Project Name (e.g., E-Commerce App): "

:: Update the command prompt window title dynamically
title %PROJECT_NAME% - Strict Guardrail Backup Utility

echo.
echo ------------------------------------------------------------
echo   ENTER YOUR FOLDER PATHS (Right-Click to Paste or Drag Folder)
echo ------------------------------------------------------------
set /p PROD_SOURCE="2. Enter Live PRODUCTION Source Path: "
set /p PROD_DEST="3. Enter PRODUCTION Backup (Cloud/Drive) Path: "
echo.
set /p LOCAL_SOURCE="4. Enter Live LOCALHOST Source Path: "
set /p LOCAL_DEST="5. Enter LOCALHOST Backup (Cloud/Drive) Path: "

:: PRO-DEV GUARDRAIL: Strip quotes if they dragged/dropped folders with spaces
set PROD_SOURCE=%PROD_SOURCE:"=%
set PROD_DEST=%PROD_DEST:"=%
set LOCAL_SOURCE=%LOCAL_SOURCE:"=%
set LOCAL_DEST=%LOCAL_DEST:"=%
goto MENU

:MENU
cls
color 0F
echo ============================================================
echo   PROJECT: %PROJECT_NAME% BACKUP UTILITY
echo ============================================================
echo   Current Active Target Paths:
echo   Prod Src:  %PROD_SOURCE%
echo   Local Src: %LOCAL_SOURCE%
echo ============================================================
echo.
echo  [1] Run SAFE SIMULATION (Test paths without changing files)
echo  [2] Run LIVE BACKUP     (Sync everything to Google Drive)
echo  [3] Reset Paths / Change Project Name
echo  [4] Exit
echo.
echo ============================================================
echo.

set /p choice="Enter your choice (1-4) then press Enter: "

if "%choice%"=="1" goto INITIALIZE_SIM
if "%choice%"=="2" goto INITIALIZE_LIVE
if "%choice%"=="3" goto SETUP_PATHS
if "%choice%"=="4" goto EXIT
goto INVALID

:INITIALIZE_SIM
set MODE=SIMULATION
goto VERIFY_PATHS

:INITIALIZE_LIVE
set MODE=LIVE
goto VERIFY_PATHS

:VERIFY_PATHS
cls
echo ============================================================
echo  GUARDRAIL ACTIVE: Verifying all folder paths match exactly...
echo ============================================================
echo.

:: Strict Folder Verification Checks
if not exist "%PROD_SOURCE%" set "FAILED_PATH=PRODUCTION SOURCE" & set "PATH_VAL=%PROD_SOURCE%" & goto PATH_ERROR
if not exist "%PROD_DEST%" set "FAILED_PATH=PRODUCTION DESTINATION" & set "PATH_VAL=%PROD_DEST%" & goto PATH_ERROR
if not exist "%LOCAL_SOURCE%" set "FAILED_PATH=LOCALHOST SOURCE" & set "PATH_VAL=%LOCAL_SOURCE%" & goto PATH_ERROR
if not exist "%LOCAL_DEST%" set "FAILED_PATH=LOCALHOST DESTINATION" & set "PATH_VAL=%LOCAL_DEST%" & goto PATH_ERROR

echo [OK] All paths verified and match perfectly! Proceeding...
timeout /t 2 >nul
if "%MODE%"=="SIMULATION" goto SIMULATION
if "%MODE%"=="LIVE" goto LIVE
goto MENU

:SIMULATION
cls
echo ============================================================
echo  RUNNING SIMULATION MODE... (No files will be modified)
echo ============================================================
echo.
echo --- [1/2] Simulating PRODUCTION... ---
robocopy "%PROD_SOURCE%" "%PROD_DEST%" /MIR /XD node_modules dist .git /R:2 /W:5 /L
echo.
echo --- [2/2] Simulating LOCALHOST... ---
robocopy "%LOCAL_SOURCE%" "%LOCAL_DEST%" /MIR /XD node_modules dist .git /R:2 /W:5 /L
echo.
echo ============================================================
echo  Simulation finished! No changes were made to your cloud.
echo ============================================================
goto END

:LIVE
cls
echo ============================================================
echo  WARNING: RUNNING LIVE BACKUP MODE...
echo ============================================================
echo.
echo --- [1/2] Syncing PRODUCTION to Backup Destination... ---
robocopy "%PROD_SOURCE%" "%PROD_DEST%" /MIR /XD node_modules dist .git /R:2 /W:5
echo.
echo --- [2/2] Syncing LOCALHOST to Backup Destination... ---
robocopy "%LOCAL_SOURCE%" "%LOCAL_DEST%" /MIR /XD node_modules dist .git /R:2 /W:5
echo.
echo ============================================================
echo  Live backup completed successfully!
echo ============================================================
goto END

:PATH_ERROR
color 0C
echo.
echo ❌ CRITICAL CONFIGURATION ERROR ❌
echo ------------------------------------------------------------
echo THE FOLLOWING PATH DOES NOT MATCH OR DOES NOT EXIST:
echo Target: %FAILED_PATH%
echo Path:   %PATH_VAL%
echo ------------------------------------------------------------
echo.
echo [!] OPERATION ABORTED. No files were read, copied, or modified.
echo Please fix your folder name or paths before trying again.
echo.
pause
color 0F
goto SETUP_PATHS

:INVALID
echo.
echo [!] Invalid selection. Please try again.
pause
goto MENU

:EXIT
echo.
echo Exiting utility. Goodbye!
goto END

:END
echo.
pause
exit