import 'dart:io';
import 'package:file_picker/file_picker.dart';

abstract interface class FileSystemDataSource {
  Future<File> openFile();
  Future<List<File>> openFiles();
  Future<void> createFile();
  Future<void> renameFile(String newPath);
  Future<void> copyFile(String newPath);
  Future<void> deleteFile();
  Future<void> createDirectory();
  Future<void> renameDirectory(String newPath);
  Future<void> copyDirectory(String newPath);
  Future<void> deleteDirectory();
  Future<List<FileSystemEntity>> openDirectoryPicker();
  Future<List<FileSystemEntity>> getEntitiesByDirectoryPath(String path);
}

class FileSystemDataSourceImpl implements FileSystemDataSource {
  @override
  Future<void> copyDirectory(String newPath) {
    throw UnimplementedError();
  }

  @override
  Future<void> copyFile(String newPath) {
    throw UnimplementedError();
  }

  @override
  Future<void> createDirectory() {
    throw UnimplementedError();
  }

  @override
  Future<void> createFile() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteDirectory() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFile() {
    throw UnimplementedError();
  }

  @override
  Future<List<FileSystemEntity>> openDirectoryPicker() async {
    final selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      return getEntitiesByDirectoryPath(selectedDirectory);
    } else {
      throw Exception('Directory not selected');
    }
  }

  @override
  Future<List<FileSystemEntity>> getEntitiesByDirectoryPath(String path) async {
    final entities = Directory(path).listSync();

    final directories = entities.whereType<Directory>().toList();
    final files = entities.whereType<File>().toList();

    directories.sort((a, b) => a.path.compareTo(b.path));
    files.sort((a, b) => a.path.compareTo(b.path));

    return [...directories, ...files];
  }

  @override
  Future<File> openFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return File(result.files.single.path!);
    } else {
      throw Exception('File not selected');
    }
  }

  @override
  Future<List<File>> openFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      return result.paths.map((path) => File(path!)).toList();
    } else {
      throw Exception('Files not selected');
    }
  }

  @override
  Future<void> renameDirectory(String newPath) {
    throw UnimplementedError();
  }

  @override
  Future<void> renameFile(String newPath) {
    throw UnimplementedError();
  }
}
