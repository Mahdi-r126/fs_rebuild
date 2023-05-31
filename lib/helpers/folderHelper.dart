import 'package:freesms/models/folders.dart';

import '../apis/apis.dart';

class FolderHelper {
  static List<Folders> _folders = [];

  static Future<void> init() async {
    await _resetAllInbox();
  }

  static Future<void> _resetAllInbox() async {
    Apis apis = Apis();
    try {
      final data = await apis.getAllFolders();
      _folders = data;
    } catch (e) {
      print(e);
    }
  }

  static getAll() {
    return _folders;
  }
}
