# leuko_Ai

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
```
## 🧑‍💻 Usage / How to Use

Upon launching the app, the following flow is followed:

1. **Splash Screen** – Displays the app logo briefly.  
2. **Onboarding Screen** – Introduces the app's core features.  
3. **User Selection** – User selects their role (**Admin**, **Doctor**, or **Patient**) before authentication.  
4. **Login Screen** – Sign in via **email** or **Google**.  
5. **Role-Based Dashboard** – The app navigates to the corresponding interface based on the selected role.

---

### 👑 Admin Panel

Admins have full control over the system:

- View, add, update, or delete **doctors and patients**
- Monitor full application activity
- Access a comprehensive **statistics dashboard**
- Interface available in both **Arabic** and **English**

---

### 🧑‍⚕️ Doctor Dashboard

Doctors can:

- View statistics for **their assigned patients**
- **Chat** with patients in real time
- Upload **blood sample images** and submit **diagnosis results**
- View and update **personal profile**
- Access the **patient list** with detailed case information

---

### 🧑‍💼 Patient Dashboard

Patients can:

- View a personalized home screen:
  - If diagnosed, the result is displayed
  - If not yet diagnosed, a **Lottie animation** with a waiting message is shown
- **Chat** directly with their assigned doctor
- Edit **personal profile information**
- Receive real-time **push notifications** when:
  - A **new message** is received

---

### 🌐 Language and Notifications

- Fully localized in **Arabic** and **English** using `easy_localization`
- Push notifications powered by **Firebase Cloud Messaging (FCM)**:
- Instant alerts for chat messages and medical results


## Commands we used 

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
## 📞 Contact & Support

If you have any questions, encounter issues, or would like to contribute or suggest improvements, feel free to reach out:

- 📧 **Email**: [samimadane23@gmail.com](mailto:samimadane23@gmail.com)  
- 💼 **LinkedIn**: [linkedin.com/in/samimadane](https://www.linkedin.com/in/samimadane)  
- 🐞 **Report Issues**: Feel free to open an issue in this GitHub repository to report bugs or request features.
