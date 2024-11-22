import 'package:dial_editor_flutter/feature/document/presentation/view/markdown_editing/component/line.dart';
import 'package:dial_editor_flutter/share/provider/document/presentation/state_manager/inline_list_async_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarkdownEditingArea extends ConsumerWidget {
  const MarkdownEditingArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inlines = ref.watch(inlineListProvider);
    return inlines.when(
      loading: Container.new,
      data: (inlines) => ListView.builder(
        key: ObjectKey(inlines),
        itemCount: inlines.length,
        itemBuilder: (context, index) {
          final inline = inlines[index];
          return Line(
            inlineKey: inline.key,
            index: index,
          );
        },
      ),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}
