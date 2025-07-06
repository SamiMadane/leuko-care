import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class TimestampAdapter extends TypeAdapter<Timestamp> {
  @override
  final int typeId = 100; // أي رقم لا يتعارض مع الباقي

  @override
  Timestamp read(BinaryReader reader) {
    final microsecondsSinceEpoch = reader.readInt();
    return Timestamp.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
  }

  @override
  void write(BinaryWriter writer, Timestamp obj) {
    writer.writeInt(obj.microsecondsSinceEpoch);
  }
}
