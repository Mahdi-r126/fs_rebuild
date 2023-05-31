import 'package:flutter_contacts/flutter_contacts.dart';

class GroupList {
  List<Group> groupList;

  GroupList({required this.groupList});

  factory GroupList.fromJson(Map<String, dynamic> json) {
    var list = json['groups'] as List;
    List<Group> groupList = list.map((i) => Group.fromJson(i)).toList();
    return GroupList(groupList: groupList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'groups': groupList.map((x) => x.toJson()).toList(),
    });
  }
}