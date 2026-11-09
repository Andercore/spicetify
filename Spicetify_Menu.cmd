@echo off
chcp 65001 >nul
set "cols=100"
mode con: cols=%cols% lines=30
setlocal EnableDelayedExpansion
title Spicetify Menu
color 0a
cls

net session >nul 2>&1
if %errorlevel%==0 (
    call :centerText "Please do NOT run this script as Administrator."
    pause
    exit /b
)

:welcome
cls
call :centerText "Welcome to the Spicetify Menu!"
call :centerText ""
call :centerText "Is the Spotify desktop app installed? (Y/N):"
choice /c YN /n
if errorlevel 2 (
    call :displayMessage "Spotify desktop app is required for the menu to work!"
    pause
    exit /b 0
)

:menu
color 0a
cls
echo.
call :centerText "SPICETIFY MENU"
echo.
echo ┌────┬───────────────────────────────┐
echo │ OP │           Action              │
echo ├────┼───────────────────────────────┤
echo │  1 │ Install                       │
echo │  2 │ Update                        │
echo │  3 │ Uninstall                     │
echo │  0 │ Exit                          │
echo ├────┴───────────────────────────────┤
echo │ Press the key for the desired option│
echo └────────────────────────────────────┘
echo.

choice /c 1230 /n /m "Select an option: "
if errorlevel 4 goto option0
if errorlevel 3 goto option3
if errorlevel 2 goto option2
if errorlevel 1 goto option1
goto menu

:option1
call :install
goto menu

:option2
call :update
goto menu

:option3
call :uninstall
goto menu

:option0
exit /b 0

:install
color 0a
cls
call :displayMessage "Installing Spicetify..."
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.ps1 | iex"
if %errorlevel% neq 0 exit /b %errorlevel%
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.ps1 | iex"
if %errorlevel% neq 0 exit /b %errorlevel%
call :displayMessage "Applying Spicetify..."
spicetify backup
if %errorlevel% neq 0 exit /b %errorlevel%
call :displayMessage "Restarting Spotify..."
spicetify restart
if %errorlevel% neq 0 exit /b %errorlevel%
call :displayMessage "Spicetify Installed!"
timeout /t 2 /nobreak >nul
call :question
exit /b 0

:update
color 0a
cls
call :displayMessage "Updating Spicetify..."
spicetify upgrade
if %errorlevel% neq 0 exit /b %errorlevel%
spicetify restore
if %errorlevel% neq 0 exit /b %errorlevel%
spicetify clear
if %errorlevel% neq 0 exit /b %errorlevel%
spicetify backup
if %errorlevel% neq 0 exit /b %errorlevel%
spicetify apply
if %errorlevel% neq 0 exit /b %errorlevel%
spicetify restart
if %errorlevel% neq 0 exit /b %errorlevel%
call :displayMessage "Spicetify Updated!"
timeout /t 2 /nobreak >nul
exit /b 0

:uninstall
color 0a
cls
choice /c YN /n /m "Are you sure you want to uninstall Spicetify? (Y/N): "
if errorlevel 2 exit /b 0
call :removeSpicetify
exit /b 0

:question
color 0a
cls
choice /c YN /n /m "Did the Spicetify installation work? (Y/N): "
if errorlevel 2 (
    call :removeSpicetify
    call :install
)
if errorlevel 1 exit /b 0
exit /b 0

:removeSpicetify
call :displayMessage "Uninstalling Spicetify..."
spicetify restore
if %errorlevel% neq 0 exit /b %errorlevel%
spicetify config current_theme default
if %errorlevel% neq 0 exit /b %errorlevel%
spicetify clear
if %errorlevel% neq 0 exit /b %errorlevel%
rmdir /S /Q "%APPDATA%\spicetify"
rmdir /S /Q "%LOCALAPPDATA%\spicetify"
call :displayMessage "Spicetify Uninstalled!"
timeout /t 2 /nobreak >nul
exit /b 0

:displayMessage
cls
setlocal EnableDelayedExpansion
call :centerText "┌==========================================┐"
call :centerText "│                                          │"
call :centerText "│  %~1"
call :centerText "│                                          │"
call :centerText "└==========================================┘"
echo.
endlocal
exit /b 0

:centerText
setlocal EnableDelayedExpansion
set "str=%~1"
if "!str!"=="" (
    echo.
    endlocal
    exit /b 0
)
set "len=0"
set "tmpstr=!str!"
:strlen_loop
if not "!tmpstr!"=="" (
    set "tmpstr=!tmpstr:~1!"
    set /a len+=1
    goto strlen_loop
)
set /a spaces=(cols - len)/2
set "pad="
for /l %%i in (1,1,!spaces!) do set "pad=!pad! "
echo !pad!%~1
endlocal
exit /b 0
