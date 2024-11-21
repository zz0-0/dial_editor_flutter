import 'package:dial_editor_flutter/feature/file_system/domain/model/file_tree_node.dart';
import 'package:dial_editor_flutter/feature/file_system/presentation/state_manager/file_tree_nodes_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fileTreeNodesProvider =
    NotifierProvider<FileTreeNodesNotifier, List<FileTreeNode>>(
  FileTreeNodesNotifier.new,
);
