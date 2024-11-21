import 'dart:io';

import 'package:dial_editor_flutter/feature/file_system/domain/model/file_tree_node.dart';

abstract interface class FileSystemGateway {
  Future<List<FileTreeNode>> directoryEntitiesToNode(String? path);
  Future<FileSystemEntity> openFile();
  Future<List<FileSystemEntity>> openFiles();
}
