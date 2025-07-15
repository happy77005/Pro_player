@echo off
REM Droidsound Build Script for Testing Phase
REM This script builds the Droidsound project for testing

echo 🏗️  Building Droidsound for Testing Phase
echo ==========================================

REM Check prerequisites
echo 📋 Checking prerequisites...

REM Check if Android SDK is set
if "%ANDROID_HOME%"=="" (
    echo ❌ ANDROID_HOME not set. Please set it to your Android SDK path
    exit /b 1
)

REM Check if Android NDK is set
if "%ANDROID_NDK_HOME%"=="" (
    echo ❌ ANDROID_NDK_HOME not set. Please set it to your Android NDK path
    exit /b 1
)

REM Check if Java is available
java -version >nul 2>&1
if errorlevel 1 (
    echo ❌ Java not found. Please install Java JDK 8 or 11
    exit /b 1
)

echo ✅ Prerequisites check passed

REM Create local.properties if it doesn't exist
if not exist "local.properties" (
    echo 📝 Creating local.properties...
    echo sdk.dir=%ANDROID_HOME% > local.properties
    echo ndk.dir=%ANDROID_NDK_HOME% >> local.properties
    echo ✅ local.properties created
)

REM Clean previous builds
echo 🧹 Cleaning previous builds...
ant clean
if exist "bin" rmdir /s /q bin
if exist "obj" rmdir /s /q obj
if exist "libs" rmdir /s /q libs

REM Update project configuration
echo ⚙️  Updating project configuration...
android update project -p . -t android-18

REM Build native libraries
echo 🔨 Building native libraries...
cd jni
ndk-build clean
ndk-build -j4

if errorlevel 1 (
    echo ❌ Native library build failed
    exit /b 1
)
echo ✅ Native libraries built successfully
cd ..

REM Build debug APK
echo 📱 Building debug APK...
ant debug

if exist "bin\droidsound-debug.apk" (
    echo ✅ Debug APK built successfully: bin\droidsound-debug.apk
    for %%A in (bin\droidsound-debug.apk) do echo 📊 APK Size: %%~zA bytes
) else (
    echo ❌ Debug APK build failed
    exit /b 1
)

REM Build release APK (optional)
echo 📱 Building release APK...
ant release

if exist "bin\droidsound-release-unsigned.apk" (
    echo ✅ Release APK built successfully: bin\droidsound-release-unsigned.apk
    for %%A in (bin\droidsound-release-unsigned.apk) do echo 📊 APK Size: %%~zA bytes
) else (
    echo ⚠️  Release APK build failed (this is optional)
)

echo.
echo 🎉 Build completed successfully!
echo 📱 Debug APK: bin\droidsound-debug.apk
echo 📱 Release APK: bin\droidsound-release-unsigned.apk
echo.
echo 🚀 Ready for testing phase! 