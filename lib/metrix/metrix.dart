import 'package:metrix_plugin/Metrix.dart';
import 'package:metrix_plugin/MetrixAttribution.dart';

class FreeSmsMetrix {
  static String sessionNumber = "";
  static String sessionId = "";
  static String userId = "";
  static MetrixAttribution? attribution;

  static init() {
    Metrix.addUserAttributes({"name": "hisName"});

    Metrix.getAttributionData().listen((value) {
      attribution = value;
    });

    Metrix.getUserId().listen((value) {
      userId = value;
    });

    Metrix.getSessionNumber().listen((sessionNum) {
      sessionNumber = sessionNum.toString();
    });

    Metrix.getSessionId().listen((id) {
      sessionId = id;
    });
  }

  // final Metrix metrix;
  //
  // FreeSmsMetrix(this.metrix);

  // lib/pages/select_language_page.dart
  static selectLanguage(String locale) async {
    Metrix.newEvent('gqlnu', {'locale': locale});
  }

  //lib/presentation/pages/on_boarding/on_boarding.dart
  static intro({required bool skipped, required bool compeleted}) async {
    Metrix.newEvent(
        'nvcsy', {'skipped': '$skipped', 'compeleted': "$compeleted"});
  }

  //lib/presentation/pages/login/login_page.dart
  static readPrivacyPolicy() async {
    Metrix.newEvent('zurjs');
  }

  //lib/presentation/pages/login/login_page.dart
  static readTerm() async {
    Metrix.newEvent('zclmo');
  }

  //lib/presentation/pages/login/login_page.dart
  static countryCode(String code) async {
    Metrix.newEvent('tzkbi', {'country_code': code});
  }

  //lib/presentation/pages/login/login_page.dart
  static resendOTPCode({
    required String phoneNumber,
  }) async {
    final now = DateTime.now();
    final date = '${now.year}/${now.month}/${now.day}';
    final time = '${now.hour}:${now.minute}';

    Metrix.newEvent('wbfoi', {
      "date": date,
      "time": time,
      "phone_number": phoneNumber,
    });
  }

  //lib/presentation/pages/login/referral_screen.dart
  static invited(String referralCode, bool skipped, String userId) async {
    final now = DateTime.now();
    final date = '${now.year}/${now.month}/${now.day}';
    final time = '${now.hour}:${now.minute}';
    Metrix.newEvent('gxlzz', {
      "date": date,
      "time": time,
      'referral_code': referralCode,
      'skipped': '$skipped',
      'user_id': userId,
    });
  }

  //lib/pages/setting.dart
  static settingChangeLanguage({
    required String phoneNumber,
    required String locale,
  }) async {
    final now = DateTime.now();
    final date = '${now.year}/${now.month}/${now.day}';
    final time = '${now.hour}:${now.minute}';
    Metrix.newEvent('rtyov',
        {'locale': locale, "date": date, "time": time, "user_id": phoneNumber});
  }

  static checkWallet({
    required String phoneNumber,
  }) async {
    final now = DateTime.now();
    final date = '${now.year}/${now.month}/${now.day}';
    final time = '${now.hour}:${now.minute}';
    Metrix.newEvent(
        'dupoj', {"date": date, "time": time, "user_id": phoneNumber});
  }

  static checkCashOut({
    required String phoneNumber,
    required String balance,
  }) async {
    final now = DateTime.now();
    final date = '${now.year}/${now.month}/${now.day}';
    final time = '${now.hour}:${now.minute}';
    Metrix.newEvent('nqdsm', {
      "date": date,
      "time": time,
      "user_id": phoneNumber,
      'wallet_balance': balance
    });
  }

  static cashOutRequest({
    required String phoneNumber,
    required String balance,
    required withdrawalAmount,
  }) async {
    final now = DateTime.now();
    final date = '${now.year}/${now.month}/${now.day}';
    final time = '${now.hour}:${now.minute}';
    Metrix.newEvent('oqsqo', {
      "date": date,
      "time": time,
      "user_id": phoneNumber,
      'wallet_balance': balance,
      'withdrawal_amount': withdrawalAmount,
    });
  }

  static rewardChangeStatus({
    required String phoneNumber,
    required String rewardStatus,
  }) async {
    final now = DateTime.now();
    final date = '${now.year}/${now.month}/${now.day}';
    final time = '${now.hour}:${now.minute}';
    Metrix.newEvent('zgxbp', {
      "date": date,
      "time": time,
      "user_id": phoneNumber,
      'reward_status': rewardStatus
    });
  }

  static rewardedMessageCount({
    required String phoneNumber,
    required String adsID,
    required String receiverNumber,
    required String textMessage,
  }) async {
    final now = DateTime.now();
    final date = '${now.year}/${now.month}/${now.day}';
    final time = '${now.hour}:${now.minute}';
    Metrix.newEvent('vqfro', {
      "date": date,
      "time": time,
      "user_id": phoneNumber,
      'ads_id': adsID,
      'receiver_number': receiverNumber,
      'text_msg': textMessage,
    });
  }

  static unRewardedMessageCount({
    required String phoneNumber,
    required String receiverNumber,
    required String textMessage,
  }) async {
    final now = DateTime.now();
    final date = '${now.year}/${now.month}/${now.day}';
    final time = '${now.hour}:${now.minute}';
    Metrix.newEvent('crivp', {
      "date": date,
      "time": time,
      "user_id": phoneNumber,
      'receiver_number': receiverNumber,
      'text_msg': textMessage,
    });
  }
}