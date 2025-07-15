# USB DAC Permissions and Device Detection

## Overview

This document describes the comprehensive USB DAC permissions and device detection system implemented in Droidsound. The system provides automatic USB DAC detection, runtime permission handling, user notifications, and audio routing for bit-perfect playback.

## Architecture

### Core Components

1. **UsbDacManager** (`src/com/ssb/droidsound/usb/UsbDacManager.java`)
   - Central manager for USB DAC device detection and permissions
   - Handles automatic device discovery and connection events
   - Manages runtime permissions and user notifications
   - Routes audio output to USB DACs

2. **UsbPermissionActivity** (`src/com/ssb/droidsound/usb/UsbPermissionActivity.java`)
   - Dedicated activity for handling USB device permission requests
   - Provides user-friendly interface for permission management
   - Shows device information and permission status

3. **PlayerService Integration**
   - Integrated USB DAC manager into the main player service
   - Provides USB DAC status to UI components
   - Handles audio routing and format configuration

4. **UI Integration**
   - Updated DacStatusFragment to use new USB DAC manager
   - Real-time status updates and device information display
   - Material You design with dark theme

## Features

### Automatic Device Detection

- **USB Device Monitoring**: Continuously monitors for USB device connections/disconnections
- **Audio Device Detection**: Detects USB audio devices via Android AudioManager
- **Device Matching**: Matches USB devices with corresponding audio devices
- **Format Detection**: Automatically detects supported audio formats (sample rates, bit depths, channels)

### Runtime Permissions

- **Automatic Permission Requests**: Requests USB permissions when devices are connected
- **User-Friendly Interface**: Dedicated permission activity with device information
- **Permission Status Tracking**: Monitors permission grants/denials
- **Fallback Handling**: Graceful handling of permission denials

### User Notifications

- **Connection Notifications**: Shows "USB DAC Connected: FiiO KA11 – 24bit/192kHz"
- **Disconnection Notifications**: Alerts when USB DAC is disconnected
- **Permission Notifications**: Informs about permission grants/denials
- **Status Updates**: Real-time status in UI components

### Audio Routing

- **Direct Audio Routing**: Routes audio directly to USB DAC bypassing Android mixer
- **Format Configuration**: Configures optimal audio format for each device
- **Bit-Perfect Playback**: Ensures bit-perfect audio transmission
- **Fallback Support**: Falls back to internal audio if USB DAC unavailable

## Implementation Details

### UsbDacManager

```java
public class UsbDacManager {
    // Device tracking
    private Map<String, UsbDevice> connectedUsbDevices;
    private List<AudioDeviceInfo> usbAudioDevices;
    private UsbDevice currentUsbDevice;
    private AudioDeviceInfo currentAudioDevice;
    
    // Callbacks for UI updates
    public interface UsbDacCallback {
        void onUsbDeviceConnected(UsbDevice device, AudioDeviceInfo audioDevice);
        void onUsbDeviceDisconnected(UsbDevice device);
        void onUsbPermissionGranted(UsbDevice device);
        void onUsbPermissionDenied(UsbDevice device);
        void onAudioDeviceChanged(AudioDeviceInfo device);
    }
}
```

### Key Methods

1. **startMonitoring()**: Starts USB device monitoring
2. **checkExistingDevices()**: Checks for already connected devices
3. **requestUsbPermission()**: Requests permission for USB device
4. **routeAudioToUsbDevice()**: Routes audio to USB device
5. **getDeviceInfoString()**: Returns formatted device information

### Permission Handling

```java
// Request permission with user-friendly interface
private void requestUsbPermission(UsbDevice device) {
    Intent intent = new Intent(this, UsbPermissionActivity.class);
    intent.putExtra(UsbManager.EXTRA_DEVICE, device);
    startActivity(intent);
}

// Handle permission result
private void handlePermissionResult(boolean granted) {
    if (granted) {
        // Route audio to USB device
        routeAudioToUsbDevice(currentAudioDevice);
        showUsbConnectedNotification(device, audioDevice);
    } else {
        showUsbPermissionDeniedNotification(device);
    }
}
```

### Notification System

```java
// Show connection notification
private void showUsbConnectedNotification(UsbDevice device, AudioDeviceInfo audioDevice) {
    String deviceName = device.getProductName();
    String format = getAudioFormatString(audioDevice);
    String message = deviceName + " – " + format;
    
    NotificationCompat.Builder builder = new NotificationCompat.Builder(context, CHANNEL_ID)
        .setContentTitle("USB DAC Connected")
        .setContentText(message);
}
```

## UI Integration

### DacStatusFragment Updates

- **Real-time Status**: Shows current USB DAC connection status
- **Device Information**: Displays device name, format, and capabilities
- **Permission Status**: Shows permission status for connected devices
- **Format Configuration**: Allows manual format configuration

