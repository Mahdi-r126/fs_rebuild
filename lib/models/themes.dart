import './theme.dart';

class Themes {
  List<Theme> themeList;

  Themes({required this.themeList});

  factory Themes.fromJson(Map<String, dynamic> json) {
    var list = json['themes'] as List;
    List<Theme> themeList = list.map((i) => Theme.fromJson(i)).toList();
    return Themes(themeList: themeList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'themes': themeList.map((x) => x.toJson()).toList(),
    });
  }
}