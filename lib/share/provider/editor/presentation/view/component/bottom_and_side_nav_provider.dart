import 'package:flutter/material.dart';

enum Navigation {
  file(
    selectedIcon: Icon(Icons.file_open),
    icon: Icon(Icons.file_open_outlined),
    label: 'File',
  ),
  search(
    selectedIcon: Icon(Icons.person_search),
    icon: Icon(Icons.person_search_outlined),
    label: 'Search',
  ),
  setting(
    selectedIcon: Icon(Icons.settings),
    icon: Icon(Icons.settings_outlined),
    label: 'Setting',
  );

  const Navigation({
    required this.selectedIcon,
    required this.icon,
    required this.label,
  });

  final Icon selectedIcon;
  final Icon icon;
  final String label;
}
