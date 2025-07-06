import 'dart:io';

void main() {
  final directory = Directory.current; // تقدر تغيّر المسار لو حابب

  // دالة تمشي على الملفات بشكل متكرر
  void processDirectory(Directory dir) {
    final entities = dir.listSync(recursive: false);

    for (var entity in entities) {
      if (entity is File) {
        final path = entity.path;
        if (path.endsWith('.freezed.dart') || path.endsWith('.g.dart')) {
          print('Processing $path');

          final content = entity.readAsStringSync();

          // استبدال كل .tr() بـ '' (حذفها)
          final newContent = content.replaceAll('.tr()', '');

          // اكتب المحتوى الجديد بنفس الملف
          entity.writeAsStringSync(newContent);
        }
      } else if (entity is Directory) {
        // استدعاء دالة للمجلدات الفرعية
        processDirectory(entity);
      }
    }
  }

  processDirectory(directory);
  print('Done.');
}
