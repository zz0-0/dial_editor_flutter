import 'package:dial_editor_flutter/feature/file_system/presentation/view/component/file_tree_item.dart';
import 'package:dial_editor_flutter/share/provider/editor/presentation/state_manager/opened_files_notifier_provider.dart';
import 'package:dial_editor_flutter/share/provider/file_system/presentation/state_manager/file_tree_nodes_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileTree extends ConsumerStatefulWidget {
  const FileTree({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TreeState();
}

class _TreeState extends ConsumerState<FileTree> {
  @override
  Widget build(BuildContext context) {
    final fileTreeNoes = ref.watch(fileTreeNodesProvider);
    return ListView.builder(
      itemCount: fileTreeNoes.length,
      itemBuilder: (context, index) {
        final node = fileTreeNoes[index];
        return FileTreeItem(
          node: node,
          onFileTap: (node) {
            ref.read(openedFilesProvider.notifier).addFile(node.path);
          },
          onDirectoryTap: (node) {
            ref.read(fileTreeNodesProvider.notifier).toggleNode(node);
          },
        );
      },
    );
  }
}
