# Audiophilia - Android Music Player

A modern Android music player with support for various audio formats and USB DAC connectivity.

## Features

- **Modern Material You Design**: Beautiful dark theme with Material Design 3 components
- **Multi-format Support**: Plays various audio formats including MOD, SID, NSF, and more
- **USB DAC Support**: Connect external USB DACs for high-quality audio output
- **Fragment-based UI**: Modern architecture with bottom navigation
- **Real-time Audio Info**: Display detailed audio format information
- **Playlist Management**: Create and manage playlists

## Building with Android Studio

### Prerequisites

- Android Studio Hedgehog (2023.1.1) or later
- Android SDK 34
- JDK 17 or later

### Setup Instructions

1. **Open the Project**:
   - Launch Android Studio
   - Select "Open an existing Android Studio project"
   - Navigate to the project directory and select it

2. **Sync the Project**:
   - Android Studio will automatically sync the project with Gradle
   - Wait for the sync to complete (this may take a few minutes on first run)

3. **Build the APK**:
   - Go to `Build` → `Build Bundle(s) / APK(s)` → `Build APK(s)`
   - Or use the command line: `./gradlew assembleDebug`

4. **Install on Device**:
   - Connect your Android device via USB
   - Enable USB debugging in Developer options
   - Click "Run" in Android Studio or use: `./gradlew installDebug`

### Project Structure

```
app/
├── src/main/
│   ├── java/com/ssb/droidsound/
│   │   ├── ui/                    # User interface components
│   │   │   ├── fragments/         # Fragment classes
│   │   │   └── MainActivity.java  # Main activity
│   │   ├── service/               # Background services
│   │   └── ...
│   ├── res/
│   │   ├── layout/                # Layout files
│   │   ├── drawable/              # Icons and graphics
│   │   ├── values/                # Strings, colors, styles
│   │   └── ...
│   └── AndroidManifest.xml        # App manifest
├── assets/                        # App assets
└── build.gradle                   # Module build configuration
```

### Key Components

- **MainActivity**: Main activity with bottom navigation and fragment management
- **NowPlayingFragment**: Displays current track info and player controls
- **PlaylistFragment**: Manages playlists and track lists
- **DacStatusFragment**: Shows USB DAC connection status and audio info
- **PlayerService**: Background service for audio playback

### Dependencies

The project uses modern Android libraries:
- AndroidX AppCompat, Core, Media
- Material Design Components
- Fragment and Activity libraries
- RecyclerView and ViewPager2
- ConstraintLayout

### Troubleshooting

1. **Build Errors**: Make sure you have the latest Android Studio and SDK installed
2. **Missing Icons**: All vector drawables are included in the project
3. **Permission Issues**: The app requests necessary permissions for audio and storage access
4. **Native Libraries**: The project includes native code for audio processing

### Building from Command Line

```bash
# Clean and build
./gradlew clean assembleDebug

# Install on connected device
./gradlew installDebug

# Build release APK
./gradlew assembleRelease
```

## License

This project is based on the original Droidsound player with modern Android architecture updates, rebranded as Audiophilia.

## Overview

Audiophilia is a production-grade, high-resolution audio player for Android that supports bit-perfect playback via USB DACs and modern audio formats. Built on a legacy retro music player, it has been completely modernized with Material You design, USB DAC support, high-resolution format support, streaming capabilities, and comprehensive logging.

## Features

### 🎵 Audio Playback
- **Bit-Perfect USB DAC Support**: Direct audio routing to USB DACs for lossless playback
- **High-Resolution Formats**: FLAC (up to 24-bit/192kHz), WAV, AIFF, DSD/DSF
- **CUE Sheet Support**: Album navigation and track splitting
- **Streaming Support**: HTTP(S) streaming for FLAC, WAV, MP3
- **Playlist Support**: M3U playlist parsing and management

### 🎛️ USB DAC Integration
- **Automatic Detection**: USB DACs are automatically detected and configured
- **Permission Handling**: Runtime permission requests with user-friendly UI
- **Format Detection**: Automatic audio format detection and configuration
- **Status Monitoring**: Real-time USB DAC status and device information

### 🎨 Modern UI
- **Material You Design**: Dark theme with Material You components
- **Fragment-Based Architecture**: Modular UI with NowPlaying, Playlist, and DAC Status fragments
- **Drag & Drop**: Playlist reordering with drag-drop support
- **Queue Management**: Advanced playlist and queue management
- **Audio Information**: Real-time audio format and device information display

