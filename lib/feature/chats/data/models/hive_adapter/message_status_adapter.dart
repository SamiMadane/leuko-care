import 'package:hive/hive.dart';
import 'package:leuko_care/feature/chats/data/models/chat_model.dart';

class MessageStatusAdapter extends TypeAdapter<MessageStatus> {
  @override
  final int typeId = 101; // اجعل هذا الرقم فريدًا

  @override
  MessageStatus read(BinaryReader reader) {
    return MessageStatus.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, MessageStatus obj) {
    writer.writeInt(obj.index);
  }
}
