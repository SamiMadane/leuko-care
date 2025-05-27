import 'dart:io';

void main() {
  final projectDir = Directory('lib');
  final dartFiles = <File>[];

  void scanDir(Directory dir) {
    for (var entity in dir.listSync(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        dartFiles.add(entity);
      }
    }
  }

  scanDir(projectDir);

  final pattern = RegExp(r'\.tr\(\);');

  for (var file in dartFiles) {
    final content = file.readAsStringSync();
    final newContent = content.replaceAll(pattern, '.tr()');

    if (content != newContent) {
      file.writeAsStringSync(newContent);
      print('Fixed: ${file.path}');
    }
  }

  print('All done!');
}
