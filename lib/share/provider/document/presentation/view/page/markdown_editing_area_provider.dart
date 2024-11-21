import 'package:dial_editor_flutter/feature/document/presentation/view/markdown_editing/page/markdown_editing_area.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final markdownEditingAreaProvider = Provider<MarkdownEditingArea>((ref) {
  return const MarkdownEditingArea();
});
