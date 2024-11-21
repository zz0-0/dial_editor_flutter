import 'package:dial_editor_flutter/share/provider/editor/presentation/view/component/side_panel_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidePanel extends ConsumerWidget {
  const SidePanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(width: 200, child: ref.watch(sidePanelWidgetProvider));
  }
}
