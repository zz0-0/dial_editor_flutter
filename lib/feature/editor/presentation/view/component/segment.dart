import 'package:dial_editor_flutter/share/provider/editor/presentation/view/component/segement_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Segment extends ConsumerStatefulWidget {
  const Segment({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SegmentState();
}

class _SegmentState extends ConsumerState<Segment> {
  DisplayType displayType = DisplayType.file;
  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      segments: <ButtonSegment<DisplayType>>[
        ButtonSegment<DisplayType>(
          value: DisplayType.file,
          label: Text(DisplayType.file.label),
          icon: DisplayType.file.icon,
        ),
        ButtonSegment<DisplayType>(
          value: DisplayType.canvas,
          label: Text(DisplayType.canvas.label),
          icon: DisplayType.canvas.icon,
        ),
      ],
      selected: {displayType},
    );
  }
}
