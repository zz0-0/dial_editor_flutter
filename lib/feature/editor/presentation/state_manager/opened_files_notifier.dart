import 'dart:collection';
import 'dart:io';

import 'package:dial_editor_flutter/share/provider/file_system/presentation/view/componet/file_tree_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OpenedFilesNotifier extends Notifier<LinkedHashMap<String, String>> {
  @override
  LinkedHashMap<String, String> build() {
    return LinkedHashMap();
  }

  void addFile(String path) {
    final id = state.entries.firstWhere(
      (e) => e.value == path,
      orElse: () {
        const id0 = '';
        final entry = MapEntry<String, String>(id0, path);
        final current = LinkedHashMap<String, String>.from(state);
        current[id0] = path;
        state = current;
        ref.read(fileIdProvider.notifier).state = id0;
        return entry;
      },
    ).key;
    ref.read(fileIdProvider.notifier).state = id;
    ref.read(fileProvider(id).notifier).state = File(path);
  }

  void removeFile(String path) {
    final id = state.entries.firstWhere((e) => e.value == path).key;
    ref.read(fileProvider(id).notifier).state = null;
    state.remove(id);
    if (state.entries.lastOrNull == null) {
      ref.read(fileIdProvider.notifier).state = null;
    } else {
      ref.read(fileIdProvider.notifier).state = state.entries.last.key;
    }
    state = LinkedHashMap<String, String>.from(state);
  }
}
