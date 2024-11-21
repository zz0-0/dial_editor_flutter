import 'package:dial_editor_flutter/feature/document/domain/model/element/inline.dart';
import 'package:flutter/material.dart';

base class Emoji extends Inline {
  Emoji({
    required super.key,
    required super.text,
  });

  @override
  Emoji copyWith({
    TextStyle? textStyle,
    double? lineHeight,
    bool? isEditing,
    bool? isExpanded,
    bool? isBlockStart,
    int? level,
    int? baseOffset,
    int? extentOffset,
  }) {
    final inline = Emoji(
      key: key,
      text: text,
    )
      ..textStyle = textStyle ?? this.textStyle
      ..lineHeight = lineHeight ?? this.lineHeight
      ..isEditing = isEditing ?? this.isEditing
      ..isExpanded = isExpanded ?? this.isExpanded
      ..isBlockStart = isBlockStart ?? this.isBlockStart
      ..level = level ?? this.level;
    inline.textController.text = textController.text;
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
