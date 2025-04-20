# obesmart

Here’s a simple step-by-step description on how to run your Flutter project, assuming you already have Flutter installed:

---

 🚀 How to Run Your Flutter Project

1. **Open Your Terminal or Command Prompt**  
   Navigate to your Flutter project directory:
   ```bash
   cd path/to/your/flutter_project
   ```

2. **Ensure Flutter SDK is Installed**  
   Run this to verify Flutter is set up correctly:
   ```bash
   flutter doctor
   ```
   Fix any issues shown (especially with Android SDK or emulators).

3. **Get All Dependencies**  
   Run:
   ```bash
   flutter pub get
   ```

4. **Launch an Emulator or Connect a Device**  
   - To start an Android emulator:
     ```bash
     flutter emulators --launch <emulator_id>
     ```
     Or use Android Studio to launch one.
   - Or just plug in your physical device with USB debugging enabled.

5. **Run the Project**  
   Run:
   ```bash
   flutter run
   ```

---

### Optional Commands

- **Run on a specific device** (if multiple are connected):
  ```bash
  flutter devices  # list devices
  flutter run -d <device_id>
  ```

- **Run in release mode** (faster, no debugging):
  ```bash
  flutter run --release
  ```

- **Hot reload** (while running):
  - Press `r` in terminal for hot reload
  - Press `R` for full restart

---



## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
