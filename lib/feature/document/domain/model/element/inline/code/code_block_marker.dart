import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:flutter/material.dart';

base class CodeBlockMarker extends Inline {
  CodeBlockMarker({
    required super.key,
    required super.text,
    required super.renderText,
    required this.isCodeBlockStartMarker,
  });

  bool isCodeBlockStartMarker;

  @override
  Inline createNewLine() {
    if (isBlockStart) {
      return CodeLine(key: GlobalKey(), text: '', renderText: '');
    }
    return TextNode(key: GlobalKey(), text: '', renderText: '');
  }

  @override
  CodeBlockMarker copyWith({
    TextStyle? textStyle,
    double? lineHeight,
    bool? isEditing,
    bool? isExpanded,
    bool? isBlockStart,
    int? level,
    int? baseOffset,
    int? extentOffset,
    String? text,
    String? renderText,
  }) {
    final inline = CodeBlockMarker(
      key: key,
      text: text ?? this.text,
      renderText: renderText ?? this.renderText,
      isCodeBlockStartMarker: isCodeBlockStartMarker,
    )
      ..textStyle = textStyle ?? this.textStyle
      ..lineHeight = lineHeight ?? this.lineHeight
      ..isEditing = isEditing ?? this.isEditing
      ..isExpanded = isExpanded ?? this.isExpanded
      ..isBlockStart = isBlockStart ?? this.isBlockStart
      ..level = level ?? this.level;

    if (baseOffset != null || extentOffset != null) {
      inline.textController.selection = TextSelection(
        baseOffset: baseOffset ?? textController.selection.baseOffset,
        extentOffset: extentOffset ?? textController.selection.extentOffset,
      );
    }
    replaceInline(this, inline);
    return inline;
  }
}
