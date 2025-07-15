# High-Resolution Audio Support for Droidsound

This document describes the implementation of high-resolution audio format support in Droidsound, transforming it from a retro music player into a production-grade, high-resolution audio player.

## Overview

Droidsound has been extended to support modern high-resolution audio formats while maintaining its existing retro format capabilities. The implementation includes:

- **FLAC Support**: Up to 24-bit/192kHz lossless audio
- **WAV Support**: Up to 32-bit/384kHz uncompressed PCM
- **AIFF Support**: Apple's uncompressed PCM format
- **DSD Support**: Direct Stream Digital (DSF files)
- **CUE Sheet Support**: Album navigation and track splitting
- **USB DAC Integration**: Bit-perfect playback via USB audio devices

## Supported Formats

### FLAC (Free Lossless Audio Codec)
- **Sample Rates**: 44.1kHz, 48kHz, 88.2kHz, 96kHz, 176.4kHz, 192kHz
- **Bit Depths**: 16-bit, 24-bit, 32-bit
- **Channels**: Mono, Stereo, Multi-channel
- **Features**: Metadata support (Vorbis comments), seeking, streaming

### WAV (Waveform Audio File Format)
- **Sample Rates**: Up to 384kHz
- **Bit Depths**: 16-bit, 24-bit, 32-bit
- **Channels**: Mono, Stereo, Multi-channel
- **Features**: Uncompressed PCM, direct file access

### AIFF (Audio Interchange File Format)
- **Sample Rates**: Up to 384kHz
- **Bit Depths**: 16-bit, 24-bit, 32-bit
- **Channels**: Mono, Stereo, Multi-channel
- **Features**: Apple's uncompressed format, 80-bit float sample rate

### DSD (Direct Stream Digital)
- **Formats**: DSF (DSD Stream File)
- **Rates**: DSD64 (2.8MHz), DSD128 (5.6MHz), DSD256 (11.2MHz)
- **Features**: Native DSD playback or PCM conversion
- **Channels**: Stereo

## Architecture

### Plugin System
The high-resolution formats are implemented using Droidsound's existing plugin architecture:

```
src/com/ssb/droidsound/plugins/
├── FLACPlugin.java      # FLAC decoder plugin
├── WAVPlugin.java       # WAV decoder plugin
├── AIFFPlugin.java      # AIFF decoder plugin
└── DSDPlugin.java       # DSD decoder plugin
```

### Native Implementation
Each format has a corresponding native C++ implementation:

```
jni/
├── flac/
│   ├── flac_decoder.cpp    # FLAC decoder using libFLAC
│   └── Android.mk          # Build configuration
├── wav/
│   ├── wav_decoder.cpp     # WAV decoder
│   └── Android.mk
├── aiff/
│   ├── aiff_decoder.cpp    # AIFF decoder
│   └── Android.mk
└── dsd/
    ├── dsd_decoder.cpp     # DSD decoder
    └── Android.mk
```

### CUE Sheet Support
Album navigation is handled by the CUE sheet parser:

```
src/com/ssb/droidsound/utils/
└── CueSheetParser.java     # CUE sheet parsing and navigation
```

## Features

### High-Resolution Playback
- **Bit-Perfect Output**: Direct PCM passthrough to USB DACs
- **Format Detection**: Automatic format detection and configuration
- **Sample Rate Matching**: Automatic sample rate switching
- **Bit Depth Support**: 16-bit, 24-bit, and 32-bit audio

### USB DAC Integration
- **Direct Audio Routing**: Bypasses Android's audio mixer
- **Format Negotiation**: Automatic format negotiation with DAC
- **AAudio Support**: Uses Android 8.1+ AAudio for low-latency
- **OpenSL ES Fallback**: Compatible with older Android versions

### CUE Sheet Navigation
- **Track Splitting**: Automatic track detection from CUE files
- **Album Metadata**: Artist, album, track information
- **Seeking**: Direct track seeking within albums
- **Progress Tracking**: Current track and position display

### Metadata Support
- **FLAC Metadata**: Vorbis comments (artist, album, title, etc.)
- **CUE Sheet Metadata**: Album and track information
- **Format Information**: Sample rate, bit depth, channels
- **Duration**: Accurate track and album duration

## Usage

### Playing High-Resolution Files
```java
// Load and play a FLAC file
PlayerService service = getPlayerService();
service.playMod("/path/to/album.flac");

// Enable USB audio for bit-perfect playback
service.enableUsbAudio(true);
service.startUsbAudio();
```

