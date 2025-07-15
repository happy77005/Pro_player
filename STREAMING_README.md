# Droidsound Streaming Plugin System

## Overview

The streaming plugin system enhances Droidsound with HTTP(S) streaming capabilities, M3U playlist support, and integration with the USB DAC system for bit-perfect playback. This implementation provides a production-grade streaming solution similar to USB Audio Player PRO.

## Features

### Streaming Support
- **HTTP(S) Streaming**: Support for FLAC, WAV, and MP3 streams via HTTP/HTTPS
- **Buffering**: 32KB buffer with configurable size for smooth playback
- **Retry Logic**: Automatic reconnection with configurable retry attempts
- **Format Detection**: Automatic detection of audio format from stream headers
- **Metadata Support**: FLAC metadata parsing for title, artist, album info

### M3U Playlist Support
- **M3U/M3U8 Playlists**: Full support for M3U and extended M3U8 playlists
- **HTTP(S) Links**: Support for streaming URLs in playlists
- **Extended Info**: Parsing of #EXTINF tags for track duration and metadata
- **Relative URLs**: Automatic resolution of relative URLs in playlists
- **Playlist Navigation**: Track-by-track navigation with automatic progression

### USB DAC Integration
- **Bit-Perfect Playback**: Direct routing to USB DAC bypassing Android mixer
- **High-Resolution Support**: Up to 24-bit/192kHz streaming
- **Format Matching**: Automatic format negotiation with USB DAC capabilities
- **Real-time Switching**: Seamless switching between local and streaming audio

## Architecture

### Plugin System
```
StreamingPlugin (Base Class)
├── StreamingFLACPlugin
├── StreamingWAVPlugin
└── PlaylistPlugin
```

### Core Components

#### 1. StreamingPlugin (Base Class)
- **Location**: `src/com/ssb/droidsound/plugins/StreamingPlugin.java`
- **Purpose**: Base class for all streaming plugins
- **Features**:
  - HTTP(S) connection management
  - Buffering and retry logic
  - Audio format detection
  - PCM output routing

#### 2. StreamingFLACPlugin
- **Location**: `src/com/ssb/droidsound/plugins/StreamingFLACPlugin.java`
- **Purpose**: FLAC stream decoding
- **Features**:
  - FLAC header parsing
  - Metadata extraction (Vorbis comments)
  - Multi-bit depth support (16/24/32-bit)
  - Sample rate and channel detection

#### 3. StreamingWAVPlugin
- **Location**: `src/com/ssb/droidsound/plugins/StreamingWAVPlugin.java`
- **Purpose**: WAV stream decoding
- **Features**:
  - WAV header parsing
  - PCM format support
  - Multi-bit depth support
  - Chunk-based parsing

#### 4. PlaylistPlugin
- **Location**: `src/com/ssb/droidsound/plugins/PlaylistPlugin.java`
- **Purpose**: M3U playlist handling
- **Features**:
  - M3U/M3U8 parsing
  - Track navigation
  - Automatic format detection
  - Playlist metadata

#### 5. M3UPlaylistParser
- **Location**: `src/com/ssb/droidsound/utils/M3UPlaylistParser.java`
- **Purpose**: M3U playlist parsing utility
- **Features**:
  - Extended M3U8 support
  - Metadata parsing
  - URL validation
  - Format detection

## Usage

### Basic Streaming
```java
// Play a FLAC stream
playerService.playMod("https://example.com/stream.flac");

// Play a WAV stream
playerService.playMod("https://example.com/stream.wav");
```

### Playlist Streaming
```java
// Play an M3U playlist
playerService.playMod("https://example.com/playlist.m3u");

// Play a local M3U file
playerService.playMod("/sdcard/playlist.m3u");
```

### USB DAC Integration
```java
// Enable USB DAC for streaming
playerService.enableUsbAudio(true);
playerService.setUsbAudioFormat(48000, 24, 2); // 48kHz, 24-bit, stereo
playerService.startUsbAudio();

// Play stream with USB DAC
playerService.playMod("https://example.com/hi-res.flac");
```

## Configuration

### Streaming Settings
```java
// Configure buffer size (default: 32KB)
playerService.setStreamBufferSize(65536); // 64KB

// Configure retry attempts (default: 3)
playerService.setMaxStreamRetries(5);
```

### USB DAC Settings
```java
// Set audio format for streaming
playerService.setUsbAudioFormat(sampleRate, bitDepth, channels);

// Available formats:
// - 44.1kHz, 16-bit, stereo
// - 48kHz, 24-bit, stereo
// - 96kHz, 24-bit, stereo
// - 192kHz, 24-bit, stereo
```

## M3U Playlist Format

### Basic M3U
```
#EXTM3U
#EXTINF:180,Song Title - Artist
https://example.com/song1.flac
#EXTINF:240,Another Song - Another Artist
https://example.com/song2.wav
```

