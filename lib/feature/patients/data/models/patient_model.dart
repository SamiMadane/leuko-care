import 'package:json_annotation/json_annotation.dart';
part 'patient_model.g.dart';

@JsonSerializable()
class PatientModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String profileImage;
  final String doctorId;
  final String userType;
  final bool isExamined;
  final String registrationDate;
  final String healthStatus;
  final String birthDate;
  final String leukemiaType;

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
    required this.leukemiaType,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);
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
    String? leukemiaType,
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
      leukemiaType: leukemiaType ?? this.leukemiaType,
    );
  }
}
