import 'package:flutter_contacts/flutter_contacts.dart';

class EventList {
  List<Event> eventList;

  EventList({required this.eventList});

  factory EventList.fromJson(Map<String, dynamic> json) {
    var list = json['events'] as List;
    List<Event> eventList = list.map((i) => Event.fromJson(i)).toList();
    return EventList(eventList: eventList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'events': eventList.map((x) => x.toJson()).toList(),
    });
  }
}