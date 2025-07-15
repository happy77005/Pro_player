@echo off
echo Building Droidsound with Gradle...
echo.

REM Check if gradlew exists
if not exist "gradlew.bat" (
    echo Error: gradlew.bat not found!
    echo Please run: gradle wrapper
    pause
    exit /b 1
)

REM Clean previous builds
echo Cleaning previous builds...
call gradlew.bat clean
if errorlevel 1 (
    echo Error during clean!
    pause
    exit /b 1
)

REM Build debug APK
echo Building debug APK...
call gradlew.bat assembleDebug
if errorlevel 1 (
    echo Error during build!
    pause
    exit /b 1
)

echo.
echo Build completed successfully!
echo APK location: app\build\outputs\apk\debug\app-debug.apk
echo.

REM Check if device is connected
echo Checking for connected devices...
adb devices
echo.

echo To install on device/emulator:
echo   gradlew.bat installDebug
echo.
echo To run the app:
echo   adb shell am start -n com.ssb.droidsound/.ui.MainActivity
echo.

pause 