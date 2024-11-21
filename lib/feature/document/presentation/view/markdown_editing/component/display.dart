import 'package:dial_editor_flutter/feature/document/presentation/state_manager/render_util_notifier.dart';
import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:dial_editor_flutter/share/provider/document/presentation/state_manager/inline_notifier_provider.dart';
import 'package:dial_editor_flutter/share/provider/document/presentation/state_manager/render_utility_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Display extends ConsumerStatefulWidget {
  const Display({required this.inline, super.key});

  final Inline inline;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DisplayState();
}

class _DisplayState extends ConsumerState<Display> {
  late RenderUtilNotifier renderUtil;
  late Widget displayWidget;

  @override
  void initState() {
    super.initState();
    renderUtil = ref.read(renderUtilProvider.notifier);
    displayWidget = renderUtil.render(context, widget.inline);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.inline.lineHeight,
      child: GestureDetector(
        onTap: () {
          ref
              .read(inlineProvider(widget.inline.key).notifier)
              .updateToEditngMode();
        },
        child: displayWidget,
      ),
    );
  }
}
