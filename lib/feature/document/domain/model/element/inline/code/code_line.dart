import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:flutter/material.dart';

base class CodeLine extends Inline {
  CodeLine({
    required super.key,
    required super.text,
  });

  @override
  Inline createNewLine() {
    return CodeLine(key: GlobalKey(), text: '');
  }

  @override
  CodeLine copyWith({
    TextStyle? textStyle,
    double? lineHeight,
    bool? isEditing,
    bool? isExpanded,
    bool? isBlockStart,
    int? level,
  }) {
    final inline = CodeLine(
      key: key,
      text: text,
    )
      ..textStyle = textStyle ?? this.textStyle
      ..lineHeight = lineHeight ?? this.lineHeight
      ..isEditing = isEditing ?? this.isEditing
      ..isExpanded = isExpanded ?? this.isExpanded
      ..isBlockStart = isBlockStart ?? this.isBlockStart
      ..level = level ?? this.level;
    replaceInline(this, inline);
    return inline;
  }
}
