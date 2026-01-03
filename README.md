# 📱 AI Object Detector App (Flutter)

A cross-platform mobile application built with **Flutter** that interacts with a **Django YOLOv8 API** to detect objects in images. This app handles image capture, API communication, and dynamic rendering of bounding boxes using CustomPainters.

![Flutter](https://img.shields.io/badge/Flutter-3.19-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0-0175C2?logo=dart)
![Platform](https://img.shields.io/badge/Platform-Android%20|%20iOS-gray)
![State Management](https://img.shields.io/badge/State-Provider%20|%20Bloc-purple)


## ✨ Features

* **Image Capture:** Seamless integration with Camera and Gallery using `image_picker`.
* **Real-time API Interaction:** Uploads images to the Django/YOLOv8 backend using `Dio` / `Http`.
* **Visual Visualization:** Draws Bounding Boxes and Labels directly on the image using **CustomPainter**.
* **Error Handling:** Graceful handling of network timeouts and server errors.
* **Responsive Design:** Optimized UI for both Android and iOS devices.

## 🛠️ Tech Stack

* **Framework:** Flutter (Dart)
* **Networking:** Dio (with Interceptors for logging)
* **Image Handling:** image_picker, flutter_image_compress
* **Architecture:** Clean Architecture (Separation of UI, Logic, and Data)

## 🚀 Installation & Setup

**1. Clone the repository**
```bash
git clone [https://github.com/your-username/flutter-object-detector.git](https://github.com/your-username/flutter-object-detector.git)
cd flutter-object-detector
```
2. Install Dependencies

```Bash

flutter pub get
```
3. Configure Backend Connection Create a .env file or update the constant file lib/core/constants.py:

```Dart

// For Android Emulator
const String BASE_URL = "[http://10.0.2.2:8000/api/detect/](http://10.0.2.2:8000/api/detect/)";

// For Physical Device (Use your PC's Local IP)
const String BASE_URL = "[http://192.168.1.](http://192.168.1.)X:8000/api/detect/";
```
4. Run the App

```Bash

flutter run
```
🔒 Security & Optimization (Future Roadmap)
As part of the security integration roadmap:

[ ] SSL Pinning: Prevent Man-in-the-Middle (MITM) attacks when communicating with the API.

[ ] Secure Storage: Store user tokens/sessions using flutter_secure_storage.

[ ] App Obfuscation: Obfuscate Dart code in release builds to prevent reverse engineering.

🤝 Contributing
Contributions are welcome! If you are interested in AI on Mobile or App Security, feel free to open an issue.

Developed by Nima
