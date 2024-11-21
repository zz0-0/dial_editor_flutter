import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:dial_editor_flutter/share/provider/document/presentation/state_manager/inline_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Expand extends ConsumerWidget {
  const Expand({required this.inline, super.key});

  final Inline inline;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 30,
      height: inline.lineHeight,
      child: Center(
        child: GestureDetector(
          onTap: () {
            ref.read(inlineProvider(inline.key).notifier).toggleExpand();
          },
          child: inline.isBlockStart
              ? inline.isExpanded
                  ? const Icon(Icons.expand_more)
                  : const Icon(Icons.chevron_right)
              : Container(),
        ),
      ),
    );
  }
}
