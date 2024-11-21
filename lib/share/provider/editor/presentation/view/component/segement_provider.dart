import 'package:flutter/material.dart';

enum DisplayType {
  file(
    label: 'File',
    icon: Icon(Icons.drive_file_rename_outline_outlined),
  ),
  canvas(
    label: 'Canvas',
    icon: Icon(Icons.draw_outlined),
  );

  const DisplayType({
    required this.label,
    required this.icon,
  });

  final String label;
  final Icon icon;
}
