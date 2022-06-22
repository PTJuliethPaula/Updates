
pushd %PROTOPAS_ROOT%

REM applying rc files

call ccrcconv CONF\hotfix.rc -A\ -h HKEY_LOCAL_MACHINE -r "SOFTWARE\WOW6432Node\Wincor Nixdorf\ProTopas\CurrentVersion\"

REM DLL files


call xcopy /y C:\ProFlex4\SJ\atm-cli-1.0-SNAPSHOT-jar-with-dependencies.jar C:\SmartJournal\


:StopTheServiceWait

sc stop SmartJournal

set /A COUNTER=COUNTER+1

if "%COUNTER%" EQU "120" GOTO ServiceNotStopped

echo %DATE% %TIME% Waiting to Stop Services. Counter = %COUNTER% 

Sleep 2000 > Nul

for /f "tokens=4" %%s in ('sc query SmartJournal ^| find "STATE"') do if "%%s"=="STOPPED" goto StopTheServiceEnd

goto StopTheServiceWait

 

:ServiceNotStopped


echo %DATE% %TIME% Unable to stop Service SmartJournal - Abort 

goto abort

 

:StopTheServiceEnd

sc start SmartJournal

echo %DATE% %TIME% Service stopped, starting again

:abort

popd


popd
