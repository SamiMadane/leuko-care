// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      conversationId: json['conversationId'] as String? ?? '',
      participantAId: json['participantAId'] as String,
      participantBId: json['participantBId'] as String,
      lastMessage: json['lastMessage'] as String? ?? '',
      lastMessageTime:
          const TimestampConverter().fromJson(json['lastMessageTime']),
      hasUnreadMessagesByParticipant:
          (json['hasUnreadMessagesByParticipant'] as Map<String, dynamic>?)
                  ?.map(
                (k, e) => MapEntry(k, e as bool),
              ) ??
              {},
      lastMessageSenderId: json['lastMessageSenderId'] as String,
    );

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'participantAId': instance.participantAId,
      'participantBId': instance.participantBId,
      'lastMessage': instance.lastMessage,
      'lastMessageTime':
          const TimestampConverter().toJson(instance.lastMessageTime),
      'lastMessageSenderId': instance.lastMessageSenderId,
      'hasUnreadMessagesByParticipant': instance.hasUnreadMessagesByParticipant,
    };
