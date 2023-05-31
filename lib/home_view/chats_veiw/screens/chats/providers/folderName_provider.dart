import 'package:flutter/material.dart';

class FolderNameProvider extends ChangeNotifier {
  String _folderNamevalue = '';

  String get getFolderName => _folderNamevalue;

  set setFolderName(String newValue) {
    _folderNamevalue = newValue;
    notifyListeners();
  }
}