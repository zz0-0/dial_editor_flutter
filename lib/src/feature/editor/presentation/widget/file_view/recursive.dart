import 'package:dial_editor/src/core/provider/editor/file_view_provider.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/block.dart';
import 'package:dial_editor/src/feature/editor/domain/model/element/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/model/node.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/editing.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/expand.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/line_number.dart';
import 'package:dial_editor/src/feature/editor/presentation/widget/file_view/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Recursive extends ConsumerWidget {
  final Node node;
  final int index;
  const Recursive(
    this.node,
    this.index, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = index;
    if (node is Block) {
      ref
          .read(nodeListStateNotifierProvider.notifier)
          .insertBlockNodeIntoMap(node.key, node as Block);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (node as Block).children.map((child) {
          final widget = Recursive(child, currentIndex);
          currentIndex++;
          return widget;
        }).toList(),
      );
    } else if (node is Inline) {
      final inlineNode = node as Inline;
      final List<Inline?> updatedNode =
          ref.watch(nodeStateProvider(inlineNode.key));
      if (updatedNode.isEmpty) {
        updatedNode.add(inlineNode);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(nodeStateProvider(node.key).notifier).initialize(inlineNode);
        });
      }
      return _buildNodeContent(updatedNode[0]!, currentIndex);
    }
    return Container();
  }

  Widget _buildNodeContent(Inline inline, int currentIndex) {
    return (inline.isBlockStart || (!inline.isBlockStart && inline.isExpanded))
        ? Row(
            children: [
              LineNumber(inline, currentIndex),
              Expand(inline),
              Expanded(
                child: inline.isEditing ? Editing(inline) : Rendering(inline),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
