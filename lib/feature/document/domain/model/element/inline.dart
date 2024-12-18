import 'dart:collection';

import 'package:dial_editor_flutter/feature/document/domain/model/element.dart';
import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:dial_editor_flutter/share/uuid.dart';
import 'package:flutter/material.dart';

abstract base class Inline extends LinkedListEntry<Inline> {
  Inline({required this.id, required this.text, required this.renderText}) {
    textController.text = renderText;
  }

  ElementId id;
  String text;
  String renderText;
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();
  TextStyle textStyle = const TextStyle();
  double? lineHeight;
  bool _isEditing = false;
  bool isExpanded = true;
  bool isBlockStart = false;
  int level = 0;

  bool get isEditing => _isEditing;

  set isEditing(bool value) {
    _isEditing = value;
    if (_isEditing) {
      textController.text = text;
      focusNode.requestFocus();
    } else {
      textController.text = renderText;
      focusNode.unfocus();
    }
  }

  Inline createNewLine() {
    final elementId = ElementId(uuid.v4(), ElementType.inline);
    return TextNode(id: elementId, text: '', renderText: '');
  }

  void replaceInline(Inline oldInline, Inline newInline) {
    oldInline
      ..insertAfter(newInline)
      ..unlink();
  }

  Inline copyWith({
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
  });
}
