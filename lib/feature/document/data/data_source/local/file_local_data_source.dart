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
    final id = ref.watch(fileIdProvider);
    return await ref.watch(fileProvider(id!))!;
  }

  @override
  Future<void> writeFile(String content) async {
    final id = ref.watch(fileIdProvider);
    return ref.watch(fileProvider(id!))!.writeAsStringSync(content);
  }
}
