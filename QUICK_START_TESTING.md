# 🚀 Quick Start Testing Guide

## Immediate Testing After Build

### 1. **Install APK on Device**

```bash
# Install debug APK
adb install bin/droidsound-debug.apk

# Verify installation
adb shell pm list packages | grep droidsound
```

### 2. **Launch App**

```bash
# Launch the app
adb shell am start -n com.ssb.droidsound/.MainActivity

# Check if app launched successfully
adb logcat | grep -i "droidsound.*launch"
```

### 3. **Basic Functionality Test**

#### Test Audio Playback
1. Open app
2. Navigate to playlist
3. Select an audio file
4. Verify playback starts
5. Test play/pause controls
6. Test seek functionality

#### Test USB DAC (if available)
1. Connect USB DAC to device
2. Check if permission dialog appears
3. Grant USB permissions
4. Verify DAC status shows "Connected"
5. Play audio file
6. Verify audio routes to USB DAC

#### Test Settings
1. Open Settings (gear icon)
2. Test audio output selection
3. Test log level configuration
4. Test export logs function

### 4. **Quick Debug Commands**

```bash
# Monitor app logs
adb logcat | grep -i "droidsound"

# Check for crashes
adb logcat | grep -i "fatal\|crash\|exception"

# Monitor USB events
adb logcat | grep -i "usb\|dac"

# Monitor audio events
adb logcat | grep -i "audio\|playback"

# Check app permissions
adb shell dumpsys package com.ssb.droidsound
```

### 5. **Performance Quick Check**

```bash
# Check memory usage
adb shell dumpsys meminfo com.ssb.droidsound

# Check CPU usage
adb shell top -p $(adb shell pidof com.ssb.droidsound)

# Check battery impact
adb shell dumpsys battery
```

### 6. **Common Test Scenarios**

#### Scenario 1: Basic Audio Playback
```bash
# Expected behavior:
# - App launches without crashes
# - Audio files load and play
# - Controls respond correctly
# - No audio artifacts
```

#### Scenario 2: USB DAC Integration
```bash
# Expected behavior:
# - USB DAC detected automatically
# - Permission dialog appears
# - Audio routes to USB DAC
# - Status updates correctly
```

#### Scenario 3: Settings Configuration
```bash
# Expected behavior:
# - Settings activity opens
# - Options save correctly
# - Log export works
# - Log level changes apply
```

### 7. **Quick Issue Resolution**

#### If App Won't Launch
```bash
# Check for missing dependencies
adb logcat | grep -i "class.*not found"

# Check for resource issues
adb logcat | grep -i "resource.*not found"

# Reinstall APK
adb uninstall com.ssb.droidsound
adb install bin/droidsound-debug.apk
```

#### If Audio Doesn't Play
```bash
# Check audio routing
adb shell dumpsys audio | grep -i "output"

# Check audio format detection
adb logcat | grep -i "audio.*format"

# Test with different audio files
```

#### If USB DAC Not Working
```bash
# Check USB device detection
adb shell dumpsys usb

# Check audio device list
adb shell dumpsys audio | grep -i usb

# Test with different USB DAC
```

### 8. **Log Analysis Quick Start**

```bash
# Enable debug logging in app settings
# Export logs
adb pull /sdcard/Android/data/com.ssb.droidsound/files/logs/

# Search for specific issues
grep -i "error\|exception" droidsound_log_*.txt
grep -i "usb.*dac" droidsound_log_*.txt
grep -i "audio.*format" droidsound_log_*.txt
```

### 9. **Expected Test Results**

#### ✅ Success Indicators
- App launches in under 3 seconds
- Audio playback starts immediately
- USB DAC detection works (if DAC connected)
- Settings save and load correctly
- Log export creates files
- No crashes or ANR dialogs

#### ❌ Failure Indicators
- App crashes on launch
- Audio doesn't play
- USB DAC not detected
- Settings don't save
- Logs not exported
- High memory usage (>200MB)
- High CPU usage (>20%)

### 10. **Next Steps After Quick Test**

If quick test passes:
1. **Run comprehensive testing** (see TESTING_DEBUGGING_GUIDE.md)
2. **Test with different audio formats**
3. **Test with different USB DACs**
4. **Test performance over time**
5. **Test edge cases and error conditions**

If quick test fails:
1. **Check build logs** for compilation errors
2. **Verify prerequisites** are installed correctly
3. **Check environment variables** are set
4. **Review error logs** for specific issues
5. **Rebuild project** if necessary

### 11. **Quick Performance Metrics**

```bash
# Target metrics for good performance:
# - App startup: < 3 seconds
# - Memory usage: < 200MB
# - CPU usage: < 20% during playback
# - Audio latency: < 50ms
# - Battery drain: Reasonable for audio app
```

### 12. **Emergency Rollback**

```bash
# If testing reveals critical issues:
# 1. Uninstall current version
adb uninstall com.ssb.droidsound

# 2. Install previous working version (if available)
adb install previous_version.apk

# 3. Or rebuild with fixes
ant clean
ant debug
adb install bin/droidsound-debug.apk
```

## 🎯 Quick Test Checklist

- [ ] App launches without crashes
- [ ] Audio playback works
- [ ] USB DAC detection works (if DAC available)
- [ ] Settings activity opens
- [ ] Log export function works
- [ ] No memory leaks
- [ ] No performance issues
- [ ] All UI elements display correctly
- [ ] Dark theme applies properly
- [ ] Bottom navigation works

## 🚨 Emergency Contacts

If you encounter critical issues:
1. Check the troubleshooting section in BUILD_GUIDE.md
2. Review logs for specific error messages
3. Verify all prerequisites are installed
4. Try rebuilding from scratch
5. Test on different device/emulator

---

**Ready to test! 🚀**

Run the quick tests above to verify your build is working correctly before proceeding to comprehensive testing. 