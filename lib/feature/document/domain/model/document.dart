import 'dart:collection';

import 'package:dial_editor_flutter/feature/document/domain/model/element/inline.dart';

// import 'package:dial_editor_flutter/feature/document/domain/model/node_map.dart';

class Document {
  Document({required this.inlines}) {
    // _nodeMap = NodeMap(nodes);
  }

  LinkedList<Inline> inlines;
  // late NodeMap _nodeMap;
}
