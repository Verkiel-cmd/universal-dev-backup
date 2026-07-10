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
echo   [3] Saved Path Profiles (Load, Save, View, or Delete)
echo ============================================================
echo.
set /p path_choice="Select an option (1, 2, or 3) then press Enter: "

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
    
    title %PROJECT_NAME% - Strict Guardrail 
    Backup Utility
    goto VERIFY_PATHS
)
if "%path_choice%"=="2" goto CUSTOM_WIZARD
if "%path_choice%"=="3" goto PROFILE_MANAGER
goto SETUP_PATHS

:PROFILE_MANAGER
cls
echo ============================================================
echo             SAVED PATH PROFILES MANAGER
echo ============================================================
echo   [1] Load a Saved Profile
echo   [2] View All Saved Profiles
echo   [3] Delete a Saved Profile
echo   [4] Go Back to Main Menu
echo ============================================================
echo.
set /p prof_choice="Select an option (1-4): "
if "%prof_choice%"=="1" goto LOAD_PROFILE
if "%prof_choice%"=="2" goto VIEW_PROFILES
if "%prof_choice%"=="3" goto DELETE_PROFILE
if "%prof_choice%"=="4" goto SETUP_PATHS
goto PROFILE_MANAGER

:LOAD_PROFILE
cls
echo ============================================================
echo                   LOAD PROFILE SELECTION
echo ============================================================
if not exist "saved_paths.txt" (
    echo   No saved profiles found yet! Go configure a custom path first.
    echo.
    pause
    goto PROFILE_MANAGER
)
echo   Available Saved Profiles:
echo   ------------------------------------------------------------
findstr /B "PROFILE:" saved_paths.txt
echo   ------------------------------------------------------------
echo.
set "LOAD_TARGET="
set /p LOAD_TARGET="Enter the EXACT Profile Name to load: "
if "%LOAD_TARGET%"=="" goto PROFILE_MANAGER

set "FOUND_PROF="
for /f "tokens=1* delims=" %%A in (saved_paths.txt) do (
    if "%%A"=="PROFILE:%LOAD_TARGET%" set FOUND_PROF=1
)
if not defined FOUND_PROF (
    echo.
    echo  [!] Profile "%LOAD_TARGET%" not found. Check spelling and capitalization.
    pause
    goto PROFILE_MANAGER
)

:: Read out variables matching this specific profile name
for /f "usebackq tokens=2,3 delims==" %%A in (`findstr /R "^%LOAD_TARGET%\." saved_paths.txt`) do (
    set "%%A=%%B"
)
echo.
echo  [+] Profile "%LOAD_TARGET%" successfully loaded into environment memory!
pause
goto VERIFY_PATHS

:VIEW_PROFILES
cls
echo ============================================================
echo               RAW PROFILE MANIFEST REGISTRY
echo ============================================================
if not exist "saved_paths.txt" (
    echo   No paths configurations have been saved yet.
) else (
    type saved_paths.txt
)
echo ============================================================
echo.
pause
goto PROFILE_MANAGER

:DELETE_PROFILE
cls
echo ============================================================
echo                   DELETE PROFILE CONFIGURATION
echo ============================================================
if not exist "saved_paths.txt" (
    echo   No profiles exist to delete.
    pause
    goto PROFILE_MANAGER
)
findstr /B "PROFILE:" saved_paths.txt
echo ------------------------------------------------------------
echo.
set "DEL_TARGET="
set /p DEL_TARGET="Enter the EXACT Profile Name to delete: "
if "%DEL_TARGET%"=="" goto PROFILE_MANAGER

:: Rewrite text file filtering out the profile marker and variables prefixed with profile name
if exist "saved_paths.tmp" del "saved_paths.tmp"
for /f "tokens=1* delims=" %%A in (saved_paths.txt) do (
    echo %%A | findstr /B "PROFILE:%DEL_TARGET%" >nul
    if errorlevel 1 (
        echo %%A | findstr /B "%DEL_TARGET%." >nul
        if errorlevel 1 (
            echo %%A>>saved_paths.tmp
        )
    )
)
move /y "saved_paths.tmp" "saved_paths.txt" >nul
echo.
echo  [-] Profile "%DEL_TARGET%" has been scrubbed from records.
pause
goto PROFILE_MANAGER

:SAVE_PROFILE_PROMPT
echo.
echo ============================================================
echo   WOULD YOU LIKE TO SAVE THIS RUN CONTEXT AS A PROFILE?
echo ============================================================
echo   [1] Yes, save it to persistent disk store
echo   [2] No, just proceed to verification menu directly
echo ============================================================
echo.
set /p save_choice="Select an option (1 or 2): "
if "%save_choice%"=="2" goto MENU
if not "%save_choice%"=="1" goto SAVE_PROFILE_PROMPT

cls
echo ============================================================
echo               CREATE UNIQUE PROFILE REGISTRATION
echo ============================================================
set "NEW_PROF_NAME="
set /p NEW_PROF_NAME="Assign a single alphanumeric profile name (No spaces): "
if "%NEW_PROF_NAME%"=="" goto SAVE_PROFILE_PROMPT

