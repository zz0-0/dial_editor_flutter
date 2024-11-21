import 'package:dial_editor_flutter/feature/file_system/domain/model/file_tree_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileTreeItem extends ConsumerWidget {
  const FileTreeItem({
    required this.node,
    required this.onFileTap,
    required this.onDirectoryTap,
    super.key,
  });

  final FileTreeNode node;
  final void Function(FileTreeNode node) onFileTap;
  final void Function(FileTreeNode node) onDirectoryTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              if (node.isDirectory) {
                onDirectoryTap(node);
              } else {
                onFileTap(node);
              }
            },
            child: Row(
              children: [
                if (node.isDirectory)
                  Icon(
                    node.isExpanded
                        ? Icons.keyboard_arrow_down_outlined
                        : Icons.keyboard_arrow_right_outlined,
                  ),
                if (!node.isDirectory) const Icon(Icons.insert_drive_file),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    node.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          if (node.isDirectory && node.isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: node.children
                    .map(
                      (child) => FileTreeItem(
                        node: child,
                        onFileTap: onFileTap,
                        onDirectoryTap: onDirectoryTap,
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
