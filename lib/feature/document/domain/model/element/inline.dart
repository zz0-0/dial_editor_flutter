import 'dart:collection';

import 'package:dial_editor_flutter/share/markdown_element.dart';
import 'package:flutter/material.dart';

abstract base class Inline extends LinkedListEntry<Inline> {
  Inline({required this.key, required this.text}) {
    renderText = text;
    textController.text = text;
  }

  GlobalKey key;
  String text;
  String renderText = '';
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();
  TextStyle textStyle = const TextStyle();
  double? lineHeight;
  bool isEditing = false;
  bool isExpanded = true;
  bool isBlockStart = false;
  int level = 0;

  Inline createNewLine() {
    return TextNode(key: GlobalKey(), text: '');
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
  });
}
