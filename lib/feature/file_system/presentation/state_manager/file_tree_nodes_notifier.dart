import 'package:dial_editor_flutter/feature/file_system/data/data_source/local/file_system_entity_data_source.dart';
import 'package:dial_editor_flutter/feature/file_system/data/gateway_impl/file_system_gateway_impl.dart';
import 'package:dial_editor_flutter/feature/file_system/domain/gateway/file_system_gateway.dart';
import 'package:dial_editor_flutter/feature/file_system/domain/model/file_tree_node.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileTreeNodesNotifier extends Notifier<List<FileTreeNode>> {
  FileTreeNodesNotifier();

  late FileSystemGateway _gateway;

  @override
  List<FileTreeNode> build() {
    _gateway = FileSystemGatewayImpl(FileSystemDataSourceImpl());
    return [];
  }

  Future<void> loadDirectory() async {
    state = await _gateway.directoryEntitiesToNode(null);
  }

  Future<void> toggleNode(FileTreeNode node) async {
    node.isExpanded = !node.isExpanded;
    if (node.children.isEmpty) {
      node.children = await _gateway.directoryEntitiesToNode(node.path);
    }
    state = [...state];
  }
}
