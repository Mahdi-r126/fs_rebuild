import 'package:flutter/foundation.dart';

import '../models/ad.dart';

class PinProvider extends ChangeNotifier {
  bool _pinned = false;
  Ad? _ad;

  bool get pinned => _pinned;
  Ad? get ad => _ad;

  void setAd(Ad ad) {
    _ad = ad;
    notifyListeners();
  }

  void setPinned(bool value, Ad? ad) {
    _pinned = value;
    _ad = ad;
    notifyListeners();
  }

  void setAdd( Ad? ad) {
    _ad = ad;
    notifyListeners();
  }

  void closePin() {
    _pinned = true;
    notifyListeners();
  }
}
