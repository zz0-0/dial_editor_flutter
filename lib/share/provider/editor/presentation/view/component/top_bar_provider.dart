import 'dart:ui';

import 'package:dial_editor_flutter/share/provider/theme/theme_notifier_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuItem {
  const MenuItem({
    required this.label,
    this.onPressed,
    this.children,
  });

  final String label;
  final VoidCallback? onPressed;
  final List<MenuItem>? children;

  bool get hasSubmenu => children != null && children!.isNotEmpty;
}

final menuProvider = Provider<Map<String, MenuItem>>(
  (ref) {
    return {
      'File': MenuItem(
        label: 'File',
        children: [
          MenuItem(
            label: 'New',
            onPressed: () {},
          ),
          MenuItem(
            label: 'Open',
            onPressed: () {},
          ),
          MenuItem(
            label: 'Save',
            onPressed: () {},
          ),
          MenuItem(
            label: 'Save As',
            onPressed: () {},
          ),
          MenuItem(
            label: 'Export',
            onPressed: () {},
            children: [
              MenuItem(
                label: 'Export as Image',
                onPressed: () {},
              ),
              MenuItem(
                label: 'Export as PDF',
                onPressed: () {},
              ),
            ],
          ),
          MenuItem(
            label: 'Import',
            onPressed: () {},
          ),
        ],
      ),
      'Edit': MenuItem(
        label: 'Edit',
        children: [
          MenuItem(
            label: 'Undo',
            onPressed: () {},
          ),
          MenuItem(
            label: 'Redo',
            onPressed: () {},
          ),
          MenuItem(
            label: 'Cut',
            onPressed: () {},
          ),
          MenuItem(
            label: 'Copy',
            onPressed: () {},
          ),
          MenuItem(
            label: 'Paste',
            onPressed: () {},
          ),
        ],
      ),
      'Theme': MenuItem(
        label: 'Theme',
        children: [
          MenuItem(
            label: 'Switch Theme',
            onPressed: () {
              ref.read(themeProvider.notifier).toggle();
            },
          ),
          MenuItem(
            label: 'Color Scheme',
            onPressed: () {},
            children: [
              MenuItem(
                label: 'Blue',
                onPressed: () {},
              ),
              MenuItem(
                label: 'Red',
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    };
  },
);
