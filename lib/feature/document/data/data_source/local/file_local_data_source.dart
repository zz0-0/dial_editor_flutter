import 'dart:io';

import 'package:dial_editor_flutter/share/provider/file_system/presentation/view/componet/file_tree_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class FileLocalDataSource {
  Future<File> readFile();
  Future<void> writeFile(String content);
}

class FileLocalDataSourceImpl implements FileLocalDataSource {
  FileLocalDataSourceImpl(this.ref);
  Ref ref;
  @override
  Future<File> readFile() async {
    final key = ref.watch(fileKeyProvider);
    return await ref.watch(fileProvider(key!))!;
  }

  @override
  Future<void> writeFile(String content) async {
    final key = ref.watch(fileKeyProvider);
    return ref.watch(fileProvider(key!))!.writeAsStringSync(content);
  }
}