### Status Display

```java
private void updateStatusDisplay(boolean usbDacConnected, String deviceName, String deviceFormat) {
    if (usbDacConnected) {
        statusText.setText("USB DAC Connected: " + deviceName);
        currentFormatText.setText("Format: " + deviceFormat);
        connectedChip.setChecked(true);
        activeChip.setChecked(true);
        bitPerfectChip.setChecked(true);
    } else {
        statusText.setText("No USB DAC Connected");
        connectedChip.setChecked(false);
        activeChip.setChecked(false);
        bitPerfectChip.setChecked(false);
    }
}
```

## Permissions and Manifest

### AndroidManifest.xml

```xml
<!-- USB DAC permissions -->
<uses-permission android:name="android.permission.USB_PERMISSION" />
<uses-feature android:name="android.hardware.usb.host" android:required="false" />
<uses-feature android:name="android.hardware.usb.accessory" android:required="false" />

<!-- USB Permission Activity -->
<activity android:name="com.ssb.droidsound.usb.UsbPermissionActivity" 
    android:theme="@style/Theme.Droidsound.Dark"
    android:exported="false" />
```

### Runtime Permissions

- **USB_PERMISSION**: Required for accessing USB devices
- **Audio Device Access**: Automatic detection via AudioManager
- **Notification Permissions**: For user notifications

## Usage

### Automatic Detection

1. **Connect USB DAC**: Plug in USB DAC to device
2. **Permission Request**: App automatically requests permission
3. **User Approval**: User grants permission via UsbPermissionActivity
4. **Audio Routing**: Audio automatically routes to USB DAC
5. **Status Update**: UI shows "USB DAC Connected: [Device] – [Format]"

### Manual Control

1. **DAC Status Fragment**: View current USB DAC status
2. **Device List**: See all connected USB audio devices
3. **Format Configuration**: Configure audio format manually
4. **Enable/Disable**: Manually enable/disable USB audio

### Notification Examples

- **Connected**: "USB DAC Connected: FiiO KA11 – 24bit/192kHz"
- **Disconnected**: "USB DAC Disconnected: FiiO KA11"
- **Permission Denied**: "USB DAC Permission Denied: Cannot access FiiO KA11"

## Error Handling

### Permission Denials

- **Graceful Fallback**: Falls back to internal audio
- **User Notification**: Informs user of permission denial
- **Retry Option**: Allows user to retry permission request

### Device Disconnection

- **Automatic Detection**: Detects when USB DAC is unplugged
- **Audio Fallback**: Automatically switches to internal audio
- **Status Update**: Updates UI to reflect disconnection

### Audio Errors

- **Error Detection**: Detects audio routing errors
- **Fallback Mechanism**: Switches to internal audio on error
- **User Notification**: Informs user of audio issues

## Testing

### USB DAC Testing

1. **Connect USB DAC**: Plug in USB DAC to test device
2. **Permission Flow**: Test permission request and approval
3. **Audio Routing**: Verify audio routes to USB DAC
4. **Format Detection**: Check automatic format detection
5. **Disconnection**: Test disconnection handling

### Notification Testing

1. **Connection Notification**: Verify connection notification appears
2. **Format Display**: Check format string accuracy
3. **Permission Notifications**: Test permission grant/denial notifications

## Future Enhancements

### Planned Features

1. **Multiple Device Support**: Support for multiple USB DACs
2. **Advanced Format Detection**: More sophisticated format detection
3. **Custom Format Configuration**: User-defined format settings
4. **Device Profiles**: Save/load device configurations
5. **Advanced Error Recovery**: More robust error handling

### Potential Improvements

1. **USB Audio Class 2.0**: Support for USB Audio Class 2.0 devices
2. **DSD Support**: Direct Stream Digital support
3. **Advanced Routing**: More sophisticated audio routing options
4. **Device Validation**: Validate device compatibility
5. **Performance Optimization**: Optimize for low-latency audio

## Troubleshooting

### Common Issues

1. **Permission Denied**: Check USB permissions in system settings
2. **Device Not Detected**: Verify USB DAC compatibility
3. **Audio Not Routing**: Check audio format compatibility
4. **Format Issues**: Verify device supports requested format

### Debug Information

- **Log Tags**: Use "UsbDacManager" for USB DAC logs
- **Device Info**: Check device information in DAC status
- **Permission Status**: Verify permission status in UI
- **Audio Format**: Check current audio format settings

## Conclusion

The USB DAC permissions and device detection system provides a comprehensive solution for automatic USB DAC detection, permission handling, and audio routing. The system ensures bit-perfect playback while providing a user-friendly experience with clear notifications and status updates.

The implementation follows Android best practices for USB device handling and provides robust error handling and fallback mechanisms. The modular design allows for easy extension and enhancement of functionality. 