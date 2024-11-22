import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:flutter/material.dart';

base class CodeBlockMarker extends Inline {
  CodeBlockMarker({
    required super.key,
    required super.text,
    required this.isCodeBlockStartMarker,
  });

  bool isCodeBlockStartMarker;

  @override
  Inline createNewLine() {
    if (isBlockStart) {
      return CodeLine(key: GlobalKey(), text: '');
    }
    return TextNode(key: GlobalKey(), text: '');
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
  }) {
    final inline = CodeBlockMarker(
      key: key,
      text: text ?? this.text,
      isCodeBlockStartMarker: isCodeBlockStartMarker,
    )
      ..textStyle = textStyle ?? this.textStyle
      ..lineHeight = lineHeight ?? this.lineHeight
      ..isEditing = isEditing ?? this.isEditing
      ..isExpanded = isExpanded ?? this.isExpanded
      ..isBlockStart = isBlockStart ?? this.isBlockStart
      ..level = level ?? this.level;
    inline.textController.text = text ?? this.text;
    if (baseOffset != null || extentOffset != null) {
      inline.textController.selection = TextSelection(
        baseOffset: baseOffset ?? textController.selection.baseOffset,
        extentOffset: extentOffset ?? textController.selection.extentOffset,
      );
    } else {
      inline.textController.selection = textController.selection;
    }
    replaceInline(this, inline);
    return inline;
  }
}
