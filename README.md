# leuko_care

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
