@echo off
cls
setlocal enabledelayedexpansion

:: Check argument
if "%~1"=="" (
    echo Use `%~nx0 yourapp.apk` to Streaming Install.
    echo Use `%~nx0 logger` to open Logcat util.
    pause
    exit /b 1
)


set APK="%~NX1"
if "%~1"=="logger" (
    echo Opening Logcat util
) else echo Installing "%~NX1"


:: Get list of connected devices
for /f "skip=1 tokens=1" %%d in ('adb devices') do (
    if NOT "%%d"=="offline" if NOT "%%d"=="unauthorized" if NOT "%%d"=="" (
        set /a count+=1
        set device[!count!]=%%d
    )
)

:: No devices
if not defined device[1] (
    echo.
    echo X No connected Android devices found! X
    echo Please connect a device via USB and ensure USB debugging is enabled.
    pause
    exit /b 1
)

:: Single device
if "!count!"=="1" (
    set target=!device[1]!
    echo Found 1 device: !target!
    goto install
)

:: List devices with models
echo.
echo Multiple devices detected:
for /l %%i in (1,1,!count!) do (
    set "model="
    for /f "usebackq delims=" %%m in (`adb -s !device[%%i]! shell getprop ro.product.model 2^>nul`) do (
        set "model=%%m"
    )
    set "model=!model:$'\r'=!"
    echo   %%i^. !device[%%i]! `!model!`
)

echo.
set /p choice=Select number of target device: 

if not defined device[%choice%] (
    echo X Invalid choice. Exiting... X
    pause
    exit /b 1
)

set target=!device[%choice%]!

:install

if "%~1"=="logger" (
    goto :logcat_app
)

echo.
echo Installing %APK% on device `%target%`:
adb -s %target% install -d -r %APK%
if %ERRORLEVEL% neq 0 (
    echo.
    echo X Installation failed, Checking for version downgrade issue... X

    :: Extract package name from APK using aapt
    for /f "tokens=2 delims='='" %%a in ('^""%aapt_path%\aapt.exe" dump badging %APK% ^| findstr "package: name"^"') do (
        set PACKAGE=%%~a
        goto :gotPackage
    )

    :gotPackage
    echo Found package name: %PACKAGE%
    echo Uninstalling previous version of "%PACKAGE%"...
    adb -s %target% uninstall %PACKAGE%

    echo Re-installing %APK% freshly...
    adb -s %target% install %APK%
)

echo.
choice /C yn /n /m "Do you want to open logcat on device `%target%`? (y/n)" 
goto l%ERRORLEVEL%

:l1
:logcat_app
echo Showing all logs on device %target%...
adb -s %target% logcat -c
adb -s %target% logcat -s Unity IabHelper UnityMain UnityPlayer UnityActivity UnityNotifications UnityAds Ads UnityAnalytics Analytics Mono firebase FirebaseApp FirebaseSessions FirebaseInitProvider FirebaseCrashlytics FirebaseMessaging #GameAnalytics

:l2
:end
echo.
echo Done. Exiting installer.