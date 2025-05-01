import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime timestamp; 
  final String? attachmentUrl; 

  ChatModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
    this.attachmentUrl, 
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
