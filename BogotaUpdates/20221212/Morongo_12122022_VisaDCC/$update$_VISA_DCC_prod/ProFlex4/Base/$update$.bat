
pushd %PROTOPAS_ROOT%

REM applying rc files

call ccrcconv CONF\hotfix.rc -A\ -h HKEY_LOCAL_MACHINE -r "SOFTWARE\WOW6432Node\Wincor Nixdorf\ProTopas\CurrentVersion\"

REM DLL files


popd
