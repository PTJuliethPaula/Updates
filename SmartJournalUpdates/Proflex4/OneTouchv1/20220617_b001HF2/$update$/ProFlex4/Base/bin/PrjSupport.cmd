@ECHO OFF
REM CCSupport will capture *.zip in %TMPDIR%, so this doesn't need to be compressed.  Just custom additional zip files have to be created
REM Clean up old information in case it exists
SET TMPDIR=C:\ProFlex4\Base\work\CCSUPPORT
REM Cleanup SmartJournal
del /f %TMPDIR%\SmartJournalDir.TXT
del /f %TMPDIR%\SmartJournal.zip
del /f %TMPDIR%\AdditionalInfo.zip

REM Cleanup ASAI OneTouch
del /f %TMPDIR%\ASAIOneTouch.zip

SET REG_TOOL=%SystemRoot%\regedit.exe
if not "%ProgramW6432%" == "" SET REG_TOOL=%WINDIR%\SysWOW64\regedit.exe
if exist "%PROTOPAS_ROOT%\Bin\CCRegEdit.exe" SET REG_TOOL="%PROTOPAS_ROOT%\Bin\CCRegEdit.exe"

REM Don't recurse all subdirectories for the *.log, it will pick up CSCW logs which are huge
WNPACK /A /E /S %TMPDIR%\AdditionalInfo.zip %PROTOPAS_ROOT%\BIN\PrjSupport.cmd
WNPACK /A /E /S %TMPDIR%\AdditionalInfo.zip C:\$OEM$\$1\DRIVER\*.log

REM P.txt is temporary, but put into support in case it's there for dev support
WNPACK /A /E /S %TMPDIR%\AdditionalInfo.zip C:\Proflex4\p.txt

REM Let's get the importRegistry.cmd log too...
WNPACK /A /E %TMPDIR%\AdditionalInfo.zip %PROFLEX4_FAMILY_ROOT%\*.log

REM PF4 SavedTraces
WNPACK /A /E /S %TMPDIR%\SavedTraces.zip C:\ProFlex4\Base\SavedTraces\*.*

:ASAIOneTouch
REM ASAI OneTouch logs and settings
if not exist C:\ASAI goto ASAIOneTouchEnd
WNPACK /A /E /S %TMPDIR%\ASAIOneTouch.zip C:\ASAI\CacheConfigFile\*.*
WNPACK /A /E /S %TMPDIR%\ASAIOneTouch.zip C:\ASAI\PF4Traces\*.*
WNPACK /A /E /S %TMPDIR%\ASAIOneTouch.zip C:\ASAI\LogFiles\*.*
WNPACK /A /E /S %TMPDIR%\ASAIOneTouch.zip C:\ASAI\LogData\*.*
WNPACK /A /E /S %TMPDIR%\ASAIOneTouch.zip C:\ASAI\TicketRedemption\Logs\*.*
WNPACK /A /E /S %TMPDIR%\ASAIOneTouch.zip C:\ASAI\counters\*.*
WNPACK /A /E /S %TMPDIR%\ASAIOneTouch.zip C:\ASAI\OneTTraces\*.*
WNPACK /A /E /S %TMPDIR%\ASAIOneTouch.zip C:\ASAI\PTR\*.*
WNPACK /A /E /S %TMPDIR%\ASAIOneTouch.zip C:\ASAI\DevicesLog\*.*


:ASAIOneTouchEnd

:SmartJournal

REM SmartJournal logs and settings
if not exist C:\SmartJournal goto SmartJournalEnd
WNPACK /A /E /S %TMPDIR%\SmartJournal.zip C:\SmartJournal\cjpf4.properties
WNPACK /A /E /S %TMPDIR%\SmartJournal.zip C:\SmartJournal\log4j.xml
WNPACK /A /E /S %TMPDIR%\SmartJournal.zip C:\SmartJournal\log\*.*
WNPACK /A /E /S %TMPDIR%\SmartJournal.zip C:\SmartJournal.log
dir /s C:\SmartJournal\*.* >> %TMPDIR%\SmartJournalDir.TXT

:SmartJournalEnd