### CUE Sheet Navigation
```java
// Get current track information
CueTrack currentTrack = service.getCurrentTrack();
if (currentTrack != null) {
    String trackTitle = currentTrack.title;
    String artist = currentTrack.performer;
    long startTime = currentTrack.startTime;
}

// Seek to specific track
service.seekToTrack(2); // Track 3 (0-indexed)

// Get all tracks
List<CueTrack> tracks = service.getCueTracks();
```

### USB Audio Configuration
```java
// Configure USB audio format
service.setUsbAudioFormat(192000, 24, 2); // 192kHz, 24-bit, stereo

// Get connected USB devices
List<AudioDeviceInfo> devices = service.getUsbDevices();

// Select USB DAC
service.setUsbDevice(selectedDevice);
```

## Build Configuration

### Dependencies
- **libFLAC**: For FLAC decoding (static library)
- **Android NDK**: For native code compilation
- **AAudio**: For USB audio (Android 8.1+)

### Build Files
```makefile
# jni/Android.mk - Main build configuration
include $(X)/flac/Android.mk
include $(X)/wav/Android.mk
include $(X)/aiff/Android.mk
include $(X)/dsd/Android.mk
```

### Plugin Registration
```java
// src/com/ssb/droidsound/plugins/DroidSoundPlugin.java
public static List<DroidSoundPlugin> createPluginList() {
    List<DroidSoundPlugin> pluginList = new ArrayList<>();
    
    // High-resolution audio plugins (priority)
    pluginList.add(new FLACPlugin());
    pluginList.add(new WAVPlugin());
    pluginList.add(new AIFFPlugin());
    pluginList.add(new DSDPlugin());
    
    // Retro format plugins
    pluginList.add(new OpenMPTPlugin());
    // ... other plugins
}
```

## Performance Considerations

### Memory Management
- **Direct Buffers**: Uses ByteBuffer.allocateDirect() for efficient native access
- **Streaming**: Reads audio data in chunks to minimize memory usage
- **Format Conversion**: Efficient bit depth and sample rate conversion

### CPU Optimization
- **Native Code**: Critical audio processing in C++ for performance
- **SIMD Instructions**: Optimized audio processing where available
- **Buffer Management**: Efficient buffer reuse and management

### USB Audio Latency
- **AAudio**: Low-latency audio path for USB DACs
- **Direct Routing**: Bypasses Android's audio mixer
- **Format Matching**: Automatic format negotiation for optimal performance

## Compatibility

### Android Versions
- **Android 8.1+**: Full USB audio support with AAudio
- **Android 4.4+**: Basic USB audio with OpenSL ES
- **Android 4.0+**: High-resolution format playback

### USB DAC Support
- **FiiO KA11**: Tested and supported
- **AudioQuest DragonFly**: Compatible
- **Schiit Modi**: Compatible
- **Generic USB DACs**: Automatic detection and configuration

### File Format Support
- **FLAC**: Full support with metadata
- **WAV**: Uncompressed PCM support
- **AIFF**: Apple format support
- **DSD**: DSF file support (DFF planned)

## Testing

### Audio Quality Verification
- **Bit-Perfect Playback**: Verified with audio analysis tools
- **Sample Rate Accuracy**: Confirmed with frequency analysis
- **Dynamic Range**: 24-bit and 32-bit audio support verified

### Performance Testing
- **CPU Usage**: Optimized for minimal CPU impact
- **Memory Usage**: Efficient buffer management
- **Latency**: Low-latency USB audio confirmed

### Compatibility Testing
- **USB DACs**: Tested with multiple DAC models
- **Android Versions**: Verified on Android 8.1+ and 4.4+
- **File Formats**: Tested with various high-resolution files

## Future Enhancements

### Planned Features
- **DFF Support**: Complete DSD format support
- **Network Streaming**: High-resolution streaming support
- **Advanced DSP**: Equalizer and effects processing
- **Gapless Playback**: Seamless track transitions
- **MQA Support**: Master Quality Authenticated audio

### Performance Improvements
- **Hardware Acceleration**: GPU-accelerated audio processing
- **Parallel Processing**: Multi-threaded audio decoding
- **Memory Optimization**: Further memory usage optimization

## Conclusion

The high-resolution audio support transforms Droidsound from a retro music player into a production-grade, high-resolution audio player. The implementation maintains compatibility with existing retro formats while adding modern high-resolution capabilities, USB DAC support, and album navigation features.

The modular architecture allows for easy extension with additional formats and features, making Droidsound a versatile audio player suitable for both retro gaming and high-fidelity music listening. 