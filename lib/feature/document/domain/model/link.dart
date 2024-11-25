import 'package:dial_editor_flutter/feature/document/domain/model/element.dart';

class Link {
  Link(
    this.id,
    this.source,
    this.target,
    this.type,
    this.createdAt,
    this.updatedAt,
  );

  final String id;
  final ElementId source;
  final ElementId target;
  final LinkType type;
  final DateTime createdAt;
  final DateTime updatedAt;
}

enum LinkType {
  reference,
  citation,
  belong;
}
