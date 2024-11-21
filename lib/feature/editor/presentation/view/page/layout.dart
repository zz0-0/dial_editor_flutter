import 'package:dial_editor_flutter/feature/editor/presentation/view/page/adaptive_navigation.dart';
import 'package:dial_editor_flutter/feature/editor/presentation/view/page/main_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Layout extends ConsumerWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AdaptiveNavigation(child: MainArea());
  }
}
