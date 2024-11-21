import 'dart:io';

import 'package:dial_editor_flutter/feature/editor/presentation/view/component/bottom_nav.dart';
import 'package:dial_editor_flutter/feature/editor/presentation/view/component/side_nav.dart';
import 'package:dial_editor_flutter/feature/editor/presentation/view/component/side_panel.dart';
import 'package:dial_editor_flutter/feature/editor/presentation/view/component/status_bar.dart';
import 'package:dial_editor_flutter/feature/editor/presentation/view/component/top_bar.dart';
import 'package:dial_editor_flutter/share/provider/editor/presentation/view/component/side_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdaptiveNavigation extends ConsumerWidget {
  const AdaptiveNavigation({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMoible = Platform.isIOS || Platform.isAndroid;
    final hideSidePanel = ref.watch(hideSidePanelProvider);
    return isMoible
        ? Scaffold(
            body: child,
            bottomNavigationBar: const BottomNav(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(),
              const Divider(thickness: 1, height: 1),
              Expanded(
                child: Row(
                  children: [
                    const SideNav(),
                    const VerticalDivider(thickness: 1, width: 1),
                    if (hideSidePanel == false) const SidePanel(),
                    if (hideSidePanel == false)
                      const VerticalDivider(thickness: 1, width: 1),
                    Expanded(child: child),
                  ],
                ),
              ),
              const Divider(thickness: 1, height: 1),
              const StatusBar(),
            ],
          );
  }
}
