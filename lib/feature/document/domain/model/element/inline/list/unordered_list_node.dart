import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:flutter/material.dart';

base class UnorderedListNode extends Inline {
  UnorderedListNode({
    required super.key,
    required super.text,
  });

  @override
  Inline createNewLine() {
    return UnorderedListNode(key: GlobalKey(), text: '');
  }

  @override
  TaskListNode copyWith({
    TextStyle? textStyle,
    double? lineHeight,
    bool? isEditing,
    bool? isExpanded,
    bool? isBlockStart,
    int? level,
  }) {
    final inline = TaskListNode(
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
