@echo off
echo Building Audiophilia APK...

REM Set environment variables
set JAVA_HOME=C:\Program Files\Java\jdk-24
set PATH=%JAVA_HOME%\bin;%PATH%

REM Check if Java is available
java -version
if %errorlevel% neq 0 (
    echo ERROR: Java not found. Please install Java JDK 24.
    pause
    exit /b 1
)

REM Download Gradle if not exists
if not exist "C:\gradle-8.0\bin\gradle.bat" (
    echo Downloading Gradle 8.0...
    powershell -Command "Invoke-WebRequest -Uri 'https://services.gradle.org/distributions/gradle-8.0-bin.zip' -OutFile 'gradle-8.0-bin.zip'"
    echo Extracting Gradle...
    powershell -Command "Expand-Archive -Path 'gradle-8.0-bin.zip' -DestinationPath 'C:\' -Force"
    del gradle-8.0-bin.zip
)

REM Set Gradle home
set GRADLE_HOME=C:\gradle-8.0
set PATH=%GRADLE_HOME%\bin;%PATH%

REM Clean and build
echo Cleaning project...
gradle clean
if %errorlevel% neq 0 (
    echo ERROR: Gradle clean failed.
    pause
    exit /b 1
)

echo Building debug APK...
gradle assembleDebug
if %errorlevel% neq 0 (
    echo ERROR: Build failed.
    pause
    exit /b 1
)

echo.
echo BUILD SUCCESSFUL!
echo APK location: app\build\outputs\apk\debug\app-debug.apk
echo.
pause 