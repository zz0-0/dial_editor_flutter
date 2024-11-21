import 'dart:io';

import 'package:dial_editor_flutter/feature/file_system/data/data_source/local/file_system_entity_data_source.dart';
import 'package:dial_editor_flutter/feature/file_system/domain/gateway/file_system_gateway.dart';
import 'package:dial_editor_flutter/feature/file_system/domain/model/file_tree_node.dart';

class FileSystemGatewayImpl implements FileSystemGateway {
  FileSystemGatewayImpl(this._fileSystemDataSource);

  final FileSystemDataSource _fileSystemDataSource;

  @override
  Future<List<FileTreeNode>> directoryEntitiesToNode(String? path) async {
    final entities = path == null
        ? await _fileSystemDataSource.openDirectoryPicker()
        : await _fileSystemDataSource.getEntitiesByDirectoryPath(path);
    return entities.map(FileTreeNode.fromFileSystemEntity).toList();
  }

  @override
  Future<FileSystemEntity> openFile() {
    return _fileSystemDataSource.openFile();
  }

  @override
  Future<List<FileSystemEntity>> openFiles() {
    return _fileSystemDataSource.openFiles();
  }
}
