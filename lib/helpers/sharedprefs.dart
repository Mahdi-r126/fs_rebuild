import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get_storage/get_storage.dart';

class SharedPrefs {

  static final box = GetStorage();

  // first launch check
  static void setFirstLaunch(bool firstLaunch) {
    box.write('firstLaunch', firstLaunch);
  }

  static bool isFirstLaunch() {
    if (box.read('firstLaunch') == null) {
      return true;
    } else {
      return box.read('firstLaunch');
    }
  }

  static void setReward(bool reward) {
    box.write('reward', reward);
  }

  static bool getReward() {
    if (box.read('reward') == null) {
      return false;
    } else {
      return box.read('reward');
    }
  }

  static void setAllMessage(List<SmsMessage> messages) {
    box.write('allMessages', messages);
  }

  static List<SmsMessage>? getAllMessages() {
    if (box.read('allMessages') == null) {
      return null;
    } else {
      return box.read('allMessages');
    }
  }

  static void setLastMessages(Map<String, SmsMessage> messages) {
    box.write('lastMessages', messages);
  }

  static Map<String, SmsMessage>? getLastMessages() {
    if (box.read('lastMessages') == null) {
      return null;
    } else {
      return box.read('lastMessages');
    }
  }



  static void setAdmin(bool admin){
    box.write('admin', admin);
  }
  static bool getAdmin() {
    if (box.read('admin') == null) {
      return false;
    } else {
      return box.read('admin');
    }
  }

  static void setSeenVersion(String version){
    box.write('version', version);
  }

  static String getSeenVersion() {
    if (box.read('version') == null) {
      return "";
    } else {
      return box.read('version');
    }
  }

  static void setWallet(int wallet){
    box.write('wallet', wallet);
  }

  static int getWallet() {
    if (box.read('wallet') == null) {
      return -1;
    } else {
      return box.read('wallet');
    }
  }

  static void setTotalMessage(int totalMessage){
    box.write('totalMessage', totalMessage);
  }

  static int getTotalMessage() {
    if (box.read('totalMessage') == null) {
      return -1;
    } else {
      return box.read('totalMessage');
    }
  }

  // login done Check
  static void setLoginDone(bool isLoginDone) {
    box.write('isLoginDone', isLoginDone);
  }

  static bool isLoginDone() {
    if (box.read('isLoginDone') == null) {
      return false;
    } else {
      return box.read('isLoginDone');
    }
  }

  // first db injection
  static void setFirstDBInjection(bool firstDBInjection) {
    box.write('firstDBInjection', firstDBInjection);
  }

  static bool isFirstDBInjection() {
    if (box.read('firstDBInjection') == null) {
      return true;
    } else {
      return box.read('firstDBInjection');
    }
  }

  // tokens
  static void setAccessToken(String accessToken) {
     box.write('accessToken', accessToken);
  }

  static String getAccessToken() {
    if (box.read('accessToken') == null) {
      return '';
    } else {
      return box.read('accessToken');
    }
  }

  static void setCheckLts(bool check){
    box.write('check', check);
  }

  static bool getCheckLts(){
    if (box.read('check') == null) {
      return false;
    } else {
      return box.read('check');
    }
  }


  static void setOrganizationAccessToken(String organizationAccessToken) {
    box.write('organizationAccessToken', organizationAccessToken);
  }

  static String getOrganizationAccessToken() {
    if (box.read('organizationAccessToken') == null) {
      return '';
    } else {
      return box.read('organizationAccessToken');
    }
  }

  static void setAdminAccessToken(String adminAccessToken) {
    box.write('adminAccessToken', adminAccessToken);
  }

  static String getAdminAccessToken() {
    if (box.read('adminAccessToken') == null) {
      return '';
    } else {
      return box.read('adminAccessToken');
    }
  }

  static void setRefreshToken(String refreshToken) {
    box.write('refreshToken', refreshToken);
  }

  static String getRefreshToken() {
    if (box.read('refreshToken') == null) {
      return '';
    } else {
      return box.read('refreshToken');
    }
  }

  static void setOrganizationRefreshToken(String organizationRefreshToken) {
    box.write('organizationRefreshToken', organizationRefreshToken);
  }

  static String getOrganizationRefreshToken() {
    if (box.read('organizationRefreshToken') == null) {
      return '';
    } else {
      return box.read('organizationRefreshToken');
    }
  }

  static void setAdminRefreshToken(String adminRefreshToken) {
    box.write('adminRefreshToken', adminRefreshToken);
  }

  static String getAdminRefreshToken() {
    if (box.read('adminRefreshToken') == null) {
      return '';
    } else {
      return box.read('adminRefreshToken');
    }
  }

  static void setPhoneNumber(String phoneNumber) {
    box.write('phoneNumber', phoneNumber);
  }

  static String getPhoneNumber() {
    if (box.read('phoneNumber') == null) {
      return '';
    } else {
      return box.read('phoneNumber');
    }
  }

  static void setLocal(String local) {
    box.write('local', local);
  }

  static String getLocal() {
    if (box.read('local') == null) {
      return "en_GB";
    } else {
      return box.read('local');
    }
  }

}