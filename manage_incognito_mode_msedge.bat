@echo off
:init
    setlocal DisableDelayedExpansion
    set "batchPath=%~0"
    for %%k in (%0) do set batchName=%%~nk
    set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
    setlocal EnableDelayedExpansion

:checkPrivileges
    NET FILE 1>NUL 2>NUL
    if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
    if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
    echo Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
    echo args = "ELEV " >> "%vbsGetPrivileges%"
    echo For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
    echo args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
    echo Next >> "%vbsGetPrivileges%"
    echo UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
    "%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
    exit /B

:gotPrivileges
    setlocal & pushd .
    cd /d %~dp0
    if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
    goto main




:main
cls
title Manage incognito mode - Microsoft Edge
echo ==================================
echo Manage Edge's Incognito Mode
echo ==================================
echo.
echo This involves some registry editing, which will require administrative privileges.
echo.
echo Please choose what do you want to do to Edge's built-in incognito mode:
echo.
echo 1-Disable Edge's incognito mode.
echo 2-Enable Edge's incognito mode.
echo 3-Exit this script.
echo.
choice /c 123 /M "Choose an option: "
if %errorlevel% == 1 goto disable
if %errorlevel% == 2 goto enable
if %errorlevel% == 3 goto quit
rem abnormal exiting...
exit /b 25 

:disable
    cls
    rem disable Edge's incognito mode.
    echo.
    echo Disable Edge's incognito mode.
    echo.
    echo Step #1, create edge policies registry key.
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /f
    echo Step #1 complete, going to step #2
    echo Step #2, create the "InPrivateModeAvailability" registry value...
    echo.
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "InPrivateModeAvailability" /t REG_DWORD /d 1 /f
    echo.
    echo Steps #1, #2 done, Disabled Edge's incognito mode.
    echo.
    rem all done prompt
    echo Everything is done, press any key to close this window...
    pause >nul
    exit /b 0

:enable
    cls
    rem enable Edge's incognito mode.
    echo.
    echo Enable Edge's incognito mode.
    echo.
    echo Step #1, delete edge policies registry key.
    echo.
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /f
    echo.
    echo Step #1 done, Enabled edge's incognito mode again.
    echo.
    rem all done prompt
    echo Everything is done, press any key to close this window...
    pause >nul
    exit /b 0


:quit
    rem when error level is not 1 or 2
    rem when the user chooses 3 to exit this script file.
    cls
    echo.
    echo User has chosen to exit this script file.
    echo Press any key to close this window...
    pause >nul
    exit /b 0


rem abnormal exiting.
exit /b 25
