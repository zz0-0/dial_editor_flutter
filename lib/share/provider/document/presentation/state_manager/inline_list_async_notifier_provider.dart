import 'package:dial_editor_flutter/feature/document/presentation/state_manager/inline_list_async_notifier.dart';
import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inlineListProvider =
    AsyncNotifierProvider<InlineListAsyncNotifier, List<Inline>>(
  InlineListAsyncNotifier.new,
);
