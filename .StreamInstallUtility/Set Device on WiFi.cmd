@echo off
cls
echo 1. Connect to Device via WiFi
echo 2. Disconnect All Devices
echo 3. Show All Devices
echo 4. Connect to %MyStaticMobileIPAddress%
echo 5. Run Logcat...
choice /C 12345 /n /m "Press 1,2,3,4 for Action: " 
cls
goto l%ERRORLEVEL%

:l1
echo Make Sure the Device is Conncted via USB Port and Enabled "USB Debugging" on Mobile Settings
pause>nul
adb disconnect
adb tcpip 5555
set /p ip="Enter Device IP Address from your Network: "
adb connect %ip%
cls
echo You can Disconnect your Device from USB Port...

:l3
adb devices
pause>nul
exit

:l2
adb disconnect
pause>nul
exit

:l4
adb disconnect
adb tcpip 5555
adb connect  %MyStaticMobileIPAddress%
cls
echo You can Disconnect your Device from USB Port...
goto l3

:l5
cls
Remote_Install.cmd logger