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
echo   [1] Use Ezeki's Default PC Paths (Fixed 8-Path Sync)
echo   [2] Input Custom Paths (Dynamic Folder Allocator)
echo ============================================================
echo.
set /p path_choice="Select an option (1 or 2) then press Enter: "

if "%path_choice%"=="1" (
    :: Ezeki's pristine default setup - UNTOUCHED
    set "PROJECT_NAME=Student Management System"
    set "SYNC_MODE=FULL_STACK"
    
    set "PROD_SOURCE=C:\Users\ezeki\Downloads\ezeki_live-code~[student-management-system]\PRODUCTION_student-management-frontend"
    set "PROD_DEST=G:\My Drive\Universal-devs-data\PRODUCTION_student-management-frontend"
    set "LOCAL_SOURCE=C:\Users\ezeki\Downloads\ezeki_local-code~[student-management-system]\LOCALHOST_student-management-frontend"
    set "LOCAL_DEST=G:\My Drive\Universal-devs-data\LOCALHOST_student-management-frontend"
    
    set "BACKEND_PROD_SOURCE=C:\Users\ezeki\Downloads\ezeki_live-code~[student-management-system]\PRODUCTION_student-management-backend"
    set "BACKEND_PROD_DEST=G:\My Drive\Universal-devs-data\PRODUCTION_student-management-backend"
    set "BACKEND_LOCAL_SOURCE=C:\Users\ezeki\Downloads\ezeki_local-code~[student-management-system]\LOCALHOST_student-management-backend"
    set "BACKEND_LOCAL_DEST=G:\My Drive\Universal-devs-data\LOCALHOST_student-management-backend"
    
    title %PROJECT_NAME% - Strict Guardrail Backup Utility
    goto VERIFY_PATHS
)
if "%path_choice%"=="2" goto CUSTOM_WIZARD
goto SETUP_PATHS

:CUSTOM_WIZARD
cls
echo ============================================================
echo             DYNAMIC CUSTOM PATH ALLOCATOR
echo ============================================================
echo  What structural components do you want to sync?
echo ------------------------------------------------------------
echo   [1] Single Environment Pipeline (2 Folders - 1 Src, 1 Dest)
echo   [2] Frontend Architecture Only  (4 Folders - Local + Prod)
echo   [3] Backend Architecture Only   (4 Folders - Local + Prod)
echo   [4] Full-Stack Combo Ecosystem   (8 Folders - All Profiles)
echo ============================================================
echo.
set /p sync_scope="Enter choice (1, 2, 3, or 4): "

if "%sync_scope%"=="1" set "SYNC_MODE=SINGLE_ENV" & goto CUSTOM_INPUT
if "%sync_scope%"=="2" set "SYNC_MODE=FRONTEND_ONLY" & goto CUSTOM_INPUT
if "%sync_scope%"=="3" set "SYNC_MODE=BACKEND_ONLY" & goto CUSTOM_INPUT
if "%sync_scope%"=="4" set "SYNC_MODE=FULL_STACK" & goto CUSTOM_INPUT
goto CUSTOM_WIZARD

:CUSTOM_INPUT
cls
echo ============================================================
echo               CUSTOM PROJECT PATH CONFIGURATION
echo ============================================================
set /p PROJECT_NAME="Enter Project Name: "

if "%SYNC_MODE%"=="SINGLE_ENV" goto INPUT_SINGLE
if "%SYNC_MODE%"=="BACKEND_ONLY" goto INPUT_BACKEND

:INPUT_FRONTEND
echo.
echo --- [FRONTEND CHANNELS REGISTRATION] ---
set /p PROD_SOURCE="Enter FRONTEND PRODUCTION Source Path: "
set /p PROD_DEST="Enter FRONTEND PRODUCTION Destination Path: "
set /p LOCAL_SOURCE="Enter FRONTEND LOCALHOST Source Path: "
set /p LOCAL_DEST="Enter FRONTEND LOCALHOST Destination Path: "
if "%SYNC_MODE%"=="FRONTEND_ONLY" goto VERIFY_PATHS

:INPUT_BACKEND
echo.
echo --- [BACKEND CHANNELS REGISTRATION] ---
set /p BACKEND_PROD_SOURCE="Enter BACKEND PRODUCTION Source Path: "
set /p BACKEND_PROD_DEST="Enter BACKEND PRODUCTION Destination Path: "
set /p BACKEND_LOCAL_SOURCE="Enter BACKEND LOCALHOST Source Path: "
set /p BACKEND_LOCAL_DEST="Enter BACKEND LOCALHOST Destination Path: "
goto VERIFY_PATHS

:INPUT_SINGLE
echo.
echo --- [SINGLE ENVIRONMENT REGISTRATION] ---
set /p SINGLE_SOURCE="Enter SOURCE Folder Path: "
set /p SINGLE_DEST="Enter DESTINATION Cloud Path: "
goto VERIFY_PATHS

