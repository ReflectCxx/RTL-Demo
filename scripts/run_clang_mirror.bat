@echo off
setlocal

REM Run clang-mirror (Windows)

REM Resolve project root (parent of scripts folder)
set SCRIPT_DIR=%~dp0
for %%I in ("%SCRIPT_DIR%..") do set PROJECT_ROOT=%%~fI

set MIRROR_EXE=%PROJECT_ROOT%\clang-mirror\release\clang-mirror.exe
set SOURCE_LIST=%PROJECT_ROOT%\registration_srcs.txt
set OUT_DIR=%PROJECT_ROOT%

if not exist "%MIRROR_EXE%" (
echo ERROR: clang-mirror not found.
echo Expected at:
echo %MIRROR_EXE%
exit /b 1
)

if not exist "%SOURCE_LIST%" (
echo ERROR: reflection_srcs.txt not found.
echo Expected at:
echo %SOURCE_LIST%
exit /b 1
)

if not exist "%OUT_DIR%" mkdir "%OUT_DIR%"

set FILE_ARGS=

for /f "usebackq delims=" %%F in ("%SOURCE_LIST%") do (
call :add_file "%%F"
)

echo.
echo Final command:
echo "%MIRROR_EXE%" %FILE_ARGS% -out-dir="%OUT_DIR%" -- -std=c++20 -fsyntax-only
echo.

"%MIRROR_EXE%" %FILE_ARGS% -out-dir="%OUT_DIR%" -- -std=c++20 -fsyntax-only

if errorlevel 1 (
echo clang-mirror failed.
exit /b 1
)

echo.
echo Reflection generation complete.
echo Output directory:
echo %OUT_DIR%
echo.

endlocal
exit /b 0

:add_file
set LINE=%~1

if "%LINE%"=="" goto :eof
if "%LINE:~0,1%"=="#" goto :eof

set FILE_ARGS=%FILE_ARGS% "%PROJECT_ROOT%\%LINE%"
goto :eof