# Streaming Install Utility

Streaming Install Utility is a tool designed to simplify the installation, update, and downgrade of `.apk` files on Android devices directly from your PC.
With this tool, you don’t need to copy `.apk` files manually onto your Android device for installation, Just one click and it’s done!

---

## Features

- Install APK files on connected Android devices
- Update existing apps easily
- Downgrade APK versions when needed
- Works seamlessly with devices connected via USB or Wi-Fi

---

## Installation

1. Download the `installer.zip` file
2. Extract it to `C:\` drive
3. Run the registry configuration file: `C:\.StreamInstallUtility\Registry_Config.reg`
4. Installation is complete

---

## Important Device Requirement

⚠️ **USB Debugging must be enabled on your Android device.**  
This tool communicates with devices via `adb`, which requires developer access. So, Make sure your device is authorized when first connected to your PC. You may see a prompt on your phone asking to allow USB debugging — choose **Allow**.

---

## Important Notices

To ensure proper functionality, please configure the following environment variables:

1. **AAPT Path**  
   - Add the path of `Android SDK build-tools` to a new system variable named `aapt_path`  
   - Example: `D:\Android-Developer-Tools\Android-SDK\build-tools\36.0.0`

2. **ADB Path**  
   - Add the path of `Android SDK platform-tools` to the end of the existing `Path` system variable

3. **Wi-Fi Device Setup**  
   - To use `Set Device on WiFi.cmd` located in `.StreamInstallUtility`, add a new system variable named `MyStaticMobileIPAddress`  
   - Set its value to the static IP address of your mobile device on your local network

---

## Usage

- **Install APK files**  
  - Double-click on the `.apk` file **OR**  
  - Right-click the `.apk` > click on `Install on Device` to install it directly into your device
- **Remote Install via CMD**  
  - Open Command Prompt in `.StreamInstallUtility` folder:  `Remote_Install yourapp.apk` Installs the APK into the connected device.
  - Open Logcat utility for device logs:  `Remote_Install logger`
- **Set Device on Wi-Fi**  
  - Run `Set Device on WiFi.cmd` to connect your device over Wi-Fi. Make sure `MyStaticMobileIPAddress` is set as a system variable.
  - You can Run `Set Device on WiFi.cmd` and choose internal options to use different if for other devices.

---

## Folder Content (`.StreamInstallUtility`)

- **APK_File_Icon.ico** — Icon used for APK files (optional visual aid)
- **Registry_Config.reg** — Adds necessary registry settings for the utility
- **Remote_Install.cmd** — Command-line tool to install APKs remotely and open Logcat
- **Set Device on WiFi.cmd** — Command to configure your device for Wi-Fi installation
  - Tip: Create a shortcut with hotkeys (e.g., Ctrl+1) to run this script quickly
 
---

## Contributing

Contributions, issues, and feature requests are welcome.  
Please submit a pull request or open an issue to collaborate.  

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
