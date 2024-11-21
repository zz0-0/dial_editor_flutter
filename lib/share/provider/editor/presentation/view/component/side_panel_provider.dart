import 'package:dial_editor_flutter/feature/file_system/presentation/view/component/file_tree.dart';
import 'package:dial_editor_flutter/share/provider/editor/presentation/view/component/side_nav_provider.dart';
import 'package:dial_editor_flutter/share/provider/file_system/presentation/state_manager/file_tree_nodes_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sidePanelWidgetProvider = Provider<Widget>((ref) {
  final selectedIndex = ref.watch(selectedIndexProvider);
  if (selectedIndex == 0) {
    return _buildFolderView(ref);
  } else if (selectedIndex == 1) {
    return _buildSearchView();
  } else if (selectedIndex == 2) {
    return _buildSettingsView();
  } else {
    return Container();
  }
});

Widget _buildFolderView(Ref ref) {
  final fileTreeNode = ref.watch(fileTreeNodesProvider);
  if (fileTreeNode.isEmpty) {
    return Center(
      child: TextButton(
        onPressed: () {
          ref.read(fileTreeNodesProvider.notifier).loadDirectory();
        },
        child: const Text('Open Folder'),
      ),
    );
  } else {
    return const FileTree();
  }
}

Widget _buildSearchView() {
  return Container();
}

Widget _buildSettingsView() {
  return Container();
}
