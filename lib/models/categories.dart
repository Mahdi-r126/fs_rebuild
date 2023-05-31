import './category.dart';

class Categories {
  List<Category> categoryList;

  Categories({required this.categoryList});

  factory Categories.fromJson(Map<String, dynamic> json) {
    var list = json['categories'] as List;
    List<Category> categoryList = list.map((i) => Category.fromJson(i)).toList();
    return Categories(categoryList: categoryList);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'categories': categoryList.map((x) => x.toJson()).toList(),
    });
  }
}