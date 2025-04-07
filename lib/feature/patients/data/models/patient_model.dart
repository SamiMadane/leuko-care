import 'package:json_annotation/json_annotation.dart';
part 'patient_model.g.dart';

@JsonSerializable()
class PatientModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String profileImage;
  final String doctorId; // الطبيب المعالج
  final String userType; // نوع المستخدم (مريض، دكتور، أدمن)
  final bool isExamined; // حالة فحص المريض
  final String registrationDate; // تاريخ التسجيل (تاريخ اليوم)
  final String healthStatus; // حالة المريض (سليم، مريض)
  final String birthDate; // تاريخ ميلاد المريض

  PatientModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.doctorId,
    required this.userType,
    required this.isExamined,
    required this.registrationDate,
    required this.healthStatus,
    required this.birthDate,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => _$PatientModelFromJson(json);
  Map<String, dynamic> toJson() => _$PatientModelToJson(this);

  PatientModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImage,
    String? doctorId,
    String? userType,
    bool? isExamined,
    String? registrationDate,
    String? healthStatus,
    String? birthDate,
  }) {
    return PatientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      doctorId: doctorId ?? this.doctorId,
      userType: userType ?? this.userType,
      isExamined: isExamined ?? this.isExamined,
      registrationDate: registrationDate ?? this.registrationDate,
      healthStatus: healthStatus ?? this.healthStatus,
      birthDate: birthDate ?? this.birthDate,
    );
  }
}
