import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:freesms/helpers/contactHelper.dart';
import 'package:freesms/helpers/models/inbox_model.dart';

class SmsHelper {
  static Map<String, InboxModel> _loadedSmsMessage = {};

  static Map<String, InboxModel> get messages => _loadedSmsMessage;

  static final List<Function> _allTrigers = [];

  static bool _initCalledOnce = false;

  static const int _minInboxInPage = 10;
  static const int _firstFetchCount = 1000;
  static const int _nextFetchCount = 20000;
  static const int _delayForEachCall = 5000;
  static int _loadedMessagesTillNow = 0;

  static bool _isFirstFetch = false;
  static bool _isOnCompleteingFetches = false;

  static SmsQuery? smsQuery;

  static SmsMessage? _lastSMS;

  /// Call this function when you are ready to load all massegaes
  static Future<void> init() async {
    if (_initCalledOnce) {
      return;
    }
    smsQuery = SmsQuery();
    _initCalledOnce = true;
    await _resetAllInbox();

    // telephony.listenIncomingSms(
    //         onNewMessage: (T.SmsMessage message) {
    //          updateInbox();
    //         },
    //         listenInBackground: true,
    //       );
  }

  static addToMessages(String phoneNumber, SmsMessage message) {
    _loadedSmsMessage[phoneNumber]?.messages.add(message);
    _loadedSmsMessage[phoneNumber]?.body = message.body;
  }


  //
  // static addToMessages(String phoneNumber,SmsMessage message){
  //   _loadedSmsMessage[phoneNumber]?.messages.add(message);
  // }

  static Future<void> updateInbox() async {
    final List<SmsMessage> smses = await smsQuery!.querySms(
      kinds: [
        SmsQueryKind.sent,
        SmsQueryKind.inbox,
        SmsQueryKind.draft
      ], //Sepehr
      // address: null,
      count: 100,
      start: 0,
      sort: true,
    );
    await _onNewMessageFetched(smses);
  }

  static _onNewMessageFetched(List<SmsMessage> smses) {
    Map<String, InboxModel> newMessages = {};
    for (SmsMessage sms in smses) {
      if (_lastSMS!.id! >= sms.id!) {
        break;
      }
      String clearedAddress = ContactHelper.clearNumber(sms.address!);
      if (newMessages[clearedAddress] == null) {
        newMessages[clearedAddress] = InboxModel();
        newMessages[clearedAddress]!.address = sms.address;
        newMessages[clearedAddress]!.body = sms.body;
        newMessages[clearedAddress]!.dateSent = sms.dateSent;
        newMessages[clearedAddress]!.id = sms.id;
        newMessages[clearedAddress]!.read = sms.read;
        newMessages[clearedAddress]!.date = sms.date;
        newMessages[clearedAddress]!.isRead = sms.isRead;
      }
      newMessages[clearedAddress]!.messages.add(sms);
    }
    for (int i = 0; i < newMessages.keys.length; i++) {
      String currentKey = newMessages.keys.toList()[i];
      if (_loadedSmsMessage.containsKey(currentKey)) {
        newMessages[currentKey]!
            .messages
            .addAll(_loadedSmsMessage[currentKey]!.messages);
        _loadedSmsMessage.remove(currentKey);
      }
    }
    _loadedSmsMessage = Map<String, InboxModel>.from(newMessages)
      ..addAll(_loadedSmsMessage);
    if (newMessages.keys.isNotEmpty) {
      _callTriggers();
    }
  }

  static Future<void> _resetAllInbox() async {
    _isFirstFetch = true;
    _isOnCompleteingFetches = false;
    _loadedMessagesTillNow = 0;
    final smsList = await smsQuery!.querySms(
      kinds: [
        SmsQueryKind.sent,
        SmsQueryKind.inbox,
        SmsQueryKind.draft
      ], //Sepehr
      // address: null,
      count: _firstFetchCount,
      start: 0,
      sort: true,
    );
    await _onMessagesFetched(smsList);
    _loadedMessagesTillNow += _firstFetchCount;
  }

  static Future<void> _onMessagesFetched(List<SmsMessage> value) async {
    print(DateTime.now().millisecondsSinceEpoch.toString() +
        " Start Next Fetch " +
        _loadedMessagesTillNow.toString());
    if (_isFirstFetch) {
      _loadedSmsMessage = {};
      _lastSMS = value[0];
    }
    _isFirstFetch = false;
    for (SmsMessage sms in value) {
      String clearedAddress = ContactHelper.clearNumber(sms.address??'');
      if (_loadedSmsMessage[clearedAddress] == null) {
        _loadedSmsMessage[clearedAddress] = InboxModel();
        _loadedSmsMessage[clearedAddress]!.address = sms.address;
        _loadedSmsMessage[clearedAddress]!.body = sms.body;
        _loadedSmsMessage[clearedAddress]!.dateSent = sms.dateSent;
        _loadedSmsMessage[clearedAddress]!.id = sms.id;
        _loadedSmsMessage[clearedAddress]!.read = sms.read;
        _loadedSmsMessage[clearedAddress]!.date = sms.date;
        _loadedSmsMessage[clearedAddress]!.isRead = sms.isRead;
      }
      _loadedSmsMessage[clearedAddress]!.messages.add(sms);
    }
    print(DateTime.now().millisecondsSinceEpoch.toString() +
        "Calculate done " +
        _loadedSmsMessage.keys.length.toString());

    if (_isOnCompleteingFetches && value.length < _nextFetchCount) {
      _isOnCompleteingFetches = false;
      _callTriggers();
    } else {
      await _continueFetch();
      // Future.delayed(Duration(milliseconds: _delayForEachCall), _continueFetch);
    }
  }