### Extended M3U8
```
#EXTM3U
#EXTINF:180.5,Song Title - Artist
https://example.com/song1.flac
#EXTINF:240.2,Another Song - Another Artist
https://example.com/song2.wav
#PLAYLIST:My Streaming Playlist
```

## Supported Formats

### Streaming Formats
- **FLAC**: Lossless compression, up to 24-bit/192kHz
- **WAV**: Uncompressed PCM, up to 24-bit/192kHz
- **MP3**: Lossy compression, up to 320kbps

### Playlist Formats
- **M3U**: Basic playlist format
- **M3U8**: Extended playlist format with metadata

### USB DAC Formats
- **Sample Rates**: 44.1kHz, 48kHz, 88.2kHz, 96kHz, 176.4kHz, 192kHz
- **Bit Depths**: 16-bit, 24-bit
- **Channels**: Mono (1), Stereo (2)

## Testing

### Streaming Test Activity
- **Location**: `src/com/ssb/droidsound/StreamingTestActivity.java`
- **Layout**: `res/layout/streaming_test_activity.xml`
- **Purpose**: Test streaming capabilities with USB DAC

### Features
- Stream URL input
- USB DAC enable/disable
- Real-time status monitoring
- Stream information display
- USB device information

### Usage
1. Launch StreamingTestActivity
2. Enter streaming URL
3. Enable USB DAC (optional)
4. Press "Play Stream"
5. Monitor status and information

## Performance Considerations

### Buffering
- **Default Buffer**: 32KB for smooth playback
- **Configurable**: Adjust based on network conditions
- **Memory Efficient**: Direct buffer management

### Network
- **Connection Timeout**: 10 seconds
- **Read Timeout**: 30 seconds
- **Retry Logic**: Automatic reconnection
- **Range Requests**: Support for partial content

### USB DAC
- **Direct Routing**: Bypasses Android audio system
- **Format Negotiation**: Automatic capability matching
- **Real-time Switching**: Seamless format changes
- **Bit-Perfect**: No resampling or mixing

## Error Handling

### Network Errors
- **Connection Failures**: Automatic retry with exponential backoff
- **Timeout Handling**: Configurable timeouts
- **Format Errors**: Graceful fallback to standard audio

### USB DAC Errors
- **Device Disconnection**: Automatic fallback to standard audio
- **Format Mismatch**: Automatic format negotiation
- **Driver Errors**: Graceful error reporting

## Integration with Existing System

### Plugin Registration
```java
// High-priority streaming plugins
pluginList.add(new StreamingFLACPlugin());
pluginList.add(new StreamingWAVPlugin());
pluginList.add(new PlaylistPlugin());
```

### Service Integration
```java
// PlayerService streaming support
public boolean isStreaming();
public String getCurrentStreamUrl();
public void setStreamBufferSize(int bufferSize);
public void setMaxStreamRetries(int maxRetries);
```

### USB Audio Integration
```java
// USB audio for streaming
public void enableUsbAudio(boolean enable);
public boolean setUsbDevice(AudioDeviceInfo device);
public void setUsbAudioFormat(int sampleRate, int bitDepth, int channels);
```

## Build Configuration

### Dependencies
- **Android HTTP**: Built-in HttpURLConnection
- **Native Libraries**: FLAC, WAV decoders
- **USB Audio**: AAudio/OpenSL ES

### Permissions
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
```

## Future Enhancements

### Planned Features
- **HLS Support**: HTTP Live Streaming
- **DASH Support**: Dynamic Adaptive Streaming
- **Caching**: Local stream caching
- **Quality Selection**: Adaptive bitrate streaming
- **Offline Playlists**: Download and cache playlists

### Performance Improvements
- **Parallel Buffering**: Multiple buffer streams
- **Predictive Loading**: Pre-buffer next track
- **Compression**: Network compression
- **CDN Support**: Content delivery network optimization

## Troubleshooting

### Common Issues

#### Stream Won't Play
1. Check network connectivity
2. Verify URL is accessible
3. Check audio format support
4. Review error logs

#### USB DAC Not Working
1. Verify USB DAC is connected
2. Check device compatibility
3. Verify audio format support
4. Check USB audio permissions

#### Playlist Issues
1. Verify M3U format
2. Check URL accessibility
3. Review playlist syntax
4. Check relative URL resolution

### Debug Information
```java
// Enable debug logging
Log.d(TAG, "Stream URL: " + streamUrl);
Log.d(TAG, "Buffer size: " + bufferSize);
Log.d(TAG, "Retry count: " + retryCount);
Log.d(TAG, "USB enabled: " + usbEnabled);
```

## Conclusion

The streaming plugin system provides a comprehensive solution for HTTP(S) audio streaming with USB DAC support. The modular architecture allows for easy extension and maintenance, while the integration with the existing plugin system ensures compatibility with all existing features.

The system is designed for production use with proper error handling, performance optimization, and user-friendly interfaces. The USB DAC integration provides bit-perfect playback capabilities that rival professional audio players. 