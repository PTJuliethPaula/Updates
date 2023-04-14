
REM pushd %PROTOPAS_ROOT%

REM applying rc files
ccrcconv ChainingChanges.rc -A\ -h HKEY_LOCAL_MACHINE -r "SOFTWARE\WOW6432Node\Wincor Nixdorf\ProTopas\CurrentVersion\"


REM Property definitions
call xcopy *.xml C:\ProFlex4\base\CONF\properties\ /y /d /e


REM DLL files
REM call xcopy FEATURES\FEATURE_CUSTOMIZING\PROTOPAS\bin\* bin\ /y /d /e


REM jar files
REM call xcopy *.jar C:\ProFlex4\base\Java\lib\ /y /d /e


REM GUIAPP
REM call xcopy *.html C:\ProFlex4\Base\GUIAPP\content_softkey\views\ /y /d /e


REM copying receipt from base to probase
REM call xcopy *.flc C:\ProFlex4\Base\forms\ptr\*.*  /y /d /e

REM popd
