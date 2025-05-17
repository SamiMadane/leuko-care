// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) => PatientModel(
  id: json['id'] as String?,
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  profileImage: json['profileImage'] as String,
  doctorId: json['doctorId'] as String,
  userType: json['userType'] as String,
  isExamined: json['isExamined'] as bool,
  registrationDate: json['registrationDate'] as String,
  healthStatus: json['healthStatus'] as String,
  birthDate: json['birthDate'] as String,
  leukemiaType: json['leukemiaType'] as String,
  diseaseConfidence: (json['diseaseConfidence'] as num).toDouble(),
  aiNote: json['aiNote'] as String?,
  latestSampleImageUrl: json['latestSampleImageUrl'] as String?,
  lastExamDate: json['lastExamDate'] as String?,
  hasUnreadMessages: json['hasUnreadMessages'] as bool?,
  lastMessageTime: const TimestampConverter().fromJson(json['lastMessageTime']),
  fcmToken: json['fcmToken'] as String?,
  gender: json['gender'] as String,
);

Map<String, dynamic> _$PatientModelToJson(PatientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'profileImage': instance.profileImage,
      'doctorId': instance.doctorId,
      'userType': instance.userType,
      'isExamined': instance.isExamined,
      'registrationDate': instance.registrationDate,
      'healthStatus': instance.healthStatus,
      'birthDate': instance.birthDate,
      'leukemiaType': instance.leukemiaType,
      'diseaseConfidence': instance.diseaseConfidence,
      'aiNote': instance.aiNote,
      'latestSampleImageUrl': instance.latestSampleImageUrl,
      'lastExamDate': instance.lastExamDate,
      'hasUnreadMessages': instance.hasUnreadMessages,
      'lastMessageTime': _$JsonConverterToJson<dynamic, Timestamp>(
        instance.lastMessageTime,
        const TimestampConverter().toJson,
      ),
      'gender': instance.gender,
      'fcmToken': instance.fcmToken,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
