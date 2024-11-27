import 'package:dial_editor_flutter/feature/document/data/data_source/local/link_local_data_source.dart';
import 'package:dial_editor_flutter/feature/document/domain/gateway/gateway/link_gateway.dart';
import 'package:dial_editor_flutter/feature/document/domain/model/link.dart';

class LinkGatewayImpl implements LinkGateway {
  LinkGatewayImpl(this._linkLocalDataSource);

  final LinkLocalDataSource _linkLocalDataSource;

  @override
  Future<void> deleteAllLinks() {
    return _linkLocalDataSource.deleteAllLinks();
  }

  @override
  Future<void> deleteLink(String id) {
    return _linkLocalDataSource.deleteLink(id);
  }

  @override
  Future<Link> getLink(String id) {
    return _linkLocalDataSource.getLink(id);
  }

  @override
  Future<List<Link>> getLinks() {
    return _linkLocalDataSource.getLinks();
  }

  @override
  Future<void> saveLink(Link link) {
    return _linkLocalDataSource.saveLink(link);
  }

  @override
  Future<void> updateLink(Link link) {
    return _linkLocalDataSource.updateLink(link);
  }
}
