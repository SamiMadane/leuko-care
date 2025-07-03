# leuko_care

## 📖 Overview

**leuko_care** is a medical application designed to enhance the experience of leukemia patients by connecting them with their specialized doctors, tracking test results, managing conversations between patients and doctors, and providing important notifications and alerts.

The app features an easy-to-use interface supporting both Arabic and English languages, with a secure authentication system based on Firebase Authentication.

---

## 🚀 Key Features

- Login using email and Google account  
- User management system (Admin, Doctor, Patient) with distinct permissions for each role  
- Real-time chat for managing conversations between patients and doctors  
- Uploading and viewing medical test results by doctors for their patients  
- Instant notifications using Firebase Cloud Messaging (FCM)  
- Multi-language support (Arabic and English) via `easy_localization`  
- Password recovery through email  
- Image storage via Cloudinary for better performance and cost-efficiency  
- Responsive and elegant UI with support for light and dark themes  

---

## 🛠 Technologies Used

- **Flutter** for building the app’s user interface  
- **Firebase** for authentication, Firestore database, and push notifications (FCM)  
- **flutter_bloc** for state management and business logic  
- **Cloudinary** for image and file storage  
- **easy_localization** for multi-language support  
- **Lottie** to enhance user experience with animations  
- **freezed + json_serializable** for safe and efficient data modeling  

---

## 📂 Project Structure

```plaintext
leuko_care/
├── android/                 # Android-specific files
├── ios/                     # iOS-specific files
├── assets/                  # Fonts, images, animations, languages
├── lib/                     # Main Flutter source code
│   ├── core/                # Shared utilities, helpers, and services
│   ├── feature/             # Features divided by domain (Auth, Chats, Doctors, Patients...)
│   ├── main.dart            # App entry point
│   └── firebase_options.dart # Firebase configuration
├── test/                    # Unit and widget tests
├── pubspec.yaml             # Dependencies and configurations
├── flutter_native_splash.yaml # Splash screen config
└── README.md                # This file

## System Design 🎨

![system design](https://github.com/user-attachments/assets/58875a89-7f3e-41f4-b723-fd22a3d4ecb2)

### Commands we used 

1. To run my project structure script, use the following command: ✍️
```bash
dart run structure_project.dart
```

2. To run flutter native splash ( if it outside pubspec.yaml ), use the following command: ✍️
```bash
dart run flutter_native_splash:create --path=flutter_native_splash.yaml
```

3. To run flutter native splash ( if it inside pubspec.yaml ), use the following command: ✍️
```bash
dart run flutter_native_splash:create
```

4. If you are using models with the `@JsonSerializable()` or `@Freezed()` or `@RestApi()` annotation, run the following command to generate the necessary code:✍️
```bash
   flutter pub run build_runner build --delete-conflicting-outputs
```
