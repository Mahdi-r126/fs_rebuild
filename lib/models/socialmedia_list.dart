import 'package:flutter_contacts/flutter_contacts.dart';

class SocialMediaList {
  List<SocialMedia> socialMediaList;

  SocialMediaList({required this.socialMediaList});

  factory SocialMediaList.fromJson(Map<String, dynamic> json) {
    var list = json['socialMedias'] as List;
    List<SocialMedia> socialMediaList = list.map((i) => SocialMedia.fromJson(i)).toList();
    return SocialMediaList(socialMediaList: socialMediaList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'socialMedias': socialMediaList.map((x) => x.toJson()).toList(),
    });
  }
}