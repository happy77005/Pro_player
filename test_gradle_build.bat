@echo off
echo Testing Gradle Build for Droidsound
echo ===================================
echo.

echo 1. Checking project structure...
if not exist "app\build.gradle" (
    echo ERROR: app\build.gradle not found!
    pause
    exit /b 1
)

if not exist "app\AndroidManifest.xml" (
    echo ERROR: app\AndroidManifest.xml not found!
    pause
    exit /b 1
)

if not exist "app\src" (
    echo ERROR: app\src directory not found!
    pause
    exit /b 1
)

echo ✓ Project structure looks good
echo.

echo 2. Checking Gradle wrapper...
if not exist "gradlew.bat" (
    echo ERROR: gradlew.bat not found!
    pause
    exit /b 1
)

echo ✓ Gradle wrapper found
echo.

echo 3. Attempting to build project...
echo This may take a few minutes on first run...
echo.

call gradlew.bat assembleDebug --info
if errorlevel 1 (
    echo.
    echo ❌ Build failed! Check the error messages above.
    echo.
    echo Common solutions:
    echo - Make sure Android SDK is installed
    echo - Update local.properties with correct SDK path
    echo - Install required Android SDK platforms
    echo.
    pause
    exit /b 1
)

echo.
echo ✅ Build completed successfully!
echo.
echo APK location: app\build\outputs\apk\debug\app-debug.apk
echo.
echo To install on device/emulator:
echo   gradlew.bat installDebug
echo.
pause 