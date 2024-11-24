import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:flutter/material.dart';

base class BoldItalic extends Inline {
  BoldItalic({
    required super.key,
    required super.text,
    required super.renderText,
  });

  @override
  BoldItalic copyWith({
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
    final inline = BoldItalic(
      key: key,
      text: text ?? this.text,
      renderText: renderText ?? this.renderText,
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
