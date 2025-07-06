import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:leuko_care/core/helpers/timestamp_converter.dart';
part 'chat_model.g.dart';

enum MessageStatus { sending, sent, failed }

@HiveType(typeId: 0)
@JsonSerializable()
class ChatModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String senderId;
  @HiveField(2)
  final String receiverId;
  @HiveField(3)
  final String text;

  @HiveField(4)
  @TimestampConverter()
  final Timestamp? timestamp;
  @HiveField(5)
  final String attachmentUrl;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(6)
  MessageStatus status;

  @HiveField(7)
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool pendingDelete;

  @HiveField(8)
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? localImagePath;

  ChatModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    this.timestamp,
    required this.attachmentUrl,
    this.status = MessageStatus.sending,
    this.pendingDelete = false,
    this.localImagePath
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
    MessageStatus? status,
    bool? pendingDelete,
    String? localImagePath

  }) {
    return ChatModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      status: status ?? this.status,
      pendingDelete: pendingDelete ?? this.pendingDelete,
      localImagePath: localImagePath ?? this.localImagePath,

    );
  }
}
