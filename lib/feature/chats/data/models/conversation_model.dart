import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:leuko_care/core/helpers/timestamp_converter.dart';

part 'conversation_model.g.dart';

@JsonSerializable()
class ConversationModel {
  @JsonKey(defaultValue: '')
  final String conversationId; // عادة يكون عبارة عن `${participantAId}_${participantBId}`
  final String participantAId;
  final String participantBId;
  @JsonKey(defaultValue: '')
  final String lastMessage;

  @TimestampConverter()
  final Timestamp? lastMessageTime;

  /// يخزن حالة الرسائل غير المقروءة لكل مشارك بناءً على معرفه
  @JsonKey(defaultValue: {})
  final Map<String, bool> hasUnreadMessagesByParticipant;

  ConversationModel({
    required this.conversationId,
    required this.participantAId,
    required this.participantBId,
    required this.lastMessage,
    this.lastMessageTime,
    required this.hasUnreadMessagesByParticipant,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);

  /// دالة مساعدة للحصول على حالة الرسائل غير المقروءة لمشارك معين
  bool hasUnreadMessagesFor(String userId) {
    return hasUnreadMessagesByParticipant[userId] ?? false;
  }

  ConversationModel copyWith({
    String? conversationId,
    String? participantAId,
    String? participantBId,
    String? lastMessage,
    Timestamp? lastMessageTime,
    Map<String, bool>? hasUnreadMessagesByParticipant,
  }) {
    return ConversationModel(
      conversationId: conversationId ?? this.conversationId,
      participantAId: participantAId ?? this.participantAId,
      participantBId: participantBId ?? this.participantBId,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      hasUnreadMessagesByParticipant: hasUnreadMessagesByParticipant ?? this.hasUnreadMessagesByParticipant,
    );
  }
}
