import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LineNumber extends ConsumerWidget {
  const LineNumber({
    required this.index,
    required this.inline,
    super.key,
  });

  final int index;
  final Inline inline;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 30,
      height: inline.lineHeight,
      child: Center(
        child: Text(
          '${index + 1}',
        ),
      ),
    );
  }
}
