import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:leuko_care/feature/chats/data/models/timestamp_converter.dart';
part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;

  @TimestampConverter()
  final Timestamp timestamp;

  final String attachmentUrl;

  ChatModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
    required this.attachmentUrl,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  ChatModel copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? text,
    Timestamp? timestamp,
    String? attachmentUrl,
  }) {
    return ChatModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
    );
  }
}
