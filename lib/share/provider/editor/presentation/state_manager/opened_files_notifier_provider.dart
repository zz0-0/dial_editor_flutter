import 'dart:collection';

import 'package:dial_editor_flutter/feature/editor/presentation/state_manager/opened_files_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final openedFilesProvider =
    NotifierProvider<OpenedFilesNotifier, LinkedHashMap<String, String>>(
  OpenedFilesNotifier.new,
);
