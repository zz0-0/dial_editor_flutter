import 'package:dial_editor_flutter/feature/editor/presentation/view/component/segment.dart';
import 'package:dial_editor_flutter/feature/editor/presentation/view/component/tab_nav.dart';
import 'package:dial_editor_flutter/share/provider/document/presentation/view/page/markdown_editing_area_provider.dart';
import 'package:dial_editor_flutter/share/provider/editor/presentation/state_manager/opened_files_notifier_provider.dart';
import 'package:dial_editor_flutter/share/provider/file_system/presentation/view/componet/file_tree_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainArea extends ConsumerWidget {
  const MainArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = ref.watch(fileKeyProvider);
    return Column(
      children: [
        if (ref.watch(openedFilesProvider).isNotEmpty) const TabNav(),
        Expanded(
          child: Column(
            children: [
              if (ref.watch(openedFilesProvider).isNotEmpty) const Segment(),
              if (key != null)
                Expanded(child: ref.watch(markdownEditingAreaProvider)),
            ],
          ),
        ),
      ],
    );
  }
}
