
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
  final String gender;
  final String? fcmToken;
  final String? language;


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
    this.fcmToken,
    this.language,
    required this.gender,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return  _$PatientModelFromJson(json);
  }
    

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
    String? gender,
    String? fcmToken,
    String? language
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
      gender: gender ?? this.gender,
      fcmToken: fcmToken ?? this.fcmToken,
      language: language ?? this.language,
    );
  }

  // Override equality to compare PatientModel objects by their ID only.
  // This is needed for DropdownButton in UploadSampleScreen to correctly
  // recognize the selected patient after navigating between screens.
 @override
bool operator ==(Object other) =>
    identical(this, other) ||
    other is PatientModel &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        name == other.name &&
        email == other.email &&
        phone == other.phone &&
        profileImage == other.profileImage &&
        doctorId == other.doctorId &&
        userType == other.userType &&
        isExamined == other.isExamined &&
        registrationDate == other.registrationDate &&
        healthStatus == other.healthStatus &&
        birthDate == other.birthDate &&
        leukemiaType == other.leukemiaType &&
        diseaseConfidence == other.diseaseConfidence &&
        aiNote == other.aiNote &&
        latestSampleImageUrl == other.latestSampleImageUrl &&
        lastExamDate == other.lastExamDate &&
        gender == other.gender &&
        fcmToken == other.fcmToken;

@override
int get hashCode =>
    id.hashCode ^
    name.hashCode ^
    email.hashCode ^
    phone.hashCode ^
    profileImage.hashCode ^
    doctorId.hashCode ^
    userType.hashCode ^
    isExamined.hashCode ^
    registrationDate.hashCode ^
    healthStatus.hashCode ^
    birthDate.hashCode ^
    leukemiaType.hashCode ^
    diseaseConfidence.hashCode ^
    (aiNote?.hashCode ?? 0) ^
    (latestSampleImageUrl?.hashCode ?? 0) ^
    (lastExamDate?.hashCode ?? 0) ^
    gender.hashCode ^
    (fcmToken?.hashCode ?? 0);
    
bool equalsById(PatientModel other) {
  return this.id == other.id;
}

}
