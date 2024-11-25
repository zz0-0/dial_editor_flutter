import 'package:dial_editor_flutter/share/uuid.dart';

class LinkStore {
  final Map<String, Link> _links = {};
  final Map<String, Set<String>> _sourceToLinkIds = {};
  final Map<String, Set<String>> _targetToLinkIds = {};

  void createLink(String sourceId, String targetId) {
    final link = Link(sourceId: sourceId, targetId: targetId);
    _links[link.id] = link;
    _sourceToLinkIds.putIfAbsent(sourceId, () => {}).add(link.id);
    _targetToLinkIds.putIfAbsent(targetId, () => {}).add(link.id);
  }

  void removeLink(String linkId) {
    final link = _links.remove(linkId);
    if (link != null) {
      _sourceToLinkIds[link.sourceId]?.remove(linkId);
      _targetToLinkIds[link.targetId]?.remove(linkId);
    }
  }

  Set<Link?> getIncomingLinks(String id) {
    return _targetToLinkIds[id]?.map((linkId) => _links[linkId]).toSet() ?? {};
  }

  Set<Link?> getOutgoingLinks(String id) {
    return _sourceToLinkIds[id]?.map((linkId) => _links[linkId]).toSet() ?? {};
  }
}

class Link {
  Link({
    required this.sourceId,
    required this.targetId,
    this.type = LinkType.reference,
  }) {
    id = uuid.v4();
    createdAt = DateTime.now();
    updatedAt = DateTime.now();
  }

  late String id;
  final String sourceId;
  final String targetId;
  final LinkType type;
  late DateTime createdAt;
  late DateTime updatedAt;
}

enum LinkType {
  reference,
  citation,
  belong;
}