:VERIFY_PATHS
cls
echo Verification: Checking if chosen targets are valid...

if "%SYNC_MODE%"=="SINGLE_ENV" goto VERIFY_SINGLE
if "%SYNC_MODE%"=="BACKEND_ONLY" goto VERIFY_BACKEND

:VERIFY_FRONTEND
echo "%PROD_SOURCE%" | findstr /I "G: My-Drive OneDrive Dropbox iCloud CloudSync" >nul && goto SWAP_ERROR
echo "%LOCAL_SOURCE%" | findstr /I "G: My-Drive OneDrive Dropbox iCloud CloudSync" >nul && goto SWAP_ERROR

if not exist "%PROD_SOURCE%" set "FAILED_PATH=FRONTEND PRODUCTION SOURCE" & set "PATH_VAL=%PROD_SOURCE%" & goto PATH_ERROR
if not exist "%PROD_DEST%" set "FAILED_PATH=FRONTEND PRODUCTION DESTINATION" & set "PATH_VAL=%PROD_DEST%" & goto PATH_ERROR
if not exist "%LOCAL_SOURCE%" set "FAILED_PATH=FRONTEND LOCALHOST SOURCE" & set "PATH_VAL=%LOCAL_SOURCE%" & goto PATH_ERROR
if not exist "%LOCAL_DEST%" set "FAILED_PATH=FRONTEND LOCALHOST DESTINATION" & set "PATH_VAL=%LOCAL_DEST%" & goto PATH_ERROR
if "%SYNC_MODE%"=="FRONTEND_ONLY" goto MENU

:VERIFY_BACKEND
echo "%BACKEND_PROD_SOURCE%" | findstr /I "G: My-Drive OneDrive Dropbox iCloud CloudSync" >nul && goto SWAP_ERROR
echo "%BACKEND_LOCAL_SOURCE%" | findstr /I "G: My-Drive OneDrive Dropbox iCloud CloudSync" >nul && goto SWAP_ERROR

if not exist "%BACKEND_PROD_SOURCE%" set "FAILED_PATH=BACKEND PRODUCTION SOURCE" & set "PATH_VAL=%BACKEND_PROD_SOURCE%" & goto PATH_ERROR
if not exist "%BACKEND_PROD_DEST%" set "FAILED_PATH=BACKEND PRODUCTION DESTINATION" & set "PATH_VAL=%BACKEND_PROD_DEST%" & goto PATH_ERROR
if not exist "%BACKEND_LOCAL_SOURCE%" set "FAILED_PATH=BACKEND LOCALHOST SOURCE" & set "PATH_VAL=%BACKEND_LOCAL_SOURCE%" & goto PATH_ERROR
if not exist "%BACKEND_LOCAL_DEST%" set "FAILED_PATH=BACKEND LOCALHOST DESTINATION" & set "PATH_VAL=%BACKEND_LOCAL_DEST%" & goto PATH_ERROR
goto MENU

:VERIFY_SINGLE
echo "%SINGLE_SOURCE%" | findstr /I "G: My-Drive OneDrive Dropbox iCloud CloudSync" >nul && goto SWAP_ERROR

if not exist "%SINGLE_SOURCE%" set "FAILED_PATH=SINGLE TARGET SOURCE" & set "PATH_VAL=%SINGLE_SOURCE%" & goto PATH_ERROR
if not exist "%SINGLE_DEST%" set "FAILED_PATH=SINGLE TARGET DESTINATION" & set "PATH_VAL=%SINGLE_DEST%" & goto PATH_ERROR
goto MENU

:MENU
cls
color 0F
echo ============================================================
echo   %PROJECT_NAME% - BACKUP UTILITY (%SYNC_MODE%)
echo ============================================================
echo   Active Target Configurations:
if "%SYNC_MODE%"=="SINGLE_ENV" (
    echo   [SRC]  %SINGLE_SOURCE%
    echo   [DEST] %SINGLE_DEST%
)
if not "%SYNC_MODE%"=="BACKEND_ONLY" if not "%SYNC_MODE%"=="SINGLE_ENV" (
    echo   [FE-PROD]  %PROD_SOURCE%
    echo   [FE-LOCAL] %LOCAL_SOURCE%
)
if not "%SYNC_MODE%"=="FRONTEND_ONLY" if not "%SYNC_MODE%"=="SINGLE_ENV" (
    echo   [BE-PROD]  %BACKEND_PROD_SOURCE%
    echo   [BE-LOCAL] %BACKEND_LOCAL_SOURCE%
)
echo ============================================================
echo   [1] RUN SAFE SIMULATION (Check changes without overwriting)
echo   [2] RUN LIVE BACKUP     (Mirror actual project directories)
echo   [3] Exit Utility
echo ============================================================
echo.
set /p action_choice="Select an option (1, 2, or 3) then press Enter: "

if "%action_choice%"=="1" goto SIMULATE
if "%action_choice%"=="2" goto LIVE
if "%action_choice%"=="3" goto EXIT
goto MENU

