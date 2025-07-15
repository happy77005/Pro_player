# Gradle Migration Guide for Droidsound

This document describes the conversion from Ant-based build system to Gradle for Android Studio compatibility.

## What Changed

### File Structure
- **Before**: All files in root directory
- **After**: App files moved to `app/` subdirectory
  - `app/src/` - Java source files
  - `app/res/` - Resource files
  - `app/assets/` - Asset files
  - `app/libs/` - Library JARs
  - `app/AndroidManifest.xml` - App manifest

### Build Files
- **Removed**: `build.xml`, `project.properties`, `ant.properties`
- **Added**: 
  - `build.gradle` (root)
  - `app/build.gradle` (app module)
  - `settings.gradle`
  - `gradle.properties`
  - `gradle/wrapper/gradle-wrapper.properties`

## Build Configuration

### Key Settings
- **Package**: `com.ssb.droidsound`
- **Min SDK**: 9 (Android 2.3)
- **Target SDK**: 18 (Android 4.3)
- **Compile SDK**: 33 (Android 13)
- **Version**: 1.6 (Code: 22)

### Dependencies
- Android Support Library (JAR)
- AndroidX libraries for modern compatibility
- Existing JAR libraries in `app/libs/`

## Building the Project

### Prerequisites
1. Install Android Studio
2. Install Android SDK (API 33)
3. Set up `local.properties` with your SDK path

### Build Commands
```bash
# Clean build
./gradlew clean

# Build debug APK
./gradlew assembleDebug

# Build release APK
./gradlew assembleRelease

# Install on connected device
./gradlew installDebug
```

### Android Studio
1. Open project in Android Studio
2. Sync Gradle files
3. Build → Make Project

## Testing

### Emulator Setup
1. Create AVD with API 18 or higher
2. Enable USB debugging
3. Start emulator

### Device Testing
1. Enable Developer Options
2. Enable USB Debugging
3. Connect device via USB

### Build and Install
```bash
# Build debug APK
./gradlew assembleDebug

# Install on device/emulator
./gradlew installDebug

# Run app
adb shell am start -n com.ssb.droidsound/.ui.MainActivity
```

## Troubleshooting

### Common Issues

#### SDK Path Not Found
- Create `local.properties` with correct SDK path
- Example: `sdk.dir=C\:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk`

#### Build Errors
- Clean project: `./gradlew clean`
- Invalidate caches in Android Studio
- Sync Gradle files

#### Missing Dependencies
- Check `app/libs/` contains all JAR files
- Verify AndroidX dependencies in `app/build.gradle`

#### Native Library Issues
- Ensure NDK is installed if building native code
- Check `jni/` directory structure

### Debug Commands
```bash
# View build output
./gradlew assembleDebug --info

# Check dependencies
./gradlew dependencies

# Run with debug info
./gradlew assembleDebug --debug
```

## Migration Notes

### Preserved Features
- All source code and resources
- USB DAC functionality
- Audio plugins
- Settings and preferences
- Logging system

### Updated Components
- Build system (Ant → Gradle)
- Project structure
- Dependency management
- Build configuration

### Removed Files
- `build.xml` (Ant build file)
- `project.properties` (Ant properties)
- `ant.properties` (Ant configuration)

## Next Steps

1. **Test Build**: Ensure project builds successfully
2. **Test Functionality**: Verify all features work
3. **Optimize**: Update dependencies and configurations
4. **Deploy**: Build release APK for distribution

## Support

For issues with the Gradle migration:
1. Check build output for specific errors
2. Verify all files were copied correctly
3. Ensure Android Studio and SDK are properly configured
4. Review this guide for common solutions 