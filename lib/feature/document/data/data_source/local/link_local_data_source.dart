import 'package:dial_editor_flutter/feature/document/domain/model/link.dart';
import 'package:dial_editor_flutter/share/sembast.dart';
import 'package:tekartik_app_flutter_sembast/sembast.dart';

abstract class LinkLocalDataSource {
  Future<void> deleteAllLinks();
  Future<void> deleteLink(String id);
  Future<Link> getLink(String id);
  Future<List<Link>> getLinks();
  Future<void> saveLink(Link link);
  Future<void> updateLink(Link link);
}

class LinkLocalDataSourceImpl implements LinkLocalDataSource {
  LinkLocalDataSourceImpl() {
    dbFuture = Sembast.openDatabase('link');
  }
  StoreRef store = intMapStoreFactory.store('link');
  late Future<Database> dbFuture;

  @override
  Future<void> deleteAllLinks() async {
    final db = await dbFuture;
    await store.drop(db);
  }

  @override
  Future<void> deleteLink(String id) async {
    final db = await dbFuture;
    await store.delete(db, finder: Finder(filter: Filter.byKey(id)));
  }

  @override
  Future<Link> getLink(String id) async {
    final db = await dbFuture;
    return store.record(id).get(db) as Future<Link>;
  }

  @override
  Future<List<Link>> getLinks() async {
    final db = await dbFuture;
    return Sembast.store.record('link').get(db) as Future<List<Link>>;
  }

  @override
  Future<void> saveLink(Link link) async {
    final db = await dbFuture;
    await store.record(link.id).put(db, link.toJson());
  }

  @override
  Future<void> updateLink(Link link) async {
    final db = await dbFuture;
    await store.update(db, link, finder: Finder(filter: Filter.byKey(link.id)));
  }
}
