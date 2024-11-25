import 'package:dial_editor_flutter/feature/document/domain/model/element.dart';

abstract base class Block {
  Block({required this.id, required this.level});

  ElementId id;
  int level;
  bool isExpanded = true;
}
