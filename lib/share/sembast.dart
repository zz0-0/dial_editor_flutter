import 'package:tekartik_app_flutter_sembast/sembast.dart';

class Sembast {
  static DatabaseFactory factory = getDatabaseFactory();
  static StoreRef<String, String> store = StoreRef<String, String>.main();

  static Future<Database> openDatabase(String databaseName) async {
    return factory.openDatabase('{$databaseName}.db');
  }
}
