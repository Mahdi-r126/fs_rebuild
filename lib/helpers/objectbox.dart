import 'package:path/path.dart' as p;
import '../objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._creat(this.store);

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox?> create() async {
    final store = await openStore(directory: p.join('/data/user/0/com.textallin.smsonlines/files/', "obx-db"));
    if(store.isClosed()) {
      return ObjectBox._creat(store);
    }
  }
}