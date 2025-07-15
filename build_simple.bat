@echo off
echo Building Audiophilia APK using Android Studio Gradle...

REM Set Java environment
set JAVA_HOME=C:\Program Files\Java\jdk-24
set PATH=%JAVA_HOME%\bin;%PATH%

REM Check Java
java -version
if %errorlevel% neq 0 (
    echo ERROR: Java not found!
    pause
    exit /b 1
)

REM Try to find Android Studio's Gradle
set GRADLE_PATH=C:\Users\harip\AppData\Local\Android\Sdk\gradle\gradle-8.0\bin\gradle.bat
if exist "%GRADLE_PATH%" (
    echo Using Android Studio Gradle...
    set GRADLE_CMD="%GRADLE_PATH%"
) else (
    echo Using Gradle wrapper...
    set GRADLE_CMD=gradlew.bat
)

REM Set Gradle user home to desktop
set GRADLE_USER_HOME=C:\Users\harip\Desktop\gradle-home

REM Clean and build
echo Cleaning project...
%GRADLE_CMD% clean
if %errorlevel% neq 0 (
    echo ERROR: Clean failed!
    pause
    exit /b 1
)

echo Building APK...
%GRADLE_CMD% assembleDebug
if %errorlevel% neq 0 (
    echo ERROR: Build failed!
    pause
    exit /b 1
)

echo.
echo BUILD SUCCESSFUL!
echo APK location: app\build\outputs\apk\debug\app-debug.apk
echo.
pause 