:: Wipe out any existing entry matching this name to act as an Update mechanism
if exist "saved_paths.txt" (
    if exist "saved_paths.tmp" del "saved_paths.tmp"
    for /f "tokens=1* delims=" %%A in (saved_paths.txt) do (
        echo %%A | findstr /B "PROFILE:%NEW_PROF_NAME%" >nul
        if errorlevel 1 (
            echo %%A | findstr /B "%NEW_PROF_NAME%." >nul
            if errorlevel 1 (
                echo %%A>>saved_paths.tmp
            )
        )
    )
    move /y "saved_paths.tmp" "saved_paths.txt" >nul
)

:: Append the active profile environment block to file
echo PROFILE:%NEW_PROF_NAME%>>saved_paths.txt
echo %NEW_PROF_NAME%.PROJECT_NAME=%PROJECT_NAME%>>saved_paths.txt
echo %NEW_PROF_NAME%.SYNC_MODE=%SYNC_MODE%>>saved_paths.txt
if "%SYNC_MODE%"=="SINGLE_ENV" (
    echo %NEW_PROF_NAME%.SINGLE_SOURCE=%SINGLE_SOURCE%>>saved_paths.txt
    echo %NEW_PROF_NAME%.SINGLE_DEST=%SINGLE_DEST%>>saved_paths.txt
)
if not "%SYNC_MODE%"=="BACKEND_ONLY" if not "%SYNC_MODE%"=="SINGLE_ENV" (
    echo %NEW_PROF_NAME%.PROD_SOURCE=%PROD_SOURCE%>>saved_paths.txt
    echo %NEW_PROF_NAME%.PROD_DEST=%PROD_DEST%>>saved_paths.txt
    echo %NEW_PROF_NAME%.LOCAL_SOURCE=%LOCAL_SOURCE%>>saved_paths.txt
    echo %NEW_PROF_NAME%.LOCAL_DEST=%LOCAL_DEST%>>saved_paths.txt
)
if not "%SYNC_MODE%"=="FRONTEND_ONLY" if not "%SYNC_MODE%"=="SINGLE_ENV" (
    echo %NEW_PROF_NAME%.BACKEND_PROD_SOURCE=%BACKEND_PROD_SOURCE%>>saved_paths.txt
    echo %NEW_PROF_NAME%.BACKEND_PROD_DEST=%BACKEND_PROD_DEST%>>saved_paths.txt
    echo %NEW_PROF_NAME%.BACKEND_LOCAL_SOURCE=%BACKEND_LOCAL_SOURCE%>>saved_paths.txt
    echo %NEW_PROF_NAME%.BACKEND_LOCAL_DEST=%BACKEND_LOCAL_DEST%>>saved_paths.txt
)
echo.>>saved_paths.txt

echo  [+] Profile "%NEW_PROF_NAME%" compiled and written successfully!
pause
goto MENU

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
if "%SYNC_MODE%"=="FRONTEND_ONLY" goto SAVE_PROFILE_PROMPT

:VERIFY_BACKEND
echo "%BACKEND_PROD_SOURCE%" | findstr /I "G: My-Drive OneDrive Dropbox iCloud CloudSync" >nul && goto SWAP_ERROR
echo "%BACKEND_LOCAL_SOURCE%" | findstr /I "G: My-Drive OneDrive Dropbox iCloud CloudSync" >nul && goto SWAP_ERROR

if not exist "%BACKEND_PROD_SOURCE%" set "FAILED_PATH=BACKEND PRODUCTION SOURCE" & set "PATH_VAL=%BACKEND_PROD_SOURCE%" & goto PATH_ERROR
if not exist "%BACKEND_PROD_DEST%" set "FAILED_PATH=BACKEND PRODUCTION DESTINATION" & set "PATH_VAL=%BACKEND_PROD_DEST%" & goto PATH_ERROR
if not exist "%BACKEND_LOCAL_SOURCE%" set "FAILED_PATH=BACKEND LOCALHOST SOURCE" & set "PATH_VAL=%BACKEND_LOCAL_SOURCE%" & goto PATH_ERROR
if not exist "%BACKEND_LOCAL_DEST%" set "FAILED_PATH=BACKEND LOCALHOST DESTINATION" & set "PATH_VAL=%BACKEND_LOCAL_DEST%" & goto PATH_ERROR
goto SAVE_PROFILE_PROMPT

:VERIFY_SINGLE
echo "%SINGLE_SOURCE%" | findstr /I "G: My-Drive OneDrive Dropbox iCloud CloudSync" >nul && goto SWAP_ERROR

if not exist "%SINGLE_SOURCE%" set "FAILED_PATH=SINGLE TARGET SOURCE" & set "PATH_VAL=%SINGLE_SOURCE%" & goto PATH_ERROR
if not exist "%SINGLE_DEST%" set "FAILED_PATH=SINGLE TARGET DESTINATION" & set "PATH_VAL=%SINGLE_DEST%" & goto PATH_ERROR
goto SAVE_PROFILE_PROMPT

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
echo Exiting utility.
Keep coding safely!
pause
exit
