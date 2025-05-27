
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
  timestamp: const TimestampConverter().fromJson(json['timestamp']),
  attachmentUrl: json['attachmentUrl'] as String,
);

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
  'id': instance.id,
  'senderId': instance.senderId,
  'receiverId': instance.receiverId,
  'text': instance.text,
  'timestamp': const TimestampConverter().toJson(instance.timestamp),
  'attachmentUrl': instance.attachmentUrl,
};
