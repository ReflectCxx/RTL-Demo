@echo off
setlocal

REM Setup clang-mirror (Windows)

set PROJECT_ROOT=%~dp0
set INSTALL_DIR=%PROJECT_ROOT%clang-mirror
set RELEASE_TAG=release-latest
set REPO=ReflectCxx/clang-mirror

set ASSET=clang-mirror-windows.zip
set DOWNLOAD_URL=https://github.com/%REPO%/releases/download/%RELEASE_TAG%/%ASSET%

if exist "%INSTALL_DIR%\clang-mirror.exe" (
echo clang-mirror already installed at:
echo %INSTALL_DIR%
echo.
echo Skipping download.
exit /b 0
)

if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

echo.
echo Downloading clang-mirror from:
echo %DOWNLOAD_URL%
echo.

curl -L -o "%INSTALL_DIR%%ASSET%" "%DOWNLOAD_URL%"
if errorlevel 1 (
echo Download failed.
exit /b 1
)

echo.
echo Extracting...

tar -xf "%INSTALL_DIR%%ASSET%" -C "%INSTALL_DIR%"
if errorlevel 1 (
echo Extraction failed.
exit /b 1
)

del "%INSTALL_DIR%%ASSET%"

echo.
echo clang-mirror successfully installed at:
echo %INSTALL_DIR%
echo.

endlocal
