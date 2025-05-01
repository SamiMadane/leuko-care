// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
  id: json['id'] as String,
  senderId: json['senderId'] as String,
  receiverId: json['receiverId'] as String,
  text: json['text'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  attachmentUrl: json['attachmentUrl'] as String?,
);

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
  'id': instance.id,
  'senderId': instance.senderId,
  'receiverId': instance.receiverId,
  'text': instance.text,
  'timestamp': instance.timestamp.toIso8601String(),
  'attachmentUrl': instance.attachmentUrl,
};
