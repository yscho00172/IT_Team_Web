@echo off

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" 
if '%errorlevel%' NEQ '0' ( 
REM    echo 관리 권한을 요청 ... 
    goto UACPrompt 
) else ( goto gotAdmin ) 
:UACPrompt 
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs" 
    set params = %*:"="" 
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" 


    "%temp%\getadmin.vbs" 
    rem del "%temp%\getadmin.vbs" 
    exit /B 

:gotAdmin 
pushd "%CD%" 
    CD /D "%~dp0" 

:main
cls
goto delete
goto main

:delete
net stop spooler

del "%windir%\system32\spool\printers" /f /s /q

del "%windir%\system32\spool\printers\*.shd" /f /s /q

del "%windir%\system32\spool\printers\*.spl" /f /s /q

del "%systemroot%\system32\spool\printers" /f /s /q

del "%systemroot%\system32\spool\printers\*.shd" /f /s /q

del "%systemroot%\system32\spool\printers\*.spl" /f /s /q

net start spooler

pause
goto exit

:exit
exit