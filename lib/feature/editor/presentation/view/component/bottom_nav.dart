import 'package:dial_editor_flutter/share/provider/editor/presentation/view/component/bottom_and_side_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNav extends ConsumerWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationBar(
      destinations: [
        NavigationDestination(
          selectedIcon: Navigation.file.selectedIcon,
          icon: Navigation.file.icon,
          label: Navigation.file.label,
        ),
        NavigationDestination(
          selectedIcon: Navigation.search.selectedIcon,
          icon: Navigation.search.icon,
          label: Navigation.search.label,
        ),
        NavigationDestination(
          selectedIcon: Navigation.setting.selectedIcon,
          icon: Navigation.setting.icon,
          label: Navigation.setting.label,
        ),
      ],
    );
  }
}
