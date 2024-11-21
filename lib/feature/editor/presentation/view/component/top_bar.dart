import 'package:dial_editor_flutter/share/provider/editor/presentation/view/component/top_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBar extends ConsumerWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menu = ref.watch(menuProvider);
    return MenuBar(
      style: const MenuStyle(
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        elevation: WidgetStatePropertyAll(0),
      ),
      children: [
        ...menu.entries.map(
          (entry) => SubmenuButton(
            menuChildren: entry.value.children!
                .map(
                  buildMenuItem,
                )
                .toList(),
            child: Text(entry.value.label),
          ),
        ),
      ],
    );
  }

  Widget buildMenuItem(MenuItem item) {
    if (item.hasSubmenu) {
      return SubmenuButton(
        menuChildren: item.children!
            .map(
              buildMenuItem,
            )
            .toList(),
        child: Text(item.label),
      );
    } else {
      return MenuItemButton(
        onPressed: item.onPressed,
        child: Text(item.label),
      );
    }
  }
}
