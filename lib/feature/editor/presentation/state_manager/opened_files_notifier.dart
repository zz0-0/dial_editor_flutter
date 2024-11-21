import 'dart:collection';
import 'dart:io';

import 'package:dial_editor_flutter/share/provider/file_system/presentation/view/componet/file_tree_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OpenedFilesNotifier extends Notifier<LinkedHashMap<GlobalKey, String>> {
  @override
  LinkedHashMap<GlobalKey, String> build() {
    return LinkedHashMap();
  }

  void addFile(String path) {
    final key = state.entries.firstWhere(
      (e) => e.value == path,
      orElse: () {
        final key0 = GlobalKey();
        final entry = MapEntry<GlobalKey, String>(key0, path);
        final current = LinkedHashMap<GlobalKey, String>.from(state);
        current[key0] = path;
        state = current;
        ref.read(fileKeyProvider.notifier).state = key0;
        return entry;
      },
    ).key;
    ref.read(fileKeyProvider.notifier).state = key;
    ref.read(fileProvider(key).notifier).state = File(path);
  }

  void removeFile(String path) {
    final key = state.entries.firstWhere((e) => e.value == path).key;
    ref.read(fileProvider(key).notifier).state = null;
    state.remove(key);
    if (state.entries.lastOrNull == null) {
      ref.read(fileKeyProvider.notifier).state = null;
    } else {
      ref.read(fileKeyProvider.notifier).state = state.entries.last.key;
    }
    state = LinkedHashMap<GlobalKey, String>.from(state);
  }
}
