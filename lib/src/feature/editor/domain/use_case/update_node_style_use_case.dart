import 'package:dial_editor/src/feature/editor/domain/model/markdown_element.dart';
import 'package:flutter/material.dart';

class UpdateNodeStyleUseCase {
  UpdateNodeStyleUseCase();

  void update(Inline node, TextStyle newStyle) {
    node.style = newStyle;
  }
}
