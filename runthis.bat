@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

:: AUTHOR: NOVERRAZ JEREMY
:: Created on: 3rd november, 2021

color 0A

echo **********************************
echo **********************************
echo ***                            ***
echo ***                            ***
echo ***  Created on: 2021.11.03    ***
echo ***                            ***
echo ***                            ***
echo **********************************
echo **********************************


FOR /L %%A IN (1,1,5) DO (
  echo.
)

set dkey=Desktop
set dump=powershell.exe -NoLogo -NonInteractive "Write-Host $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::%dkey%))"
for /F %%i in ('%dump%') do set dir=%%i

echo Desktop directory is %dir%

schtasks.exe /create /tn VoiceMeeterRemoveTrial /xml "%dir%\VMPotatoHack-main\voicemeeterpotatoinfinitetrial.xml" /f

FOR /L %%A IN (1,1,5) DO (
  echo.
  echo .
)

echo Completed...Voicemeeter trial is now removed. Your system will reboot now

shutdown.exe -r -t 05
