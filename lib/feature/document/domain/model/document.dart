import 'dart:collection';

import 'package:dial_editor_flutter/feature/document/domain/model/element.dart';
import 'package:dial_editor_flutter/feature/document/domain/model/element/inline.dart';

class Document {
  Document({required this.id, required this.inlines});

  final ElementId id;
  LinkedList<Inline> inlines;
}
