import 'package:dial_editor_flutter/feature/document/presentation/view/markdown_editing/component/display.dart';
import 'package:dial_editor_flutter/feature/document/presentation/view/markdown_editing/component/edit.dart';
import 'package:dial_editor_flutter/feature/document/presentation/view/markdown_editing/component/expand.dart';
import 'package:dial_editor_flutter/feature/document/presentation/view/markdown_editing/component/line_number.dart';
import 'package:dial_editor_flutter/share/provider/document/presentation/state_manager/inline_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Line extends ConsumerWidget {
  const Line({required this.inlineKey, required this.index, super.key});

  final int index;
  final GlobalKey inlineKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inline = ref.watch(inlineProvider(inlineKey));
    final currentToggleLevel = ref.watch(toggleLevelProvider);
    return inline.isExpanded ||
            (inline.level <= currentToggleLevel &&
                inline.isExpanded == false &&
                inline.isBlockStart == true)
        ? Row(
            children: [
              LineNumber(
                inline: inline,
                index: index,
              ),
              Expand(
                inline: inline,
              ),
              Expanded(
                child: inline.isEditing
                    ? Edit(
                        inline: inline,
                      )
                    : Display(
                        inline: inline,
                      ),
              ),
            ],
          )
        : Container();
  }
}