  static Future<void> _continueFetch() async {
    if (_isOnCompleteingFetches == false &&
        _loadedSmsMessage.keys.length > _minInboxInPage) {
      _callTriggers();
      _isOnCompleteingFetches = true;
      final data = await smsQuery!.querySms(
        kinds: [
          SmsQueryKind.sent,
          SmsQueryKind.inbox,
          SmsQueryKind.draft
        ], //Sepehr
        // address: null,
        count: _nextFetchCount,
        start: _loadedMessagesTillNow,
        sort: true,
      );
      await _onMessagesFetched(data);
      _loadedMessagesTillNow += _nextFetchCount;
    } else if (_isOnCompleteingFetches == false) {
      final data = await smsQuery!.querySms(
        kinds: [
          SmsQueryKind.sent,
          SmsQueryKind.inbox,
          SmsQueryKind.draft
        ], //Sepehr
        // address: null,
        count: _firstFetchCount,
        start: _loadedMessagesTillNow,
        sort: true,
      );
      await _onMessagesFetched(data);
      _loadedMessagesTillNow += _firstFetchCount;
    } else if (_isOnCompleteingFetches || true) {
      final data = await smsQuery!.querySms(
        kinds: [SmsQueryKind.sent, SmsQueryKind.inbox, SmsQueryKind.draft],
        //Sepehr
        // address: null,
        count: _nextFetchCount,
        start: _loadedMessagesTillNow,
        sort: true,
      );
      await _onMessagesFetched(data);
      _loadedMessagesTillNow += _nextFetchCount;
    }
    print(DateTime.now().millisecondsSinceEpoch.toString() + "End of function");
  }

  static Future<void> _callTriggers() async {
    for (Function func in _allTrigers) {
      await func();
    }
  }

  /// Get all inboxes
  static Map<String, InboxModel> allInboxes(List<String>? include) {
    if (include != null) {
      for (int i = 0; i < include.length; i++) {
        include[i] = ContactHelper.clearNumber(include[i]);
      }
      Map<String, InboxModel> filteredSMSMessage = {};
      List<String> allKeys = _loadedSmsMessage.keys.toList();
      for (int i = 0; i < allKeys.length; i++) {
        String num = allKeys[i]; //.replaceAll('+', '');// example 980001123
        if (include.contains(num)) {
          filteredSMSMessage[num] = _loadedSmsMessage[num]!;
        }
      }
      return filteredSMSMessage;
    }
    return _loadedSmsMessage;
  }

  /// Get all inboxes
  static Map<String, InboxModel> matchInboxes(RegExp regex) {
    Map<String, InboxModel> filteredSMSMessage = {};
    List<String> availableAddresses = _loadedSmsMessage.keys.toList();

    for (int j = 0; j < availableAddresses.length; j++) {
      //Available Address = +98980001123 > 980001123
      if (regex.hasMatch(availableAddresses[j])) {
        filteredSMSMessage[availableAddresses[j]] =
            _loadedSmsMessage[availableAddresses[j]]!;
      }
    }
    return filteredSMSMessage;
  }

  static List<SmsMessage>? specialInbox(String address) {
   List<SmsMessage>? messages = _loadedSmsMessage[address]?.messages;
    if (messages != null) {
      // Use a set to store unique message IDs
      Set<int> uniqueIds = <int>{};
      List<SmsMessage> uniqueMessages = [];

      for (SmsMessage message in messages) {
        if (!uniqueIds.contains(message.id!)) {
          // Add the message to the uniqueMessages list
          uniqueMessages.add(message);
          uniqueIds.add(message.id!);
        }
      }

      return uniqueMessages;
    }

    return null;
  }

  static onListUpdated(Function triggerUpdate) {
    _allTrigers.add(triggerUpdate);
  }

  static removeOnListUpdated(Function triggerUpdate) {
    _allTrigers.remove(triggerUpdate);
  }

  static changeReadStatus(
      List<SmsMessage>? messages, Map<String, InboxModel>? allMessages) {
    if (messages != null) {
      for (SmsMessage message in messages) {
        message.read = true;
      }
    }
    if (allMessages != null) {
      for (InboxModel message in allMessages.values) {
        message.read = true;
      }
    }
  }
}
