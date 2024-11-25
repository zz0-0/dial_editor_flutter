import 'package:dial_editor_flutter/share/markdown_element.dart';

class ElementId {
  ElementId(this.id, this.type);

  final String id;
  final ElementType type;
}

enum ElementType {
  document(Document),
  block(Block),
  inline(Inline);

  const ElementType(this.type);

  final Type type;
}
