// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
  id: json['id'] as String?,
  name: json['name'] as String,
  experience: json['experience'] as String,
  description: json['description'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  profileImage: json['profileImage'] as String,
  userType: json['userType'] as String,
  hasUnreadMessages: json['hasUnreadMessages'] as bool?,
  lastMessageTime: const TimestampConverter().fromJson(json['lastMessageTime']),
  fcmToken: json['fcmToken'] as String?,
  gender: json['gender'] as String,
);

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'experience': instance.experience,
      'description': instance.description,
      'email': instance.email,
      'phone': instance.phone,
      'profileImage': instance.profileImage,
      'userType': instance.userType,
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
