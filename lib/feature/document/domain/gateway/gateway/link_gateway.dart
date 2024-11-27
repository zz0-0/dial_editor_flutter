import 'package:dial_editor_flutter/feature/document/domain/model/link.dart';

abstract class LinkGateway {
  Future<void> deleteAllLinks();
  Future<void> deleteLink(String id);
  Future<Link> getLink(String id);
  Future<List<Link>> getLinks();
  Future<void> saveLink(Link link);
  Future<void> updateLink(Link link);
}
