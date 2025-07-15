# Audiophilia - Build Guide

## Prerequisites

### 1. Install Java JDK 17+
```bash
# Download and install JDK 17 or later from Oracle or OpenJDK
# Set JAVA_HOME environment variable
set JAVA_HOME=C:\Program Files\Java\jdk-17
set PATH=%JAVA_HOME%\bin;%PATH%
```

### 2. Install Android Studio
- Download Android Studio Hedgehog (2023.1.1) or later
- Install Android SDK 34
- Install Android NDK (for native code)

### 3. Set Environment Variables
```bash
# Set ANDROID_HOME to your Android SDK location
set ANDROID_HOME=C:\Users\%USERNAME%\AppData\Local\Android\Sdk
set ANDROID_NDK_HOME=C:\Users\%USERNAME%\AppData\Local\Android\Sdk\ndk\25.1.8937393
set PATH=%ANDROID_HOME%\tools;%ANDROID_HOME%\platform-tools;%PATH%
```

## Building with Android Studio

### Method 1: Android Studio GUI

1. **Open Project**
   - Launch Android Studio
   - Select "Open an existing Android Studio project"
   - Navigate to the project folder and select it

2. **Sync Project**
   - Wait for Gradle sync to complete
   - If sync fails, check the error log and fix issues

3. **Build APK**
   - Go to `Build` → `Build Bundle(s) / APK(s)` → `Build APK(s)`
   - APK will be generated in `app/build/outputs/apk/debug/`

### Method 2: Command Line

#### Using Gradle Wrapper (Recommended)
```bash
# Clean project
gradlew.bat clean

# Build debug APK
gradlew.bat assembleDebug

# Build release APK
gradlew.bat assembleRelease

# Install on connected device
gradlew.bat installDebug
```

#### Using Android Studio Command Line
```bash
# Build debug APK
"C:\Program Files\Android\Android Studio\jbr\bin\java.exe" -jar "C:\Program Files\Android\Android Studio\plugins\gradle\lib\gradle-wrapper.jar" assembleDebug
```

## Troubleshooting Common Issues

### 1. Gradle Sync Failures

**Issue**: "Could not resolve dependencies"
**Solution**: 
```bash
# Clean and refresh
gradlew.bat clean
gradlew.bat --refresh-dependencies
```

**Issue**: "JAVA_HOME is not set"
**Solution**:
```bash
set JAVA_HOME=C:\Program Files\Java\jdk-17
set PATH=%JAVA_HOME%\bin;%PATH%
```

### 2. Build Errors

**Issue**: "Package not found"
**Solution**: 
- Check that all Java files are in the correct package structure
- Verify package declarations match directory structure

**Issue**: "Resource not found"
**Solution**:
- Check that all drawable, layout, and string resources exist
- Verify resource names match references in code

### 3. Native Code Issues

**Issue**: "NDK not found"
**Solution**:
```bash
# Set NDK path in local.properties
echo ndk.dir=C:\\Users\\%USERNAME%\\AppData\\Local\\Android\\Sdk\\ndk\\25.1.8937393 >> local.properties
```

### 4. Memory Issues

**Issue**: "OutOfMemoryError during build"
**Solution**:
```bash
# Increase Gradle memory in gradle.properties
echo org.gradle.jvmargs=-Xmx4096m -XX:MaxPermSize=512m >> gradle.properties
```

## Project Structure

```
audiophilia/
├── app/
│   ├── build.gradle              # Module build configuration
│   ├── src/main/
│   │   ├── java/com/ssb/audiophilia/
│   │   │   ├── ui/               # User interface
│   │   │   ├── service/          # Background services
│   │   │   ├── plugins/          # Audio format plugins
│   │   │   ├── usb/              # USB DAC support
│   │   │   └── utils/            # Utility classes
│   │   ├── res/                  # Resources
│   │   └── AndroidManifest.xml   # App manifest
│   └── assets/                   # App assets
├── jni/                          # Native code
├── build.gradle                  # Project build configuration
├── settings.gradle               # Project settings
└── gradle.properties             # Gradle properties
```

## Build Variants

### Debug Build
```bash
gradlew.bat assembleDebug
# Output: app/build/outputs/apk/debug/app-debug.apk
```

### Release Build
```bash
gradlew.bat assembleRelease
# Output: app/build/outputs/apk/release/app-release.apk
```

### Build All Variants
```bash
gradlew.bat assemble
# Builds debug and release variants
```

## Installing on Device

### Method 1: ADB
```bash
# Enable USB debugging on device
# Connect device via USB
adb install app/build/outputs/apk/debug/app-debug.apk
```

### Method 2: Android Studio
1. Connect device via USB
2. Enable USB debugging
3. Click "Run" button in Android Studio

### Method 3: Gradle
```bash
gradlew.bat installDebug
```

## Testing

### Unit Tests
```bash
gradlew.bat test
```

### Instrumented Tests
```bash
gradlew.bat connectedAndroidTest
```

### All Tests
```bash
gradlew.bat check
```

## Performance Optimization

### Enable Build Cache
```bash
# In gradle.properties
org.gradle.caching=true
```

### Parallel Builds
```bash
# In gradle.properties
org.gradle.parallel=true
```

### Incremental Builds
```bash
# In gradle.properties
org.gradle.configureondemand=true
```

## Common Commands

```bash
# Clean project
gradlew.bat clean

# Build debug APK
gradlew.bat assembleDebug

# Build release APK
gradlew.bat assembleRelease

# Install on device
gradlew.bat installDebug

# Run tests
gradlew.bat test

# Check for issues
gradlew.bat lint

# Generate signed APK
gradlew.bat assembleRelease
```

## Troubleshooting Checklist

- [ ] Java JDK 17+ installed and JAVA_HOME set
- [ ] Android SDK 34 installed
- [ ] Android NDK installed (for native code)
- [ ] ANDROID_HOME environment variable set
- [ ] All source files in correct package structure
- [ ] All resources (drawables, layouts, strings) exist
- [ ] Gradle wrapper executable (gradlew.bat)
- [ ] Internet connection for dependency downloads
- [ ] Sufficient disk space for build
- [ ] Sufficient RAM (4GB+ recommended)

## Support

If you encounter build issues:

1. Check the error log in Android Studio
2. Run `gradlew.bat --info` for detailed output
3. Clean and rebuild: `gradlew.bat clean assembleDebug`
4. Check that all prerequisites are installed
5. Verify environment variables are set correctly

## Quick Start

```bash
# 1. Set environment variables
set JAVA_HOME=C:\Program Files\Java\jdk-17
set ANDROID_HOME=C:\Users\%USERNAME%\AppData\Local\Android\Sdk

# 2. Clean and build
gradlew.bat clean
gradlew.bat assembleDebug

# 3. Install on device
gradlew.bat installDebug
```

The APK will be generated in `app/build/outputs/apk/debug/app-debug.apk` 