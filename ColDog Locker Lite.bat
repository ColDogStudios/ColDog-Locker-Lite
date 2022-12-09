@echo off
setlocal enabledelayedexpansion
set "vrsn=v0.5.1"
:: Date Modified: 8/2/22
set "bar=----------------------------------------------"
set "cdl=-         ColDog Locker Lite %vrsn%          -"
set "cpr=-  (c) ColDog Studios. All rights reserved.  -"
title ColDog Locker Lite %vn%
if exist "private" goto UNLOCK
if exist "Locker" goto MENU
md Locker
exit /b
:MENU
cls
echo %bar%
echo %cdl%
echo %cpr%
echo %bar%
echo.
echo Lock the folder? [ Y/n ]
echo.
set /p "menuChoice=> "
if /i %menuChoice%==Y goto LOCK
if /i %menuChoice%==n exit /b
echo
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Invalid Choice
echo. 
pause > nul | set /p ="Press any key to retry . . . "
goto MENU
:LOCK
ren "Locker" "private"
attrib +h +s "private"
exit /b
:UNLOCK
cls
echo %bar%
echo %cdl%
echo %cpr%
echo %bar%
echo.
set "inputPass=powershell -Command "$pword = read-host 'Enter Password' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
    [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%inputPass%`) do set lockerKey=%%p
if NOT %lockerKey%==password goto FAIL
:SUCCESS
attrib -h -s private
ren private Locker
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Folder unlocked.
echo.
pause > nul | set /p ="Press any key to exit . . . "
exit /b
:FAIL
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Incorrect Password!
echo.
pause > nul | set /p ="Press any key to retry . . . "
goto UNLOCK