### ⚙️ Settings & Configuration
- **Audio Output Selection**: Choose between Internal, USB DAC, or Auto
- **Resampling Control**: Enable/disable audio format conversion
- **Log Level Configuration**: Error, Warning, Info, Debug levels
- **Audio Format Logging**: Detailed audio format information logging

### 🔧 Debugging & Logging
- **Comprehensive Logging**: Multi-level logging with audio format tracking
- **Log Export**: Export logs to files for debugging
- **USB DAC Event Logging**: Connection/disconnection event tracking
- **Audio Format Logging**: Detailed device capability logging
- **Performance Monitoring**: Track audio performance and device behavior

## Architecture

### Core Components

```
src/com/ssb/droidsound/
├── ui/
│   ├── MainActivity.java              # Main activity with fragment management
│   ├── SettingsActivity.java          # Settings configuration
│   └── fragments/
│       ├── NowPlayingFragment.java    # Now playing UI
│       ├── PlaylistFragment.java      # Playlist management
│       └── DacStatusFragment.java     # USB DAC status
├── service/
│   └── PlayerService.java             # Audio playback service
├── audio/
│   └── UsbAudioEngine.java           # USB audio engine
├── usb/
│   ├── UsbDacManager.java            # USB DAC management
│   └── UsbPermissionActivity.java    # Permission handling
├── plugins/
│   ├── FLACPlugin.java               # FLAC decoder
│   ├── WAVPlugin.java                # WAV decoder
│   ├── AIFFPlugin.java               # AIFF decoder
│   ├── DSDPlugin.java                # DSD decoder
│   ├── StreamingPlugin.java          # Streaming support
│   └── PlaylistPlugin.java           # Playlist support
└── utils/
    ├── LogExporter.java              # Logging utility
    ├── CueSheetParser.java           # CUE sheet parser
    └── M3UPlaylistParser.java       # M3U playlist parser
```

### Native Components

```
jni/
├── FLACPlugin/                       # FLAC native decoder
├── WAVPlugin/                        # WAV native decoder
├── AIFFPlugin/                       # AIFF native decoder
├── DSDPlugin/                        # DSD native decoder
├── StreamingPlugin/                  # Streaming native support
├── PlaylistPlugin/                   # Playlist native support
├── UsbAudioEngine/                   # USB audio native engine
└── common/                           # Shared native utilities
```

## Installation

### Prerequisites
- Android Studio 4.0+
- Android SDK 21+
- NDK r21+
- USB DAC (optional, for bit-perfect playback)

### Build Instructions

1. **Clone Repository**
   ```bash
   git clone https://github.com/your-repo/audiophilia.git
cd audiophilia
   ```

2. **Configure NDK**
   ```bash
   # Set NDK path in local.properties
   ndk.dir=/path/to/android-ndk
   ```

3. **Build Project**
   ```bash
   ./gradlew assembleDebug
   ```

4. **Install APK**
   ```bash
   adb install app/build/outputs/apk/debug/app-debug.apk
   ```

## Usage

### Basic Playback

1. **Launch App**: Open Droidsound from app launcher
2. **Select Audio**: Choose audio files from device storage
3. **Play**: Audio starts playing with automatic format detection
4. **USB DAC**: If connected, audio automatically routes to USB DAC

### USB DAC Setup

1. **Connect USB DAC**: Plug USB DAC into device
2. **Grant Permissions**: Allow USB device access when prompted
3. **Automatic Detection**: App detects USB DAC and shows status
4. **Bit-Perfect Playback**: Audio routes directly to USB DAC

### Settings Configuration

1. **Open Settings**: Tap settings icon in main UI
2. **Audio Output**: Select Internal/USB DAC/Auto
3. **Resampling**: Enable/disable audio format conversion
4. **Logging**: Configure log levels and audio format logging

### Streaming Audio

1. **Stream URL**: Enter HTTP(S) URL for audio stream
2. **Buffer Configuration**: Adjust streaming buffer size
3. **Retry Logic**: Automatic retry on connection issues
4. **Format Support**: FLAC, WAV, MP3 streaming

### Playlist Management

1. **Load Playlist**: Import M3U playlist files
2. **Drag & Drop**: Reorder tracks with drag-drop
3. **Queue Management**: Add tracks to queue
4. **CUE Support**: Load CUE sheets for album navigation

## Configuration

### Audio Output Settings

- **Auto**: Automatically use USB DAC if available
- **Internal**: Force internal audio output
- **USB DAC**: Force USB DAC output (if available)

