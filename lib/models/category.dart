class Category {
  String categoryId;
  String name;
  String icon;

  Category({required this.categoryId, required this.name, required this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
    var categoryId = json['categoryId'];
    var name = json['name'];
    var icon = json['icon'];
    return Category(categoryId: categoryId, name: name, icon: icon);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'categoryId': categoryId,
      'name': name,
      'icon': icon
    });
  }
}