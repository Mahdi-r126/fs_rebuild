class Theme {
  String themeId;
  String name;
  String icon;

  Theme({required this.themeId, required this.name, required this.icon});

  factory Theme.fromJson(Map<String, dynamic> json) {
    var themeId = json['themeId'];
    var name = json['name'];
    var icon = json['icon'];
    return Theme(themeId: themeId, name: name, icon: icon);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'themeId': themeId,
      'name': name,
      'icon': icon
    });
  }
}