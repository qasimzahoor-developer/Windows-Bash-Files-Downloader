@echo off
for /F %%I in ('curl http://localhost/files.php?filenames') do set files=%%I
call :parse "%files%"
pause
goto :eof

:parse
setlocal
set list=%~1
rem echo list = %list%
for /F "tokens=1* delims=," %%f in ("%list%") do (
    rem if the item exist
    if not "%%f" == "" call :getLineNumber %%f
    rem if next item exist
    if not "%%g" == "" call :parse "%%g"
)
endlocal
goto :eof

:getLineNumber
setlocal
echo %1
set datefolder=%DATE:/=-%
mkdir %datefolder%  2>nul 
set filename=%1
curl -L "http://localhost/files.php?file=%filename%" -o %datefolder%/%filename%
goto :eof