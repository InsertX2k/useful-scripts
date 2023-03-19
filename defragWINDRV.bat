@echo off
cls
title Defrag Windows drive (+ boot optimization)
goto check_Permissions

:check_Permissions
    title 
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed, continuing to main function...
        goto mainProg
    ) else (
        echo Failure: Insufficient permissions, Administrative permissions required, Please run this file as Admin, Press any key to close this window...
    )

    pause >nul
    rem exiting with error code 10 to indicate a failure.
    exit /b 10
:mainProg
    cls
    echo Defrag Windows drive with boot optimization
    echo Windows drive is: %systemdrive% 
    echo.
    echo Stage #1: Analyzing volume
    echo.
    rem performs analyses on system drive (normal priority mode)
    defrag %systemdrive% /A /U /H
    echo.
    echo Stage #1 complete, continuing to stage #2
    echo Stage #2: Defrag System drive 
    echo.
    rem performs defragmentation on system drive (normal priority mode)
    defrag %systemdrive% /O /U /H
    echo.
    echo Stage #2 complete, continuing to stage #3
    echo Stage #3: Run Boot optimization
    echo.
    rem performs boot optimization on system drive (normal priority mode)
    defrag %systemdrive% /B /U /H
    echo.
    echo All pending operations has been completed.
    echo Press any key to close this window...
    pause >nul
    exit /b 0