import 'package:dial_editor_flutter/feature/document/domain/model/element.dart';
import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:dial_editor_flutter/share/uuid.dart';
import 'package:flutter/material.dart';

base class CodeBlockMarker extends Inline {
  CodeBlockMarker({
    required super.id,
    required super.text,
    required super.renderText,
    required this.isCodeBlockStartMarker,
  });

  bool isCodeBlockStartMarker;

  @override
  Inline createNewLine() {
    final elementId = ElementId(uuid.v4(), ElementType.inline);
    if (isBlockStart) {
      return CodeLine(id: elementId, text: '', renderText: '');
    }
    return TextNode(id: elementId, text: '', renderText: '');
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
      id: id,
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
