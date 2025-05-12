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
  final double diseaseConfidence;
  final String? aiNote; 
  final String? latestSampleImageUrl;
  final String? lastExamDate;
  final bool? hasUnreadMessages;
  final String? lastMessageTime;
  final String? gender;

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
    required this.diseaseConfidence,
    this.aiNote,
    this.latestSampleImageUrl,
    this.lastExamDate,
    this.hasUnreadMessages,
    this.lastMessageTime,
    this.gender,
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
    String? diseaseType,
    double? diseaseConfidence,
    String? aiNote,
    String? latestSampleImageUrl,
    String? lastExamDate,
    bool? hasUnreadMessages,
    String? lastMessageTime,
    String? gender,
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
      leukemiaType: diseaseType ?? this.leukemiaType,
      diseaseConfidence: diseaseConfidence ?? this.diseaseConfidence,
      aiNote: aiNote ?? this.aiNote,
      latestSampleImageUrl: latestSampleImageUrl ?? this.latestSampleImageUrl,
      lastExamDate: lastExamDate ?? this.lastExamDate,
      hasUnreadMessages: hasUnreadMessages ?? this.hasUnreadMessages,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      gender: gender ?? this.gender,
    );
  }
}