:SIMULATE
cls
echo ============================================================
echo  RUNNING SIMULATION MODE... (No files will be modified)
echo ============================================================
echo.
if "%SYNC_MODE%"=="SINGLE_ENV" goto SIM_SINGLE
if "%SYNC_MODE%"=="BACKEND_ONLY" goto SIM_BACKEND

:SIM_FRONTEND
echo --- Simulating FRONTEND PRODUCTION... ---
robocopy "%PROD_SOURCE%" "%PROD_DEST%" /L /S /E /DCOPY:DA /COPY:DAT /PURGE /MIR /R:2 /W:5 /XD node_modules dist .git
echo.
echo --- Simulating FRONTEND LOCALHOST... ---
robocopy "%LOCAL_SOURCE%" "%LOCAL_DEST%" /L /S /E /DCOPY:DA /COPY:DAT /PURGE /MIR /R:2 /W:5 /XD node_modules dist .git
echo.
if "%SYNC_MODE%"=="FRONTEND_ONLY" goto SIM_DONE

:SIM_BACKEND
echo --- Simulating BACKEND PRODUCTION... ---
robocopy "%BACKEND_PROD_SOURCE%" "%BACKEND_PROD_DEST%" /L /S /E /DCOPY:DA /COPY:DAT /PURGE /MIR /R:2 /W:5 /XD node_modules dist .git
echo.
echo --- Simulating BACKEND LOCALHOST... ---
robocopy "%BACKEND_LOCAL_SOURCE%" "%BACKEND_LOCAL_DEST%" /L /S /E /DCOPY:DA /COPY:DAT /PURGE /MIR /R:2 /W:5 /XD node_modules dist .git
echo.
goto SIM_DONE

:SIM_SINGLE
echo --- Simulating SINGLE ENVIRONMENT PIPELINE... ---
robocopy "%SINGLE_SOURCE%" "%SINGLE_DEST%" /L /S /E /DCOPY:DA /COPY:DAT /PURGE /MIR /R:2 /W:5 /XD node_modules dist .git
echo.

:SIM_DONE
echo ============================================================
echo  Simulation finished! No changes were made to your cloud.
echo ============================================================
pause
goto MENU

:LIVE
cls
echo ============================================================
echo  WARNING: RUNNING LIVE BACKUP MODE...
echo ============================================================
echo.
if "%SYNC_MODE%"=="SINGLE_ENV" goto LIVE_SINGLE
if "%SYNC_MODE%"=="BACKEND_ONLY" goto LIVE_BACKEND

:LIVE_FRONTEND
echo --- Syncing FRONTEND PRODUCTION to Backup Destination... ---
robocopy "%PROD_SOURCE%" "%PROD_DEST%" /MIR /XD node_modules dist .git /R:2 /W:5
echo.
echo --- Syncing FRONTEND LOCALHOST to Backup Destination... ---
robocopy "%LOCAL_SOURCE%" "%LOCAL_DEST%" /MIR /XD node_modules dist .git /R:2 /W:5
echo.
if "%SYNC_MODE%"=="FRONTEND_ONLY" goto LIVE_DONE

:LIVE_BACKEND
echo --- Syncing BACKEND PRODUCTION to Backup Destination... ---
robocopy "%BACKEND_PROD_SOURCE%" "%BACKEND_PROD_DEST%" /MIR /XD node_modules dist .git /R:2 /W:5
echo.
echo --- Syncing BACKEND LOCALHOST to Backup Destination... ---
robocopy "%BACKEND_LOCAL_SOURCE%" "%BACKEND_LOCAL_DEST%" /MIR /XD node_modules dist .git /R:2 /W:5
echo.
goto LIVE_DONE

:LIVE_SINGLE
echo --- Syncing SINGLE PIPELINE to Backup Destination... ---
robocopy "%SINGLE_SOURCE%" "%SINGLE_DEST%" /MIR /XD node_modules dist .git /R:2 /W:5
echo.

:LIVE_DONE
echo ============================================================
echo  Live backup completed successfully!
echo ============================================================
pause
goto MENU

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

:SWAP_ERROR
color 0C
cls
echo ============================================================
echo   ❌ CRITICAL GUARDRAIL INTERCEPTION: PATH REVERSAL DETECTED
echo ============================================================
echo   SECURITY ALERT: You assigned a Cloud backup path 
echo   as your [SOURCE] directory!
echo.
echo   Your local drive MUST be the SOURCE (where your live work is).
echo   The cloud drive MUST be the DESTINATION (backup target).
echo ------------------------------------------------------------
echo   [!] OPERATION SAFELY BLOCKED to prevent wiping out local code.
echo   Please re-run the utility and input your paths correctly.
echo ============================================================
echo.
pause
color 0F
goto SETUP_PATHS

:EXIT
cls
echo Exiting utility. Keep coding safely!
pause
exit