### Logging Settings

- **Error Only**: Only log error messages
- **Warning and Error**: Log warnings and errors
- **Info, Warning and Error**: Log info, warnings, and errors
- **Debug**: Log all messages including debug

### Streaming Settings

- **Buffer Size**: Configure streaming buffer (16KB-64KB)
- **Retry Count**: Set maximum retry attempts
- **Timeout**: Configure connection timeout

## Troubleshooting

### USB DAC Issues

1. **Check Permissions**: Ensure USB permissions are granted
2. **Verify Connection**: Check USB cable and device compatibility
3. **Check Logs**: Export logs to identify issues
4. **Test Audio**: Use test audio function in DAC status

### Audio Playback Issues

1. **Check Format**: Verify audio format is supported
2. **Check Settings**: Review audio output settings
3. **Check Logs**: Export logs for debugging
4. **Test Different Files**: Try different audio files

### Performance Issues

1. **Reduce Log Level**: Set log level to Error only
2. **Clear Logs**: Clear stored logs to free memory
3. **Check Buffer Size**: Adjust streaming buffer size
4. **Restart App**: Restart app to clear memory

## Development

### Adding New Audio Formats

1. **Create Plugin**: Add new plugin in `jni/` directory
2. **Implement Decoder**: Create native decoder implementation
3. **Add Java Interface**: Create Java plugin interface
4. **Register Plugin**: Add plugin to DroidSoundPlugin registry

### Adding New UI Features

1. **Create Fragment**: Add new fragment in `ui/fragments/`
2. **Create Layout**: Add layout file in `res/layout/`
3. **Update MainActivity**: Add fragment to MainActivity
4. **Add Navigation**: Update bottom navigation

### Debugging

1. **Enable Debug Logging**: Set log level to Debug
2. **Export Logs**: Export logs to file for analysis
3. **Check Audio Format**: Review audio format logs
4. **Monitor Performance**: Track memory and CPU usage

## API Reference

### PlayerService Methods

```java
// USB DAC Management
public void enableUsbAudio(boolean enable);
public boolean isUsbAudioEnabled();
public boolean isUsbDacConnected();
public String getCurrentUsbDeviceName();

// Audio Playback
public boolean playMod(String name);
public void playPause(boolean play);
public void stop();
public boolean seekTo(int msec);

// CUE Sheet Support
public void loadCueSheet(String audioFilePath);
public CueTrack getCurrentTrack();
public List<CueTrack> getCueTracks();

// Streaming Support
public boolean isStreaming();
public String getCurrentStreamUrl();
public void setStreamBufferSize(int bufferSize);
```

### LogExporter Methods

```java
// Logging
public static void logAudioFormat(String deviceName, int sampleRate, int bitDepth, int channels, String format, String codec);
public static void logUsbDacEvent(String event, String deviceName, String format);
public static void logAudioOutputChange(String fromDevice, String toDevice, String reason);
public static void logResampling(int fromSampleRate, int toSampleRate, int fromBitDepth, int toBitDepth, String method);

// Export
public static String exportLogs(Context context);
public static void clearLogs();
public static String getLogStatistics();
```

## Contributing

### Code Style

- Follow Android coding conventions
- Use meaningful variable and method names
- Add comprehensive comments for complex logic
- Include error handling for all operations

### Testing

- Test on multiple Android versions
- Test with various USB DACs
- Test with different audio formats
- Test streaming functionality
- Test UI responsiveness

### Documentation

- Update README for new features
- Add inline code comments
- Create feature-specific documentation
- Update API documentation

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Original Droidsound developers for the base architecture
- Android USB audio community for USB DAC support
- FLAC, WAV, AIFF, DSD format specifications
- Material You design system

## Support

For issues and questions:
- Check the troubleshooting section
- Review the logs for error information
- Test with different audio files and USB DACs
- Report bugs with detailed information

## Roadmap

### Planned Features
- [ ] Advanced audio visualization
- [ ] Equalizer support
- [ ] Crossfade between tracks
- [ ] Gapless playback
- [ ] Advanced playlist features
- [ ] Cloud storage integration
- [ ] Advanced audio processing
- [ ] Multi-room audio support

### Performance Improvements
- [ ] Optimized audio processing
- [ ] Reduced memory usage
- [ ] Faster startup time
- [ ] Better battery efficiency
- [ ] Improved streaming performance

---

**Audiophilia** - High-resolution audio player with USB DAC support
