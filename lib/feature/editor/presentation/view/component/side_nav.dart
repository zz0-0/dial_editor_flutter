import 'package:dial_editor_flutter/share/provider/editor/presentation/view/component/bottom_and_side_nav_provider.dart';
import 'package:dial_editor_flutter/share/provider/editor/presentation/view/component/side_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SideNav extends ConsumerStatefulWidget {
  const SideNav({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SideNavState();
}

class _SideNavState extends ConsumerState<SideNav> {
  @override
  Widget build(BuildContext context) {
    var selectedIndex = ref.watch(selectedIndexProvider);
    return NavigationRail(
      minWidth: 52,
      selectedIndex: selectedIndex,
      labelType: NavigationRailLabelType.none,
      indicatorColor: Colors.transparent,
      indicatorShape: const CircleBorder(),
      destinations: [
        NavigationRailDestination(
          selectedIcon: Navigation.file.selectedIcon,
          icon: Navigation.file.icon,
          label: Text(Navigation.file.label),
        ),
        NavigationRailDestination(
          selectedIcon: Navigation.search.selectedIcon,
          icon: Navigation.search.icon,
          label: Text(Navigation.search.label),
        ),
        NavigationRailDestination(
          selectedIcon: Navigation.setting.selectedIcon,
          icon: Navigation.setting.icon,
          label: Text(Navigation.setting.label),
        ),
      ],
      onDestinationSelected: (int index) {
        if (index == selectedIndex) {
          ref.read(hideSidePanelProvider.notifier).state =
              !ref.read(hideSidePanelProvider);
        } else {
          selectedIndex = index;
          ref.read(hideSidePanelProvider.notifier).state = false;
          ref.read(selectedIndexProvider.notifier).state = index;
        }
      },
    );
  }
}
