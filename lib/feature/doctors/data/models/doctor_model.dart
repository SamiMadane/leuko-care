import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:leuko_care/core/helpers/timestamp_converter.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorModel {
  final String? id;
  final String name;
  final String experience;
  final String description;
  final String email;
  final String phone;
  final String profileImage;
  final String userType;
  final bool? hasUnreadMessages;
  @TimestampConverter()
  final Timestamp? lastMessageTime;
  final String gender;
  final String? fcmToken;

  DoctorModel({
    required this.id,
    required this.name,
    required this.experience,
    required this.description,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.userType,
    this.hasUnreadMessages,
    this.lastMessageTime,
    this.fcmToken,
    required this.gender,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);

  DoctorModel copyWith({
    String? id,
    String? name,
    String? experience,
    String? description,
    String? email,
    String? phone,
    String? profileImage,
    String? userType,
    bool? hasUnreadMessages,
    Timestamp? lastMessageTime,
    String? gender,
    String? fcmToken,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      experience: experience ?? this.experience,
      description: description ?? this.description,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      userType: userType ?? this.userType,
      hasUnreadMessages: hasUnreadMessages ?? this.hasUnreadMessages,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      gender: gender ?? this.gender,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}
