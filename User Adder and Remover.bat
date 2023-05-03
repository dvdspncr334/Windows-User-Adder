@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo This script must be run as an administrator. Exiting...
    timeout /t 3 >nul
    exit /b 1
)

:mainMenu
cls
echo.
echo Select an option:
echo 1. Add a user
echo 2. Remove a user
echo 3. Exit
echo.
set /p choice="Enter your choice (1, 2, or 3): "

if "%choice%"=="1" goto addUser
if "%choice%"=="2" goto removeUser
if "%choice%"=="3" exit

:addUser
cls
echo.
echo Add a user:
echo 1. Guest user
echo 2. Custom Guest User
echo 3. Normal user
echo.
set /p userType="Enter user type (1 or 2 or 3): "

if "%userType%"=="1" goto addGuestUser
if "%userType%"=="2" goto addCustomGuestUser
if "%userType%"=="3" goto addNormalUser
goto addUser

:addGuestUser
cls
echo Adding a guest user to Windows 10...
net user GuestUser /add /comment:"Guest User Account" /expires:never /passwordreq:no
net localgroup "Guests" GuestUser /add
echo Successfully added GuestUser to the Guests group.
goto mainMenu

:addCustomGuestUser
cls
set /p guestUsername="Enter the guest username: "
net user %guestUsername% /add /comment:"Guest User Account" /expires:never /passwordreq:no
net localgroup "Guests" %guestUsername% /add
echo.
echo Guest user %guestUsername% added successfully.
timeout /t 2 >nul
goto mainMenu



:addNormalUser
cls
set /p normalUsername="Enter the normal username: "
set /p normalPassword="Enter the normal user's password: "
net user %normalUsername% %normalPassword% /add
net localgroup "Users" %normalUsername% /add
echo.
echo Normal user %normalUsername% added successfully.
timeout /t 2 >nul
goto mainMenu

:removeUser
cls
echo.
set /p removeUsername="Enter the username to be removed: "
net user %removeUsername% /delete
echo.
echo User %removeUsername% removed successfully.
timeout /t 2 >nul
goto mainMenu
