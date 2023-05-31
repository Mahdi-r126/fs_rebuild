class Folders {
  Folders({
    this.id,
    this.folderId,
    this.title,
    this.description,
    this.numbers,
    this.createdAt,
    this.updatedAt,
  });
  String? id;
  String? folderId;
  String? title;
  String? description;
  List<String>? numbers;
  String? createdAt;
  String? updatedAt;

  Folders.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    folderId = json['folderId'];
    title = json['title'];
    description = json['description'];
    numbers = List.castFrom<dynamic, String>(json['numbers']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['folderId'] = folderId;
    _data['title'] = title;
    _data['description'] = description;
    _data['numbers'] = numbers;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}

// class FolderList {
//   List<Folders> folders;
//   int totalItems;
//
//   FolderList({
//     required this.folders,
//     required this.totalItems,
//   });
//
//   factory FolderList.fromJson(Map<String, dynamic> json) {
//     return FolderList(
//       folders: List<Folders>.from(json['folders'].map((x) => Folders.fromJson(x))),
//       totalItems: json['totalItems'],
//     );
//   }
// }
