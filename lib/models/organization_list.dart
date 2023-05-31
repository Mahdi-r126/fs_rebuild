import 'ad.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class OrganizationList {
  List<Organization> organizationList;

  OrganizationList({required this.organizationList});

  factory OrganizationList.fromJson(Map<String, dynamic> json) {
    var list = json['organizations'] as List;
    List<Organization> organizationList = list.map((i) => Organization.fromJson(i)).toList();
    return OrganizationList(organizationList: organizationList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'organizations': organizationList.map((x) => x.toJson()).toList(),
    });
  }
}