import 'dart:io';

class FileTreeNode {
  FileTreeNode({
    required this.name,
    required this.path,
    required this.isDirectory,
    this.children = const [],
    this.isExpanded = false,
  });

  factory FileTreeNode.fromFileSystemEntity(FileSystemEntity entity) {
    final name = entity.path.split(Platform.pathSeparator).last;
    final path = entity.path;
    final isDirectory = entity is Directory;
    return FileTreeNode(
      name: name,
      path: path,
      isDirectory: isDirectory,
    );
  }

  final String name;
  final String path;
  final bool isDirectory;
  List<FileTreeNode> children;
  bool isExpanded;

  @override
  String toString() {
    return 'FileTreeNode(name: $name, path: $path, isDirectory: $isDirectory, '
        'children: $children, isExpanded: $isExpanded)';
  }
}
