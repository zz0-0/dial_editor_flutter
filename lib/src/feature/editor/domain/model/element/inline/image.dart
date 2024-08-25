/// library for markdown element
library node;

import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

base class ImageNode extends Inline {
  ImageNode({
    required super.rawText,
    required super.key,
  }) {
    type = MarkdownElement.image.type;
  }

  @override
  RenderInstruction render() {
    return TextRenderInstruction(rawText, MarkdownElement.image);
  }

  factory ImageNode.fromMap(Map<String, dynamic> map) {
    return ImageNode(
      key: map['key'] as GlobalKey<EditableTextState>,
      rawText: map['rawText'] as String,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'type': type,
    };
  }
}
